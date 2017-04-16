//
//  HomepageSecondViewController.m
//  M-Cut
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "HomepageViewController.h"
#import "VideoDBOperation.h"
#import "SoapOperation.h"
#import "CustomeClass.h"
#import "ActivityViewController.h"
#import "VideoLabelDetailViewController.h"
#import "HomeSearchViewController.h"
#import "PlayerView.h"
#import "HomePageBelowCollectionViewCell.h"
#import "ZFDownloadManager.h"
#import "LoginAndRegister.h"
#import "VideoLabelViewController.h"
#import "GuidePlayView.h"
#import "HomePageLabelModel.h"
#import "AFNetWorkManager.h"

@interface HomepageViewController ()<UICollectionViewDelegate,
                                     UICollectionViewDataSource>
/** 界面数据源*/
@property (nonatomic, strong) NSMutableArray * belowLabelMuArray;
@property (nonatomic, strong) NSMutableArray * aboveLabelMuArray;
@property (nonatomic, strong) UICollectionView * homeCollectionView;
/** 播放器*/
@property (nonatomic, strong) AVPlayerViewController * videoPlayerVc;
/** 影集上面的部分*/
@property (nonatomic, strong) PlayerView * myPlayView;
/** 播放状态*/
@property (nonatomic, assign) BOOL isPlay;
/** 下载状态*/
@property (nonatomic, assign) BOOL isDownload;
/** 本地url*/
@property (nonatomic, copy) NSString * localHomePageVideoUrl;
@property (nonatomic, strong) UIView * launchView;
@end

@implementation HomepageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //注册app进入前台通知
    REGISTEREDNOTI(playVideo:, APPFOREGROUND);
    //注册app进入后台通知
    REGISTEREDNOTI(pauseVideo:, APPBACKGROUND);
    //上部标签跳转的通知
    REGISTEREDNOTI(pushToVideoLabelDetailVc:, PUSHTOVIDEOLABELDETAILVC);
    //跳转搜索页面的通知
    REGISTEREDNOTI(pushToSearchVc:, PUSHTOSEARCHVC);
    //注册网络监听
    REGISTEREDNOTI(networkUpdate:, networkStatus);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.videoPlayerVc.player play];
    //禁止侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //打开侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.videoPlayerVc.player pause];
}

#pragma mark - alertDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:APPSTOREURL];
    }
}

#pragma mark - CollectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView
          layout:(UICollectionViewLayout *)collectionViewLayout
          referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ISScreen_Width, ISScreen_Width / 3 * 2 + 114);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView * headerView =
    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                       withReuseIdentifier:@"headerResuableStr"
                                              forIndexPath:indexPath];
    if (![self.myPlayView.superview isEqual:headerView]) {
        [headerView addSubview:self.myPlayView];
    }
    return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.belowLabelMuArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [HomePageBelowCollectionViewCell getHomePageBelowCollectionViewCellWithCollectionView:collectionView
                                                                                        CellInfo:self.belowLabelMuArray[indexPath.item]
                                                                                       CellIndex:indexPath
                                                                                     ResuableStr:@"belowResuableStr"];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self pushToVideoLabelDetailVcWithVideoLabelInfo:self.belowLabelMuArray[indexPath.row]];
}

#pragma mark - 功能模块

/**
 *  监听网络状态
 */
- (void)networkUpdate:(NSNotification *)noti{
    NSInteger networkStatus = [noti.userInfo[networkStatusDes] integerValue];
    static BOOL isStart = NO;
    
    if ((networkStatus == AFNetworkReachabilityStatusReachableViaWWAN || networkStatus == AFNetworkReachabilityStatusReachableViaWiFi) && !isStart) {
        isStart = YES;
        
        //下载数据
        [self downloadDataWithOffset:0];
    }
}

/**
 *  请求数据，刷新view
 */
- (void)downloadDataWithOffset:(NSInteger)offset{
    [CustomeClass HUDshow:self.view Tag:1234567890];
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_getvideolabelsexWithVideoLabelLocation:2 Offset:offset Count:666 Success:^(NSMutableArray *serverDataArray){
        [CustomeClass HUDhidden:weakSelf.view Tag:1234567890];
                                                                     
         //如果传入的起始位置是0，认为是从头开始，所以移除所有元素
         if (offset == 0) {
             [weakSelf.belowLabelMuArray removeAllObjects];
         }
        
        for (MovierDCInterfaceSvc_VDCVideoLabelEx2 *labelInfo in serverDataArray) {
            HomePageLabelModel *labelModel = [HomePageLabelModel new];
            labelModel.labelInfo = labelInfo;
            [weakSelf.belowLabelMuArray addObject:labelModel];
        }
        
        MAINQUEUEUPDATEUI({
            [weakSelf.homeCollectionView reloadSections:[[NSIndexSet alloc] initWithIndex:0]];
        })
     } Fail:^(NSError *error) {
         if (error.code != 6) {
             RELOADSERVERDATA([weakSelf downloadDataWithOffset:offset];)
         }
     }];
}

//首页视频下载
- (void)downloadHomePageVideo{
    WEAKSELF2
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        [[SoapOperation Singleton] WS_gethomepagebackgroundSuccess:^(NSString *serverString) {
            [weakSelf downloadManagerDownloadWithServerStr:serverString];
        } Fail:^(NSError *error) {
            RELOADSERVERDATA([weakSelf downloadHomePageVideo];)
        }];
    }, )
}

- (void)downloadManagerDownloadWithServerStr:(NSString *)serverStr{
    WEAKSELF2
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        [[ZFDownloadManager sharedDownloadManager] downFileUrl:serverStr
                                                      filename:[serverStr lastPathComponent]
                                                     fileimage:nil
                                                   ReturnBlock:^(BOOL isDownload, NSString *filePath) {
                                                       weakSelf.isDownload = isDownload;
                                                       [weakSelf setVideoPlayerWithPath:filePath];
                                                   }];
    }, {})
}

#pragma mark - 上面搜索部分和标签部分的跳转
- (void)pushToVideoLabelDetailVc:(NSNotification *)noti{
    [self pushToVideoLabelDetailVcWithVideoLabelInfo:noti.userInfo[@"videoLabelInfo"]];
}

- (void)pushToVideoLabelDetailVcWithVideoLabelInfo:(HomePageLabelModel *)labelModel{
    MovierDCInterfaceSvc_VDCVideoLabelEx2 *videoLabelInfo = labelModel.labelInfo;
    
    if ([videoLabelInfo.szLabelName isEqualToString:@"活动"] ||
        [videoLabelInfo.szLabelName isEqualToString:@"热门活动"]) {
        ActivityViewController * activityVC = [ActivityViewController new];
        activityVC.activityLabelId = [NSString stringWithFormat:@"%@", videoLabelInfo.nLabelID];
        activityVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:activityVC animated:YES];
    }else{
        VideoLabelViewController *videoLabelVc = [VideoLabelViewController new];
        videoLabelVc.hidesBottomBarWhenPushed = YES;
        videoLabelVc.labelInfo = videoLabelInfo;
        [self.navigationController pushViewController:videoLabelVc animated:YES];
    }
}

- (void)pushToSearchVc:(NSNotification *)noti{
    HomeSearchViewController * homeSearchVc = [HomeSearchViewController new];
    homeSearchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:homeSearchVc animated:YES];
}

#pragma mark - 播放器部分
- (void)setVideoPlayerWithPath:(NSString *)videoPath{
    MAINQUEUEUPDATEUI({
        self.isPlay = YES;
        NSURL * videoUrl;
        if ([videoPath containsString:@"http"]) {
            videoUrl = [NSURL URLWithString:videoPath];
        }else{
            self.localHomePageVideoUrl = videoPath;
            videoUrl = [NSURL fileURLWithPath:videoPath];
        }
        self.videoPlayerVc = nil;
        self.videoPlayerVc = [AVPlayerViewController new];
        AVPlayerItem * playItem = [[AVPlayerItem alloc] initWithURL:videoUrl];
        self.videoPlayerVc.player = [AVPlayer playerWithPlayerItem:playItem];
        CGFloat playerViewH = ISScreen_Width / 3 * 2;
        CGFloat playerViewW = playerViewH / 9 * 16;
        self.videoPlayerVc.view.frame = CGRectMake( - (playerViewW - ISScreen_Width) / 2 ,
                                                   0,
                                                   playerViewW,
                                                   playerViewH);
        [self.myPlayView insertSubview:self.videoPlayerVc.view
                          belowSubview:self.myPlayView.mySearchView];
        self.videoPlayerVc.player.volume = 0;
        self.videoPlayerVc.showsPlaybackControls = NO;
        [self.videoPlayerVc.player play];
        self.isPlay = YES;
        REGISTEREDNOTI(videoPlayFinished:, AVPlayerItemDidPlayToEndTimeNotification);
    })
}

//视频播放完成的通知方法
- (void)videoPlayFinished:(NSNotification *)noti{
    self.isPlay = YES;
    if (self.isDownload && self.localHomePageVideoUrl.length > 0) {
        self.videoPlayerVc.player = nil;
        NSURL * videoURL = [NSURL fileURLWithPath:self.localHomePageVideoUrl];
        AVPlayerItem * playItem = [[AVPlayerItem alloc] initWithURL:videoURL];
        self.videoPlayerVc.player = [AVPlayer playerWithPlayerItem:playItem];
        self.videoPlayerVc.player.volume = 0;
        [self.videoPlayerVc.player play];
        self.isPlay = YES;
    }else{
        [self downloadHomePageVideo];
    }
}

- (void)playVideoWhenPause{
    if (!self.isPlay) {
        [self.videoPlayerVc.player play];
        self.isPlay = YES;
    }
}

- (void)pauseVideoWhenPlay{
    if (self.isPlay) {
        [self.videoPlayerVc.player pause];
        self.isPlay = NO;
    }
}

- (void)playVideo:(NSNotification *)noti{
    [self playVideoWhenPause];
}

- (void)pauseVideo:(NSNotification *)noti{
    [self pauseVideoWhenPlay];
}

#pragma mark - 懒加载

- (NSMutableArray *)belowLabelMuArray{
    if (!_belowLabelMuArray) {
        _belowLabelMuArray = [NSMutableArray new];
    }
    return _belowLabelMuArray;
}

- (NSMutableArray *)aboveLabelMuArray{
    if (!_aboveLabelMuArray) {
        _aboveLabelMuArray = [NSMutableArray new];
    }
    return  _aboveLabelMuArray;
}

- (PlayerView *)myPlayView{
    if (!_myPlayView) {
        _myPlayView = [[PlayerView alloc] initWithFrame:CGRectMake(0,
                                                                   0,
                                                                   ISScreen_Width,
                                                                   ISScreen_Width / 3 * 2 + 114)];
        //设置背景图片或者视频内容
        [self downloadHomePageVideo];
        [self.view addSubview:_myPlayView];
    }
    return _myPlayView;
}

- (UICollectionView *)homeCollectionView{
    if (!_homeCollectionView) {
        
        //初始化collectionView
        UICollectionViewFlowLayout * homeCollectionViewFlowLayout = [UICollectionViewFlowLayout new];
        homeCollectionViewFlowLayout.itemSize = CGSizeMake(ISScreen_Width / 2 - 0.5, ISScreen_Width / 2 - 0.5);
        homeCollectionViewFlowLayout.minimumLineSpacing = 1;
        homeCollectionViewFlowLayout.minimumInteritemSpacing = 1;
        
        _homeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                 0,
                                                                                 ISScreen_Width,
                                                                                 ISScreen_Height - 49)
                                                 collectionViewLayout:homeCollectionViewFlowLayout];
        _homeCollectionView.dataSource = self;
        _homeCollectionView.delegate = self;
        _homeCollectionView.showsVerticalScrollIndicator = NO;
        _homeCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_homeCollectionView registerClass:[HomePageBelowCollectionViewCell class]
                forCellWithReuseIdentifier:@"belowResuableStr"];
        [_homeCollectionView registerClass:[UICollectionReusableView class]
                forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                       withReuseIdentifier:@"headerResuableStr"];
        _homeCollectionView.opaque = YES;
        _homeCollectionView.decelerationRate = 1;
        
        [self.view addSubview:_homeCollectionView];
    }
    return _homeCollectionView;
}

@end
