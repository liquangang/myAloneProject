//
//  CloudDiskViewController.m
//  M-Cut
//
//  Created by apple on 16/12/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudDiskViewController.h"
#import "WaterLayout.h"
#import "CloudAlbumCollectionViewCell.h"
#import "CloudHeaderCollectionViewCell.h"
#import "CloudHeaderView.h"
#import "RecycleViewController.h"
#import "CustomeClass.h"
#import "CloudDiskSearchViewController.h"
#import "AFNetWorkManager.h"
#import "UserEntity.h"
#import "CloudDiskPreviewViewController.h"
#import "CustomAlertView.h"
#import "AlbumViewController.h"
#import "ShowCloudFIleImageViewController.h"

typedef NS_ENUM(NSInteger, CreateAlbumType){
    repeatName,
    strLength,
    canCreate
};

static NSString *const CloudAlbumCollectionViewCellResuableStr = @"CloudAlbumCollectionViewCell";
static NSString *const CloudHeaderCollectionViewCellResuableStr = @"CloudHeaderCollectionViewCell";
static NSString *const CloudDiskHeaderResuableStr = @"header";
static NSString *const CloudDiskFooterResuableStr = @"footer";

@interface CloudDiskViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *cloudDiskCollectionView;
@property (nonatomic, strong) NSMutableArray *albumMuArray;
@property (nonatomic, strong) CloudHeaderView *headerView;
@property (nonatomic, strong) CustomAlertView *alertView;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation CloudDiskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    //接受用户信息更新的通知
    REGISTEREDNOTI(updateUseInfo:, @"updateUserInfo");
    [self downLoadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //禁止侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (![self noLogin]) {
        [self.albumMuArray removeAllObjects];
        [self.cloudDiskCollectionView reloadData];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //打开侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - collectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.albumMuArray.count == 0) {
        UILabel *propmtLabel = [[UILabel alloc] initWithFrame:self.cloudDiskCollectionView.bounds];
        propmtLabel.textColor = ColorFromRGB(0x2E2E3A, 1);
        propmtLabel.text = @"快去创建第一个文件吧！";
        propmtLabel.textAlignment = NSTextAlignmentCenter;
        self.cloudDiskCollectionView.backgroundView = propmtLabel;
    }else{
        self.cloudDiskCollectionView.backgroundView = [[UIView alloc] initWithFrame:self.cloudDiskCollectionView.bounds];
    }
    
    return self.albumMuArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CloudAlbumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CloudAlbumCollectionViewCellResuableStr forIndexPath:indexPath];
    NSDictionary *albumInfoDic = self.albumMuArray[indexPath.item];
    [cell.backImage sd_setImageWithURL:[NSURL URLWithString:albumInfoDic[@"thumbnail"]] placeholderImage:[UIImage imageNamed:@"inshow素材"]];
    cell.numLabel.text = [albumInfoDic[@"childfilecount"] stringValue];
    cell.titleLabel.text = [albumInfoDic[@"dirname"] isEqual:[NSNull null]] ? @"" : albumInfoDic[@"dirname"];
    cell.lockImage.hidden = YES;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CloudDiskHeaderResuableStr forIndexPath:indexPath];
        return header;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CloudDiskFooterResuableStr forIndexPath:indexPath];
        return footerView;
    }
}

#pragma mark - collectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self noLogin]) {
        ShowCloudFIleImageViewController *showImageVc = [ShowCloudFIleImageViewController new];
        showImageVc.albumInfoDic = self.albumMuArray[indexPath.item];
        [self.navigationController pushViewController:showImageVc animated:YES];
    }
}

#pragma mark - interface

- (void)setUI{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.cloudDiskCollectionView];
    [self.view addSubview:self.headerView];
    
    REGISTERSHOWKEYBOARDNOTI
    REGISTERHIDDENKEYBOARDNOTI
}

/**
 *  跳转到回收站
 */
- (void)pushToImageVc{
    
    if ([self noLogin]) {
        RecycleViewController *showImageVc = [RecycleViewController new];
        
        [CustomeClass mainQueue:^{
            WEAKSELF2
            [weakSelf.navigationController pushViewController:showImageVc animated:YES];
        }];
    }
}

- (void)pushToSearchVc{
    
    if ([self noLogin]) {
        CloudDiskSearchViewController *searchVc = [CloudDiskSearchViewController new];
        
        [CustomeClass mainQueue:^{
            WEAKSELF2
            [weakSelf.navigationController pushViewController:searchVc animated:YES];
        }];
    }
}

- (void)downLoadData{
    WEAKSELF2
    
    if ([self noLogin] && ([SINGLETON(AFNetWorkManager) netStatus] == AFNetworkReachabilityStatusReachableViaWWAN || [SINGLETON(AFNetWorkManager) netStatus] == AFNetworkReachabilityStatusReachableViaWiFi)) {
        [CustomeClass HUDshow:self.view Tag:123456789];
        [[AFNetWorkManager shareInstance] searchUserFile:@"/" LabelArray:@[] Progress:^(NSProgress *progress) {
            [CustomeClass HUDhidden:weakSelf.view Tag:123456789];
            NSLog(@"progress --- %@", progress);
        } Success:^(NSURLSessionDataTask *task, id responseObject) {
            [CustomeClass HUDhidden:weakSelf.view Tag:123456789];
            NSLog(@"%@", responseObject);
            [weakSelf.albumMuArray removeAllObjects];
            [weakSelf.albumMuArray addObjectsFromArray:responseObject[@"ret"]];
            
            [CustomeClass mainQueue:^{
                [weakSelf.cloudDiskCollectionView reloadData];
            }];
        } Fail:^(NSURLSessionDataTask *task, NSError *error) {
            [CustomeClass HUDhidden:weakSelf.view Tag:123456789];
            NSLog(@"%@", error);
        }];
    }
}

- (BOOL)noLogin{
    
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [self showLoginAndRegisterWindow];
        return NO;
    }
    return YES;
}

/**
 *  增加文件夹(相册)
 */
- (void)addAlbum{
    self.alertView.hidden = NO;
}

/**
 *  提示框按钮点击方法
 */
- (void)touchButtonActionWithIndex:(NSInteger)index{
    self.alertView.hidden = YES;
    [self.view endEditing:YES];
    
    if (index == 1) {
        
        //确定，请求服务器创建文件夹
        [self createFileWithName:self.textField.text];
        self.textField.text = @"";
        self.textField.placeholder = @"     为你的相册取个名字吧";
    }
}

/**
 *  判断用户输入内容是否合法
 */
- (CreateAlbumType)judgeFileNameWithName:(NSString *)fileName{

    if (fileName.length <= 10) {
        for (NSDictionary *albumDic in self.albumMuArray) {
            if (![albumDic[@"dirname"] isEqual:[NSNull null]] && [albumDic[@"dirname"] isEqualToString:fileName]) {
                [CustomeClass showMessage:@"文件名重复了！" ShowTime:3 TextColor:ColorFromRGB(0xF4413F, 1)];
                return repeatName;
            }
        }
        return canCreate;
    }else{
        return strLength;
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

- (void)createFileWithName:(NSString *)fileName{
    
    //先判断是否合法，如果合法则进行文件夹得创建
    if ([self judgeFileNameWithName:self.textField.text] == canCreate) {
        WEAKSELF2
        [[AFNetWorkManager shareInstance] addFileWithFileName:fileName Prefix:[NSString stringWithFormat:@"/"] Progress:^(NSProgress *progress) {
            NSLog(@"%@", progress);
        } Success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@", responseObject);
            
            //创建成功 提醒创建成功 然后重新下载信息
            [CustomeClass showMessage:@"相册创建成功" ShowTime:3 TextColor:ColorFromRGB(0xF4413F, 1.0)];
            [weakSelf downLoadData];
        } Fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}

/**
 *  用户登录通知
 */
- (void)updateUseInfo:(NSNotification *)noti{
    
    [self downLoadData];
}

#pragma mark - getter

- (UICollectionView *)cloudDiskCollectionView{
    if (!_cloudDiskCollectionView) {
        WaterLayout *waterLayout = [WaterLayout new];
        waterLayout.rowMargin = 4;
        waterLayout.columnMargin = 4;
        waterLayout.columnsCount = 4;
        waterLayout.sectionEdgeInset = UIEdgeInsetsMake(4, 4, 4, 4);
        
        [waterLayout setItemHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            return width;
        }];
        
        [waterLayout setHeaderSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(CGRectGetWidth(self.view.frame), 0);
        }];
        
        [waterLayout setFooterSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(CGRectGetWidth(self.view.frame), 0);
        }];
        
        _cloudDiskCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 250, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 49 - 250) collectionViewLayout:waterLayout];
        
        _cloudDiskCollectionView.delegate = self;
        _cloudDiskCollectionView.dataSource = self;
        
        [_cloudDiskCollectionView registerNib:[UINib nibWithNibName:CloudAlbumCollectionViewCellResuableStr bundle:nil] forCellWithReuseIdentifier:CloudAlbumCollectionViewCellResuableStr];
        [_cloudDiskCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CloudDiskFooterResuableStr];
        [_cloudDiskCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CloudDiskHeaderResuableStr];
        
        _cloudDiskCollectionView.opaque = YES;
        _cloudDiskCollectionView.showsVerticalScrollIndicator = NO;
        _cloudDiskCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _cloudDiskCollectionView;
}

- (NSMutableArray *)albumMuArray{
    LAZYINITMUARRAY(_albumMuArray)
}

- (CloudHeaderView *)headerView{
    
    if (!_headerView) {
        WEAKSELF2
        _headerView = [[CloudHeaderView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 250)];
        
        [_headerView setDeleteBlock:^{
            [weakSelf pushToImageVc];
        }];
        
        [_headerView setAddBlock:^{
            [weakSelf addAlbum];
        }];
        
        [_headerView setSearchBlock:^{
            [weakSelf pushToSearchVc];
        }];
        
        [_headerView setUploadBlock:^{
           
//            [CustomeClass mainQueue:^{
//                AlbumViewController *showImageVc = [AlbumViewController new];
//                [weakSelf.navigationController pushViewController:showImageVc animated:YES];
//            }];
        }];
    }
    return _headerView;
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
        
        [self.view addSubview:_alertView];
        [self.view bringSubviewToFront:_alertView];
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

@end
