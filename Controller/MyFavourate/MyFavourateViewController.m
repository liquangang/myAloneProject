//
//  MyFavourateViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/22.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "MyFavourateViewController.h"
//#import "MovieDetailPreviewViewController.h"
//
//#import "HomeVideoDetailViewController.h" // 替换 MovieDetailPreviewViewController.h

#import "UIViewExt.h"
#import "MyFavourateTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "WaterFlowLayout.h"
#import "FavourateMovieDetailPreviewViewController.h"
#import "Video.h"

@implementation MyFavourateViewController
@synthesize imageLibraryArra,numberOfArra,videoID,videoName,ownerID,ownerName,ownerAcatar,videoLabelName,videoCreateTime,videoThumbnailUrl,videoReferenceUrl,videoNumberOfPraise,videoNumberOfShare,videoNumberOfFavorite,videoNumberOfComment,videoCollectStatus,szImage,ownerAcatarArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        if (![UserEntity sharedSingleton].customerId) {
            imageLibraryArra = [[NSMutableArray alloc] initWithArray:[[APPUserPrefs Singleton] APP_getfavoritevideobyDB:0 Count:10]];
            numberOfArra = imageLibraryArra.count;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setupRefresh];
            });
//            [self setupRefresh];
        }
    });

    
    // 监听   制作影片素材上传进度改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadProgressChange:) name:UploadFileProgressChange object:nil];
}
// 制作影片素材上传进度改变
- (void)uploadProgressChange:(NSNotification *)noti {
    CGFloat progress = [noti.userInfo[@"finishProgress"] floatValue];
    [self.navigationController setSGProgressPercentage:progress*100 andTintColor:[UIColor colorWithRed:235.f/255.f green:51.f/255.f blue:73.f/255.f alpha:1.f]];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![UserEntity sharedSingleton].customerId) {
        [imageLibraryArra removeAllObjects];
    }
    [self headerRereshing];
}

- (void)setupRefresh
{
    [tabV addHeaderWithTarget:self action:@selector(headerRereshing)];
    [tabV addFooterWithTarget:self action:@selector(footerRereshing)];
    tabV.headerPullToRefreshText = @"下拉可以刷新了";
    tabV.headerReleaseToRefreshText = @"松开马上刷新了";
    tabV.headerRefreshingText = @"";
    
    tabV.footerPullToRefreshText = @"上拉可以加载更多数据了";
    tabV.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    tabV.footerRefreshingText = @"";
}

- (void)headerRereshing
{
    if (![UserEntity sharedSingleton].customerId) {
        [imageLibraryArra removeAllObjects];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [imageLibraryArra addObjectsFromArray:[[APPUserPrefs Singleton] APP_getfavoritevideobyDB:0 Count:10]];
            numberOfArra = imageLibraryArra.count;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [tabV reloadData];
                [tabV headerEndRefreshing];
            });
        });

    }
}

- (void)footerRereshing
{
    if (![UserEntity sharedSingleton].customerId) {
        [imageLibraryArra addObjectsFromArray:[[APPUserPrefs Singleton] APP_getfavoritevideobyDB:(int)numberOfArra Count:10]];
        numberOfArra = imageLibraryArra.count;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tabV reloadData];
            [tabV footerEndRefreshing];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    static NSString *MyFavourateIdentifier = @"MyFavourateIdentifier_byli";
    
    MyFavourateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyFavourateIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyFavourateTableViewCell" owner:nil options:nil] lastObject];
    }
    
//    CollectpageVideoOrder *collectpageVideoOrder = [[CollectpageVideoOrder alloc] init];
    CollectpageVideoOrder *collectpageVideoOrder = [imageLibraryArra objectAtIndex:indexPath.row];
    cell.videoImagView.image = [[APPUserPrefs Singleton]APP_getImg:collectpageVideoOrder.videoThumbnailUrl ImageView:cell.videoImagView ImageName:@"huan"];
    cell.videoNameLabel.text = collectpageVideoOrder.videoName;
    cell.ownerNameLabel.text = collectpageVideoOrder.ownerName;
    cell.videoNumberOfPraiseLabel.text = collectpageVideoOrder.videoNumberOfPraise;
//    cell.videoNumberOfShareLabel.text = collectpageVideoOrder.videoNumberOfShare;
//    int videoID = [collectpageVideoOrder.videoID intValue];
    
    int num = [[APPUserPrefs Singleton] APP_getShareNumByVideoID:[collectpageVideoOrder.videoID intValue]];
    cell.videoNumberOfShareLabel.text = [NSString stringWithFormat:@"%d", num];
    cell.videoPlayNumLabel.text = collectpageVideoOrder.videoPlayCount;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    [Video Singleton].videoSignature = collectpageVideoOrder.videoSignature;
    
    int num = [[APPUserPrefs Singleton] APP_setVideoPlayNumByVideoID:[collectpageVideoOrder.videoID intValue]];
    // 设置 cell 对应的播放次数
    MyFavourateTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.videoPlayNumLabel.text = [NSString stringWithFormat:@"%d", num];
    
//    MovieDetailPreviewViewController *detail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieDetailPreviewStoryboardID1"];
//    [self.navigationController pushViewController:detail animated:YES];
    FavourateMovieDetailPreviewViewController *detail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieDetailPreviewStoryboardID"];
    [self.navigationController pushViewController:detail animated:YES];
}

//-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
//    [self performSegueWithIdentifier:@"MyFavourateIndentifier_segue2" sender:self];
//}

@end
