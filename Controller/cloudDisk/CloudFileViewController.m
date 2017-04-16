//
//  CloudFileViewController.m
//  M-Cut
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudFileViewController.h"
#import "WaterLayout.h"
#import "FileCollectionViewCell.h"
#import "CustomAlertView.h"
#import "CloudUploadViewController.h"
#import "PhotoModel.h"
#import "UploadMaterialModel.h"
#import "UploadImageManager.h"

typedef NS_ENUM(NSInteger, CreateAlbumType){
    repeatName,
    strLength,
    canCreate
};

static NSString *const cellResuableStr = @"FileCollectionViewCell";
static NSString *const headerResuableStr = @"header";
static NSString *const footerResuableStr = @"footer";

@interface CloudFileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) WaterLayout *waterLayout;
@property (nonatomic, strong) UICollectionView *fileCollectionView;
@property (nonatomic, strong) NSMutableArray *fileDataMuArray;
@property (nonatomic, strong) UIButton *confirmMoveButton;
@property (nonatomic, strong) NSDictionary *selectAlbumDic;
@property (nonatomic, strong) CustomAlertView *alertView;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation CloudFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.fileCollectionView];
    [self.view addSubview:self.confirmMoveButton];
    [self.view addSubview:self.alertView];
    [self.view bringSubviewToFront:self.alertView];
    self.alertView.hidden = YES;
    NAVIGATIONBACKBARBUTTONITEM
    NAVIGATIONBARTITLEVIEW(@"移动至")
    NAVIGATIONBARRIGHTBARBUTTONITEMWITHIMAGE(@"addImage")
    REGISTERSHOWKEYBOARDNOTI
    REGISTERHIDDENKEYBOARDNOTI
    [self downloadFileData];
}

#pragma mark - collectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.fileDataMuArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellResuableStr forIndexPath:indexPath];
    NSDictionary *fileInfoDic = self.fileDataMuArray[indexPath.item];
    [cell.fileThumailImage sd_setImageWithURL:[NSURL URLWithString:fileInfoDic[@"thumbnail"]] placeholderImage:[UIImage imageNamed:@"inshow素材"]];
    cell.fileNameLabel.text = [fileInfoDic[@"dirname"] isEqual:[NSNull null]] ? @"" : fileInfoDic[@"dirname"];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr forIndexPath:indexPath];
        return header;
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr forIndexPath:indexPath];
        return footer;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectAlbumDic = self.fileDataMuArray[indexPath.item];
    self.confirmMoveButton.hidden = NO;
    self.fileCollectionView.frame = CGRectMake(0, 0, ISScreen_Width, ISScreen_Height - 44);
}

#pragma mark - interface

NAVIGATIONBACKITEMMETHOD

- (void)rightBarItemAction{
    self.alertView.hidden = NO;
}

- (void)addFile{
    
    //先判断是否合法，如果合法则进行文件夹得创建
    if ([self judgeFileNameWithName:self.textField.text] == canCreate) {
        WEAKSELF2
        [[AFNetWorkManager shareInstance] addFileWithFileName:self.textField.text Prefix:[NSString stringWithFormat:@"/"] Progress:^(NSProgress *progress) {
            NSLog(@"%@", progress);
        } Success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@", responseObject);
            
            //创建成功 提醒创建成功 然后重新下载信息
            [CustomeClass showMessage:@"相册创建成功" ShowTime:3 TextColor:ColorFromRGB(0xF4413F, 1.0)];
            [weakSelf downloadFileData];
        } Fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}

/**
 *  判断用户输入内容是否合法
 */
- (CreateAlbumType)judgeFileNameWithName:(NSString *)fileName{
    
    if (fileName.length <= 10) {
        
        for (NSDictionary *albumDic in self.fileDataMuArray) {
            
            if ([albumDic[@"dirname"] isEqualToString:fileName]) {
                [CustomeClass showMessage:@"文件名重复了！" ShowTime:3 TextColor:ColorFromRGB(0xF4413F, 1)];
                return repeatName;
            }
        }
        return canCreate;
    }else{
        return strLength;
    }
}

- (void)confirmMoveButtonAction{
    SHOWHUD
    for (PhotoModel *photoModel in self.selectArray) {
        UploadMaterialModel *uploadModel = [UploadMaterialModel new];
        uploadModel.status = uploadStart;
        uploadModel.assetURL = [SINGLETON(PhotoManager) getAssetURLWithAsset:photoModel.asset];
        uploadModel.localURL = [SINGLETON(PhotoManager) getLocalURLWithAsset:photoModel.asset];
        uploadModel.createTime = [CustomeClass getCurrentTimeWithFormatter:@"yyyy-MM-dd HH：mm：ss"];
        uploadModel.contentSize = @"2";
        uploadModel.fileName = [SINGLETON(PhotoManager) getFileNameWithAsset:photoModel.asset];
        uploadModel.yunFileName = self.selectAlbumDic[@"dirname"];
        
        [SINGLETON(PhotoManager) getFileSizeWithAsset:photoModel.asset complete:^(CGFloat fileSize) {
            uploadModel.contentSize = [NSString stringWithFormat:@"%f", fileSize];
            [[VideoDBOperation Singleton] insertDataWithModel:uploadModel];
        }];
        
        [SINGLETON(PhotoManager) getAssetThumbnailSyncWithAsset:photoModel.asset TargetSize:[UIScreen mainScreen].bounds.size complete:^(UIImage *image) {
            NSString *filePath = [NSString stringWithFormat:@"%@/%@", [CustomeClass createFileAtSandboxWithName:uploadImageFileName], [[[PHAssetResource assetResourcesForAsset:photoModel.asset] firstObject] originalFilename]];
            [CustomeClass saveImageWithPath:filePath ImageData:image];
        }];
    }
    
    //开始上传
    [SINGLETON(UploadImageManager) startUploadImage];
    HIDDENHUD
    [CloudUploadViewController pushToUploadVcWithNav:self.navigationController];
}

- (void)downloadFileData{
    WEAKSELF2
    SHOWHUD
    
    [[AFNetWorkManager shareInstance] searchUserFile:@"/" LabelArray:@[] Progress:^(NSProgress *progress) {
        HIDDENHUD
        NSLog(@"progress --- %@", progress);
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        HIDDENHUD
        NSLog(@"%@", responseObject);
        [weakSelf.fileDataMuArray removeAllObjects];
        [weakSelf.fileDataMuArray addObjectsFromArray:responseObject[@"ret"]];
        
        [CustomeClass mainQueue:^{
            [weakSelf.fileCollectionView reloadData];
        }];
    } Fail:^(NSURLSessionDataTask *task, NSError *error) {
        HIDDENHUD
        DEBUGLOG(error)
    }];
}

/**
 *  提示框按钮点击方法
 */
- (void)touchButtonActionWithIndex:(NSInteger)index{
    self.alertView.hidden = YES;
    [self.view endEditing:YES];
    
    if (index == 1) {
        
        //确定，请求服务器创建文件夹
        [self addFile];
        self.textField.text = @"";
        self.textField.placeholder = @"     为你的相册取个名字吧";
    }
}

/**
 *  键盘出现
 */
- (void)keyboardWillShow:(NSNotification *)noti{
    self.view.frame = CGRectMake(0, - [CustomeClass getKeyboardHeightWithNoti:noti] / 2, ISScreen_Width, ISScreen_Height);
}

/**
 *  键盘消失
 */
- (void)keyboardWillHidden:(NSNotification *)noti{
    self.view.frame = CGRectMake(0, 0, ISScreen_Width, ISScreen_Height);
}

#pragma mark - getter

- (WaterLayout *)waterLayout{
    if (!_waterLayout) {
        _waterLayout = [WaterLayout new];
        _waterLayout.rowMargin = 0;
        _waterLayout.columnMargin = 0;
        _waterLayout.columnsCount = 1;
        _waterLayout.sectionEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [_waterLayout setItemHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            return 60;
        }];
        
        [_waterLayout setHeaderSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 0);
        }];
        
        [_waterLayout setFooterSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 0);
        }];
    }
    return _waterLayout;
}

- (UICollectionView *)fileCollectionView{
    if (!_fileCollectionView) {
        _fileCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height) collectionViewLayout:self.waterLayout];
        _fileCollectionView.delegate = self;
        _fileCollectionView.dataSource = self;
        _fileCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_fileCollectionView registerNib:[UINib nibWithNibName:cellResuableStr bundle:nil] forCellWithReuseIdentifier:cellResuableStr];
        [_fileCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr];
        [_fileCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr];
    }
    return _fileCollectionView;
}

- (NSMutableArray *)fileDataMuArray{
    LAZYINITMUARRAY(_fileDataMuArray)
}

- (UIButton *)confirmMoveButton{
    if (!_confirmMoveButton) {
        _confirmMoveButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ISScreen_Height - 44 - 64, ISScreen_Width, 44)];
        _confirmMoveButton.backgroundColor = ColorFromRGB(0x2E2E3A, 1.0);
        [_confirmMoveButton setTitle:@"确定移动" forState:UIControlStateNormal];
        [_confirmMoveButton addTarget:self action:@selector(confirmMoveButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _confirmMoveButton.hidden = YES;
    }
    return _confirmMoveButton;
}

- (CustomAlertView *)alertView{
    if (!_alertView) {
        WEAKSELF2
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(ISScreen_Width / 2 - 120, ISScreen_Height / 2 - 72, 240, 84)];
        [backView addSubview:self.textField];
        
        _alertView = [[CustomAlertView alloc] initWithTitle:@"新建相册" ButtonTitleArray:@[@"取消", @"确定"] Width:240 Height:144];
        [_alertView addCustomeView:backView];
        
        [_alertView setTouchBottomButtonBlock:^(NSInteger index) {
            [weakSelf touchButtonActionWithIndex:index];
        }];
    }
    return _alertView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(14, 10, 212, 30)];
        _textField.placeholder = @"     为你的相册取个名字吧";
        _textField.textColor = ColorFromRGB(0x2E2E3A, 1.0);
        _textField.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _textField.layer.cornerRadius = 6;
        _textField.layer.masksToBounds = YES;
        _textField.font = ISFont_12;
    }
    return _textField;
}

- (NSArray *)selectArray{
    LAZYINITARRAY(_selectArray)
}

@end
