//
//  HomeSearchViewController.m
//  M-Cut
//
//  Created by apple on 16/8/25.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HomeSearchViewController.h"
#import "MySearchCell.h"
#import "MySearchUserCell.h"
#import "MovierDCInterfaceSvc.h"
#import <UIImageView+WebCache.h>
#import "SearchVideoTableViewCell.h"
#import "VideoInformationObject.h"
#import "SearchUserVC.h"
#import "Video.h"
#import "MyVideoViewController.h"
#import "VideoDBOperation.h"
#import "MJRefresh.h"
#import "CustomeClass.h"
#import "UserEntity.h"
#import "ISConst.h"
#import "VideoDetailViewController.h"
#import "SoapOperation.h"

@interface HomeSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *searchTable;
@property (nonatomic, strong) UISearchDisplayController * searchDC;
@property (nonatomic, strong) UISearchBar * searchBa;

/**  存放展示视频的对象（一个数组对应cell的一个位置的数据源）*/
@property (nonatomic, strong) NSMutableArray * oneVideoMuArray;
@property (nonatomic, strong) NSMutableArray * twoVideoMuArray;
@property (nonatomic, strong) NSMutableArray * threeVideoMuArray;
@property (nonatomic, strong) NSMutableArray * fourVideoMuArray;

/** 搜索记录数据源*/
@property (nonatomic, strong) NSMutableArray * searchRecordMuArray;
/** 搜索用户数据源*/
@property (nonatomic, strong) NSMutableArray * searchUserMuArray;
/** 搜索视频数据源*/
@property (nonatomic, strong) NSMutableArray * searchVideoMuArray;

/**  存储用户头像*/
@property (nonatomic, strong) NSMutableArray * buttonArray;

/** 可以展示没有搜索结果的提示*/
@property (nonatomic, assign) BOOL isShowNoDataSearch;

/**  是否在viewdidappear显示键盘*/
@property (nonatomic, assign) BOOL isShowkeyBoard;
@end

@implementation HomeSearchViewController


- (UISearchBar *)searchBa{
    if (!_searchBa) {
        //初始化UISearchBar
        _searchBa = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 44)];
        self.searchTable.tableHeaderView = _searchBa;
        _searchBa.placeholder = @"搜索";
        _searchBa.searchBarStyle = UISearchBarStyleMinimal;
        _searchBa.delegate = self;
        [_searchBa sizeToFit];
        _searchBa.keyboardType = UIKeyboardTypeDefault;
        _searchBa.barStyle = UIBarStyleDefault;
        _searchBa.tintColor = ISRedColor;
        UITextField * searchField = [_searchBa valueForKey:@"_searchField"];
        [searchField setValue:ISB3B7BC forKeyPath:@"_placeholderLabel.textColor"];
        [searchField setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
    }
    return _searchBa;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"搜索";
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    self.isShowkeyBoard = YES;
    
    [self.searchTable registerNib:[UINib nibWithNibName:@"MySearchCell" bundle:[NSBundle mainBundle]]
           forCellReuseIdentifier:@"cell0"];
    [self.searchTable registerNib:[UINib nibWithNibName:@"MySearchUserCell" bundle:[NSBundle mainBundle]]
           forCellReuseIdentifier:@"cell1"];
    [self.searchTable registerNib:[UINib nibWithNibName:@"SearchVideoTableViewCell"
                                                 bundle:[NSBundle mainBundle]]
           forCellReuseIdentifier:@"SearchVideoTableViewCell"];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"HomeSearchViewController dealloc");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.isShowkeyBoard) {
        [self.searchBa becomeFirstResponder];
    }
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - searchBar回调
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    WEAKSELF(weakSelf);
    [self.searchTable addFooterWithCallback:^{
        MAINQUEUEUPDATEUI({
            [weakSelf loadMoreData];
        })
    }];
    
    self.isShowNoDataSearch = YES;
    [self.searchBa endEditing:YES];
    //将搜索记录添加到数据库中
    [[VideoDBOperation Singleton] DB_AddRecord:self.searchBa.text];
    //下砸搜索数据并展示结果
    [self searchTableReloadData:self.searchBa.text];
}

- (void)searchTableReloadData:(NSString *)searchBarText
{
    [self.searchRecordMuArray removeAllObjects];
    [self.searchUserMuArray removeAllObjects];
    [self.searchVideoMuArray removeAllObjects];
    __weak typeof(self) weakSelf = self;
    [[SoapOperation Singleton] WS_SearchUser:searchBarText Start:0 Count:[NSNumber numberWithInt:5] Success:^(MovierDCInterfaceSvc_VDCCustomerBaseInfoExArr *array) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.searchRecordMuArray removeAllObjects];
            [weakSelf.searchUserMuArray removeAllObjects];
            [weakSelf.searchUserMuArray addObjectsFromArray:[array.item copy]];
            [weakSelf.searchTable reloadData];
        });
    } Fail:^(NSError *error) {
        DEBUGLOG(error)
    }];
    [self.searchVideoMuArray removeAllObjects];
    [self loadMoreData];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //添加搜索记录
    [self.searchRecordMuArray removeAllObjects];
    [self.searchRecordMuArray addObjectsFromArray:[[VideoDBOperation Singleton] findRecentRecord]];
    [self.searchTable reloadData];
}

#pragma mark -  搜索table
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 80;
    }
    else if (indexPath.section == 2) {
        return 460;
    }
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 1;
    }
    else if (section == 2){
        //返回oneVideoMuArray的个数作为二组cell的数量
        return self.oneVideoMuArray.count;
    }
    else {
        return self.searchRecordMuArray.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    
    if([self.searchRecordMuArray count] != 0) {
        BACKPROPMTVIEW(NO, 1234, @"没有搜索结果", self.searchTable)
        return 1;
    }else if([self.searchUserMuArray count] == 0 && [self.searchVideoMuArray count] == 0) {
        //无结果情况
        if ((self.searchUserMuArray.count == 0 && self.isShowNoDataSearch) || (self.searchVideoMuArray.count == 0 && self.isShowNoDataSearch)) {
            BACKPROPMTVIEW(self.oneVideoMuArray.count == 0, 1234, @"没有搜索结果", self.searchTable)
        }
        return 0;
    }else {
        return 3;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([self.searchRecordMuArray count] != 0) {
        if (section == 0) {
            return @"历史搜索";
        }
    }
    if([self.searchRecordMuArray count] == 0 && ([self.searchUserMuArray count] != 0 || [self.searchVideoMuArray count] != 0)){
        if (section == 1) {
            return @"相关用户";
        }
        else if (section == 2){
            return @"相关视频";
        }
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //展示搜索记录（0组）
    if (indexPath.section == 0) {
        MySearchCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell0"];
        
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MySearchCell" owner:nil options:nil] lastObject];
        }
        
        cell.titleLabel.text = self.searchRecordMuArray[indexPath.row];
        if ([cell.titleLabel.text isEqualToString:@"全部搜索记录"] || [cell.titleLabel.text isEqualToString:@"清空搜索记录"]) {
            cell.titleLabel.textAlignment = NSTextAlignmentCenter;
            cell.recordButton.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }else{
            cell.titleLabel.textAlignment = NSTextAlignmentLeft;
            cell.recordButton.backgroundColor = [UIColor whiteColor];
        }

        cell.recordButton.tag = indexPath.row;
        WEAKSELF2
        [cell setRecordButtonBlock:^(NSString *title, UIButton *recordButton) {
            if ([title isEqualToString:@"全部搜索记录"]) {
                [weakSelf recordButtonShowAllRecord];
            }else if ([title isEqualToString:@"清空搜索记录"]){
                [weakSelf recordButtonEmptyRecord];
            }else{
                [weakSelf recordButtonAction:recordButton];
            }
        }];
        return cell;
    }else if (indexPath.section == 1){
        //展示相关用户(1组)
        MySearchUserCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MySearchUserCell" owner:nil options:nil] lastObject];
        }
        NSArray * buttonArr = @[cell.user1, cell.user2, cell.user3, cell.user4, cell.user5];
        [self.buttonArray removeAllObjects];
        [self.buttonArray addObjectsFromArray:buttonArr];
        int i = 0;
        for (UIImageView * imageView in self.buttonArray) {
            if(i < [self.searchUserMuArray count]){
                if (self.searchUserMuArray[i] != nil) {
                    imageView.tag = 200 + i;
                    MovierDCInterfaceSvc_VDCCustomerBaseInfoEx * customeBaseInfo = self.searchUserMuArray[i];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:customeBaseInfo.szAcatar] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView * moreUserImage = [UIImageView new];
        moreUserImage.layer.masksToBounds = YES;
        moreUserImage.layer.cornerRadius = cell.user5.frame.size.height / 2;
        moreUserImage.image = [UIImage imageNamed:@"moreUserImage"];
        
        if ([self.searchUserMuArray count] == 5) {
            if (iPhone4 || iPhone5_5S_5C) {
                cell.user5.hidden = YES;
                moreUserImage.frame = CGRectMake(260, 20, 50, 50);
                [cell.contentView addSubview:moreUserImage];
                
            }else{
                moreUserImage.frame = CGRectMake(316, 20, 50, 50);
                [cell.contentView addSubview:moreUserImage];
            }
        }
        
        if([self.searchUserMuArray count] > 0){
            cell.noUserLabel.hidden = YES;
        }
        else{
            cell.noUserLabel.hidden = NO;
        }
        return cell;
    }else if(indexPath.section == 2){
        
        //展示相关视频（2组）
        SearchVideoTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SearchVideoTableViewCell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchVideoTableViewCell" owner:nil options:nil] lastObject];
        }
        [self setCellWithIndex:indexPath BackImage:cell.backImage1 UserHeaderImage:cell.userHeaderImage1 UserNameLabel:cell.userNameLabel1 LookTimesLabel:cell.lookTimesLabel1 VideoNameLabel:cell.videoNameLabel1 BackView:cell.backView1 CellInfoArray:self.oneVideoMuArray backViewTag:20000];
        [self setCellWithIndex:indexPath BackImage:cell.backImage2 UserHeaderImage:cell.userHeaderImage2 UserNameLabel:cell.userNameLabel2 LookTimesLabel:cell.lookTimesLabel2 VideoNameLabel:cell.videoNameLabel2 BackView:cell.backView2 CellInfoArray:self.twoVideoMuArray backViewTag:40000];
        [self setCellWithIndex:indexPath BackImage:cell.backImage3 UserHeaderImage:cell.userHeaderImage3 UserNameLabel:cell.userNameLabel3 LookTimesLabel:cell.lookTimesLabel3 VideoNameLabel:cell.videoNameLabel3 BackView:cell.backView3 CellInfoArray:self.threeVideoMuArray backViewTag:60000];
        [self setCellWithIndex:indexPath BackImage:cell.backImage4 UserHeaderImage:cell.userheaderImage4 UserNameLabel:cell.userNameLabel4 LookTimesLabel:cell.lookTimesLabel4 VideoNameLabel:cell.videoNameLabel4 BackView:cell.backView4 CellInfoArray:self.fourVideoMuArray backViewTag:80000];
        return cell;
    }
    DEFAULTCELL
    return cell;
}

- (void)setCellWithIndex:(NSIndexPath *)indexPath BackImage:(UIImageView *)backImage UserHeaderImage:(UIImageView *)userHeaderImage UserNameLabel:(UILabel *)userNameLabel LookTimesLabel:(UILabel *)lookTimesLabel VideoNameLabel:(UILabel *)videoNameLabel BackView:(UIView *)backView CellInfoArray:(NSMutableArray *)videoInfoArray backViewTag:(NSInteger)backViewTag{
    if (indexPath.row < videoInfoArray.count) {
        NSMutableDictionary * videoInfoEx = videoInfoArray[indexPath.row];
        
        [backImage sd_setImageWithURL:[NSURL URLWithString:STRTOUTF8(videoInfoEx[@"video_thumbnail"])] placeholderImage:DEFAULTVIDEOTHUMAIL options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
        
        [userHeaderImage sd_setImageWithURL:[NSURL URLWithString:videoInfoEx[@"customer_avatar"]] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //搜索table的点击方法
    if(indexPath.row == 0 && indexPath.section == 1 && [self.searchUserMuArray count] > 4){
        //跳转到所有用户页面
        if (![UserEntity sharedSingleton].isAppHasLogin) {
//            [CustomeClass showMessage:@"请登录后查看" ShowTime:1.5];
            [self showLoginAndRegisterWindow];
            return;
        }
        SearchUserVC * searchUserVC = [[SearchUserVC alloc] init];
        searchUserVC.searchBarText = self.searchBa.text;
        [self.navigationController pushViewController:searchUserVC animated:YES];
    }
}

#pragma mark - 点击
//跳转到视频播放页面
- (void)videoAction:(UITapGestureRecognizer *)noti
{
    UIView * backView = noti.view;
    if (backView.tag >= 20000 && backView.tag < 40000) {
        [self pushToHomeVideoDetailWithVideoInfoEx:self.oneVideoMuArray[backView.tag - 20000]];
    }
    else if (backView.tag >= 40000 && backView.tag < 60000){
        [self pushToHomeVideoDetailWithVideoInfoEx:self.twoVideoMuArray[backView.tag - 40000]];
    }
    else if (backView.tag >= 60000 && backView.tag < 80000)
    {
        [self pushToHomeVideoDetailWithVideoInfoEx:self.threeVideoMuArray[backView.tag - 60000]];
    }
    else {
        [self pushToHomeVideoDetailWithVideoInfoEx:self.fourVideoMuArray[backView.tag - 80000]];
    }
}

/** 跳转到搜索视频播放页面*/
- (void)pushToHomeVideoDetailWithVideoInfoEx:(NSMutableDictionary *)videoInfoEx{
    [[Video Singleton] setVideoWithVideoInfo:videoInfoEx];
    [self addVisitConunt];
    
    VideoDetailViewController * videoDetailVc = [VideoDetailViewController new];
    videoDetailVc.videoInfo = videoInfoEx;
    [self.navigationController pushViewController:videoDetailVc animated:YES];
}

- (void)addVisitConunt{
    //调用增加观看数量的接口
    [[SoapOperation Singleton] WS_IncreaseVisit:[NSNumber numberWithInt:[[Video Singleton].videoID intValue]] Success:^(NSNumber *num) {
        [Video Singleton].videoPlayCount = [NSString stringWithFormat:@"%@", num];
    } Fail:^(NSError *error) {
        DEBUGLOG(error);
    }];
}

//跳转到用户详情页面
- (void)userBtnAction:(UITapGestureRecognizer *)gesture
{
    if (![UserEntity sharedSingleton].isAppHasLogin) {
//        [CustomeClass showMessage:@"请登录后查看" ShowTime:1.5];
        [self showLoginAndRegisterWindow];
        return;
    }
    
    UIView * myView = [gesture view];
    MovierDCInterfaceSvc_VDCCustomerBaseInfoEx * customerInfo = self.searchUserMuArray[myView.tag - 200];
    
    MyVideoViewController * videoVc = [MyVideoViewController new];
    videoVc.isShowOtherUserVideo = YES;
    videoVc.userId = [NSString stringWithFormat:@"%@", customerInfo.nCustomerID];
    videoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:videoVc animated:YES];
}

//点击搜索记录时，执行该方法
- (void)recordButtonAction:(UIButton *)btn
{
    [self.searchBa resignFirstResponder];
    NSArray * recordArray = [[VideoDBOperation Singleton] findRecord];
    [self searchTableReloadData:recordArray[btn.tag]];
    self.searchBa.text = recordArray[btn.tag];
}

- (void)loadMoreData{
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             __weak typeof(self) weakSelf = self;
             weakSelf.isShowkeyBoard = NO;
             if (self.searchBa.text.length == 0) {
                 return;
             }
             [[SoapOperation Singleton] searchVideosByKeyWithSearchText:weakSelf.searchBa.text Offset:weakSelf.searchVideoMuArray.count Count:36 Success:^(NSMutableArray *serverDataArray) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                      [weakSelf.searchTable footerEndRefreshing];
                     if (serverDataArray.count == 0) {
                         [weakSelf.searchTable removeFooter];
                         [CustomeClass showMessage:@"没有更多影片了" ShowTime:1.5];
                         return;
                     }
                     [weakSelf.searchRecordMuArray removeAllObjects];
                     [weakSelf.searchVideoMuArray addObjectsFromArray:[serverDataArray copy]];
                     [weakSelf.oneVideoMuArray removeAllObjects];
                     [weakSelf.twoVideoMuArray removeAllObjects];
                     [weakSelf.threeVideoMuArray removeAllObjects];
                     [weakSelf.fourVideoMuArray removeAllObjects];
                     for(int i = 0; i < [weakSelf.searchVideoMuArray count]; i++){
                         MovierDCInterfaceSvc_VDCVideoInfoEx * videoInfo = weakSelf.searchVideoMuArray[i];
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
                     [weakSelf.searchTable reloadData];
                 });
                 
             } Fail:^(NSError *error) {
                 DEBUGLOG(error)
             }];
        });
}

//显示所有搜索记录
- (void)recordButtonShowAllRecord
{
    [self.searchRecordMuArray removeAllObjects];
    [self.searchRecordMuArray addObjectsFromArray:[[VideoDBOperation Singleton] findRecord]];
    [self.searchBa resignFirstResponder];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.searchTable reloadData];
    });
}

//清空搜索记录
- (void)recordButtonEmptyRecord
{
    [[VideoDBOperation Singleton] DeleteAllRecord];
    [self.searchRecordMuArray removeAllObjects];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.searchTable reloadData];
    });
}

- (NSMutableArray *)searchRecordMuArray{
    if (!_searchRecordMuArray) {
        _searchRecordMuArray = [NSMutableArray new];
    }
    return _searchRecordMuArray;
}

- (NSMutableArray *)searchUserMuArray{
    if (!_searchUserMuArray) {
        _searchUserMuArray = [NSMutableArray new];
    }
    return _searchUserMuArray;
}

- (NSMutableArray *)searchVideoMuArray{
    if (!_searchVideoMuArray) {
        _searchVideoMuArray = [NSMutableArray new];
    }
    return _searchVideoMuArray;
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

- (NSMutableArray *)buttonArray
{
    if(_buttonArray == nil){
        _buttonArray = [[NSMutableArray alloc] init];
    }
    return _buttonArray;
}
@end
