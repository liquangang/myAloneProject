//
//  TuwenShareViewController.m
//  M-Cut
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TuwenShareViewController.h"
#import "TuwenTextTableViewCell.h"
#import "TuwenImageTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "EditTextViewController.h"
#import "UILabel+LabelHeightAndWidth.h"
#import "HeaderChange.h"
#import "SoapOperation.h"
#import "CustomeClass.h"
#import "UserEntity.h"
#import "VideoDetailViewController.h"
#import "TuwenOBJ.h"
#import "VideoDBOperation.h"

static NSString * const resuableStr = @"TuwenTextTableViewCell";
static NSString * const resuabelStr1 = @"TuwenImageTableViewCell";

@interface TuwenShareViewController ()<UITableViewDelegate,
                                       UITableViewDataSource,
                                       UINavigationControllerDelegate,
                                       UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tuwenTable;
//数据源
@property (nonatomic, strong) NSMutableArray * dataMuArray;
//视频的缩略图
@property (nonatomic, strong) UIImage * videoImage;
//记录之前分享数据是否被保存过
@property (nonatomic, assign) BOOL isSaveShareData;
@end

@implementation TuwenShareViewController

- (void)dealloc{
    DEBUGSUCCESSLOG(@"dealloc")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

/**
 *  添加文本
 */
- (IBAction)addTextButtonAction:(id)sender {
    TuwenOBJ * tuwenObj = [TuwenOBJ new];
    tuwenObj.cellType = textType;
    tuwenObj.cellContent = nil;
    tuwenObj.cellHeight = 65;
    tuwenObj.cellImage = nil;
    tuwenObj.isHiddenPlayButton = YES;
    [self.dataMuArray addObject:tuwenObj];
    [self.tuwenTable reloadData];
    [self.tuwenTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataMuArray.count - 1 inSection:0]
                           atScrollPosition:UITableViewScrollPositionBottom
                                   animated:YES];
}


/**
 * 选择图片
 */
- (IBAction)uploadImageButtonAction:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

#pragma mark - table代理

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TuwenOBJ * tuwenObj = self.dataMuArray[indexPath.row];
    return tuwenObj.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return self.dataMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TuwenOBJ * tuwenObj = self.dataMuArray[indexPath.row];
    if (tuwenObj.cellType == imageType || tuwenObj.cellType == videoType) {
        TuwenImageTableViewCell * cell = [TuwenImageTableViewCell TuwenImageTableViewCellWithTableView:tableView
                                                                                           ResuableStr:resuabelStr1
                                                                                              TuwenObj:tuwenObj
                                                                                             IndexPath:indexPath];
        WEAKSELF2
        [cell setDeleteBlock:^(NSIndexPath * indexPath) {
            [weakSelf deleteCellWithIndex:indexPath];
        }];
        [cell setLongTapBlock:^{
            weakSelf.tuwenTable.editing = YES;
        }];
        
        if (tuwenObj.cellType == videoType) {
            self.videoImage = tuwenObj.cellImage;
        }
        
        return cell;
    }else{
        TuwenTextTableViewCell * cell = [TuwenTextTableViewCell TuwenTextTableViewCellWithTable:tableView
                                                                                    ResuableStr:resuableStr
                                                                                        Content:tuwenObj.cellContent.string
                                                                                      IndexPath:indexPath];
        WEAKSELF2
        [cell setDeleteBlock:^(NSIndexPath * indexPath) {
            [weakSelf deleteCellWithIndex:indexPath];
        }];
        [cell setLongTapBlock:^{
            weakSelf.tuwenTable.editing = YES;
        }];
        return cell;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView
        moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
        toIndexPath:(NSIndexPath *)destinationIndexPath{
    TuwenOBJ * tuwenObj = self.dataMuArray[sourceIndexPath.row];
    [self.dataMuArray removeObjectAtIndex:sourceIndexPath.row];
    [self.dataMuArray insertObject:tuwenObj atIndex:destinationIndexPath.row];
    [self.tuwenTable reloadData];
    self.tuwenTable.editing = NO;
}

- (void)tableView:(UITableView *)tableView
        didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TuwenOBJ * tuwenObj = self.dataMuArray[indexPath.row];
    if (tuwenObj.cellType == textType) {
        EditTextViewController * editTextVc = [EditTextViewController new];
        editTextVc.textStr = tuwenObj.cellContent.string;
        WEAKSELF2
        [editTextVc setFinishBlock:^(NSAttributedString *textStr) {
            [weakSelf addtextWithtext:textStr Index:indexPath];
        }];
        [self.navigationController pushViewController:editTextVc animated:YES];
    }else if (tuwenObj.cellType == videoType){
        VideoDetailViewController * videoDetailVc = [VideoDetailViewController new];
        videoDetailVc.videoInfo = [[NSMutableDictionary alloc] initWithDictionary:self.videoInfoDictionary];
        videoDetailVc.isFormTuwenVc = YES;
        [self.navigationController pushViewController:videoDetailVc animated:YES];
    }
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [CustomeClass hudShowWithView:self.view Tag:12345678];
    WEAKSELF2
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        TuwenOBJ * tuwenObj = [TuwenOBJ new];
        tuwenObj.cellType = imageType;
        tuwenObj.cellImage = image;
        tuwenObj.cellHeight = (ISScreen_Width - 25 - 15) / tuwenObj.cellImage.size.width * tuwenObj.cellImage.size.height + 20;
        tuwenObj.cellContent = nil;
        tuwenObj.isHiddenPlayButton = YES;
        NSString * tempUrl = [NSString stringWithFormat:@"%@", [info objectForKey:UIImagePickerControllerReferenceURL]];
        NSArray * tempArray = [tempUrl componentsSeparatedByString:@"="];
        NSString * fileNameStr = [tempArray[1] componentsSeparatedByString:@"&"][0];
        NSString * ext = tempArray[2];
        tuwenObj.cellImageUrl = [NSString stringWithFormat:@"http://%@.%@/movier/share/%@.%@", [UserEntity sharedSingleton].ossBucket,
                                 [UserEntity sharedSingleton].ossEndpoint,
                                 fileNameStr,
                                 ext];
        MAINQUEUEUPDATEUI({
            [weakSelf.dataMuArray addObject:tuwenObj];
            [weakSelf.tuwenTable reloadData];
            [weakSelf.tuwenTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.dataMuArray.count - 1 inSection:0]
                                   atScrollPosition:UITableViewScrollPositionBottom
                                           animated:YES];
        })
        [[HeaderChange Singleton] UploadTuwenImageWithFilename:fileNameStr
                                                           Ext:ext
                                                          Data:UIImageJPEGRepresentation(image, .4)
                                                      Complete:^{
                                                          [CustomeClass hudHiddenWithView:weakSelf.view Tag:12345678];
                                                      }];
    }];
}

#pragma mark - 功能接口

/**
 *  添加文本
 */
- (void)addtextWithtext:(NSAttributedString *)text Index:(NSIndexPath *)indexPath{
    TuwenOBJ * tuwenObj = self.dataMuArray[indexPath.row];
    tuwenObj.cellContent = text;
    CGFloat height = [UILabel getHeightByWidth:ISScreen_Width - 84
                                         title:text.string
                                          font:ISFont_14];
    tuwenObj.cellHeight = height + 56;
    [self.tuwenTable reloadData];
    [self.tuwenTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataMuArray.count - 1 inSection:0]
                           atScrollPosition:UITableViewScrollPositionBottom
                                   animated:YES];
}

/**
 *  富文本转string
 */
- (NSString *)attriToStrWithAttri:(NSAttributedString *)attri{
    NSDictionary *tempDic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    NSData *htmlData = [attri dataFromRange:NSMakeRange(0, attri.length)
                         documentAttributes:tempDic
                                      error:nil];
    return [[NSString alloc] initWithData:htmlData
                                 encoding:NSUTF8StringEncoding];
}

/**
 *  删除操作
 */
- (void)deleteCellWithIndex:(NSIndexPath *)index{
    [self.dataMuArray removeObjectAtIndex:index.row];
    [self.tuwenTable reloadData];
}

/**
 *  设置分享内容
 */
- (void)setShareContentWithShareUrl:(NSString *)shareUrl{
    for (TuwenOBJ * tuwenObj in self.dataMuArray) {
        if (tuwenObj.cellType == videoType) {
            
            //shareImage
            self.shareImage = tuwenObj.cellImage;
            
            //shareTitle
            self.shareTitle = self.videoInfoDictionary[@"video_name"];
            
            //shareUrl
            self.shareUrl = shareUrl;
        }
    }
}

/**
 *  设置ui
 */
- (void)setUI{
    NAVIGATIONBACKBARBUTTONITEM
    NAVIGATIONBARRIGHTBARBUTTONITEM(@"分享")
    self.isShowTuwenButton = NO;
    
    //注册cell
    [self.tuwenTable registerNib:[UINib nibWithNibName:resuableStr bundle:nil]
          forCellReuseIdentifier:resuableStr];
    [self.tuwenTable registerNib:[UINib nibWithNibName:resuabelStr1 bundle:nil]
          forCellReuseIdentifier:resuabelStr1];
    WEAKSELF2
    if ([[VideoDBOperation Singleton] isSaveShareDataWithVideoId:self.videoInfoDictionary[@"video_id"]]) {
        DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
            NSArray * tempArray = [[VideoDBOperation Singleton] selectAllShareDataWithVideoID:weakSelf.videoInfoDictionary[@"video_id"]];
            [weakSelf.dataMuArray addObjectsFromArray:tempArray];
            for (TuwenOBJ * tuwenObj in weakSelf.dataMuArray) {
                if (tuwenObj.cellType == textType &&
                    [tuwenObj.cellContent.string isEqualToString:@"(null)"]) {
                    tuwenObj.cellContent = nil;
                }
            }
        }, {
            [weakSelf.tuwenTable reloadData];
            [weakSelf.tuwenTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.dataMuArray.count - 1
                                                                           inSection:0]
                                   atScrollPosition:UITableViewScrollPositionBottom
                                           animated:YES];
        })
        
    }else{
        WEAKSELF2
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL * imageUrl = [NSURL URLWithString:STRTOUTF8(weakSelf.videoInfoDictionary[@"video_thumbnail"])];
            NSData * imageData = [NSData dataWithContentsOfURL:imageUrl];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //添加第一个视频image
                TuwenOBJ * tuwenObj = [TuwenOBJ new];
                tuwenObj.cellType = videoType;
                tuwenObj.cellImage = [UIImage imageWithData:imageData];
                tuwenObj.cellHeight = (ISScreen_Width - 25 - 15) / tuwenObj.cellImage.size.width * tuwenObj.cellImage.size.height + 20;
                tuwenObj.cellContent = nil;
                tuwenObj.isHiddenPlayButton = NO;
                tuwenObj.cellImageUrl = weakSelf.videoInfoDictionary[@"video_thumbnail"];
                tuwenObj.cellVideoUrl = weakSelf.videoInfoDictionary[@"video_reference"];
                [weakSelf.dataMuArray addObject:tuwenObj];
                [weakSelf.tuwenTable reloadData];
            });});
    }
}

/**
 *  返回事件
 */
- (void)backButtonAction:(UIButton *)btn{
    
     WEAKSELF2
    
    //如果之前存在就删掉之前保存的所有内容，然后保存新的内容
    if ([[VideoDBOperation Singleton] isSaveShareDataWithVideoId:weakSelf.videoInfoDictionary[@"video_id"]]) {
        [[VideoDBOperation Singleton] deleteShareDataWithVideoId:weakSelf.videoInfoDictionary[@"video_id"]];
    }
    if (self.dataMuArray.count == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
   
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示"
                                                                              message:@"是否保存您编辑的信息"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"返回"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             MAINQUEUEUPDATEUI({
                                                                 [weakSelf.navigationController popViewControllerAnimated:YES];
                                                             })
                                                         }];
    [alertController addAction:alertAction];
    
    UIAlertAction * alertAction1 = [UIAlertAction actionWithTitle:@"保存"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              MAINQUEUEUPDATEUI({
                                                                  
                                                                  
                                                                  for (TuwenOBJ * tuwenObj in weakSelf.dataMuArray) {
                                                                      [[VideoDBOperation Singleton] addOrUpdateShareDataWithTuwenObj:tuwenObj VideoId:weakSelf.videoInfoDictionary[@"video_id"]];
                                                                  }
                                                                  [weakSelf.navigationController popViewControllerAnimated:YES];
                                                              })
                                                          }];
    [alertController addAction:alertAction1];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

/**
 *  分享
 */
- (void)rightBarButtonItemAction:(UIButton *)btn{
    [self showShareView];
}

/**
 *  获取所有的分享html字符串
 */
- (NSString *)getShareHtmlStr{
    NSMutableAttributedString * shareHtmlStr = [NSMutableAttributedString new];
    for (TuwenOBJ * tuwenObj in self.dataMuArray) {
        if (tuwenObj.cellType == imageType) {
            [shareHtmlStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"<p><img src=\"%@\"></p>", tuwenObj.cellImageUrl]]];
        }else if (tuwenObj.cellType == textType && tuwenObj.cellContent.length > 0){
            [shareHtmlStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"<p><div>"]];
            [shareHtmlStr appendAttributedString:tuwenObj.cellContent];
            [shareHtmlStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"<p><div>"]];
        }else if (tuwenObj.cellType == videoType){
            [shareHtmlStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"<p><video src=\"%@\" controls=\"controls\"></video></p>", tuwenObj.cellVideoUrl]]];
        }
    }
    return [self attriToStrWithAttri:shareHtmlStr];
}

/**
 *  分享之前先上传
 */
- (void)shareTapMethodWithIndex:(NSInteger)index
                            URL:(NSString *)url
                          Title:(NSString *)title
                    UrlResource:(UMSocialUrlResource *)urlResource
                     ShareImage:(UIImage *)shareImage{
    
    //如果有，就删除之前保存的
    [[VideoDBOperation Singleton] deleteShareDataWithVideoId:self.videoInfoDictionary[@"video_id"]];
    
    WEAKSELF2
    [self uploadHtmlStrWithComplete:^(NSInteger shareId) {
        
        //id待替换
        NSString * shareUrl = [NSString stringWithFormat:@"http://www.inshowtv.com/Share?sid=%ld", (long)shareId];
        MAINQUEUEUPDATEUI({
            
            //分享
            [super shareTapMethodWithIndex:index
                                       URL:shareUrl
                                     Title:weakSelf.videoInfoDictionary[@"video_name"]
                               UrlResource:[[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeVideo
                                                                                            url:shareUrl]
                                ShareImage:weakSelf.videoImage];
        })
    }];
}

/**
 *  上传html并获得id
 */
- (void)uploadHtmlStrWithComplete:(void(^)(NSInteger shareId))completeBlock{
    //调接口传值获得id然后分享出去即可
    WEAKSELF2
    [[SoapOperation Singleton] richSnippetsWithVideoId:self.videoInfoDictionary[@"video_id"] Platform:0
                                   RichSnippetsContent:[weakSelf getShareHtmlStr]
                                               Success:^(NSNumber *successInfo) {
                                                   completeBlock([successInfo integerValue]);
                                               }
                                                  Fail:^(NSError *error) {
                                                      RELOADSERVERDATA([weakSelf uploadHtmlStrWithComplete:nil];);
                                                  }];
}

#pragma mark - 懒加载
/**
 *  数据源
 */
- (NSMutableArray *)dataMuArray{
    if (!_dataMuArray) {
        _dataMuArray = [NSMutableArray new];
    }
    return _dataMuArray;
}

@end
