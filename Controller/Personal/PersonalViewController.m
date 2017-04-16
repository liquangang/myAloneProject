  //
//  PersonalViewController.m
//  M-Cut
//
//  Created by Crab shell on 12/21/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//
#import <AFNetworking.h>
#import "PersonalViewController.h"
#import "UIViewExt.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "WaterFlowLayout.h"
#import "Video.h"
#import "PersonalMovieDetailPreviewViewController.h"
#import  "MC_OrderAndMaterialCtrl.h"
#import "VideoDBOperation.h"
#import "MyMovieCell.h"
#import "MyMovieCell2.h"
#import "VideoShowViewController.h"
#define MWTotalTabBarItems 5
#define MWTabBarHeight 49

@interface PersonalViewController ()
@property (copy, nonatomic) NSString *num;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *tableDataSource;

@property (nonatomic,weak) IBOutlet UIImageView *userHeadImageView;
@property (nonatomic,weak) IBOutlet UILabel *userNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *userDesLabel;

/**  video信息数组 */
@property (strong, nonatomic) NSMutableArray *videoInfos;

// 获得当前的 tabBarItem
@property (strong, nonatomic) UITabBarItem *tabBarItem;
@property (nonatomic, assign) NSInteger currentCount;
@property (nonatomic, assign) int noPlayMovieNum;
/** kvo释放次数*/
@property (nonatomic, assign) int deallocTimes;
@end

@implementation PersonalViewController
{
    
}
@synthesize imageLibraryArra,numberOfArra;


#pragma mark ---- 增加底部的提示数字
#pragma mark -----  2015/11/19 更换界面布局, 更换原有自定义的 tabBar 为系统的 tabBar, 提示数字当前界面设置
// 从数据库读取 --- 没有播放的视频数量改变发出通知, 有 MovierTabBarViewController 中的 badgeView 设置未播放视频数量
- (void)personalNoPlayVideoNumChange:(NSNumber *)num {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:num forKey:@"UserNoPlayVideo"];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:PersonalNotPlayVideoCountFromDB object:nil userInfo:nil];
}

// 点击一个没有播放过的视频发出的通知, 只能播放一个
- (void)playVideo:(NSNumber *)num {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger videos = [[defaults valueForKey:@"UserNoPlayVideo"] integerValue];
    [defaults setValue:@(videos - 1) forKey:@"UserNoPlayVideo"];
    [defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:PersonalNotPlayVideoPlay object:nil userInfo:nil];
}

#pragma mark ---- 增加底部的提示数字
- (NSMutableArray *)videoInfos {
    if (!_videoInfos) {
        self.videoInfos = [NSMutableArray array];
    }
    return _videoInfos;
}

#pragma mark - 当影片生成时刷新页面
- (void)personalMovieNotice:(id)sender
{
    [self loadOrderData];
    [self dataRequest];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.deallocTimes = 0;
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];

    
    self.currentCount = 30;
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(personalMovieNotice:) name:@"moiveHadBorn" object:nil];
    [_userHeadImageView.layer setMasksToBounds:YES];
    [_userHeadImageView.layer setCornerRadius:26.0];
    
    _userNameLabel.text =  [UserEntity sharedSingleton].szNickname;
    _userDesLabel.text = [UserEntity sharedSingleton].szSignature;
    [_userHeadImageView sd_setImageWithURL:[NSURL URLWithString:[UserEntity sharedSingleton].szAcatar] placeholderImage:[UIImage imageNamed:@"icon"]];

    [self downloadPersonVideoData];
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshingThird)];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshingNew)];

//    [self dataRequest:@(0) count:@(10)];
    
}

- (void)downloadPersonVideoData{
    [self CleanErrorOrder];
    [self loadOrderData];
    [self dataRequest];
}

- (void)headerRereshingThird{
    [self dataRequest];
}

/** 返回按钮点击方法*/
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)headerRereshingNew {
    
    [self.tableDataSource[2] removeAllObjects];
    [self loadOrderData];
    [self dataRequest:@(0) count:@(self.currentCount)];
}

- (void)footerRereshingNew {
    NSNumber *start = [NSNumber numberWithInteger:self.videoInfos.count];
    if([start intValue] < 30){
        start = @(30);
    }
    [self dataRequest:start count:@(self.currentCount)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [stockForKVO addObserver:self forKeyPath:@"upratio" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.deallocTimes++;
    if (self.deallocTimes < 2) {
        [stockForKVO removeObserver:self forKeyPath:@"upratio"] ;
    }
}
/**
 *  清理状态为3（正在传输的订单）但订单内容为空的订单
 */
-(void)CleanErrorOrder{
    NSArray *Orderlist = [MC_OrderAndMaterialCtrl GetTranferOrders:[[UserEntity sharedSingleton].customerId intValue]];
    for (NewNSOrderDetail* orderit in Orderlist) {
        //素材数量小于等于零的订单需要删除
        if([[MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue]
                                         Orderid:orderit.order_id] count]<=0){
            [MC_OrderAndMaterialCtrl DeleteOrder:orderit.order_id];
        }
    }
}

-(void)loadOrderData
{
    NSArray *videoStateArray = [MC_OrderAndMaterialCtrl QueryAllMyOrder:
                                [[UserEntity sharedSingleton].customerId intValue]];
    
    /*
     NOWTRANSFER =3,                     //上传中的订单
     COMMITEDORDER = 4,                  //已经提交完成的订单
     FINISHORDER = 5,                    //已经完成的订单
     */
    
    NSMutableArray *uploadArray = [NSMutableArray array];
    NSMutableArray *verifyArray = [NSMutableArray array];
    
    for (NewNSOrderDetail *db in videoStateArray)
    {
        if (db.order_st == NOWTRANSFER)
        {
            [uploadArray addObject:db];
        }
        else if(db.order_st == COMMITEDORDER)
        {
            [verifyArray addObject:db];
        }
    }
    
    [_tableDataSource replaceObjectAtIndex:0 withObject:uploadArray];//上传中的订单
//    [_tableDataSource replaceObjectAtIndex:1 withObject:verifyArray];//已经提交完成的订单
    [self.tableView reloadData];
    
    
    __weak typeof(self) wself = self;
    NSArray *statuss = [[NSArray alloc] initWithObjects:@(1),@(2),nil];   
    [[SoapOperation Singleton] WS_GetOrderInfo:statuss
                                      Customer:@([[UserEntity sharedSingleton].customerId intValue])
                                         Start:@(0)
                                         Count:@(100)
                                       Success:^(MovierDCInterfaceSvc_VDCOrderForQueryArray *array) {
                                           NSArray *arr = [[verifyArray reverseObjectEnumerator] allObjects];
                                           if([arr count]<=0)
                                               return;
                                           else if([arr count]<[array.item count])
                                               [wself.tableDataSource replaceObjectAtIndex:1 withObject:arr];
                                           else{
                                               NSMutableArray *addarr = [[NSMutableArray alloc]init];
                                               for(int i = 0 ; i < [array.item count] ;i++){
                                                   [addarr addObject:[arr objectAtIndex:i]];
                                               }
                                               //                                           [self addVideoInfosWithArray:array.item];
                                               [wself.tableDataSource replaceObjectAtIndex:1 withObject:addarr];
                                           }
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               [wself.tableView reloadData];
                                               [wself.tableView headerEndRefreshing];
                                               [wself.tableView footerEndRefreshing];
                                           });
                                       }
                                          Fail:^(NSError *error) {
                                              [wself.tableView headerEndRefreshing];
                                              [wself.tableView footerEndRefreshing];
                                          }];

    
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"upratio"])
    {
        NSString *fratio = [NSString stringWithFormat:@"%@",[stockForKVO valueForKey:@"upratio"]];
        
        float f = [fratio floatValue];
        
        if (self.tableView.numberOfSections)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                MyMovieCell *movieCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0
                                                                                                  inSection:0]];
                int  frameWidth = movieCell.localDownLoadLabel.frame.size.width * f;
                [movieCell.downPressLabel setFrame:CGRectMake(movieCell.downPressLabel.frame.origin.x,
                                                              movieCell.downPressLabel.frame.origin.y,
                                                              frameWidth,
                                                              movieCell.downPressLabel.frame.size.height)];
            });
            
        }
        
        if (f == 1)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
               [self performSelector:@selector(loadOrderData) withObject:nil afterDelay:3];
            });
        }
        
        
    }
}

-(void)dataRequest:(NSNumber *)start count:(NSNumber *)count
{
    __weak typeof(self) wself = self;
    [[SoapOperation Singleton] WS_GetPersonalVideos:nil
                                           Customer:@([[UserEntity sharedSingleton].customerId intValue])
                                              Start:start
                                              Count:count
                                            Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array){
                                                if (start.intValue == 0) {
                                                    [self.videoInfos removeAllObjects];
                                                }
                                                [self addVideoInfosWithArray:array.item];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    for (id obj in array.item) {
                                                        [wself.tableDataSource[2] addObject:obj];
                                                    }
                                                    [wself.tableView reloadData];
                                                    [wself.tableView headerEndRefreshing];
                                                    [wself.tableView footerEndRefreshing];
                                                });
                                            }
                                               Fail:^(NSError *error) {
                                                   [wself.tableView headerEndRefreshing];
                                                   [wself.tableView footerEndRefreshing];
                                               }];
}


- (void)addVideoInfosWithArray:(NSMutableArray *)array {
    for (NSInteger i = 0; i < array.count; i++) {
        MovierDCInterfaceSvc_VDCVideoInfoEx *videoInfoEx = array[i];
        VideoInformationObject *videoInfo = [[VideoInformationObject alloc] init];
        videoInfo.videoID = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoID];
        videoInfo.videoName = videoInfoEx.szVideoName;
        videoInfo.ownerID = [NSString stringWithFormat:@"%@", videoInfoEx.nOwnerID];
        videoInfo.ownerName = videoInfoEx.szOwnerName;
        videoInfo.ownerAcatar = videoInfoEx.szAcatar;
        videoInfo.videoLabelName = videoInfoEx.szVideoLabel;
        videoInfo.videoCreateTime = videoInfoEx.szCreateTime;
        videoInfo.videoThumbnailUrl = [videoInfoEx.szThumbnail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        videoInfo.videoReferenceUrl = [videoInfoEx.szReference stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        videoInfo.videoSignature = videoInfoEx.szSignature;
        videoInfo.videoNumberOfPraise = [NSString stringWithFormat:@"%@", videoInfoEx.nPraise];
        videoInfo.videoNumberOfShare = [NSString stringWithFormat:@"%@", videoInfoEx.nShareNum];
        videoInfo.videoNumberOfFavorite = [NSString stringWithFormat:@"%@", videoInfoEx.nFavoritesNum];
        videoInfo.videoNumberOfComment = [NSString stringWithFormat:@"%@", videoInfoEx.nCommentsNum];
        videoInfo.videoCollectStatus = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoStatus];
        videoInfo.videoShare = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoShare];
        videoInfo.videoPlayCount = [NSString stringWithFormat:@"%@", videoInfoEx.nVisitCount];
        [self.videoInfos addObject:videoInfo];
        [[VideoDBOperation Singleton] UpdatePersonalVideo:videoInfo];
    }
}

-(void)dataRequest
{
    __weak typeof(self) wself = self;
    [[SoapOperation Singleton] WS_GetPersonalVideos:nil
                                           Customer:@([[UserEntity sharedSingleton].customerId intValue])
                                              Start:[NSNumber numberWithInt:0]
                                              Count:[NSNumber numberWithInt:self.currentCount]
                                            Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array){
                                                [wself.tableDataSource replaceObjectAtIndex:2 withObject:array.item];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    [wself.tableView reloadData];
                                                    [wself.tableView footerEndRefreshing];
                                                    [wself.tableView headerEndRefreshing];
                                                });
                                            }
                                               Fail:^(NSError *error) {
                                               }];
}


// 改变未播放的视频数量 --- 从数据库中获取的数量
- (void)setPersonalBadgeValue {
    NSInteger num = [[[VideoDBOperation Singleton] getNoPlayVideoNum] integerValue];
    self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", num];
}
- (void)personalNoPlayVideoAdd {
    [personTabV reloadData];
}

// 制作影片素材上传进度改变
- (void)uploadProgressChange:(NSNotification *)noti {
    CGFloat progress = [noti.userInfo[@"finishProgress"] floatValue];
    [self.navigationController setSGProgressPercentage:progress*100 andTintColor:[UIColor colorWithRed:235.f/255.f green:51.f/255.f blue:73.f/255.f alpha:1.f]];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.noPlayMovieNum = [[[VideoDBOperation Singleton] getNoPlayVideoNum] intValue];
//    self.currentCount = 30;
//    [self loadOrderData];
//    [self dataRequest];
//    [personTabV reloadData];
//    [self.tableView reloadData];
//    self.navigationController.tabBarController.tabBar.hidden = YES;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.tableDataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return [[self.tableDataSource objectAtIndex:section] count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 1)
    {
        return 54;
    }
    
    if (indexPath.section == 2)
    {
        return 190;
    }
    
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MyMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadProgressCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.currentIndexPath = indexPath;
        cell.moveData = [[self.tableDataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        MyMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieParseCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.currentIndexPath = indexPath;
        if ([self.tableDataSource[indexPath.section] count] > indexPath.row) {
           cell.moveData = [[self.tableDataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        }
        return cell;
    }
    else {
        MyMovieCell2 *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyMovieCell2" owner:self options:nil] lastObject];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            MovierDCInterfaceSvc_VDCVideoInfoEx *vdcINfor = [[self.tableDataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            cell.nickNameLabel.text = vdcINfor.szOwnerName;
            cell.movieTitleLabel.text = vdcINfor.szVideoName;
            cell.lookLabel.text = [NSString stringWithFormat:@"%d",[vdcINfor.nVisitCount intValue]];
            cell.favouriteLabel.text = [NSString stringWithFormat:@"%d",[vdcINfor.nPraise intValue]];
            [cell.videoImageView sd_setImageWithURL:[NSURL URLWithString:[vdcINfor.szThumbnail
                                                                          stringByAddingPercentEscapesUsingEncoding:
                                                                          NSUTF8StringEncoding]]];
        cell.currentIndexPath = indexPath;
        cell.moveData = [[self.tableDataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        //判断是否显示提示标签 (0是没看 1是已看)
            NSArray * idArray = [[VideoDBOperation Singleton] allVideoIDs];
        if (indexPath.row < idArray.count) {
            for (NSNumber * movieID in idArray) {
                if ([movieID intValue] == [vdcINfor.nVideoID intValue] && [[VideoDBOperation Singleton] readStatusByVideoID:[vdcINfor.nVideoID intValue]] == 0) {
                    cell.promptLabel.text = @"new";
                    cell.promptLabel.textColor = [UIColor whiteColor];
                    cell.promptLabel.textAlignment = NSTextAlignmentCenter;
                    cell.promptLabel.tag = 1;
                    cell.promptLabel.backgroundColor = [UIColor redColor];
                    if (iPhone4 || iPhone5_5S_5C ) {
                        cell.promptLabel.font = [UIFont boldSystemFontOfSize:8];
                        [self drawRrangleWithRect:cell.promptLabel.bounds andView:cell.promptLabel];
                    } else if (iPhone6_6S) {
                        cell.promptLabel.font = [UIFont boldSystemFontOfSize:9];
                        [self drawRrangleWithRect:cell.promptLabel.bounds andView:cell.promptLabel];
                    } else {
                        cell.promptLabel.font = [UIFont boldSystemFontOfSize:8];
                        [self drawRrangleWithRect:cell.promptLabel.bounds andView:cell.promptLabel];
                    }
                }
            }
        }
        
       return cell;
    }
}

- (void)drawRrangleWithRect:(CGRect)rect andView:(UIView *)superView
{
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y + rect.size.height;
    CGFloat myWidth = rect.size.width;
    int num = myWidth / 2;
    int subNum = y;
    for (NSInteger i = 0; i < myWidth/2; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x, subNum++, num--, 1)];
        [superView addSubview:label];
        label.backgroundColor = [UIColor redColor];
    }
    int num2 = myWidth / 2;
    int num3 = myWidth / 2;
    int subNum2 = y;
    for (NSInteger i = 0; i < myWidth / 2; i++) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(x + num2, subNum2++, num3--, 1)];
        [superView addSubview:label];
        label.backgroundColor = [UIColor redColor];
        num2++;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1)
    {
        return;
    }
    MovierDCInterfaceSvc_VDCVideoInfoEx *collectpageVideoOrder = [[MovierDCInterfaceSvc_VDCVideoInfoEx alloc] init];
    currentSingle = (int)indexPath.row;
    collectpageVideoOrder = [[self.tableDataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [Video Singleton].videoID = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nVideoID intValue]];
    [Video Singleton].videoName = collectpageVideoOrder.szVideoName;
    [Video Singleton].ownerID = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nOwnerID intValue]];
    [Video Singleton].ownerName = collectpageVideoOrder.szOwnerName;
    [Video Singleton].ownerAcatar = collectpageVideoOrder.szAcatar;
    [Video Singleton].videoLabelName = collectpageVideoOrder.szVideoName;
    [Video Singleton].videoCreateTime = collectpageVideoOrder.szCreateTime;
    [Video Singleton].videoThumbnailUrl = [collectpageVideoOrder.szThumbnail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [Video Singleton].videoReferenceUrl = [collectpageVideoOrder.szReference stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [Video Singleton].videoNumberOfPraise = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nPraise intValue]];
    [Video Singleton].videoNumberOfShare = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nShareNum intValue]];
    [Video Singleton].videoNumberOfFavorite = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nFavoritesNum intValue]];
    [Video Singleton].videoCollectStatus =  [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nVideoStatus intValue]];
    [Video Singleton].videoShare = [NSString stringWithFormat:@"%d",[collectpageVideoOrder.nVideoShare intValue]];
    int videoID = [collectpageVideoOrder.nVideoID intValue];
    [[SoapOperation Singleton] WS_IncreaseVisit:@(videoID) Success:^(NSNumber *num) {
        [Video Singleton].videoPlayCount = [NSString stringWithFormat:@"%@", num];
    } Fail:^(NSError *error) {
        NSLog(@"------%s-----%@", __func__, error);
    }];
    // PersonalMovieDetailPreviewViewController 点击个人图标无反应
    HomeVideoDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieDetailPreviewStoryboardID1"];
    VideoShowViewController * detailViewC = [VideoShowViewController new];
//    [detailViewC initFrom:self withPublicState:[Video Singleton].videoShare];
    detail.isTransFromPersonal = YES;
    detail.isVideoPublic = [Video Singleton].videoShare;
    detail.videoId = videoID;
    NSLog(@"videoID--------%d", videoID);
    [self.navigationController pushViewController:detailViewC animated:YES];
}

#pragma mark - 数据源懒加载
- (NSMutableArray *)tableDataSource
{
    if (!_tableDataSource) {
        _tableDataSource = [NSMutableArray arrayWithObjects:
                            [NSMutableArray array],
                            [NSMutableArray array],
                            [NSMutableArray array],
                            nil];
    }
    return _tableDataSource;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
