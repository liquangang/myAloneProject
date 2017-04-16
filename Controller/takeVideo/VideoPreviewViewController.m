//
//  VideoPreviewViewController.m
//  M-Cut
//
//  Created by apple on 16/10/29.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoPreviewViewController.h"
#import "VideoPreviewCollectionViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

static NSString * const resuabelStr = @"VideoPreviewCollectionViewCell";

@interface VideoPreviewViewController ()<UICollectionViewDelegate,
                                         UICollectionViewDataSource>
//collectionview
@property (nonatomic, strong) UICollectionView * videoPreviewCollectionView;
//播放状态
@property (nonatomic, assign) BOOL isPlay;
//播放器
@property (nonatomic, strong) AVPlayer * videoPalyer;
//播放器layer
@property (nonatomic, strong) AVPlayerLayer * playerLayer;
@end

@implementation VideoPreviewViewController

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

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return self.videoDataMuArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.videoPalyer) {
        [self.playerLayer removeFromSuperlayer];
        self.playerLayer = nil;
        self.videoPalyer = nil;
        self.isPlay = NO;
    }
    VideoPreviewCollectionViewCell * cell = [VideoPreviewCollectionViewCell VideoPreviewCollectionViewCellWithTable:collectionView
                                                                                                        ResuableStr:resuabelStr
                                                                                                          IndexPath:indexPath
                                                                                                           AssModel:self.videoDataMuArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TempVideoOBj * tempVideoObj = self.videoDataMuArray[indexPath.row];
    [self setPlayerWithPath:tempVideoObj.videoUrl];
}


#pragma mark - 功能模块

/**
 *  播放完成
 */
- (void)playFinish:(NSNotification *)noti{
    [self.videoPreviewCollectionView reloadData];
}

- (void)setUI{
    [self.videoPreviewCollectionView scrollToItemAtIndexPath:self.showIndex
                                            atScrollPosition:UICollectionViewScrollPositionNone
                                                    animated:YES];
    NAVIGATIONBACKBARBUTTONITEM
    NAVIGATIONBARTITLEVIEW(@"视频预览")
}

NAVIGATIONBACKITEMMETHOD

/**
 *  设置播放器
 */
- (void)setPlayerWithPath:(NSString *)videoPath{
    if (!self.isPlay) {
        //此时需要播放
        NSURL * videoUrl = [NSURL fileURLWithPath:videoPath];
        AVPlayerItem * playItem = [AVPlayerItem playerItemWithURL:videoUrl];
        self.videoPalyer = [AVPlayer playerWithPlayerItem:playItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.videoPalyer];
        self.playerLayer.frame = CGRectMake(0, 0, ISScreen_Width, ISScreen_Height);
        [self.view.layer addSublayer:self.playerLayer];
        [self.videoPalyer play];
        REGISTEREDNOTI(playFinish:, AVPlayerItemDidPlayToEndTimeNotification);
        self.isPlay = YES;
    }else{
        [self.videoPreviewCollectionView reloadData];
    }
}

#pragma mark - 懒加载
- (UICollectionView *)videoPreviewCollectionView{
    if (!_videoPreviewCollectionView) {
        UICollectionViewFlowLayout * collectionFlowLayout = [UICollectionViewFlowLayout new];
        collectionFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        collectionFlowLayout.itemSize = CGSizeMake(ISScreen_Width, ISScreen_Height);
        collectionFlowLayout.minimumLineSpacing = 0;
        collectionFlowLayout.minimumInteritemSpacing = 0;
        collectionFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _videoPreviewCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,
                                                                                         0,
                                                                                         ISScreen_Width,
                                                                                         ISScreen_Height)
                                                         collectionViewLayout:collectionFlowLayout];
        [self.view addSubview:_videoPreviewCollectionView];
        _videoPreviewCollectionView.delegate = self;
        _videoPreviewCollectionView.dataSource = self;
        _videoPreviewCollectionView.pagingEnabled = YES;
        
        //注册cell
        [_videoPreviewCollectionView registerNib:[UINib nibWithNibName:resuabelStr bundle:nil]
                      forCellWithReuseIdentifier:resuabelStr];
    }
    return _videoPreviewCollectionView;
}
@end
