
//
//  FirstViewController.m
//  M-Cut
//
//  Created by Crab shell on 12/21/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//
// cell 之间的间距
#define ISHomeCellMargin 4
// cell 显示的列数
#define ISHomeCellColumn 2
// cell 的宽度
#define ISHomeCellWidth (ISScreen_Width - ISHomeCellMargin * (ISHomeCellColumn + 1)) * 0.5
// cell 的宽高比
#define ISHomeCellRatio (457 / 363.0)
// 顶部视图的高度
#define ISHomeTopViewRatio (372.0 / 740.0)
#define ISHomeTopViewRatioWhenSearchBarHidden (288.0 / 740.0)
#define ISHomeTopViewHeight ((ISScreen_Width - 2 * ISHomeCellMargin) * ISHomeTopViewRatio)
#define ISHomeTopViewHeightWhenSearchBarHidden ((ISScreen_Width - 2 * ISHomeCellMargin) * ISHomeTopViewRatioWhenSearchBarHidden)
#define ISHomeBannerRatio (372.0 / 740.0)
#define ISHomeBannerRatioWhenSearchHidden (288.0 / 740.0)

#import "HomeViewController.h"
#import "UIViewExt.h"
//#import "HomeCollectionViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "WaterFlowLayout.h"
#import "MovieDetailPreviewViewController.h"
#import "Video.h"
#import "MJRefresh.h"
#import "SoapOperation.h"
#import "HomeShowViewC.h"
#import "CommonMacro.h"
#import "MWICloudSearchBar.h"
#import "ISSpecialFlowLayout.h"

#pragma mark ---- 2015/11/19 修改主界面-------------------------新增内容-----------------------------
// 显示内容控制器
#import "ISHomeContentViewController.h"
#import "ISSpecialViewController.h"
// 导航条的 view
#import "ISNavigationView.h"
// 标签数据模型
#import "ISLabel.h"
// 数据库操作
#import "VideoDBOperation.h"
#import "HomeBannerWebViewController.h"
// 搜索内容展示
#import "MySearchCell.h"
#import "MySearchUserCell.h"
#import "UIImage+Extension.h"
#import "ISHomeVideoCell.h"
#import <MBProgressHUD.h>
#import "SearchUserVC.h"
#import "MyFourSearchCell2.h"
#import "MyVideoViewController.h"

@interface HomeViewController () <ISNavigationViewDelegate, UIScrollViewDelegate, ISHomeContentViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate, MBProgressHUDDelegate>
/**  主视图 */
@property (weak, nonatomic) UIScrollView *scrollView;
/**  创建导航按钮视图 */
@property (weak, nonatomic) ISNavigationView *navigationView;

/**  导航条默认选中第一个按钮 */
@property (assign, nonatomic) NSInteger currentSelectIndex;

/**  记录当前位置是否已经被选中过了, 选中过的保存为 @"YES", 没有选中过的保存为 @"NO" */
@property (strong, nonatomic) NSMutableDictionary *itemHasSelectedDict;

/**  记录 scrollView 停止拖拽时的位置的 坐标 */
@property (assign, nonatomic) CGPoint endPoint;

/**  监听网络状态 ---- 有网络: @"YES"  无网络: @"NO" */
@property (copy, nonatomic) NSString *netState;


/**  存放标签 名称 的数组, 用于更新数据时使用 */
@property (strong, nonatomic) NSMutableArray *titles;
/**  存放标签的数组, 加载本地数据 */
@property (strong, nonatomic) NSMutableArray *localInfos;

/**  存放标签的数组, 加载网络数据, 存放 ISLabel 对象 */
@property (strong, nonatomic) NSMutableArray *labelInfos;

/**  数据库缓存操作对象 */
@property (strong, nonatomic) VideoDBOperation *dbOperation;

//搜索功能
@property (nonatomic, strong) UISearchDisplayController * searchDC;
@property (nonatomic, strong) NSMutableArray * searchMuArray;
@property (nonatomic, strong) UITableView * searchTable;
@property (nonatomic, strong) UISearchBar * searchBa;
/**  加载动画控制对象*/
@property (nonatomic, strong) MBProgressHUD * HUD;
/**  存储用户头像*/
@property (nonatomic, strong) NSMutableArray * buttonArray;
/**  存放展示视频的对象（一个数组对应cell的一个位置的数据源）*/
@property (nonatomic, strong) NSMutableArray * oneVideoMuArray;
@property (nonatomic, strong) NSMutableArray * twoVideoMuArray;
@property (nonatomic, strong) NSMutableArray * threeVideoMuArray;
@property (nonatomic, strong) NSMutableArray * fourVideoMuArray;

/**  下载的数据个数*/
@property (nonatomic, assign) NSInteger videoNum;
/** 搜索无视频提示label*/
@property (nonatomic, strong) UILabel * noUserLabel;
@end
#pragma mark ---- 2015/11/19 修改主界面----------------------以上为新增内容-----------------------------


@implementation HomeViewController
@synthesize imageLibraryArra,numberOfArra,videoID,videoName,ownerID,ownerName,ownerAcatar,videoLabelName,videoCreateTime,videoThumbnailUrl,videoReferenceUrl,videoNumberOfPraise,videoNumberOfShare,videoNumberOfFavorite,videoNumberOfComment,videoCollectStatus,szImage,ownerAcatarArr,videoLabelArr,videoLabelID,integers;
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (integers > 0) {
        [videoNumberOfPraise replaceObjectAtIndex:integers withObject:[Video Singleton].videoNumberOfPraise];
    }
    [self.tabBarController.tabBar setHidden:NO];
#pragma mark --- 当主界面重新加载时, navigationView 为空??
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    self.tabBarController.tabBar.hidden = NO;
    if (self.searchBa.text.length != 0) {
        self.tabBarController.tabBar.hidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark ---- 2015/11/19 修改主界面-------------------------新增内容-----------------------------
- (NSMutableArray *)titles {
    if (!_titles) {
        self.titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)labelInfos {
    if (!_labelInfos) {
        self.labelInfos = [NSMutableArray array];
    }
    return _labelInfos;
}

- (NSMutableArray *)localInfos {
    if (!_localInfos) {
        self.localInfos = [NSMutableArray array];
    }
    return _localInfos;
}

- (VideoDBOperation *)dbOperation {
    if (!_dbOperation) {
        self.dbOperation = [VideoDBOperation Singleton];
    }
    return _dbOperation;
}

- (NSMutableDictionary *)itemHasSelectedDict {
    if (!_itemHasSelectedDict) {
        self.itemHasSelectedDict = [NSMutableDictionary dictionary];
    }
    return _itemHasSelectedDict;
}

- (void)hideSearchBar:(NSNotification *)noti{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = ISScreen_Width;
    CGFloat h = ISScreen_Height - ISNavigationHeight;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
            UIScrollView * scrollView = (UIScrollView *)[weakSelf.view viewWithTag:6];
            scrollView.frame = CGRectMake(x, y, w, h);
    }];
}

- (void)showSearchBar:(NSNotification *)noti{
    CGFloat x = 0;
    CGFloat y = 40;
    CGFloat w = ISScreen_Width;
    CGFloat h = ISScreen_Height - ISNavigationHeight;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
            UIScrollView * scrollView = (UIScrollView *)[weakSelf.view viewWithTag:6];
            scrollView.frame = CGRectMake(x, y, w, h);
    }];
    
}

#pragma mark ---- 2015/11/19 修改主界面----------------------以上为新增内容-----------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.tabBarController.tabBar.hidden == YES) {
        self.tabBarController.tabBar.hidden = NO;
    }
    
    //接收隐藏或者显示搜索框的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideSearchBar:) name:@"scrollDown" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSearchBar:) name:@"scrollUp" object:nil];
    
    //添加搜索框
    [self setUpSearch];
#pragma mark ---- 原有布局
//    [self loadDataOld];
    
#pragma mark ---- 2015/11/19 修改主界面-------------------------新增内容-----------------------------
//    self.navigationController.navigationBar.translucent = NO;
    // 加载滚动视图 scrollView
    [self setupScrollView];
    
    
    
    // 默认选中第一个
    self.currentSelectIndex = 0;
    
    [self loadDataNew];
#pragma mark ---- 2015/11/19 修改主界面----------------------以上为新增内容-----------------------------
    
    // 监听   制作影片素材上传进度改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadProgressChange:) name:UploadFileProgressChange object:nil];
    
    //让所有位置的提示数字更新一下
    [[VideoDBOperation Singleton] setBadgeNum];
}

#pragma mark - 添加搜索
- (void)setUpSearch
{
    //初始化UITableView
    self.searchTable = [[UITableView alloc] initWithFrame:CGRectMake(0, -1, ISScreen_Width, 44) style:UITableViewStylePlain];
    [self.view addSubview:self.searchTable];
    self.searchTable.delegate = self;
    self.searchTable.dataSource = self;
    self.searchTable.scrollEnabled = NO;
    
    
    //初始化UISearchBar
    self.searchBa = [[UISearchBar alloc] init];
    self.searchTable.tableHeaderView = self.searchBa;
    self.searchBa.placeholder = @"搜索";
    self.searchBa.searchBarStyle = UISearchBarStyleProminent;
    self.searchBa.delegate = self;
    [self.searchBa sizeToFit];
    self.searchBa.keyboardType = UIKeyboardTypeDefault;
    self.searchBa.barStyle = UIBarStyleDefault;
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigation_bg"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    self.searchBa.tintColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1];
    self.searchBa.barTintColor = ISBackgroundColor;
    
    //初始化UISearchDisplayController
    self.searchDC = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBa contentsController:self];
    self.searchDC.searchResultsDataSource = self;
    self.searchDC.searchResultsDelegate = self;
    self.searchDC.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.searchDC.searchResultsTableView.showsHorizontalScrollIndicator = NO;
    self.searchDC.searchResultsTableView.showsVerticalScrollIndicator = NO;
    self.hidesBottomBarWhenPushed = YES;
    
    [self.searchDC.searchResultsTableView addFooterWithTarget:self action:@selector(loadMoreData)];
}

#pragma mark - 搜索代理
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    self.tabBarController.tabBar.alpha = 0;
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    self.tabBarController.tabBar.alpha = 1;
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    self.tabBarController.tabBar.hidden = YES;
    //当搜索结束时显示tabbar
    if(self.searchBa.text.length == 0) {
        self.tabBarController.tabBar.hidden = NO;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //将搜索记录添加到数据库中
    [[VideoDBOperation Singleton] DB_AddRecord:self.searchBa.text];
    //下砸搜索数据并展示结果
    [self searchTableReloadData:self.searchBa.text];
    
}

- (void)searchTableReloadData:(NSString *)searchBarText
{
    self.tabBarController.tabBar.hidden = YES;
    [self.searchMuArray[0] removeAllObjects];
    [self.searchMuArray[1] removeAllObjects];
    [self.searchMuArray[2] removeAllObjects];
    [self.oneVideoMuArray removeAllObjects];
    [self.twoVideoMuArray removeAllObjects];
    [self.threeVideoMuArray removeAllObjects];
    [self.fourVideoMuArray removeAllObjects];
        __weak typeof(self) weakSelf = self;
        [[SoapOperation Singleton] WS_SearchUser:searchBarText Start:0 Count:[NSNumber numberWithInt:5] Success:^(MovierDCInterfaceSvc_VDCCustomerBaseInfoExArr *array) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"下载了%lu个用户信息", (unsigned long)array.item.count);
                [weakSelf.searchMuArray[0] removeAllObjects];
                [weakSelf.searchMuArray replaceObjectAtIndex:1 withObject:array.item];
                [weakSelf.searchDC.searchResultsTableView reloadData];
                
            });
        } Fail:^(NSError *error) {
            NSLog(@"searchUser error--------- %@", error);
        }];
    [self.searchMuArray[2] removeAllObjects];
    [self loadMoreData];
}

- (void)loadMoreData
{
    __weak typeof(self) weakSelf = self;
    [[SoapOperation Singleton] WS_SearchVideo:self.searchBa.text Start:@([self.searchMuArray[2] count]) Count:@(64) Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.searchMuArray[0] removeAllObjects];
            [weakSelf.searchMuArray[2] addObjectsFromArray:[array.item copy]];
            [weakSelf.oneVideoMuArray removeAllObjects];
            [weakSelf.twoVideoMuArray removeAllObjects];
            [weakSelf.threeVideoMuArray removeAllObjects];
            [weakSelf.fourVideoMuArray removeAllObjects];
            for(int i = 0; i < [weakSelf.searchMuArray[2] count]; i++){
                MovierDCInterfaceSvc_VDCVideoInfoEx * videoInfo = weakSelf.searchMuArray[2][i];
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
            [weakSelf.searchDC.searchResultsTableView reloadData];
            [weakSelf.searchDC.searchResultsTableView footerEndRefreshing];
            if(array.item.count < 64){
                [weakSelf.searchDC.searchResultsTableView removeFooter];
            }
        });
    } Fail:^(NSError *error) {
        NSLog(@"searchVideo error--------%@", error);
    }];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //添加搜索记录
    [self.searchMuArray replaceObjectAtIndex:0 withObject:[NSMutableArray arrayWithArray:[[VideoDBOperation Singleton] findRecentRecord]]];
    [self.searchDC.searchResultsTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark -  搜索table
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.searchDC.searchResultsTableView){
        if (indexPath.section == 1) {
            return 80;
        }
        else if (indexPath.section == 2) {
            if (self.oneVideoMuArray.count > self.threeVideoMuArray.count) {
                if (indexPath.row == self.oneVideoMuArray.count - 1) {
                    return ISScreen_Height / 3 + 6;
                }
            }
            return ISScreen_Height / 3 + ISScreen_Height / 6;
        }
    return 44;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDC.searchResultsTableView){
        if (section == 1) {
            return 1;
        }
        else if (section == 2){
            //返回oneVideoMuArray的个数作为二组cell的数量
            if (self.oneVideoMuArray.count == 0) {
                self.noUserLabel = [[UILabel alloc] initWithFrame:CGRectMake(ISScreen_Width / 2 - 50, ISScreen_Height / 2 - 200, 100, 100)];
                self.noUserLabel.tag = 10000;
                self.noUserLabel.text = @"无相关视频";
                self.noUserLabel.textColor = [UIColor grayColor];
                self.noUserLabel.textAlignment = NSTextAlignmentCenter;
                self.noUserLabel.font = [UIFont fontWithName:@"Helvetica" size:17.f];
                self.searchDC.searchResultsTableView.backgroundView = self.noUserLabel;
                self.noUserLabel.hidden = NO;
            }
            else{
                self.noUserLabel.hidden = YES;
            }
            return self.oneVideoMuArray.count;
        }
        else {
            return [self.searchMuArray[section] count];
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.searchDC.searchResultsTableView)
    {
        if([self.searchMuArray[0] count] != 0) {
            return 1;
        }
        else if([self.searchMuArray[1] count] == 0 && [self.searchMuArray[2] count] == 0) {
            //无结果情况
            return 0;
        }
        else {
        return 3;
        }
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.searchDC.searchResultsTableView) {
        if ([self.searchMuArray[0] count] != 0) {
            if (section == 0) {
                return @"历史搜索";
            }
        }
        if([self.searchMuArray[0] count] == 0 && ([self.searchMuArray[1] count] != 0 || [self.searchMuArray[2] count] != 0)){
        if (section == 1) {
            return @"相关用户";
        }
        else if (section == 2){
            return @"相关视频";
        }
        }
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.searchDC.searchResultsTableView) {
        //展示搜索记录（0组）
        if (indexPath.section == 0) {
            MySearchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
            if(cell == nil){
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MySearchCell" owner:nil options:nil] lastObject];
            }
            UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 30)];
            label.text = self.searchMuArray[0][indexPath.row];
            [cell.recordButton addSubview:label];
            label.textColor = [UIColor grayColor];
            label.font = [UIFont boldSystemFontOfSize:15];
            if ([label.text isEqualToString:@"全部搜索记录"] || [label.text isEqualToString:@"清空搜索记录"]) {
                label.textAlignment = NSTextAlignmentCenter;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if ([self.searchMuArray[0][indexPath.row] isEqualToString:@"全部搜索记录"])  {
                cell.recordButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [cell.recordButton addTarget:self action:@selector(recordButtonShowAllRecord) forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([self.searchMuArray[0][indexPath.row] isEqualToString:@"清空搜索记录"]) {
                cell.recordButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [cell.recordButton addTarget:self action:@selector(recordButtonEmptyRecord) forControlEvents:UIControlEventTouchUpInside];
            }
            else{
                cell.recordButton.tag = indexPath.row;
                [cell.recordButton addTarget:self action:@selector(recordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            return cell;
        }
        //展示相关用户(1组)
        else if (indexPath.section == 1){
            MySearchUserCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"MySearchUserCell" owner:nil options:nil] lastObject];
            }
            NSArray * buttonArr = @[cell.user1, cell.user2, cell.user3, cell.user4, cell.user5];
            [self.buttonArray removeAllObjects];
            [self.buttonArray addObjectsFromArray:buttonArr];
                int i = 0;
                for (UIImageView * imageView in self.buttonArray) {
                    if(i < [self.searchMuArray[1] count]){
                    if (self.searchMuArray[1][i] != nil) {
                        imageView.tag = 200 + i;
                        MovierDCInterfaceSvc_VDCCustomerBaseInfoEx * customeBaseInfo = self.searchMuArray[1][i];
                        [imageView sd_setImageWithURL:[NSURL URLWithString:customeBaseInfo.szAcatar] placeholderImage:[UIImage imageNamed:@"icon"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
                        imageView.layer.masksToBounds = YES;
                        imageView.layer.cornerRadius = imageView.frame.size.width / 2;
                        imageView.userInteractionEnabled = YES;
                        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userBtnAction:)]];
                        i++;
                    }
                    }
                    else {
                        [imageView setHidden:YES];
                    }
                }
            if ([self.searchMuArray[1] count] == 5) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (iPhone4 || iPhone5_5S_5C) {
                cell.user5.hidden = YES;
            }
            if([self.searchMuArray[1] count] > 0){
                cell.noUserLabel.hidden = YES;
            }
            else{
                cell.noUserLabel.hidden = NO;
            }
            return cell;
        }
        //展示相关视频（2组）
        else if(indexPath.section == 2){
            MyFourSearchCell2 * cell = [tableView cellForRowAtIndexPath:indexPath];
            if (cell == nil) {
                cell = [[MyFourSearchCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self setCellWithIndex:indexPath Cell:cell Array:self.oneVideoMuArray BackImage:cell.buttonImage1 Tag:20000 Button:cell.backImage1 NameLabel:cell.videoNameLabel1 AuthorLabel:cell.videoAuthorLabel1 LookTimesLabel:cell.lookTimesLabel1 LikeTimesLabel:cell.likeTimesLabel1];
            [self setCellWithIndex:indexPath Cell:cell Array:self.twoVideoMuArray BackImage:cell.buttonImage2 Tag:40000 Button:cell.backImage2 NameLabel:cell.videoNameLabel2 AuthorLabel:cell.videoAuthorLabel2 LookTimesLabel:cell.lookTimesLabel2 LikeTimesLabel:cell.likeTimesLabel2];
            [self setCellWithIndex:indexPath Cell:cell Array:self.threeVideoMuArray BackImage:cell.buttonImage3 Tag:60000 Button:cell.backImage3 NameLabel:cell.videoNameLabel3 AuthorLabel:cell.videoAuthorLabel3 LookTimesLabel:cell.lookTimesLabel3 LikeTimesLabel:cell.likeTimesLabel3];
            [self setCellWithIndex:indexPath Cell:cell Array:self.fourVideoMuArray BackImage:cell.buttonImage4 Tag:80000 Button:cell.backImage4 NameLabel:cell.videoNameLabel4 AuthorLabel:cell.videoAuthorLabel4 LookTimesLabel:cell.lookTimesLabel4 LikeTimesLabel:cell.likeTimesLabel4];
        return cell;
        }
    }
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)setCellWithIndex:(NSIndexPath *)indexPath Cell:(MyFourSearchCell2 *)cell Array:(NSMutableArray *)videoMuArray BackImage:(UIImageView *)cellBackImage Tag:(NSInteger)cellImageTag Button:(UIButton *)cellButton NameLabel:(UILabel *)cellNameLabel AuthorLabel:(UILabel *)cellAuthorLabel LookTimesLabel:(UILabel *)cellLookTimesLabel LikeTimesLabel:(UILabel *)cellLikeTimesLabel{
    if (indexPath.row < videoMuArray.count) {
    MovierDCInterfaceSvc_VDCVideoInfoEx * videoInfoEx = videoMuArray[indexPath.row];
    VideoInformationObject * videoInfo = [self setAssignment:videoInfoEx];
    [cellBackImage sd_setImageWithURL:[NSURL URLWithString:videoInfo.videoThumbnailUrl] placeholderImage:[UIImage imageNamed:@"overlayBG_shadow"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    cellButton.tag = cellImageTag + indexPath.row;
    [cellButton addTarget:self action:@selector(videoAction:) forControlEvents:UIControlEventTouchUpInside];
    cellNameLabel.text = videoInfo.videoName;
    cellAuthorLabel.text = videoInfo.ownerName;
    NSString * videoPlayCount = videoInfo.videoPlayCount;
    int playCount = [videoPlayCount intValue];
    if (playCount > 10000) {
        videoPlayCount = [NSString stringWithFormat:@"%.1f万", (float)playCount / 10000];
    }
    cellLookTimesLabel.text = videoPlayCount;
    (videoInfo.videoNumberOfPraise.length > 3) ? (cellLikeTimesLabel.text = @"...") : (cellLikeTimesLabel.text = videoInfo.videoNumberOfPraise);
    }else if (indexPath.row >= videoMuArray.count){
        cellBackImage.hidden = YES;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //搜索table的点击方法
    if (tableView == self.searchDC.searchResultsTableView) {
        if(indexPath.row == 0 && indexPath.section == 1 && [self.searchMuArray[1] count] > 4){
            //跳转到所有用户页面
            SearchUserVC * searchUserVC = [[SearchUserVC alloc] init];
            searchUserVC.searchBarText = self.searchBa.text;
            [self.navigationController pushViewController:searchUserVC animated:YES];
        }
    }
}

#pragma mark - 点击
//跳转到视频播放页面
- (void)videoAction:(UIButton *)btn
{
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

/** 跳转到搜索视频播放页面*/
- (void)pushToHomeVideoDetailWithVideoInfoEx:(MovierDCInterfaceSvc_VDCVideoInfoEx *)videoInfoEx{
    [[Video Singleton] setContent:[self setAssignment:videoInfoEx]];
    HomeVideoDetailViewController * detail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieDetailPreviewStoryboardID1"];
    VideoShowViewController * detailViewC = [VideoShowViewController new];
    detail.videoId = [videoInfoEx.nVideoID intValue];
    detail.isHiddenTabbar = YES;
//<<<<<<< .mine
    [self.navigationController pushViewController:detailViewC animated:YES];
//=======
//    detail.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:detail animated:YES];
//>>>>>>> .r871
}

//跳转到用户详情页面
- (void)userBtnAction:(UITapGestureRecognizer *)gesture
{
    UIView * myView = [gesture view];
    MovierDCInterfaceSvc_VDCCustomerBaseInfoEx * customerInfo = self.searchMuArray[1][myView.tag - 200];
    
    MyVideoViewController * videoVc = [MyVideoViewController new];
    videoVc.isShowOtherUserVideo = YES;
    videoVc.userId = [NSString stringWithFormat:@"%@", customerInfo.nCustomerID];
    videoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:videoVc animated:YES];
   
//    __weak typeof(self) weakSelf = self;
//    [[SoapOperation Singleton] WS_GetPersonalVideos:nil Customer:customerInfo.nCustomerID Start:0 Count:[NSNumber numberWithInt:1] Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array) {
//      dispatch_async(dispatch_get_main_queue(), ^{
//           OtherPeopleViewController *other = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OthersVCStoryBoardID"];
//          if (array.item.count > 0) {
//              MovierDCInterfaceSvc_VDCVideoInfoEx * videoInforEx = array.item[0];
//              [[Video Singleton] setWSContent:videoInforEx];
//              [weakSelf.navigationController pushViewController:other animated:YES];
//          }
//          else {
//              UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"该用户视频没有公开" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
//              [alert show];
//          }
//      });
//    } Fail:^(NSError *error) {
//        
//    }];
    
}

//点击搜索记录时，执行该方法
- (void)recordButtonAction:(UIButton *)btn
{
    [self.searchBa resignFirstResponder];
    NSArray * recordArray = [[VideoDBOperation Singleton] findRecord];
    [self searchTableReloadData:recordArray[btn.tag]];
    self.searchBa.text = recordArray[btn.tag];
}

//显示所有搜索记录
- (void)recordButtonShowAllRecord
{
    [self.searchMuArray replaceObjectAtIndex:0 withObject:[NSMutableArray arrayWithArray:[[VideoDBOperation Singleton] findRecord]]];
    [self.searchBa resignFirstResponder];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.searchDC.searchResultsTableView reloadData];
    });
}

//清空搜索记录
- (void)recordButtonEmptyRecord
{
    [[VideoDBOperation Singleton] DeleteAllRecord];
    [self.searchMuArray[0] removeAllObjects];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.searchDC.searchResultsTableView reloadData];
    });
}


#pragma mark ---- 2015/11/19 修改主界面-------------------------新增内容-----------------------------
- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    //添加searchBar时scroll下移44，需要隐藏是上移44
    CGFloat x = 0;
    CGFloat y = 40;
    CGFloat w = ISScreen_Width;
    CGFloat h = ISScreen_Height - ISNavigationHeight;
//    CGFloat h = ISScreen_Height - ISTabBarHeight - ISNavigationHeight;
    scrollView.frame = CGRectMake(x, y, w, h);
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    scrollView.tag = 6;
    self.scrollView = scrollView;
}


- (void)loadDataNew {
#pragma mark ---- 2015-11-26  更改 soap 接口
#pragma mark ---- 缓存策略, 加载数据库 (null) --> 本地数据 , 同时加载网络数据
    
    // 1. 加载数据库中的数据, 如果数据库为空, self.localInfos 中没有数据
    // 加载一级标签, parentid = 0
    NSMutableArray *labels = [self.dbOperation DB_GetLabels:@(0)];
    if (labels.count == 0 || !labels) {    // 数据库中数据为空, 加载 bundle 中的数据
        [self loadLabelsFromBundle];
    } else {    // 加载数据库中的数据
        [self loadDBLabels:labels];
    }
    [self setupChildVcs:self.localInfos];
    
    // 3. 网络数据加载
    [self requestServer];
}

- (void)loadDBLabels:(NSMutableArray *)labels {
    // 将 labels 中的字典对象转成 label 模型
    for (NSDictionary *dict in labels) {
        ISLabel *label = [ISLabel labelWithDict:dict];
        [self.localInfos addObject:label];
    }
}

- (void)loadLabelsFromBundle {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"labels.plist" ofType:nil];
    NSArray *labels = [NSArray arrayWithContentsOfFile:path];
    for (NSDictionary *dict in labels) {
        ISLabel *label = [ISLabel labelWithDict:dict];
        [self.localInfos addObject:label];
    }
}

#pragma mark --- 创建子控制器
/**   没有网络时, 初始化子控制器, labels 中存放的是 ISLabel 模型 */
- (void)setupChildVcs:(NSMutableArray *)labels {
    if (labels.count == 0)  return;
    // 1. 设置初始 scrollView 状态
    NSInteger count = labels.count;
    self.scrollView.contentSize = CGSizeMake(ISScreen_Width * count, 0);
    for (NSInteger i = 0; i < count; i ++) {
        self.itemHasSelectedDict[@(i)] = @"NO";
    }
    
    // 2. 创建对应个数的控制器
    [self addChildVcWithArray:labels];
    
    // 3. 创建标签的个数创建对应个数的导航按钮
    NSMutableArray *titles = [NSMutableArray array];
    for (ISLabel *label in labels) {
        [titles addObject:label.szLabelName];
    }
    
    if (self.navigationView) {
        self.navigationView.titles = titles;
    } else {
        ISNavigationView *navigationView = [ISNavigationView navigationViewWithTitles:titles];
        navigationView.delegate = self;
        self.navigationItem.titleView = navigationView;
        self.navigationView = navigationView;
    }
    
    // 显示第一个控制器
    [self addViewWithIndex:0];
}

/**  初始化 -- 加载缓存时调用
 *   labels 中存放的是 ISLabel 模型
 */
#pragma mark - 添加collectionView
- (void)addChildVcWithArray:(NSMutableArray *)labels {
    for (NSInteger i = 0; i < labels.count; i++) {
        ISHomeContentViewController *home = [[ISHomeContentViewController alloc] init];
        home.label = labels[i];
        // 将子控制器 添加到数组中
        // 不要在这里添加控制器的 View, 这样会将所有的控制器View 实例化
        [self addChildViewController:home];
    }
}

/**   更新布局 */
- (void)updateLayout:(NSMutableArray *)labels withTitles:(NSMutableArray *)titles{
    if (labels.count == 0) {
        return;
    }
    
    [self.itemHasSelectedDict removeAllObjects];
    // 设置 view 的初始状态
    for (NSInteger i = 0; i < labels.count; i ++) {
        self.itemHasSelectedDict[@(i)] = @"NO";
    }
    
    //  删除导航
    if (self.navigationView) {
        [self.navigationView removeFromSuperview];
        self.navigationView = nil;
    }
    
    //  网络请求的标签对象个数 self.labelInfos == labels
    NSInteger serverLabelsCount = self.labelInfos.count;
    //  本地的标签对象个数
    NSInteger localLabelsCount  = self.localInfos.count;
    if (serverLabelsCount > localLabelsCount) {     // 网络 labels > 本地 labels
        for (NSInteger i = 0; i < serverLabelsCount - localLabelsCount; i++) {
            ISHomeContentViewController *home = [[ISHomeContentViewController alloc] init];
            [self addChildViewController:home];
        }
    } else if (serverLabelsCount < localLabelsCount) {  // 网络 labels < 本地 labels
        for (NSInteger i = 0; i < localLabelsCount - serverLabelsCount; i++) {
            [self.childViewControllers[serverLabelsCount] removeFromParentViewController];
        }
    }
    //  更新过后, 内存中的页面个数和网络上相同, 设置导航条
    ISNavigationView *navigationView = [ISNavigationView navigationViewWithTitles:titles];
    navigationView.delegate = self;
    self.navigationItem.titleView = navigationView;
    self.navigationView = navigationView;
    if (self.scrollView.subviews.count > 0) {
        for (UIView *view in self.scrollView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    // 显示第一个视图
    [self addViewWithIndex:0];
}

/**  从服务器请求数据 */
- (void)requestServer {
    //  网络请求, 拿到标签
    SoapOperation *soap = [SoapOperation Singleton];
    
    // 将数据库以前的缓存数据删除
    [self.dbOperation DB_DeleteLabelByParentId:@(0)];
    
    [soap WS_GetVideoLabel:nil Start:@(0) Count:@(20) Parent:@(0) Success:^(MovierDCInterfaceSvc_VDCVideoLabelExArray *ws_ret) {
        // 获得 label 标签 数据
        [self.labelInfos removeAllObjects];
        for (NSInteger i = 0; i < ws_ret.item.count; i++) {
            MovierDCInterfaceSvc_VDCVideoLabelEx *vdcLabel = ws_ret.item[i];
            // 将服务器返回的模型数据统一为 ISLabel
            ISLabel *label      = [[ISLabel alloc] init];
            label.nLabelID      = vdcLabel.nLabelID;
            label.szLabelName   = vdcLabel.szLabelName;
            label.nParentID     = vdcLabel.nParentID;
            label.szThumbnail   = vdcLabel.szThumbnail;
            label.nType         = vdcLabel.nType;
            label.szDescribe    = vdcLabel.szDescribe;
            // 将 label 数据缓存到数据库
            [self.dbOperation DB_AddLabel:label.szLabelName labelId:label.nLabelID Parent:label.nParentID Thumbnail:label.szThumbnail Type:label.nType];
            
            // 保存标签模型到缓存数组中
            [self.labelInfos addObject:label];
            
            // 保存标签名称, 创建导航的按钮
            [self.titles addObject:label.szLabelName];
        }
        // 将以前的布局删除
        dispatch_async(dispatch_get_main_queue(), ^{
            self.netState = @"YES";
            //  更新布局
            [self updateLayout:self.labelInfos withTitles:self.titles];
        });
    } Fail:^(NSError *error) {
        self.netState = @"NO";
        NSLog(@"-----%s----%@", __func__, error);
    }];
}

#pragma mark ----- UIScrollViewDelegate 监听主视图的滚动
/**  停止滚动 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//     [self togetherSlide];
    // 记录结束拖拽点的 x
    self.endPoint = scrollView.contentOffset;
    NSInteger count = 0;
    if ([self.netState isEqualToString:@"YES"]) {   // 有网络, 网络数据
        count = self.labelInfos.count;
    } else {    // 无网络, 本地数据
        count = self.localInfos.count;
    }
    
    if (self.endPoint.x - self.currentSelectIndex * ISScreen_Width > ISScreen_Width * 0.5) {  //  向右拖拽
        if (self.currentSelectIndex == count)  return;
        [self scrollToRight:YES];
    } else if (self.currentSelectIndex * ISScreen_Width - self.endPoint.x > ISScreen_Width * 0.5 ){    // 向左拖拽
        if (self.currentSelectIndex == 0)  return;
        [self scrollToRight:NO];
    }
    // 其余情况不进行翻页处理, 上下拉时需要进行刷新工作
    
}

- (void)scrollToRight:(BOOL)isToRight {
    // 0. 根据方向设置 self.currentSelectIndex 的值
    NSInteger count = 0;
    if ([self.netState isEqualToString:@"YES"]) {   // 有网络, 网络数据
        count = self.labelInfos.count;
    } else {    // 无网络, 本地数据
        count = self.localInfos.count;
    }
    
    if (isToRight == YES) {
        if (self.currentSelectIndex < count - 1) {
            self.currentSelectIndex = self.currentSelectIndex + 1;
        } else {
            return;
        }
    } else {
        if (self.currentSelectIndex > 0) {
            self.currentSelectIndex = self.currentSelectIndex - 1;
        } else {
            return;
        }
    }
    
    // 1. 将导航条的 slider 滚动到和当前选中位置一致 的地方
    UIButton *button = [self.navigationView viewWithTag:self.currentSelectIndex];
    [self.navigationView scrollToButton:button];
    
    // 2. 滚动 scrollView 到相应的位置
    self.scrollView.contentOffset = CGPointMake(self.currentSelectIndex * ISScreen_Width, 0);
    
    // 3. 加载视图
    [self addViewWithIndex:self.currentSelectIndex];
}

/**  向 scrollView 中添加视图 */
- (void)addViewWithIndex:(NSInteger)index {
    // 取出对应位置的 label, 根据类型确定控制器的类型
    if ([self.itemHasSelectedDict[@(index)] isEqualToString:@"NO"]) {
        ISHomeContentViewController *home = self.childViewControllers[index];
        home.netState = self.netState;
        home.delegate = self;
        if ([self.netState isEqualToString:@"YES"]) {
            home.label = self.labelInfos[index];
        } else {
            home.label = self.localInfos[index];
        }
        home.view.frame = CGRectMake(index * ISScreen_Width, 0, ISScreen_Width, self.view.bounds.size.height);
        [self.scrollView addSubview:home.view];
        self.itemHasSelectedDict[@(index)] = @"YES";
    }
}

#pragma mark -------  ISHomeContentViewControllerDelegate   跳转到视频播放界面
- (void)homeContentViewController:(ISHomeContentViewController *)homeContentViewController didClickVideo:(int)videoID {
//    [self performSegueWithIdentifier:@"ShowDetailVideo" sender:self];
//    HomeVideoDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieDetailPreviewStoryboardID1"];
//    VideoShowViewController *detail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShowVideoStoryboard"];
//    [self.navigationController pushViewController:detail animated:YES];
    VideoShowViewController * detailViewC = [VideoShowViewController new];
    [self.navigationController pushViewController:detailViewC animated:YES];
}

- (void)homeContentViewController:(ISHomeContentViewController *)homeContentViewController didClickSpecial:(ISLabel *)label {
    ISSpecialViewController *special = [[ISSpecialViewController alloc] init];
    special.label = label;
    [self.navigationController pushViewController:special animated:YES];
}

- (void)homeContentViewController:(ISHomeContentViewController *)homeContentViewController didClickBanner:(MovierDCInterfaceSvc_VDCBannerInfo *)bannerInfo {
    NSInteger bannerType = [bannerInfo.nType intValue];
    
    if (bannerType == 1) {      // 跳转到用户界面
#pragma mark --- 暂无数据 2015- 12- 07
//        OtherPeopleViewController *other = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OthersVCStoryBoardID"];
////        other.iconUrl = bannerInfo.szThumbnail;
//        other.isTransFromCommentList = YES;
//        other.customID = [bannerInfo.nPara1 intValue];
//        [self.navigationController pushViewController:other animated:YES];
        MyVideoViewController * videoVc = [MyVideoViewController new];
        videoVc.isShowOtherUserVideo = YES;
        videoVc.userId = [NSString stringWithFormat:@"%@", bannerInfo.nPara1];
        videoVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:videoVc animated:YES];
    } else if (bannerType == 2) {   // 跳转到指定的labelId界面
        // labelID : bannerInfo.nPara1
        // 根据labelID 获得label的详细信息
        [[SoapOperation Singleton] WS_GetLabelDescric:bannerInfo.nPara1 Success:^(MovierDCInterfaceSvc_VDCVideoLabelEx *labelinfo) {
            ISLabel *label      = [[ISLabel alloc] init];
            label.nLabelID      = labelinfo.nLabelID;
            label.szLabelName   = labelinfo.szLabelName;
            label.nParentID     = labelinfo.nParentID;
            label.szThumbnail   = labelinfo.szThumbnail;
            label.nType         = labelinfo.nType;
            label.nVideoNum     = labelinfo.nVideoNum;
            label.szDescribe    = labelinfo.szDescribe;
            dispatch_async(dispatch_get_main_queue(), ^{
                ISSpecialViewController *special = [[ISSpecialViewController alloc] init];
                special.label = label;
                [self.navigationController pushViewController:special animated:YES];
            });
        } Fail:^(NSError *error) {
            NSLog(@"-------%s------%@", __func__, error);
        }];
    } else if (bannerType == 3) {   // 跳转到指定网址
        HomeBannerWebViewController *web = [[HomeBannerWebViewController alloc] init];
        web.url = bannerInfo.szPara3;
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }
}

// 从无网络状态---->有网络状态
- (void)reloadDataFromServer {
    [self requestServer];
}

#pragma mark ------- ISNavigationViewDelegate
// 加载控制器
- (void)navigationView:(ISNavigationView *)navigationView didClickButton:(UIButton *)button {
    // 1. scrollView 的滚动位置, 导航条 slider 滚动在内部实现
    NSInteger tag = button.tag;     // 当前点击的按钮tag
    // 将索引值更新, 设置为当前点击按钮
    self.currentSelectIndex = tag;
    
    // 2. 滚动 scrollView 到相应的位置
    self.scrollView.contentOffset = CGPointMake(tag * ISScreen_Width, 0);
    
    // 3. 如果该位置没有被选中, 取出对应位置的 View, 添加到 scrollView 上
    [self addViewWithIndex:tag];
}

#pragma mark ------- ISNavigationView 的下拉列表暂时没有事件, 以后补充
// 下拉列表
//- (void)navigationView:(ISNavigationView *)navigationView didClickDropButton:(UIButton *)dropButton {
//
//}

#pragma mark ---- 2015/11/19 修改主界面----------------------以上为新增内容-----------------------------

- (void)loadDataOld {
    NSMutableArray *VCList = [[NSMutableArray alloc]init];
    NSArray *labels = [SoapOperation WS_getVideoLabel];
    if(labels==nil){ //无网络情况
        HomeShowViewC *ViewC = [[HomeShowViewC alloc] initWithNibName:@"HomeShowViewC" bundle:nil];
        ViewC.title = @"全部";
        [ViewC FillContent:0];
        ViewC.delegate = self;
        [VCList addObject:ViewC];
    }else{
        for (int i = 0 ; i<[labels count]; i++) {   // 循环创建多个控制器HomeShowViewC, 在HomeShowViewC内部使用了HomeCollectionViewCell
            HomeShowViewC *ViewC = [[HomeShowViewC alloc] initWithNibName:@"HomeShowViewC" bundle:nil];
            ViewC.title = [labels objectAtIndex:i];
            [ViewC FillContent:i];  // 耗时操作
            ViewC.delegate = self;
            //        ViewC.view.frame = CGRectMake(0, 20, SCREEN_WIDTH,SCREEN_WIDTH);
//            ViewC.view.backgroundColor = [UIColor clearColor];//测试使用
            [VCList addObject:ViewC];
        }
    }
    topTabBar = [[SCNavTabBarController alloc] init];
    topTabBar.subViewControllers = VCList;
    topTabBar.showContentView = true;
    [topTabBar addParentController:self];
}

// 制作影片素材上传进度改变
- (void)uploadProgressChange:(NSNotification *)noti {
    CGFloat progress = [noti.userInfo[@"finishProgress"] floatValue];
    [self.navigationController setSGProgressPercentage:progress*100 andTintColor:[UIColor colorWithRed:235.f/255.f green:51.f/255.f blue:73.f/255.f alpha:1.f]];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tapGestureRecongnizer:(UIGestureRecognizer *)gesture{
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        _customWindow.hidden = YES;
    }
}

- (void)getCurrentNet
{
    Reachability *r1 = [Reachability reachabilityForInternetConnection];
    [r1 startNotifier];
    NetworkStatus netStatus1 = [r1 currentReachabilityStatus];
    if (netStatus1 == ReachableViaWWAN) {
        NSString *message = [[NSString alloc] initWithFormat:@"当前设备网络为WWAN!"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络状态提示:" message:message delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alert show];
    }
    
    Reachability *r2 = [Reachability reachabilityForInternetConnection];
    [r2 startNotifier];
    NetworkStatus netStatus2 = [r2 currentReachabilityStatus];
    if (netStatus2 == ReachableViaWiFi) {
//        NSString *message = [[NSString alloc] initWithFormat:@"当前设备网络为WiFi!"];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"网络状态提示" message:message delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
//        [alert show];
    }
}

- (void)addHeader
{
    __unsafe_unretained typeof(self) vc = self;
    [self.homeCollectionView addHeaderWithCallback:^{
        [vc.imageLibraryArra removeAllObjects];
        [vc.imageLibraryArra addObjectsFromArray: [[APPUserPrefs Singleton] APP_gethomevideo:0 Count:88 LabelType:0]];
        numberOfArra = imageLibraryArra.count;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.homeCollectionView reloadData];
            [vc.homeCollectionView headerEndRefreshing];
        });
    }];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    [self.homeCollectionView addFooterWithCallback:^{
        [vc.imageLibraryArra addObjectsFromArray:[[APPUserPrefs Singleton] APP_gethomevideo:(int)vc.numberOfArra Count:88 LabelType:0]];
        numberOfArra = imageLibraryArra.count;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [vc.homeCollectionView reloadData];
            [vc.homeCollectionView footerEndRefreshing];
        });
    }];
}

#pragma mark - collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 100) {
        return [self.searchMuArray[2] count];
    }
    return [imageLibraryArra count];
}

- (VideoInformationObject *)setAssignment:(MovierDCInterfaceSvc_VDCVideoInfoEx *)videoInfoEx
{
    VideoInformationObject * videoInfo = [[VideoInformationObject alloc] init];
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
    return videoInfo;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    integers = (int)indexPath.row;
    HomepageVideoOrder *homepageVideoOrder = [[HomepageVideoOrder alloc] init];
    homepageVideoOrder = [imageLibraryArra objectAtIndex:indexPath.row];
    [Video Singleton].videoID = homepageVideoOrder.videoID;
    [Video Singleton].videoName = homepageVideoOrder.videoName;
    [Video Singleton].ownerID = homepageVideoOrder.ownerID;
    [Video Singleton].ownerName = homepageVideoOrder.ownerName;
    [Video Singleton].ownerAcatar = homepageVideoOrder.ownerAcatar;
    [Video Singleton].videoLabelName = homepageVideoOrder.videoLabelName;
    [Video Singleton].videoCreateTime = homepageVideoOrder.videoCreateTime;
    [Video Singleton].videoThumbnailUrl = homepageVideoOrder.videoThumbnailUrl;
    [Video Singleton].videoReferenceUrl = homepageVideoOrder.videoReferenceUrl;
    [Video Singleton].videoNumberOfPraise = homepageVideoOrder.videoNumberOfPraise;
    [Video Singleton].videoNumberOfShare = homepageVideoOrder.videoNumberOfShare;
    [Video Singleton].videoNumberOfFavorite = homepageVideoOrder.videoNumberOfFavorite;
    [Video Singleton].videoCollectStatus = homepageVideoOrder.videoCollectStatus;
    [Video Singleton].videoSignature = homepageVideoOrder.videoSignature;
    [[APPUserPrefs Singleton] APP_setVideoPlayNumByVideoID:[homepageVideoOrder.videoID intValue]];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (IBAction)typeButtonAction:(id)sender {
    [_customWindow makeKeyAndVisible];
}

- (void)showList {
    int number = [APPUserPrefs APP_getvideolabeltotalnum];
//    videoLabelArr = [APPUserPrefs APP_getvideolabels:0 Count:number];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [videoLabelArr count]; i++) {
        VideoLabel *videoLabel = [[VideoLabel alloc] init];
        videoLabel = videoLabelArr[i];
        [array addObject:videoLabel.szLabelName];
        [videoLabelID addObject:videoLabel.nLabelID];
    }
    [array addObject:@""];
    [array addObject:@""];
//    NSArray *options = @[
//                         @"春节",
//                         @"青春",
//                         @"恋爱",
//                         @"旅游",
//                         @"亲子",
//                         @"团圆",
//                         @"美食",
//                         @"汽车",
//                         @"化妆",
//                         @"婚礼",
//                         @"",@""
//                         ];
    RNGridMenu *av = [[RNGridMenu alloc] initWithTitles:[array subarrayWithRange:NSMakeRange(0, number)]];
    av.menuStyle = RNGridMenuStyleGrid;
    av.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:.5];
    av.delegate = self;
    av.itemFont = [UIFont boldSystemFontOfSize:13];
    av.itemTextColor = [UIColor blackColor];
    av.itemSize = CGSizeMake(60,60);
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

- (void)showGrid {
    NSInteger numberOfOptions = 12;
    NSArray *options = @[
                         @"春节",
                         @"青春",
                         @"恋爱",
                         @"旅游",
                         @"亲子",
                         @"团圆",
                         @"美食",
                         @"汽车",
                         @"化妆",
                         @"婚礼",
                         @"",@""
                         ];
    RNGridMenu *av = [[RNGridMenu alloc] initWithTitles:[options subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.menuStyle = RNGridMenuStyleGrid;
    av.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:.5];
    av.delegate = self;
    av.itemFont = [UIFont boldSystemFontOfSize:13];
    av.itemTextColor = [UIColor blackColor];
    av.itemSize = CGSizeMake(90, 55);
}

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma SelectedVideo
-(void)ShowDetailView{
    [self performSegueWithIdentifier:@"ShowDetailVideo" sender:self];
}

#pragma mark - 数组懒加载
- (NSMutableArray *)searchMuArray
{
    if (_searchMuArray == nil) {
        _searchMuArray = [NSMutableArray arrayWithObjects:[NSMutableArray array], [NSMutableArray array], [NSMutableArray array],nil];
    }
    return _searchMuArray;
}

- (NSMutableArray *)buttonArray
{
    if(_buttonArray == nil){
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
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

@end
