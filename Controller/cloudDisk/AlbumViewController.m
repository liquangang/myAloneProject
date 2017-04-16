//
//  AlbumViewController.m
//  M-Cut
//
//  Created by apple on 16/12/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AlbumViewController.h"
#import "UploadImageQualityView.h"
#import "CustomeClass.h"
#import "CloudFileViewController.h"
#import "UploadMaterialModel.h"
#import "VideoDBOperation.h"

@interface AlbumViewController ()
@property (nonatomic, strong) UploadImageQualityView *qualitySelectView;
@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVIGATIONBARTITLEVIEW(@"系统相册")
    self.footerHeight = 0;
    self.headerHeight = 0;
    [self.view addSubview:self.qualitySelectView];
    [self requestStatus];
}

#pragma mark - interface

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF2
    ImageCollectionViewCell *cell = [ImageCollectionViewCell ImageCollectionViewCellWithResuableStr:cellResuableStr IndexPath:indexPath CollectionView:collectionView CellInfo:self.imageInfoMuArray[indexPath.row]];
    
    [cell setSelectBlock:^(UIButton *selectButton) {
        [weakSelf handleSelectWithButton:selectButton Index:indexPath];
    }];
    
    if (self.isAllSelect) {
        cell.selectButton.selected = self.isAllSelect;
    }

    return cell;
}

- (void)isHiddenControlView:(BOOL)isHidden{
    [super isHiddenControlView:isHidden];
    
    if (isHidden) {
        self.qualitySelectView.hidden = YES;
    }else{
        self.qualitySelectView.hidden = NO;
        self.qualitySelectView.nextLabel.text = [NSString stringWithFormat:@"%lu  下一步", self.selectMuArray.count];
        [self.view bringSubviewToFront:self.imageCollectionView];
    }
}

- (void)downloadData{
    PHFetchResult *fetchResult = [SINGLETON(PhotoManager) getPhotoAlbum];
    
    for (PHAsset *asset in fetchResult) {
        PhotoModel *photoModel = [PhotoModel new];
        photoModel.asset = asset;
        photoModel.itemSize = CGSizeMake(self.itemWidth, self.itemWidth);
        [self.imageInfoMuArray addObject:photoModel];
    }
    [self.imageCollectionView reloadData];
}

- (void)requestStatus{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusDenied) {    //用户拒绝访问,提示用户去开启权限
        ALERT(@"您未打开相册访问的权限！")
    }  else {   //允许访问相册
        [self downloadData];
    }
}

- (void)nextStep{

    [CustomeClass mainQueue:^{
        WEAKSELF2
        CloudFileViewController *cloudFileVc = [CloudFileViewController new];
        cloudFileVc.selectArray = [weakSelf.selectMuArray copy];
        [weakSelf.navigationController pushViewController:cloudFileVc animated:YES];
    }];
}

- (void)rightBarButtonItemAction:(UIButton *)btn{
    [super rightBarButtonItemAction:btn];
    self.qualitySelectView.nextLabel.text = [NSString stringWithFormat:@"%lu  下一步", self.selectMuArray.count];
}

#pragma mark - getter

- (UploadImageQualityView *)qualitySelectView{
    
    if (!_qualitySelectView) {
        WEAKSELF2
        _qualitySelectView = [[UploadImageQualityView alloc] initWithFrame:CGRectMake(0, ISScreen_Height - 182 - 64, ISScreen_Width, 182)];
        _qualitySelectView.hidden = YES;
        
        [_qualitySelectView setNextStepBlock:^(ImageQualityType qualityType) {
            [weakSelf nextStep];
        }];
        
        [_qualitySelectView setSelectQualityBlock:^(ImageQualityType qualityType) {
            
        }];
        
        [_qualitySelectView setShowSelectTableBlock:^(BOOL isHidden) {
            
            [CustomeClass mainQueue:^{
                
                if (isHidden) {
                    [weakSelf.view bringSubviewToFront:weakSelf.imageCollectionView];
                }else{
                    [weakSelf.view bringSubviewToFront:weakSelf.qualitySelectView];
                }
            }];
        }];
    }
    return _qualitySelectView;
}

@end
