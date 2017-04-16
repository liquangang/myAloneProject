//
//  XMNPhotoPreviewController.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/29.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNPhotoPreviewController.h"
#import "XMNPhotoPickerController.h"
#import "XMNAssetModel.h"
#import "XMNPhotoPickerDefines.h"
#import "XMNBottomBar.h"
#import "XMNPhotoPreviewCell.h"
#import "UIView+Animations.h"
#import "UIViewController+XMNPhotoHUD.h"
#import "XMNPhotoManager.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "UserEntity.h"
#import "CustomeClass.h"
#import "SelectMaterialArray.h"
#import "XMNAssetCell.h"

static NSString * const kXMNPhotoPreviewIdentifier = @"XMNPhotoPreviewCell";

@interface XMNPhotoPreviewController ()
@property (nonatomic, strong) UIView *topBar;
@property (nonatomic, weak)   UIButton *stateButton;
@property (nonatomic, strong) XMNBottomBar *bottomBar;
@property (nonatomic, strong) AVPlayerItem * playItem;
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) AVPlayerLayer * playerLayer;
@property (nonatomic, strong) XMNAssetModel *assModel;
@end

@implementation XMNPhotoPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.currentIndex inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    [self _setup];
    [self _setupCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    NSLog(@"preview dealloc");
}

#pragma mark - Methods

- (void)_setup {
    [self.view addSubview:self.topBar];
//    [self.view addSubview:self.bottomBar];
    [self _updateTopBarStatus];
//    [self _setupConstraints]; 
}

- (void)_setupCollectionView {
    self.collectionView.opaque = YES;
    self.collectionView.decelerationRate = 0;
    [self.collectionView registerClass:[XMNPhotoPreviewCell class] forCellWithReuseIdentifier:kXMNPhotoPreviewIdentifier];
    self.collectionView.backgroundColor = [UIColor blackColor];
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.contentSize = CGSizeMake(self.view.frame.size.width * self.assets.count, self.view.frame.size.height);
    self.collectionView.pagingEnabled = YES;
}

- (void)_setupConstraints {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomBar attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:50.0f]];
}

- (void)_handleBackAction {
    self.didFinishPreviewBlock ? self.didFinishPreviewBlock(self.selectedAssets) : nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)_handleStateChangeAction {
    
    //如果是已经添加到创建页面的话，提示不能取消
    if (self.stateButton.selected && [SINGLETON(SelectMaterialArray) isAlreadyAddWithAssModel:self.assModel]) {
        ALERT(@"素材已添加！")
        return;
    }
    
    if (self.stateButton.selected) {
        
        //已选中，此时需取消选中
        [SINGLETON(SelectMaterialArray) deleteMaterialWithAssModel:self.assModel];
        
        //更改bottombar
//        [self.bottomBar updateBottomBarWithAssets:SINGLETON(SelectMaterialArray).selectArray];
        
    }else {
        if ([SINGLETON(SelectMaterialArray) addMaterial:self.assModel]) {
//            [self.bottomBar updateBottomBarWithAssets:SINGLETON(SelectMaterialArray).selectArray];
        }
    }
    
    self.stateButton.selected = !self.stateButton.selected;
    
    if (self.stateButton.selected) {
        self.assModel.selectStatus = selected;
    }else{
        self.assModel.selectStatus = unSelect;
    }
}

- (void)_updateTopBarStatus {
    WEAKSELF2
    XMNAssetModel *asset = self.assets[self.currentIndex];
    [XMNAssetCell judgeSelectStatusWithSelectMaterialArray:[SINGLETON(SelectMaterialArray).selectArray copy] NeedJudgeModel:asset Completeblock:^(BOOL isSelect) {
        MAINQUEUEUPDATEUI({
            weakSelf.stateButton.selected = isSelect;
        })
    }];
}

- (void)_setBarHidden:(BOOL)hidden animated:(BOOL)animated {
    
    if (!animated) {
//        self.topBar.hidden = self.bottomBar.hidden = hidden;
        self.topBar.hidden = hidden;
        return;
    }
    
    [UIView animateWithDuration:.15 animations:^{
//        self.topBar.alpha = self.bottomBar.alpha = hidden ? .0f : 1.0f;
        self.topBar.alpha = hidden ? .0f : 1.0f;
    } completion:^(BOOL finished) {
//        self.topBar.hidden = self.bottomBar.hidden = hidden;
        self.topBar.hidden = hidden;
    }];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offSet = scrollView.contentOffset;
    self.currentIndex = offSet.x / self.view.frame.size.width;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self _updateTopBarStatus];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XMNPhotoPreviewCell *previewCell = [collectionView dequeueReusableCellWithReuseIdentifier:kXMNPhotoPreviewIdentifier forIndexPath:indexPath];
    XMNAssetModel * assModel = self.assets[indexPath.row];
    [previewCell configCellWithItem:assModel];
    
    __weak typeof(*&self) wSelf = self;
    [previewCell setSingleTapBlock:^{
        __weak typeof(*&self) self = wSelf;
        [self _setBarHidden:!self.topBar.hidden animated:YES];
        
        
    }];
    
    [previewCell setSetPlayer:^{
        __weak typeof(*&self) wSelf = self;
        [[XMNPhotoManager sharedManager] getVideoInfoWithAsset:assModel.asset completionBlock:^(AVPlayerItem *playerItem, NSDictionary *playetItemInfo) {
            dispatch_async(dispatch_get_main_queue(), ^{
                __weak typeof(*&self) self = wSelf;
                self.playItem = nil;
                self.player = nil;
                self.playerLayer = nil;
                self.player = [AVPlayer playerWithPlayerItem:playerItem];
                self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
                self.playerLayer.frame = self.view.bounds;
                [self.view.layer addSublayer:self.playerLayer];
                [self.player play];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pausePlayer) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
                UIView * tapView = [[UIView alloc] initWithFrame:self.view.bounds];
                [self.view addSubview:tapView];
                tapView.backgroundColor = [UIColor clearColor];
                tapView.tag = 123456;
                ADDTAPGESTURE(tapView, removePlayer);
            });
        }];
    }];
    
    return previewCell;
}

- (void)pausePlayer{
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    [self.player pause];
    [self.playerLayer removeFromSuperlayer];
}

- (void)removePlayer:(UITapGestureRecognizer *)tap{
    [self pausePlayer];
    UIView * tapView = tap.view;
    [tapView removeFromSuperview];
}

/// ========================================
/// @name   重写了collection的两个代理方法,通过预加载
/// 释放 previewImage 来节约内存
/// ========================================

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    XMNAssetModel *model = self.assets[indexPath.row];
    model.previewImage = nil;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    XMNAssetModel *model = self.assets[indexPath.row];
    [model previewImage];
}

#pragma mark - Getters

- (UIView *)topBar {
    if (!_topBar) {
        CGFloat originY = iOS7Later ? 20 : 0;
        _topBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, originY + 44)];
        _topBar.backgroundColor = [UIColor colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:.7f];
        
        UIButton *backButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"navigation_back"] forState:UIControlStateNormal];
        [backButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        [backButton sizeToFit];
        backButton.frame = CGRectMake(12, _topBar.frame.size.height/2 - backButton.frame.size.height/2 + originY/2, backButton.frame.size.width, backButton.frame.size.height);
        [backButton addTarget:self action:@selector(_handleBackAction) forControlEvents:UIControlEventTouchUpInside];
        [_topBar addSubview:backButton];
        
        UIButton *stateButton  = [UIButton buttonWithType:UIButtonTypeCustom];
        [stateButton setImage:[UIImage imageNamed:@"photo_state_normal"] forState:UIControlStateNormal];
        [stateButton setImage:[UIImage imageNamed:@"photo_state_selected"] forState:UIControlStateSelected];
        [stateButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
        [stateButton sizeToFit];
        stateButton.frame = CGRectMake(_topBar.frame.size.width - 12 - stateButton.frame.size.width, _topBar.frame.size.height/2 - stateButton.frame.size.height/2 + originY/2, stateButton.frame.size.width, stateButton.frame.size.height);
        [stateButton addTarget:self action:@selector(_handleStateChangeAction) forControlEvents:UIControlEventTouchUpInside];
        [_topBar addSubview:self.stateButton = stateButton];
    }
    return _topBar;
}

- (XMNBottomBar *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [[XMNBottomBar alloc] initWithBarType:XMNPreviewBottomBar];
        _bottomBar.translatesAutoresizingMaskIntoConstraints = NO;
        [_bottomBar setTimeViewHidden:YES];
        [_bottomBar updateBottomBarWithAssets:SINGLETON(SelectMaterialArray).selectArray];
        
        __weak typeof(*&self) wSelf = self;
        [_bottomBar setConfirmBlock:^{
            __weak typeof(*&self) self = wSelf;
            NSMutableArray *images = [NSMutableArray array];
            [self.selectedAssets enumerateObjectsUsingBlock:^(XMNAssetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [images addObject:obj];
            }];
            self.didFinishPickingBlock ? self.didFinishPickingBlock(images,SINGLETON(SelectMaterialArray).selectArray) : nil;
        }];
    }
    return _bottomBar;
}

+ (UICollectionViewLayout *)photoPreviewViewLayoutWithSize:(CGSize)size {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(size.width, size.height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    return layout;
}

- (XMNAssetModel *)assModel{
    _assModel = self.assets[self.currentIndex];
    return _assModel;
}

@end
