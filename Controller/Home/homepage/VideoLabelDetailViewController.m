


//
//  VideoLabelDetailViewController.m
//  M-Cut
//
//  Created by apple on 16/8/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoLabelDetailViewController.h"
#import "MyFourSearchCell2.h"
#import "MovierDCInterfaceSvc.h"
#import "VideoInformationObject.h"
#import <UIImageView+WebCache.h>
#import "Video.h"
#import "SoapOperation.h"
#import "MJRefresh.h"
#import "CustomeClass.h"
#import "WTImageScroll.h"
#import "SearchVideoTableViewCell.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "ISCutProViewController.h"
#import "ISStyleDetailCell.h"
#import "VideoDetailViewController.h"
#import "ActivityDetailView.h"
#import "MyVideoViewController.h"
#import "WkWebViewViewController.h"
#import "HomeBannerWebViewController.h"

@interface VideoLabelDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UITableView *videoTable;
/** 标签数据源*/
@property (nonatomic, strong) NSMutableArray * videoDataMuArray;
/**  存放展示视频的对象（一个数组对应cell的一个位置的数据源）*/
@property (nonatomic, strong) NSMutableArray * oneVideoMuArray;
@property (nonatomic, strong) NSMutableArray * twoVideoMuArray;
@property (nonatomic, strong) NSMutableArray * threeVideoMuArray;
@property (nonatomic, strong) NSMutableArray * fourVideoMuArray;
/** bannerImagearray*/
@property (nonatomic, strong) NSMutableArray * bannerMuArray;
/** bannerinfoarray*/
@property (nonatomic, strong) NSMutableArray * bannerInfoMuArray;
// bannerview
@property (nonatomic, strong) UIView * bannerView;
/** 展示无数据提示*/
@property (nonatomic, assign) BOOL isShowNoVideo;
@property(nonatomic,retain) MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *videoStyle;//存放活动模板
/** 活动详情view*/
@property (nonatomic, strong) ActivityDetailView * activityDetailView;
@end

@implementation VideoLabelDetailViewController

- (ActivityDetailView *)activityDetailView{
    if (!_activityDetailView) {
        _activityDetailView = [[ActivityDetailView alloc] initWithLabelId:self.labelId
                                                              ActivityDes:self.activityDes];
        WEAKSELF2
        [_activityDetailView setReloadTableBlock:^{
            MAINQUEUEUPDATEUI({
                [weakSelf.videoTable reloadSections:[NSIndexSet indexSetWithIndex:0]
                                   withRowAnimation:UITableViewRowAnimationFade];
            })
        }];
        [_activityDetailView setClickBannerImageBlock:^(NSInteger bannerPosition,
                                                        NSMutableArray * bannerInfoMuArray) {
            [weakSelf pushVcWithBannerArray:[bannerInfoMuArray copy] BannerPosition:bannerPosition];
        }];
    }
    return _activityDetailView;
}

- (NSMutableArray *)bannerInfoMuArray{
    if (!_bannerInfoMuArray) {
        _bannerInfoMuArray = [NSMutableArray new];
    }
    return _bannerInfoMuArray;
}

- (NSMutableArray *)bannerMuArray{
    if (!_bannerMuArray) {
        _bannerMuArray = [NSMutableArray new];
    }
    return _bannerMuArray;
}

- (NSMutableArray *)videoDataMuArray{
    if (!_videoDataMuArray) {
        _videoDataMuArray = [NSMutableArray new];
    }
    
    return _videoDataMuArray;
}

- (NSMutableArray *)oneVideoMuArray
{
    if (_oneVideoMuArray == nil) {
        _oneVideoMuArray = [[NSMutableArray alloc] init];
    }
    return _oneVideoMuArray;
}

- (NSMutableArray *)twoVideoMuArray
{
    if (_twoVideoMuArray == nil) {
        _twoVideoMuArray = [[NSMutableArray alloc] init];
    }
    return _twoVideoMuArray;
}

- (NSMutableArray *)threeVideoMuArray
{
    if (_threeVideoMuArray == nil) {
        _threeVideoMuArray = [[NSMutableArray alloc] init];
    }
    return _threeVideoMuArray;
}

- (NSMutableArray *)fourVideoMuArray
{
    if(_fourVideoMuArray == nil){
        _fourVideoMuArray = [[NSMutableArray alloc] init];
    }
    return _fourVideoMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
    [self downloadDataSecondWithStart:0];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"videoLabelDetailViewController dealloc");
}

#pragma mark - initUI
- (void)initUI{
    self.title = self.labelName;
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [self isShowJoinButton];
    
    [self.videoTable registerNib:[UINib nibWithNibName:@"SearchVideoTableViewCell"
                                                bundle:[NSBundle mainBundle]]
          forCellReuseIdentifier:@"SearchVideoTableViewCell"];
    [self.videoTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"headerCell"];
    [self.videoTable addFooterWithTarget:self action:@selector(footerRefresh)];
}

-(void)isShowJoinButton{
    if ([self.parentLabelId isEqualToString:@"12"]) {
        self.joinButton.hidden = NO;
    }else{
        self.joinButton.hidden = YES;
    }
}

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

/** 跳转创建页面*/
- (void)presentCreatePage{
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_GetStylebyLabelId:@([self.labelId intValue])
                                            Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *headerAndTail) {
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

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)footerRefresh{
    [self downloadDataSecondWithStart:self.videoDataMuArray.count];
}

- (void)downloadDataSecondWithStart:(NSInteger)dataStart{
    WEAKSELF2
    [CustomeClass hudShowWithView:self.view Tag:123456];
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        [[SoapOperation Singleton] getVideosByLabelIdWithLabelId:weakSelf.labelId
                                                          Offset:dataStart
                                                           Count:16
                                                         Success:^(NSMutableArray *serverDataArray) {
            weakSelf.isShowNoVideo = YES;
            MAINQUEUEUPDATEUI({
                [CustomeClass hudHiddenWithView:weakSelf.view Tag:123456];
                 [weakSelf.videoTable footerEndRefreshing];
                [weakSelf.videoTable reloadData];
                if (serverDataArray.count == 0) {
                    [weakSelf.videoTable removeFooter];
                    [CustomeClass showMessage:@"没有更多影片了" ShowTime:1.5];
                    return;
                }
            })
            
            if (dataStart == 0) {
                [weakSelf.videoDataMuArray removeAllObjects];
                [weakSelf.oneVideoMuArray removeAllObjects];
                [weakSelf.twoVideoMuArray removeAllObjects];
                [weakSelf.threeVideoMuArray removeAllObjects];
                [weakSelf.fourVideoMuArray removeAllObjects];
            }
            [weakSelf.videoDataMuArray addObjectsFromArray:[serverDataArray copy]];
            for(int i = 0; i < [serverDataArray count]; i++){
                MovierDCInterfaceSvc_VDCVideoInfoEx * videoInfo = serverDataArray[i];
                switch (i % 4) {
                    case 0:
                    {
                        [weakSelf.oneVideoMuArray addObject:videoInfo];
                    }
                        break;
                    case 1:
                    {
                        [weakSelf.twoVideoMuArray addObject:videoInfo];
                    }
                        break;
                    case 2:
                    {
                        [weakSelf.threeVideoMuArray addObject:videoInfo];
                    }
                        break;
                    case 3:
                    {
                        [weakSelf.fourVideoMuArray addObject:videoInfo];
                    }
                        break;
                        
                    default:
                        break;
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.videoTable reloadData];
            });
        } Fail:^(NSError *error) {
            [CustomeClass hudHiddenWithView:weakSelf.view Tag:123456];
            RELOADSERVERDATA([weakSelf downloadDataSecondWithStart:dataStart];);
        }];
    }, {})
}

#pragma mark - tabledelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 460;
    }else{
        return self.activityDetailView.frame.size.height;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        if (section == 0) {
            return 1;
        }
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        BACKPROPMTVIEW(weakSelf.oneVideoMuArray.count == 0 && weakSelf.isShowNoVideo,
                       1234567890,
                       @"还没有影片",
                       self.videoTable)
    })
    return self.oneVideoMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"headerCell"];
        }
        [cell.contentView addSubview:self.activityDetailView];
        cell.contentView.clipsToBounds = YES;
        return cell;
    }
    SearchVideoTableViewCell * cell =
    [tableView dequeueReusableCellWithIdentifier:@"SearchVideoTableViewCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchVideoTableViewCell"
                                              owner:nil
                                            options:nil] lastObject];
    }
    [self setCellWithIndex:indexPath
                 BackImage:cell.backImage1
           UserHeaderImage:cell.userHeaderImage1
             UserNameLabel:cell.userNameLabel1
            LookTimesLabel:cell.lookTimesLabel1
            VideoNameLabel:cell.videoNameLabel1
                  BackView:cell.backView1
             CellInfoArray:self.oneVideoMuArray
               backViewTag:20000];
    
    [self setCellWithIndex:indexPath
                 BackImage:cell.backImage2
           UserHeaderImage:cell.userHeaderImage2
             UserNameLabel:cell.userNameLabel2
            LookTimesLabel:cell.lookTimesLabel2
            VideoNameLabel:cell.videoNameLabel2
                  BackView:cell.backView2
             CellInfoArray:self.twoVideoMuArray
               backViewTag:40000];
    
    [self setCellWithIndex:indexPath
                 BackImage:cell.backImage3
           UserHeaderImage:cell.userHeaderImage3
             UserNameLabel:cell.userNameLabel3
            LookTimesLabel:cell.lookTimesLabel3
            VideoNameLabel:cell.videoNameLabel3
                  BackView:cell.backView3
             CellInfoArray:self.threeVideoMuArray
               backViewTag:60000];
    
    [self setCellWithIndex:indexPath
                 BackImage:cell.backImage4
           UserHeaderImage:cell.userheaderImage4
             UserNameLabel:cell.userNameLabel4
            LookTimesLabel:cell.lookTimesLabel4
            VideoNameLabel:cell.videoNameLabel4
                  BackView:cell.backView4
             CellInfoArray:self.fourVideoMuArray
               backViewTag:80000];
    return cell;
}

- (void)setCellWithIndex:(NSIndexPath *)indexPath
               BackImage:(UIImageView *)backImage
         UserHeaderImage:(UIImageView *)userHeaderImage
           UserNameLabel:(UILabel *)userNameLabel
          LookTimesLabel:(UILabel *)lookTimesLabel
          VideoNameLabel:(UILabel *)videoNameLabel
                BackView:(UIView *)backView
           CellInfoArray:(NSMutableArray *)videoInfoArray
             backViewTag:(NSInteger)backViewTag{
    if (indexPath.row < videoInfoArray.count) {
        NSMutableDictionary * videoInfoEx = videoInfoArray[indexPath.row];
        
        [backImage sd_setImageWithURL:[NSURL URLWithString:STRTOUTF8(videoInfoEx[@"video_thumbnail"])]
                     placeholderImage:DEFAULTVIDEOTHUMAIL
                              options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
        
        [userHeaderImage sd_setImageWithURL:[NSURL URLWithString:videoInfoEx[@"customer_avatar"]]
                           placeholderImage:DEFAULTHEADIMAGE
                                    options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
        
        userNameLabel.text = videoInfoEx[@"customer_nickname"];
        
        NSString * videoPlayCount = videoInfoEx[@"visitcount"];
        int playCount = [videoPlayCount intValue];
        if (playCount > 10000) {
            videoPlayCount = [NSString stringWithFormat:@"%.1f万", (float)playCount / 10000];
        }
        lookTimesLabel.text = videoPlayCount;
        
        videoNameLabel.text = videoInfoEx[@"video_name"];
        
        //手势
        backView.tag = backViewTag + indexPath.row;
        ADDTAPGESTURE(backView, videoAction)
        backView.hidden = NO;
    }else if (indexPath.row >= videoInfoArray.count){
        backView.hidden = YES;
    }
}

//跳转到视频播放页面
- (void)videoAction:(UITapGestureRecognizer *)tap
{
    UIView * btn = tap.view;
    if (btn.tag >= 20000 && btn.tag < 40000) {
        [self pushToHomeVideoDetailWithVideoInfoEx:self.oneVideoMuArray[btn.tag - 20000]];
    }
    else if (btn.tag >= 40000 && btn.tag < 60000){
        [self pushToHomeVideoDetailWithVideoInfoEx:self.twoVideoMuArray[btn.tag - 40000]];
    }
    else if (btn.tag >= 60000 && btn.tag < 80000)
    {
        [self pushToHomeVideoDetailWithVideoInfoEx:self.threeVideoMuArray[btn.tag - 60000]];
    }
    else {
        [self pushToHomeVideoDetailWithVideoInfoEx:self.fourVideoMuArray[btn.tag - 80000]];
    }
}

/** 跳转到视频播放页面*/
- (void)pushToHomeVideoDetailWithVideoInfoEx:(NSMutableDictionary *)videoInfoEx{
    VideoDetailViewController * videoDetailVc = [VideoDetailViewController new];
    videoDetailVc.videoInfo = videoInfoEx;
    [self.navigationController pushViewController:videoDetailVc animated:YES];
}

- (IBAction)joinButtonAction:(id)sender {
    //参加活动的方法
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
    [[SoapOperation Singleton] WS_GetLabelDescric:[NSNumber numberWithInt:[labelId intValue]]
                                          Success:^(MovierDCInterfaceSvc_VDCVideoLabelEx *labelinfo) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  VideoLabelDetailViewController * videoLabelDetailVc = [VideoLabelDetailViewController new];
                                                  videoLabelDetailVc.labelId = labelId;
                                                  videoLabelDetailVc.labelName = labelinfo.szLabelName;
                                                  [weakSelf.navigationController pushViewController:videoLabelDetailVc animated:YES];
                                              });
                                          } Fail:^(NSError *error) {
                                              RELOADSERVERDATA([weakSelf pushVcWithLabelId:labelId];);
                                          }];
}

/** 未登录提示*/
- (BOOL)showNoLogin{
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [self showLoginAndRegisterWindow];
        return NO;
    }
    return YES;
}
@end
