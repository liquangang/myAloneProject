//
//  NoticeViewController.m
//  M-Cut
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "NoticeViewController.h"
//自定义收藏cell
#import "NoticeCell.h"
//自定义关注cell
#import "CareCell.h"
#import "VideoDBOperation.h"
#import "MessageObj.h"
#import "SoapOperation.h"
#import "Video.h"
#import "MyVideoViewController.h"
#import "VideoDetailViewController.h"
#import "CustomeClass.h"

@interface NoticeViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *noticeTable;
/** 界面数据源*/
@property (nonatomic, strong) NSMutableArray * noticeMuArray;
@end

static NSString * collectCellId = @"NoticeCell";
static NSString * careCellId = @"careCell";

@implementation NoticeViewController

#pragma mark - 数据源懒加载
- (NSMutableArray *)noticeMuArray{
    if (!_noticeMuArray) {
        _noticeMuArray = [NSMutableArray arrayWithArray:[[VideoDBOperation Singleton] getCollectDataAndCareData]];
    }
    return _noticeMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"通知";
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageObj * mesObj = self.noticeMuArray[indexPath.section];
    if ([mesObj.term isEqualToString:COLLECTTERM]) {
        return 130;
    }else{
        return 66;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor groupTableViewBackgroundColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    BACKPROPMTVIEW(self.noticeMuArray.count == 0, 1000, @"您还没有通知", self.noticeTable);
    return self.noticeMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageObj * mesObj = self.noticeMuArray[indexPath.section];
    if ([mesObj.term isEqualToString:COLLECTTERM]) {
        NoticeCell * cell = [NoticeCell getNoticeCellWithMes:mesObj Table:tableView];
        __weak typeof(self) weakSelf = self;
        [cell pushToPersonalVc:^{
            [weakSelf pushPersonVc:cell.pushPersonId];
        }];
        [cell pushToVideoPlayVc:^{
            [weakSelf pushVideoVc:cell.pushVideoId];
        }];
        return cell;
    }else{
        CareCell * cell = [CareCell getCareCellWithTable:tableView MessageObj:mesObj];
        __weak typeof(self) weakSelf = self;
        [cell pushtoPersonalVc:^{
            [weakSelf pushPersonVc:cell.pushPersonId];
        }];
        return cell;
    }
}

- (void)pushVideoVc:(NSString *)videoId{
    //请求视频界面所需数据
//    MovierDCInterfaceSvc_IDArray * idArray = [MovierDCInterfaceSvc_IDArray new];
//    [idArray.item addObject:videoId];
//    [[SoapOperation Singleton] WS_GetVideosInfo:nil IDarray:idArray Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array) {
//        MovierDCInterfaceSvc_VDCVideoInfoEx *collectpageVideoOrder = [[MovierDCInterfaceSvc_VDCVideoInfoEx alloc] init];
//        collectpageVideoOrder = array.item[0];
//        [Video Singleton].videoID = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nVideoID intValue]];
//        [Video Singleton].videoName = collectpageVideoOrder.szVideoName;
//        [Video Singleton].ownerID = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nOwnerID intValue]];
//        [Video Singleton].ownerName = collectpageVideoOrder.szOwnerName;
//        [Video Singleton].ownerAcatar = collectpageVideoOrder.szAcatar;
//        [Video Singleton].videoLabelName = collectpageVideoOrder.szVideoName;
//        [Video Singleton].videoCreateTime = collectpageVideoOrder.szCreateTime;
//        [Video Singleton].videoThumbnailUrl = [collectpageVideoOrder.szThumbnail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [Video Singleton].videoReferenceUrl = [collectpageVideoOrder.szReference stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        [Video Singleton].videoNumberOfPraise = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nPraise intValue]];
//        [Video Singleton].videoNumberOfShare = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nShareNum intValue]];
//        [Video Singleton].videoNumberOfFavorite = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nFavoritesNum intValue]];
//        [Video Singleton].videoCollectStatus =  [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nVideoStatus intValue]];
//        [Video Singleton].videoShare = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nVideoShare intValue]];
//        int videoID = [collectpageVideoOrder.nVideoID intValue];
//        [[SoapOperation Singleton] WS_IncreaseVisit:@(videoID) Success:^(NSNumber *num) {
//            [Video Singleton].videoPlayCount = [NSString stringWithFormat:@"%@", num];
//        } Fail:^(NSError *error) {
//            NSLog(@"------%s-----%@", __func__, error);
//        }];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // PersonalMovieDetailPreviewViewController 点击个人图标无反应
//            HomeVideoDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieDetailPreviewStoryboardID1"];
//            detail.isVideoPublic = [Video Singleton].videoShare;
//            detail.videoId = videoID;
//            NSLog(@"videoID--------%d", videoID);
//            [self.navigationController pushViewController:detail animated:YES];
//        });
//    } Fail:^(NSError *error) {
//        
//    }];
    WEAKSELF2
    [[SoapOperation Singleton] getvideosbyvideoidarrWithIdArray:@[@([videoId intValue])] Success:^(NSMutableArray *serverDataArray) {
        MAINQUEUEUPDATEUI({
            NSMutableDictionary * videoInfoEx = serverDataArray[0];
            [[Video Singleton] setVideoWithVideoInfo:videoInfoEx];
            VideoDetailViewController * videoDetailVc = [VideoDetailViewController new];
            videoDetailVc.videoInfo = videoInfoEx;
            [self.navigationController pushViewController:videoDetailVc animated:YES];
        })
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf pushVideoVc:videoId];);
    }];
}

- (void)pushPersonVc:(NSString *)personId{
    MyVideoViewController * videoVc = [MyVideoViewController new];
    videoVc.isShowOtherUserVideo = YES;
    videoVc.userId = personId;
    [self.navigationController pushViewController:videoVc animated:YES];
//    __weak typeof(self) weakSelf = self;
//    [[SoapOperation Singleton] WS_GetPersonalVideos:nil Customer:[NSNumber numberWithInt:[personId intValue]] Start:0 Count:@(1) Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            OtherPeopleViewController *other = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OthersVCStoryBoardID"];
//            if (array.item.count > 0) {
//                MovierDCInterfaceSvc_VDCVideoInfoEx * videoInforEx = array.item[0];
//                [[Video Singleton] setWSContent:videoInforEx];
//                [weakSelf.navigationController pushViewController:other animated:YES];
//            }
//            else {
//                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"该用户视频没有公开" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//                [alert show];
//            }
//        });
//    } Fail:^(NSError *error) {
//        
//    }];
}

@end
