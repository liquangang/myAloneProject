//
//  MyCollectViewController.m
//  M-Cut
//
//  Created by CoderLEE on 15/12/28.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "MyCollectViewController.h"
#import "MyMovieCell.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "VideoShowViewController.h"




@interface MyCollectViewController ()<MyMovieCellDelegate>
{
    NSMutableArray *_dataArray;
}
@end

@implementation MyCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    _dataArray = [NSMutableArray array];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

#pragma mark - 返回按钮点击方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initData];
}

-(void)initData
{
    SoapOperation *ws = [SoapOperation Singleton];
    [ws WS_GetPersonalCollection:[ws WS_Session] Start:@(0) Count:@(10) Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array) {
        _dataArray = array.item;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } Fail:^(NSError *error) {
        ;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BACKPROPMTVIEW(_dataArray.count == 0, 10000, @"您当前没有收藏影片", tableView)
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *PersonalIdentifier = @"MoveCell";
    MyMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonalIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.currentIndexPath = indexPath;
    cell.delegate = self;
    MovierDCInterfaceSvc_VDCVideoInfoEx *modelData = _dataArray[indexPath.row];
    cell.moveData = modelData;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoInformationObject *video = [[VideoInformationObject alloc] init];
    MovierDCInterfaceSvc_VDCVideoInfoEx *modelData = _dataArray[indexPath.row];
    video.videoName = modelData.szVideoName;
    video.videoID = [NSString stringWithFormat:@"%@",modelData.nVideoID];
     NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)modelData.szReference, NULL, NULL,  kCFStringEncodingUTF8 ));
    video.videoReferenceUrl =encodedString ;
    video.ownerAcatar = modelData.szAcatar;
    video.videoLabelName = modelData.szVideoLabel;
    video.videoCreateTime = modelData.szCreateTime;
    video.videoThumbnailUrl = modelData.szThumbnail;
    video.videoSignature = modelData.szSignature;
    video.videoNumberOfPraise = [NSString stringWithFormat:@"%@",modelData.nPraise];
    video.videoNumberOfShare = [NSString stringWithFormat:@"%@",modelData.nShareNum];
    video.videoNumberOfFavorite = [NSString stringWithFormat:@"%@",modelData.nFavoritesNum];
    video.videoNumberOfComment = [NSString stringWithFormat:@"%@",modelData.nCommentsNum];
    video.videoCollectStatus = [NSString stringWithFormat:@"%@",modelData.nVideoStatus];
    video.videoShare = [NSString stringWithFormat:@"%@",modelData.nVideoShare];
    video.videoPlayCount = [NSString stringWithFormat:@"%@",modelData.nVisitCount];
    video.ownerName = modelData.szOwnerName;
    // 给视频单例对象赋值, 避免视频单例对象为空, 在跳转到下级界面时, 获取不到视频对象
    [[Video Singleton] setContent:video];
    int videoID = [video.videoID intValue];
    [[SoapOperation Singleton] WS_IncreaseVisit:@(videoID) Success:^(NSNumber *num) {
        video.videoPlayCount = [NSString stringWithFormat:@"%@", num];
        [[Video Singleton] setContent:video];
    } Fail:^(NSError *error) {
        NSLog(@"------%s-----%@", __func__, error);
    }];
    HomeVideoDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieDetailPreviewStoryboardID1"];
    VideoShowViewController * detailViewC = [VideoShowViewController new];
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}
@end
