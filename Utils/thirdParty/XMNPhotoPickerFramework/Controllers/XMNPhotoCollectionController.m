//
//  XMNPhotoCollectionController.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/29.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNPhotoCollectionController.h"
#import "XMNPhotoPickerController.h"
#import "XMNPhotoPreviewController.h"
#import "XMNVideoPreviewController.h"
#import "XMNAssetModel.h"
#import "XMNPhotoManager.h"
#import "XMNAssetCell.h"
#import "XMNBottomBar.h"
#import "UIViewController+XMNPhotoHUD.h"
#import "CustomeClass.h"
#import "SelectMaterialArray.h"
#import "App_vpVDCOrderForCreate.h"

static NSString * const kXMNAssetCellIdentifier = @"XMNAssetCell";

@interface XMNPhotoCollectionController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
/** 底部状态栏 */
@property (nonatomic, weak)   XMNBottomBar *bottomBar;
/** 相册内所有的资源 */
@property (nonatomic, copy)   NSArray<XMNAssetModel *> *assets;
@property (nonatomic, strong) UIImagePickerController * imagePickerVc;
@property (nonatomic, assign) BOOL isFirst;
//用来匹配的字典
@property (nonatomic, strong) NSMutableDictionary *useMatchURLDic;
@end

@implementation XMNPhotoCollectionController

DEALLOCMETHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    [self.useMatchURLArray addObjectsFromArray:[SINGLETON(SelectMaterialArray).selectAssModelURLMuArray copy]];
    [self.useMatchURLDic setDictionary:[SINGLETON(SelectMaterialArray).selectAssModelFileNameMuDic copy]];
    
    self.navigationItem.title = self.album.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(_handleCancelAction)];
    
    // 初始化collectionView的一些属性
    [self _setupCollectionView];
    [self _setupConstraints];
    [self downloadDataWithStatus:0];
    
    if ([self.album.name isEqualToString:@"最近添加"] || [self.album.name isEqualToString:@"相机胶卷"]) {
        [self.bottomBar setTakePhotoButtonHidden:NO];
    }else{
        [self.bottomBar setTakePhotoButtonHidden:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.bottomBar updateBottomBarWithAssets:[SINGLETON(SelectMaterialArray).selectArray copy]];
}

#pragma mark - imagePickerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    WEAKSELF2
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        [[XMNPhotoManager sharedManager] savePhotoWithImage:image completion:^{
            
            //重新加载数据
            [weakSelf reloadPhoto];
        }];
        
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WEAKSELF2
    XMNAssetCell *assetCell = [collectionView dequeueReusableCellWithReuseIdentifier:kXMNAssetCellIdentifier forIndexPath:indexPath];
    XMNAssetModel *assModel = self.assets[indexPath.row];
    [assetCell configCellWithItem:assModel];
    assetCell.photoStateButton.selected = NO;
    
    [self judgeSelectStatusWithAssModel:assModel Complete:^(BOOL isSelect) {
       [CustomeClass mainQueue:^{
           assetCell.photoStateButton.selected = isSelect;
       }];
    }];

    [assetCell setUpdateBottomBarBlock:^{
        MAINQUEUEUPDATEUI({
            [weakSelf.bottomBar updateBottomBarWithAssets:[SINGLETON(SelectMaterialArray).selectArray copy]];
        })
    }];
    
    return assetCell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XMNPhotoPreviewController *previewC = [[XMNPhotoPreviewController alloc] initWithCollectionViewLayout:[XMNPhotoPreviewController photoPreviewViewLayoutWithSize:[UIScreen mainScreen].bounds.size]];
    previewC.assets = self.assets;
    previewC.selectedAssets = SINGLETON(SelectMaterialArray).selectArray;
    previewC.currentIndex = indexPath.row;
    previewC.maxCount = 20 - SINGLETON(SelectMaterialArray).selectArray.count;
    
    __weak typeof(*&self) wSelf = self;
    [previewC setDidFinishPreviewBlock:^(NSArray<XMNAssetModel *> *selectedAssets) {
        __weak typeof(*&self) self = wSelf;
        
        [self.bottomBar updateBottomBarWithAssets:[SINGLETON(SelectMaterialArray).selectArray copy]];
        [self.collectionView reloadData];
    }];
    
    [previewC setDidFinishPickingBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *selectedAssets) {
        __weak typeof(*&self) self = wSelf;
        [(XMNPhotoPickerController *)self.navigationController didFinishPickingPhoto:selectedAssets];
    }];
    
    [self.navigationController pushViewController:previewC animated:YES];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - interface

- (void)judgeSelectStatusWithAssModel:(XMNAssetModel *)assModel Complete:(void(^)(BOOL isSelect))completeBlock{
    
    [CustomeClass backgroundAsyncQueue:^{
        WEAKSELF2
        
        if (weakSelf.useMatchURLDic.count == 0) {
            if (assModel.selectStatus == unKnow) {
                assModel.selectStatus = unSelect;
            }
        }else{
            
            if (assModel.selectStatus == unKnow) {
                if (weakSelf.useMatchURLDic[assModel.filename]) {
                    assModel.selectStatus = selected;
                    [weakSelf.useMatchURLDic removeObjectForKey:assModel.filename];
                }else{
                    assModel.selectStatus = unSelect;
                }
            }
        }
        
        completeBlock(assModel.selectStatus - 1);
    }];
}

- (void)_handleCancelAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    XMNPhotoPickerController *photoPickerVC = (XMNPhotoPickerController *)self.navigationController;
    [photoPickerVC didCancelPickingPhoto];
}

/** 未允许使用相机权限*/
- (void)showMessage{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"请在iphone的“设置-隐私-相机”选项中，允许映像访问你的相机" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert removeFromParentViewController];
    }];
    [alert addAction:alertAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)_setupConstraints {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:50.0f]];
}

- (void)_setupCollectionView {
    self.collectionView.decelerationRate = 0;
    self.collectionView.opaque = YES;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(4, 4, 54, 4);
    [self.collectionView registerNib:[UINib nibWithNibName:kXMNAssetCellIdentifier bundle:nil] forCellWithReuseIdentifier:kXMNAssetCellIdentifier];
    
    XMNBottomBar *bottomBar = [[XMNBottomBar alloc] initWithBarType:XMNCollectionBottomBar];
    bottomBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    __weak typeof(*&self) wSelf = self;
    [bottomBar setConfirmBlock:^{
        [(XMNPhotoPickerController *)wSelf.navigationController didFinishPickingPhoto:[SINGLETON(SelectMaterialArray).selectArray copy]];
    }];
    
    WEAKSELF(weakSelf);
    [bottomBar setTakePhotoBlock:^{
        [weakSelf takePhoto];
    }];
    [self.view addSubview:self.bottomBar = bottomBar];
}

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) && iOS8Later) {
        [self showMessage];
    } else {
        
        // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

/** status ： 状态为0时为默认状态，从相册中第一次加载，如果为1则是从拍照界面返回的加载情况*/
- (void)downloadDataWithStatus:(NSInteger)status{
    [CustomeClass hudShowWithView:self.view Tag:123];
    
    //从相册中获取所有的资源model
    WEAKSELF2
    [[XMNPhotoManager sharedManager] getAssetsFromResult:self.album.fetchResult pickingVideoEnable:[(XMNPhotoPickerController *)self.navigationController pickingVideoEnable] completionBlock:^(NSArray<XMNAssetModel *> *assets) {
        
        NSMutableArray *tempArray = [NSMutableArray new];
        
        if (status == 0) {
            [tempArray addObjectsFromArray:assets];
        }
        
        if (status == 1) {
            XMNAssetModel * assModel = assets[assets.count - 1];
            assModel.selectStatus = selected;
            [tempArray addObjectsFromArray:weakSelf.assets];
            [tempArray addObject:assModel];
            [SINGLETON(SelectMaterialArray) addMaterial:assModel];
            
            MAINQUEUEUPDATEUI({
                [weakSelf.bottomBar updateBottomBarWithAssets:[SINGLETON(SelectMaterialArray).selectArray copy]];
            })
            
        }
        
        weakSelf.assets = [NSArray arrayWithArray:[tempArray copy]];
        
//        [CustomeClass backgroundAsyncQueue:^{
//            
//            if (status == 0) {
//                dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//                dispatch_apply(weakSelf.assets.count, queue, ^(size_t index) {
//                    XMNAssetModel *assModel = weakSelf.assets[index];
//                    
//                    if (weakSelf.useMatchURLDic.count == 0) {
//                        if (assModel.selectStatus == unKnow) {
//                            assModel.selectStatus = unSelect;
//                        }
//                    }else{
//                        
//                        if (assModel.selectStatus == unKnow) {
//                            NSString *fileName = assModel.filename;
//                            if (weakSelf.useMatchURLDic[fileName]) {
//                                assModel.selectStatus = selected;
//                                [weakSelf.useMatchURLDic removeObjectForKey:fileName];
//                            }else{
//                                assModel.selectStatus = unSelect;
//                            }
//                        }
//                    }
//                });
//            }
//        }];
        
        
        MAINQUEUEUPDATEUI({
            [CustomeClass hudHiddenWithView:weakSelf.view Tag:123];
            [weakSelf.collectionView reloadData];
            [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:weakSelf.assets.count - 1 inSection:0]
                                            atScrollPosition:UICollectionViewScrollPositionBottom
                                                    animated:NO];
        })
    }];
}

- (void)reloadPhoto{
    
    //重新加载该页面来获得刚才拍照的素材，目前采用这种方法，不合适，但未找到其他方法
    __weak typeof(*&self) wSelf = self;
    [[XMNPhotoManager sharedManager] getAlbumsPickingVideoEnable:[(XMNPhotoPickerController *)self.navigationController pickingVideoEnable] completionBlock:^(NSArray<XMNAlbumModel *> *albums) {
        wSelf.album = albums[wSelf.collectionViewIndexPath.row];
        [wSelf downloadDataWithStatus:1];
    }];
}

#pragma mark - Getters

+ (UICollectionViewLayout *)photoCollectionViewLayoutWithWidth:(CGFloat)width {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = kXMNMargin;
    layout.itemSize = kXMNThumbnailSize;
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    return layout;
}

- (NSArray<XMNAssetModel *> *)assets{
    if (!_assets) {
        _assets = [NSArray new];
    }
    return _assets;
}

- (UIImagePickerController *)imagePickerVc {
    
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        
        if (iOS9Later) {
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (NSMutableDictionary *)useMatchURLDic{
    if (!_useMatchURLDic) {
        _useMatchURLDic = [NSMutableDictionary new];
    }
    return _useMatchURLDic;
}

@end
