//
//  VideoLabelViewController.m
//  M-Cut
//
//  Created by apple on 16/11/26.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoLabelViewController.h"
#import "WaterLayout.h"
#import "VideoDetailCollectionViewCell.h"
#import "ActivityDetailView.h"
#import "SoapOperation.h"
#import "CustomeClass.h"
#import "MJRefresh.h"
#import "UserEntity.h"
#import "MyVideoViewController.h"
#import "WkWebViewViewController.h"
#import "VideoDetailViewController.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "ISCutProViewController.h"
#import "ISStyleDetailCell.h"

static NSString *const itemResuableStr = @"VideoDetailCollectionViewCell";
static NSString *const headerResuableStr = @"headerResuableStr";
static NSString *const footerResuableStr = @"footerResuableStr";
static NSInteger const donwloadNum = 16;

@interface VideoLabelViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIAlertViewDelegate>
@property (nonatomic, strong) UICollectionView *videoCollectionView;
@property (nonatomic, strong) NSMutableArray *videoInfoMuArray;
@property (nonatomic, strong) ActivityDetailView * activityDetailView;
@property (nonatomic, strong) UIButton *joinButton;
@property (nonatomic, assign) BOOL isDownloadHeaderData;
@property (nonatomic, strong) WaterLayout *waterLayout;
@property (nonatomic, assign) NSInteger loadNum;
@end

@implementation VideoLabelViewController

DEALLOCMETHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    NAVIGATIONBARTITLEVIEW(self.labelInfo.szLabelName)
    NAVIGATIONBACKBARBUTTONITEM
    self.loadNum = donwloadNum;
    [self downloadDataWithStart:0];
    [self isShowJoinButton];
}

#pragma mark - collectionview 代理

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%lu", (unsigned long)self.videoInfoMuArray.count);
    return self.videoInfoMuArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [VideoDetailCollectionViewCell getVideoDetailCollectionViewCellWithCollectionView:collectionView
                                                                                    ItemInfo:self.videoInfoMuArray[indexPath.item]
                                                                               ItemIndexPath:indexPath
                                                                            ReuserIdentifier:itemResuableStr];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                  withReuseIdentifier:headerResuableStr
                                                                                         forIndexPath:indexPath];
        if (headerView.subviews.count == 0) {
            [headerView addSubview:self.activityDetailView];
        }
        return headerView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                                  withReuseIdentifier:footerResuableStr
                                                                                         forIndexPath:indexPath];
        return footerView;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [VideoDetailViewController pushVideoDetailWithVideoInfo:self.videoInfoMuArray[indexPath.item] Nav:self.navigationController VideoInfoBlock:^(NSMutableDictionary *videoInfoDic) {
        WEAKSELF2
        [weakSelf.videoInfoMuArray replaceObjectAtIndex:indexPath.item withObject:videoInfoDic];
    }];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10) {
        if (buttonIndex != 0) {
            NewNSOrderDetail *fresh =
            [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
            fresh.nVideoLength =0.0;
            [MC_OrderAndMaterialCtrl UpdateFresh:fresh];
            [MC_OrderAndMaterialCtrl DeleteMaterialsInOrder:[[UserEntity sharedSingleton].customerId intValue]
                                                    Orderid:fresh.order_id];
        }
        //跳转制作页面
        [self presentCreatePage];
    }
}

#pragma mark - 功能模块

NAVIGATIONBACKITEMMETHOD

/**
 *  下载数据
 */
- (void)downloadDataWithStart:(NSInteger)dataStart{
    WEAKSELF2
    SHOWHUD
    
    [[SoapOperation Singleton] getVideosByLabelIdWithLabelId:[weakSelf.labelInfo.nLabelID stringValue] Offset:dataStart Count:self.loadNum Success:^(NSMutableArray *serverDataArray) {
        HIDDENHUD
        
        MAINQUEUEUPDATEUI({
            [weakSelf.videoCollectionView footerEndRefreshing];
            
            if (serverDataArray.count == 0) {
                [weakSelf.videoCollectionView removeFooter];
                SHOWALERT(@"没有更多影片了！")
                return;
            }
        })
        
        if (dataStart == 0) {
            [weakSelf.videoInfoMuArray removeAllObjects];
            [weakSelf addFooter];
        }
        
        [weakSelf.videoInfoMuArray addObjectsFromArray:[serverDataArray copy]];
        
        if (weakSelf.isDownloadHeaderData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.videoCollectionView reloadData];
            });
        }
    } Fail:^(NSError *error) {
        HIDDENHUD
        RELOADSERVERDATA([weakSelf downloadDataWithStart:dataStart];);
    }];
}

/**
 *  上拉加载
 */
- (void)addFooter{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        [weakSelf.videoCollectionView addFooterWithCallback:^{
            weakSelf.loadNum = 66;
            [weakSelf downloadDataWithStart:weakSelf.videoInfoMuArray.count];
        }];
    })
}

/**
 *  下拉刷新
 */
- (void)addHeader{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        [weakSelf.videoCollectionView addHeaderWithCallback:^{
            [weakSelf downloadDataWithStart:0];
        }];
    })
}

/**
 *  model转换
 */
+ (MovierDCInterfaceSvc_VDCVideoLabelEx2 *)modelUpdateWithModel1:(MovierDCInterfaceSvc_VDCVideoLabelEx *)videoLabelEx{
    MovierDCInterfaceSvc_VDCVideoLabelEx2 *videoLabelEx2 = [MovierDCInterfaceSvc_VDCVideoLabelEx2 new];
    videoLabelEx2.nLabelID = videoLabelEx.nLabelID;
    videoLabelEx2.szLabelName = videoLabelEx.szLabelName;
    videoLabelEx2.nParentID = videoLabelEx.nParentID;
    videoLabelEx2.szThumbnail = videoLabelEx.szThumbnail;
    videoLabelEx2.nType = videoLabelEx.nType;
    videoLabelEx2.szDescribe = videoLabelEx.szDescribe;
    return videoLabelEx2;
}

/**
 *  字典转model
 */
+ (MovierDCInterfaceSvc_VDCVideoLabelEx2 *)dicToModelWithDic:(NSDictionary *)labelInfoDic{
    MovierDCInterfaceSvc_VDCVideoLabelEx2 *videoLabelEx2 = [MovierDCInterfaceSvc_VDCVideoLabelEx2 new];
    videoLabelEx2.nLabelID = [NSNumber numberWithInt:[labelInfoDic[@"label_id"] intValue]];
    videoLabelEx2.szLabelName = labelInfoDic[@"label_name"];
    videoLabelEx2.nParentID = [NSNumber numberWithInt:[labelInfoDic[@"parent"] intValue]];
    videoLabelEx2.szThumbnail = labelInfoDic[@"thumbnail"];
    videoLabelEx2.nType = [NSNumber numberWithInt:[labelInfoDic[@"type"] intValue]];
    videoLabelEx2.szDescribe = labelInfoDic[@"des"];
    return videoLabelEx2;
}

/** 根据位置跳转banner页面*/
- (void)pushVcWithBannerArray:(NSArray *)bannerInfoArray BannerPosition:(NSInteger)bannerPosition{
    NSMutableDictionary * bannerInfo = bannerInfoArray[bannerPosition];
    NSString * pushTypeStr = bannerInfo[@"type"];
    NSInteger pushInteger = [pushTypeStr integerValue];
    switch (pushInteger) {
        case 1:
        {
            //跳转个人主页
            if (![self showNoLogin]) {
                return;
            }
            MyVideoViewController * videoVc = [MyVideoViewController new];
            if (![bannerInfo[@"para1"] isEqualToString:CURRENTUSERID]) {
                videoVc.isShowOtherUserVideo = YES;
            }
            videoVc.userId = bannerInfo[@"para1"];
            [self.navigationController pushViewController:videoVc animated:YES];
        }
            break;
        case 2:
        {
            //根据标签跳转
            [self pushVcWithLabelId:bannerInfo[@"para1"]];
        }
            break;
        case 3:
        {
            //根据网页跳转
            NSURL * activityURL = [NSURL URLWithString:bannerInfo[@"para3"]];
            [WkWebViewViewController showWebWithURL:activityURL
                                              Title:@"活动详情"
                               NavigationController:self.navigationController];
        }
            break;
        case 4:
        {
            //根据话题跳转
        }
            break;
            
        default:
            break;
    }
}

/** 根据标签id跳转页面*/
- (void)pushVcWithLabelId:(NSString *)labelId{
    WEAKSELF2
    [[SoapOperation Singleton] WS_GetLabelDescric:[NSNumber numberWithInt:[labelId intValue]] Success:^(MovierDCInterfaceSvc_VDCVideoLabelEx *labelinfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            VideoLabelViewController *videoLabelVc = [VideoLabelViewController new];
            videoLabelVc.labelInfo = [VideoLabelViewController modelUpdateWithModel1:labelinfo];
            [weakSelf.navigationController pushViewController:videoLabelVc animated:YES];
        });
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf pushVcWithLabelId:labelId];);
    }];
}

/** 未登录提示*/
- (BOOL)showNoLogin{
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [CustomeClass showMessage:@"请登录后操作" ShowTime:1.5];
        return NO;
    }
    return YES;
}

/**
 *  参与按钮点击方法
 */
- (void)joinButtonAction{
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [self showLoginAndRegisterWindow];
        return;
    }
    
    //正在制作订单的素材数量为空  或 不为空
    int customer = [[UserEntity sharedSingleton].customerId intValue];
    NewNSOrderDetail *freshOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:customer];
    NSMutableArray *materials = [MC_OrderAndMaterialCtrl GetMaterial:customer Orderid:freshOrder.order_id];
    if ([materials count]>0) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                              message:@"是否使用原有素材？"
                                                             delegate:self
                                                    cancelButtonTitle:@"确定"
                                                    otherButtonTitles:@"取消", nil];
        myAlertView.tag = 10;
        [myAlertView show];
    }else{
        [self presentCreatePage];
    }
}

/**
 *  是否显示参与按钮
 */
- (void)isShowJoinButton{
    if ([self.labelInfo.nParentID integerValue] == 12) {
        self.joinButton.hidden = NO;
    }else{
        self.joinButton.hidden = YES;
    }
}

/** 跳转创建页面*/
- (void)presentCreatePage{
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_GetStylebyLabelId:self.labelInfo.nLabelID Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *headerAndTail) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //数据库订单数据填充
            NewNSOrderDetail *fresh = [MC_OrderAndMaterialCtrl
                                       GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
            fresh.nHeaderAndTailID = [headerAndTail.nID intValue];
            fresh.orderType = generalOrder;
            [MC_OrderAndMaterialCtrl UpdateFresh:fresh];
            ISCutProViewController *cut =
            [[UIStoryboard storyboardWithName:@"Preview"
                                       bundle:nil]
             instantiateViewControllerWithIdentifier:@"ISCutProRechoose_ID"];
            
            //使用返回键
            cut.isTransFromPreview = YES;
            
            //下一步直接跳转preview界面
            cut.next2Preview = YES;
            ISStyleDetail *style = [[ISStyleDetail alloc] init];
            style.nID = headerAndTail.nID;
            style.nHeaderAndTailStyle = headerAndTail.nHeaderAndTailStyle;
            style.videoUrl = headerAndTail.szReference;
            style.title = headerAndTail.szName;
            style.visitCount = headerAndTail.nHotIndex;
            style.thumbnail = headerAndTail.szThumbnail;
            style.intro = headerAndTail.szDesc;
            style.sence = headerAndTail.szFit;
            style.szCreateTime = headerAndTail.szCreateTime;
            cut.styleDetail = style;
            
            //storyboard加载时默认值是NO
            cut.HideTabbar = YES;
            [weakSelf.navigationController pushViewController:cut
                                                     animated:YES];
        });
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf presentCreatePage];);
    }];
}


#pragma mark - 懒加载
- (UICollectionView *)videoCollectionView{
    if (!_videoCollectionView) {
        
        _videoCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)
                                                  collectionViewLayout:self.waterLayout];
        [self.view addSubview:_videoCollectionView];
        _videoCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _videoCollectionView.delegate = self;
        _videoCollectionView.dataSource = self;
        _videoCollectionView.opaque = YES;
        
        //注册cell
        [_videoCollectionView registerNib:[UINib nibWithNibName:itemResuableStr bundle:nil]
               forCellWithReuseIdentifier:itemResuableStr];
        [_videoCollectionView registerClass:[UICollectionReusableView class]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                        withReuseIdentifier:headerResuableStr];
        [_videoCollectionView registerClass:[UICollectionReusableView class]
                 forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                        withReuseIdentifier:footerResuableStr];
        
        _videoCollectionView.showsVerticalScrollIndicator = NO;
        _videoCollectionView.opaque = YES;
    }
    return _videoCollectionView;
}

- (WaterLayout *)waterLayout{
    if (!_waterLayout) {
        WEAKSELF2
        WaterLayout *waterLayout = [WaterLayout new];
        waterLayout.columnsCount = 2;
        waterLayout.columnMargin = 2;
        waterLayout.rowMargin = 2;
        
        [waterLayout setItemHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat itemWidth) {
            
            //一屏显示四个
            //            NSInteger redundant = indexPath.item % 4;
            //            CGFloat mainViewWidth = CGRectGetHeight(weakSelf.view.frame);
            //            if (redundant == 0 || redundant == 3) {
            //                return mainViewWidth / 4;
            //            }
            //            return mainViewWidth / 4 * 3;
            
            //按照分辨率显示
            NSDictionary *videoInfoDic = weakSelf.videoInfoMuArray[indexPath.item];
            NSArray *tempArray = [videoInfoDic[@"resolution"] componentsSeparatedByString:@":"];
            if (tempArray.count > 1) {
                return (itemWidth / [tempArray[0] floatValue]  * [tempArray[1] floatValue]) > 0 ? (itemWidth / [tempArray[0] floatValue]  * [tempArray[1] floatValue]) : itemWidth;
            }else{
                return itemWidth;
            }
            
            //            //黄金比例显示
            //            NSInteger redundant = indexPath.item % 4;
            //            CGFloat mainViewWidth = CGRectGetWidth(weakSelf.view.frame);
            //
            //            if (redundant == 0 || redundant == 3) {
            //                return mainViewWidth / 3;
            //            }
            //            return mainViewWidth / 4 * 3;
        }];
        
        [waterLayout setHeaderSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, CGRectGetHeight(weakSelf.activityDetailView.frame));
        }];
        
        [waterLayout setFooterSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 0);
        }];

        _waterLayout = waterLayout;
    }
    return _waterLayout;
}

- (NSMutableArray *)videoInfoMuArray{
    if (!_videoInfoMuArray) {
        _videoInfoMuArray = [NSMutableArray new];
    }
    return _videoInfoMuArray;
}

- (ActivityDetailView *)activityDetailView{
    if (!_activityDetailView) {
        _activityDetailView = [[ActivityDetailView alloc] initWithLabelId:[self.labelInfo.nLabelID stringValue]
                                                              ActivityDes:self.labelInfo.szDescribe];
        WEAKSELF2
        [_activityDetailView setReloadTableBlock:^{
            weakSelf.isDownloadHeaderData = YES;
            MAINQUEUEUPDATEUI({
                [weakSelf.videoCollectionView reloadData];
            })
        }];
        [_activityDetailView setClickBannerImageBlock:^(NSInteger bannerPosition,
                                                        NSMutableArray * bannerInfoMuArray) {
            [weakSelf pushVcWithBannerArray:[bannerInfoMuArray copy] BannerPosition:bannerPosition];
        }];
    }
    return _activityDetailView;
}

- (UIButton *)joinButton{
    if (!_joinButton) {
        _joinButton = [[UIButton alloc] initWithFrame:CGRectMake(ISScreen_Width / 2 - 30, ISScreen_Height - 18 - 60 - 64, 60, 60)];
        [self.view insertSubview:_joinButton aboveSubview:self.videoCollectionView];
        [_joinButton setImage:[UIImage imageNamed:@"joinImage"]
                     forState:UIControlStateNormal];
        [_joinButton addTarget:self
                        action:@selector(joinButtonAction)
              forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinButton;
}

@end
