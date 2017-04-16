
//
//  OtherPeopleViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/4/20.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "OtherPeopleViewController.h"
#import "UIViewExt.h"
#import "MovieDetailPreviewViewController.h"

#import "HomeVideoDetailViewController.h" // 替换 MovieDetailPreviewViewController.h

#import <AssetsLibrary/AssetsLibrary.h>
#import "WaterFlowLayout.h"
#import "Video.h"
#import "NGPlayerViewController.h"
#import "VideoShowViewController.h"

@implementation OtherPeopleViewController
@synthesize imageLibraryArra,numberOfArra,userID;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initUI];
    imageLibraryArra = [NSMutableArray array];
    if (self.isTransFromCommentList == YES) {
        // 根据评论者的 customID 加载详细信息
        userID = self.customID;
    } else {
        userID = [[Video Singleton].ownerID intValue];
    }
    [self getPersonalInfo:@(0) count:@(5)];
    [self setupInfoNew];
}

#pragma mark - intiUI
- (void)initUI{
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 返回按钮点击方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupInfoNew {
    // 设置 tableView 上下拉刷新
    [self setupRefresh];
    
    // 根据视频 id 获得视频拥有者的信息
    // 头像
    if(self.userID >0)
    {
        [[SoapOperation Singleton]WS_QueryOtherInfo:self.userID Success:^(MovierDCInterfaceSvc_VDCCustomerInfo *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.ownerAcatarImage sd_setImageWithURL:[NSURL URLWithString:info.szAcatar] placeholderImage:[UIImage imageNamed:@"denglu"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
                self.userNickNameLabel.text = info.szNickname;
//                _UserSingature.text = info.szSignature;                
            });
        } Fail:^(NSError *error) {
            if([error code]==MOVIERDC_SERVER_INVALID_SESSION){
                [UIWindow showMessage:@"用户未登录" withTime:1.0];
            }
            NSLog(@"QueryOtherInfo error= %@ ! ",[error localizedDescription]);
        }];
        
    }else if (self.iconUrl) {
        [self.ownerAcatarImage sd_setImageWithURL:[NSURL URLWithString:self.iconUrl] placeholderImage:[UIImage imageNamed:@"denglu"]];
    }else {
        NSURL *iconUrl = [NSURL URLWithString:[Video Singleton].ownerAcatar];
        [self.ownerAcatarImage sd_setImageWithURL:iconUrl placeholderImage:[UIImage imageNamed:@"denglu"]];
    }

    self.userNickNameLabel.text = self.userNickName;

    
//    // 昵称
//    NSString *nickName = [Video Singleton].ownerName;
//    self.userNickNameLabel.text = nickName;
    // 个性签名
//    NSString *userCelebratedDictum = [Video Singleton].

}

- (void)getPersonalInfo:(NSNumber *)start count:(NSNumber *)count {
    SoapOperation *soap = [SoapOperation Singleton];
    [soap WS_GetPersonalVideos:nil Customer:@(userID) Start:start Count:count Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *videoInfos) {
        if (start.intValue == 0) {
            [imageLibraryArra removeAllObjects];
        }
        for (NSInteger i = 0; i < videoInfos.item.count; i++) {
            MovierDCInterfaceSvc_VDCVideoInfoEx *videoInfo = videoInfos.item[i];
            [self videoWithInfo:videoInfo];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [personTabV reloadData];
        });
    } Fail:^(NSError *error) {
        NSLog(@"------%s------WS_GetPersonalVideos-%@-", __func__, error);
    }];
}

- (void)videoWithInfo:(MovierDCInterfaceSvc_VDCVideoInfoEx *)videoInfo {
    VideoInformationObject *video = [[VideoInformationObject alloc] init];
    video.videoID                 = [videoInfo.nVideoID stringValue];
    video.videoName               = videoInfo.szVideoName;
    video.ownerName               = videoInfo.szOwnerName;
    video.ownerAcatar             = [videoInfo.szAcatar stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    video.videoLabelName          = videoInfo.szVideoLabel;
    video.videoCreateTime         = videoInfo.szCreateTime;
    video.videoThumbnailUrl       = [videoInfo.szThumbnail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    video.videoReferenceUrl       = [videoInfo.szReference stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    video.videoSignature          = videoInfo.szSignature;
    video.videoNumberOfPraise     = [videoInfo.nPraise stringValue];
    video.videoNumberOfShare      = [videoInfo.nShareNum stringValue];
    video.videoNumberOfFavorite   = [videoInfo.nFavoritesNum stringValue];
    video.videoNumberOfComment    = [videoInfo.nCommentsNum stringValue];
    video.videoCollectStatus      = [videoInfo.nVideoStatus stringValue];
    video.videoShare              = [videoInfo.nVideoShare stringValue];
    video.videoPlayCount          = [videoInfo.nVisitCount stringValue];
    video.ownerID                 = [videoInfo.nOwnerID stringValue];
    [imageLibraryArra addObject:video];
}


-(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize
{
    UIImage *i;
    // 创建一个bitmap的context,并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    // 绘制改变大小的图片
    [img drawInRect:imageRect];
    // 从当前context中创建一个改变大小后的图片
    i=UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return i;
}

- (void)setupRefresh
{
    [personTabV addHeaderWithTarget:self action:@selector(headerRereshing)];
    [personTabV addFooterWithTarget:self action:@selector(footerRereshing)];
    personTabV.headerPullToRefreshText = @"下拉可以刷新了";
    personTabV.headerReleaseToRefreshText = @"松开马上刷新了";
    personTabV.headerRefreshingText = @"";
    
    personTabV.footerPullToRefreshText = @"上拉可以加载更多数据了";
    personTabV.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    personTabV.footerRefreshingText = @"";
}

- (void)headerRereshing {
    // 显示5个
    [self getPersonalInfo:@(0) count:@(5)];
    [personTabV headerEndRefreshing];
    
//    [imageLibraryArra removeAllObjects];
//    [imageLibraryArra addObjectsFromArray:[[APPUserPrefs Singleton] APP_getprivatepersonvideo:0 Count:numberOfArra]];
//    numberOfArra = imageLibraryArra.count;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [personTabV reloadData];
//        [personTabV headerEndRefreshing];
//    });
}

- (void)footerRereshing {
    numberOfArra = imageLibraryArra.count;
    [self getPersonalInfo:@(numberOfArra) count:@(numberOfArra + 10)];
    [personTabV footerEndRefreshing];
 
//    [imageLibraryArra addObjectsFromArray:[[APPUserPrefs Singleton] APP_getprivatepersonvideo:numberOfArra Count:5]];
//    numberOfArra = imageLibraryArra.count;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [personTabV reloadData];
//        [personTabV footerEndRefreshing];
//    });
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [imageLibraryArra count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *PersonalIdentifier = @"PersonalIdentifier";
    MyMovieCell2 *cell = [tableView dequeueReusableCellWithIdentifier:PersonalIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyMovieCell2" owner:nil options:nil] lastObject];
    }
    
    CollectpageVideoOrder *collectpageVideoOrder = [imageLibraryArra objectAtIndex:indexPath.row];
    if (self.isTransFromCommentList == YES) {
        [cell.videoImageView sd_setImageWithURL:[NSURL URLWithString:collectpageVideoOrder.videoThumbnailUrl] placeholderImage:[UIImage imageNamed:@"huan"]];
    } else {
        cell.videoImageView.image = [[APPUserPrefs Singleton] APP_getImg:collectpageVideoOrder.videoThumbnailUrl ImageView:cell.videoImageView ImageName:@"huan"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.movieTitleLabel.text = collectpageVideoOrder.videoName;
    cell.nickNameLabel.text = collectpageVideoOrder.ownerName;
    cell.favouriteLabel.text = collectpageVideoOrder.videoNumberOfPraise;
    cell.lookLabel.text = collectpageVideoOrder.videoPlayCount;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CollectpageVideoOrder *collectpageVideoOrder = [[CollectpageVideoOrder alloc] init];
    CollectpageVideoOrder *collectpageVideoOrder = [imageLibraryArra objectAtIndex:indexPath.row];
    [Video Singleton].videoID = collectpageVideoOrder.videoID;
    [Video Singleton].videoName = collectpageVideoOrder.videoName;
    [Video Singleton].ownerID = collectpageVideoOrder.ownerID;
    [Video Singleton].ownerName = collectpageVideoOrder.ownerName;
    [Video Singleton].ownerAcatar = collectpageVideoOrder.ownerAcatar;
    [Video Singleton].videoLabelName = collectpageVideoOrder.videoLabelName;
    [Video Singleton].videoCreateTime = collectpageVideoOrder.videoCreateTime;
    [Video Singleton].videoThumbnailUrl = collectpageVideoOrder.videoThumbnailUrl;
    [Video Singleton].videoReferenceUrl = collectpageVideoOrder.videoReferenceUrl;
    [Video Singleton].videoNumberOfPraise = collectpageVideoOrder.videoNumberOfPraise;
    [Video Singleton].videoNumberOfShare = collectpageVideoOrder.videoNumberOfShare;
    [Video Singleton].videoNumberOfFavorite = collectpageVideoOrder.videoNumberOfFavorite;
    [Video Singleton].videoCollectStatus = collectpageVideoOrder.videoCollectStatus;
    HomeVideoDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieDetailPreviewStoryboardID1"];
    VideoShowViewController * detailViewC = [VideoShowViewController new];
    detail.isVideoPublic = [Video Singleton].videoShare;
    detail.hidesBottomBarWhenPushed = YES;
    detail.isPushFromOtherVc = YES;
    [self.navigationController pushViewController:detailViewC animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"video12"])
    {
        id theSegue = segue.destinationViewController;
        [theSegue setValue:@"1" forKey:@"video1"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

