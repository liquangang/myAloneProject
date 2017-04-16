//
//  MaterialSelectViewController.m
//  M-Cut
//
//  Created by liquangang on 2017/1/18.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "MaterialSelectViewController.h"
#import "MakeVideoNavigationControllerViewController.h"
#import "selectTableView.h"
#import "ImageCollectionView.h"
#import "XMNPhotoManager.h"

@interface MaterialSelectViewController ()
@property (weak, nonatomic) IBOutlet UIButton *selectAlbumButton;
@property (weak, nonatomic) IBOutlet UIButton *selectCloudDiskButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLengthLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (nonatomic, strong) NSMutableArray *albumInfoMuArray;
@property (nonatomic, strong) NSMutableArray *imageInfoMuArray;
@property (nonatomic, strong) selectTableView *selectTable;
@property (nonatomic, strong) ImageCollectionView *imageCollectionView;
@property (nonatomic, strong) XMNAlbumModel *selelctAlbumInfo;
@property (nonatomic, strong) NSMutableArray *selectImageInfoMuArray;
@end

@implementation MaterialSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self downloadAlbumInfo];
    self.selelctAlbumInfo = [XMNAlbumModel albumWithResult:[SINGLETON(PhotoManager) getPhotoAlbum] name:@"相机胶卷"];
    [self downloadImageInfo];
}

#pragma mark - interface

- (void)setUI{
    self.title = @"选择素材";
    NAVIGATIONBARLEFTBARBUTTONITEMWITHIMAGE(@"X号2")
    NAVIGATIONBARRIGHTBARBUTTONITEMWITHIMAGE(@"拍摄小")
    [self.view addSubview:self.imageCollectionView];
    [self.view addSubview:self.selectTable];
    [self.selectCloudDiskButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selectCloudDiskButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selectCloudDiskButton setTitleColor:ColorFromRGB(0xF4413F, 1) forState:UIControlStateSelected];
    [self.selectAlbumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selectAlbumButton setTitleColor:ColorFromRGB(0xF4413F, 1) forState:UIControlStateSelected];
    self.selectAlbumButton.selected = !self.selectAlbumButton.selected;
}

- (void)leftButtonAction:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)rightBarItemAction{
    
    //进入拍摄界面
    [self getAuthorizeStatus];
}

/**
 *  跳转拍摄界面
 */
- (void)pushToTakeVideoVc{
    MakeVideoNavigationControllerViewController *takeVideoVc = [MakeVideoNavigationControllerViewController new];
    takeVideoVc.hidesBottomBarWhenPushed = YES;
    
    [self presentViewController:takeVideoVc animated:YES completion:^{
        HIDDENHUD
    }];
}

/**  获得授权状态 */
- (void)getAuthorizeStatus{
    SHOWHUD
    WEAKSELF2
    
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(status == AVAuthorizationStatusAuthorized){
            
            //用户已经授权
            [weakSelf pushToTakeVideoVc];
        }
        else if (status == AVAuthorizationStatusDenied){
            
            //否认
            SHOWALERT(@"未获得相机的使用权限")
            return;
        }
        else if (status == AVAuthorizationStatusRestricted){
            
            //受限制
        }
        else if (status == AVAuthorizationStatusNotDetermined){
            
            //不确定
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    [weakSelf pushToTakeVideoVc];
                }
                else{
                    SHOWALERT(@"未获得相机的使用权限")
                }
            }];
        }
    }, {})
}

- (void)downloadAlbumInfo{
    WEAKSELF2
    [[XMNPhotoManager sharedManager] getAlbumsPickingVideoEnable:YES completionBlock:^(NSArray<XMNAlbumModel *> *albums) {
        for (int i = 0; i < albums.count - 1; i++) {
            XMNAlbumModel * albumModel = albums[i];
            if (![albumModel.name isEqualToString:@"最近删除"]) {
                [weakSelf.albumInfoMuArray addObject:albumModel];
            }
        }
        [CustomeClass mainQueue:^{
            weakSelf.selectTable.dataSource = weakSelf.albumInfoMuArray;
            [weakSelf.selectTable.tableView reloadData];
        }];
    }];
}

- (void)downloadImageInfo{
    SHOWHUD
    WEAKSELF2
    [[XMNPhotoManager sharedManager] getAssetsFromResult:self.selelctAlbumInfo.fetchResult pickingVideoEnable:YES completionBlock:^(NSArray<XMNAssetModel *> *assets) {
        HIDDENHUD
        [weakSelf.imageInfoMuArray removeAllObjects];
        [weakSelf.imageInfoMuArray addObjectsFromArray:assets];
        weakSelf.imageCollectionView.dataSource = weakSelf.imageInfoMuArray;
        MAINQUEUEUPDATEUI({
            [weakSelf.imageCollectionView.imageCollectionView reloadData];
            [weakSelf.imageCollectionView.imageCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:weakSelf.imageInfoMuArray.count - 1 inSection:0]
                                            atScrollPosition:UICollectionViewScrollPositionBottom
                                                    animated:NO];
        })
    }];
}

- (IBAction)selectAlbumButtonAction:(id)sender {
    self.selectTable.hidden = !self.selectTable.hidden;
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        return;
    }
    btn.selected = !btn.selected;
    self.selectCloudDiskButton.selected = !self.selectCloudDiskButton.selected;
}

- (IBAction)selectCloudDiskButtonAction:(id)sender {
    if (!self.selectTable.hidden) {
        self.selectTable.hidden = YES;
    }
    SHOWALERT(@"我马上就要出生了！")
    UIButton *btn = (UIButton *)sender;
    if (btn.selected) {
        return;
    }
    btn.selected = !btn.selected;
    self.selectAlbumButton.selected = !self.selectAlbumButton.selected;
}

- (void)updateAlbum{
    
    [CustomeClass mainQueue:^{
        WEAKSELF2
        
        //隐藏table
        //选择按钮更换文字
        //collectionview更换内容
        weakSelf.selectTable.hidden = !weakSelf.selectTable.hidden;
        [weakSelf.selectAlbumButton setTitle:weakSelf.selelctAlbumInfo.name forState:UIControlStateNormal];
        [weakSelf downloadImageInfo];
    }];
}

#pragma mark - getter

- (NSMutableArray *)albumInfoMuArray{
    if (!_albumInfoMuArray) {
        _albumInfoMuArray = [NSMutableArray new];
    }
    return _albumInfoMuArray;
}

- (NSMutableArray *)imageInfoMuArray{
    if (!_imageInfoMuArray) {
        _imageInfoMuArray = [NSMutableArray new];
    }
    return _imageInfoMuArray;
}

- (selectTableView *)selectTable{
    if (!_selectTable) {
        _selectTable = [[selectTableView alloc] initWithFrame:CGRectMake(0, 44, ISScreen_Width, ISScreen_Height - 108 - 132)];
        WEAKSELF2
        [_selectTable setSelectBlock:^(NSIndexPath *indexPath) {
            weakSelf.selelctAlbumInfo = weakSelf.albumInfoMuArray[indexPath.row];
            [weakSelf updateAlbum];
        }];
        _selectTable.hidden = YES;
        _selectTable.backgroundColor = ColorFromRGB(0x2E2E3A, 0.85);
    }
    return _selectTable;
}

- (ImageCollectionView *)imageCollectionView{
    if (!_imageCollectionView) {
        _imageCollectionView = [[ImageCollectionView alloc] initWithFrame:CGRectMake(0, 44, ISScreen_Width, ISScreen_Height - 108 - 132)];
        _imageCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_imageCollectionView setSelectBlock:^(NSIndexPath *indexPath) {
            
        }];
        _imageCollectionView.myNav = self.navigationController;
    }
    return _imageCollectionView;
}

- (NSMutableArray *)selectImageInfoMuArray{
    if (!_selectImageInfoMuArray) {
        _selectImageInfoMuArray = [NSMutableArray new];
    }
    return _selectImageInfoMuArray;
}

@end
