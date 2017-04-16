//
//  MyfavouriteViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/22.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "MyFavouriteViewController.h"
#import "MovieDetailPreviewViewController.h"
#import "UIViewExt.h"
#import "MyFavouriteTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "WaterFlowLayout.h"
#import "MovieDetailPreviewViewController.h"
#import "Video.h"

#import "FavouriteMovieDetailPreviewViewController.h"

@interface MyFavouriteViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) UITableView *tabV; 
@end

@implementation MyFavouriteViewController
@synthesize imageLibraryArra,numberOfArra,videoID,videoName,ownerID,ownerName,ownerAcatar,videoLabelName,videoCreateTime,videoThumbnailUrl,videoReferenceUrl,videoNumberOfPraise,videoNumberOfShare,videoNumberOfFavorite,videoNumberOfComment,videoCollectStatus,szImage,ownerAcatarArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![[UserEntity sharedSingleton].customerId isEqualToString:@""]) {
        imageLibraryArra = [[NSMutableArray alloc] initWithArray:[[APPUserPrefs Singleton] APP_getfavoritevideobyDB:0 Count:10]];
        numberOfArra = imageLibraryArra.count;
        [self setupRefresh];
    }
    
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![UserEntity sharedSingleton].customerId || [[UserEntity sharedSingleton].customerId isEqualToString:@""]) {
        [imageLibraryArra removeAllObjects];
    }
}

#pragma mark -- 新增tabV
- (void)setupTableView {
    UITableView *tabV = [[UITableView alloc] initWithFrame:self.view.frame];
    tabV.delegate = self;
    tabV.dataSource = self;
    [tabV addHeaderWithTarget:self action:@selector(headerRereshing)];
    [tabV addFooterWithTarget:self action:@selector(footerRereshing)];
    [self.view addSubview:tabV];
    self.tabV = tabV;
}

- (void)setupRefresh
{
    
    [self.tabV addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tabV addFooterWithTarget:self action:@selector(footerRereshing)];
    self.tabV.headerPullToRefreshText = @"下拉可以刷新了";
    self.tabV.headerReleaseToRefreshText = @"松开马上刷新了";
    self.tabV.headerRefreshingText = @"";
    
    self.tabV.footerPullToRefreshText = @"上拉可以加载更多数据了";
    self.tabV.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    self.tabV.footerRefreshingText = @"";
}

- (void)headerRereshing
{
    if (![[UserEntity sharedSingleton].customerId isEqualToString:@""]) {
        [imageLibraryArra removeAllObjects];
        [imageLibraryArra addObjectsFromArray:[[APPUserPrefs Singleton] APP_getfavoritevideobyDB:0 Count:10]];
        numberOfArra = imageLibraryArra.count;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tabV reloadData];
            [self.tabV headerEndRefreshing];
        });
    }
}

- (void)footerRereshing
{
    if (![[UserEntity sharedSingleton].customerId isEqualToString:@""]) {
        [imageLibraryArra addObjectsFromArray:[[APPUserPrefs Singleton] APP_getfavoritevideobyDB:(int)numberOfArra Count:10]];
        numberOfArra = imageLibraryArra.count;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tabV reloadData];
            [self.tabV headerEndRefreshing];
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
    static NSString *MyfavouriteIdentifier = @"MyFavouriteIdentifier";
    MyFavouriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyfavouriteIdentifier];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MyFavouriteTableViewCell" owner:nil options:nil] lastObject];
    }
    
    CollectpageVideoOrder *collectpageVideoOrder = [imageLibraryArra objectAtIndex:indexPath.row];
    cell.videoImagView.image = [[APPUserPrefs Singleton]APP_getImg:collectpageVideoOrder.videoThumbnailUrl ImageView:cell.videoImagView ImageName:@"huan"];
    
    NSString *videoname = collectpageVideoOrder.videoName;
    cell.videoNameLabel.text = videoname;
    cell.videoNameLabelWidth.constant = [videoname sizeWithWidth:MAXFLOAT font:[UIFont systemFontOfSize:15]].width;
    
    NSString *ownername = collectpageVideoOrder.ownerName;
    cell.ownerNameLabel.text = ownername;
    cell.ownerNameLabelWidth.constant = [ownername sizeWithWidth:MAXFLOAT font:[UIFont systemFontOfSize:15]].width;
    
    NSString *praise = collectpageVideoOrder.videoNumberOfPraise;
    cell.videoNumberOfPraiseLabel.text = praise;
    cell.praiseWidth.constant = [praise sizeWithWidth:MAXFLOAT font:[UIFont systemFontOfSize:15]].width;
    
    NSString *share = collectpageVideoOrder.videoNumberOfShare;
    cell.videoNumberOfShareLabel.text = share;
    cell.videoNameLabelWidth.constant = [share sizeWithWidth:MAXFLOAT font:[UIFont systemFontOfSize:15]].width;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
    
    FavouriteMovieDetailPreviewViewController *fav = [[FavouriteMovieDetailPreviewViewController alloc] init];
    [self.navigationController pushViewController:fav animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 408 * SCREEN_WIDTH / 720;
}


@end
