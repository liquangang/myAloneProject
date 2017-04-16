//
//  ViewController.m
//  TestDemo
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//
/**  屏幕宽度 */
#define ISScreen_Width [UIScreen mainScreen].bounds.size.width
/**  屏幕高度 */
#define ISScreen_Height [UIScreen mainScreen].bounds.size.height
#import "LQGMusicClipsTViewC.h"
#import "LQGTitleView.h"
//该界面的cell
#import "MyMusicCell.h"
#import "VideoDBOperation.h"
#import "SoapOperation.h"
#import "APPUserPrefs.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "UserEntity.h"
#import <MBProgressHUD.h>
#import "AudioStreamer.h"
#import "MJRefresh.h"

@interface LQGMusicClipsTViewC ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, MyMusicCellDelegate>
/**  导航栏titleView(暂时不用)*/
@property (nonatomic, strong) LQGTitleView * lqgTitleView;
/**  未搜索时展示的table*/
@property (nonatomic, strong) UITableView * tableView;
/**  最佳配乐和推荐音乐的数据源*/
@property (nonatomic, strong) NSMutableArray * dataSource1;
/**  搜索框*/
@property (nonatomic, strong) UISearchBar * searchBa;
/**  搜索记录展示table*/
@property (nonatomic, strong) UITableView * recordTableView;
/**  搜索记录数据源*/
@property (nonatomic, strong) NSMutableArray * recordDataSource;
/**  搜索内容展示table*/
@property (nonatomic, strong) UITableView * searchTableView;
/**  搜索内容数据源*/
@property (nonatomic, strong) NSMutableArray * searchDataSource;
/**  如果点击取消按钮回到默认界面，否则不回到默认界面*/
@property (nonatomic, assign) BOOL isClickCancleButton;
/**  记录用户再默认界面选择的音乐，从而确定哪一个cell上显示选择图片*/
@property (nonatomic, strong) NSIndexPath * selectIndex;
/**  记录用户选择的搜索记录界面选择的cell，从而确定显示的选中的图片显示的位置*/
@property (nonatomic, strong) NSIndexPath * selectRecordIndex;
/**  记录用户选择的搜索结果选择的cell，从而显示选中图片显示的位置*/
@property (nonatomic, strong) NSIndexPath * selectSearchIndex;
/**  记录用户选择的数据对象*/
@property (nonatomic, strong) id myMusicInfo;
/**  加载动画控制对象*/
@property (nonatomic, strong) MBProgressHUD * HUD;
/**  播放音乐的URL*/
@property (nonatomic, copy) NSMutableString * musicUrl;
/**  音乐播放控制对象*/
@property (nonatomic, strong) AudioStreamer * audioStreamer;
/**  是否在播放音乐*/
@property (nonatomic, assign) BOOL isPlayMusic;
/**  搜索界面无结果时显示*/
@property (nonatomic, strong) UIView * searchBGView;
/**  无搜索记录时显示*/
@property (nonatomic, strong) UIView * recordBGView;
/**  计时器*/
@property (nonatomic, strong) NSTimer * myTimer;
@end

@implementation LQGMusicClipsTViewC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"音乐选取";
    label.font = ISFont_17;
    label.textColor = [UIColor whiteColor];
    CGSize labelSize = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    //分为在线音乐和本地音乐的情况，暂时不用
    //    self.lqgTitleView = [[LQGTitleView alloc] initWithFrame:CGRectMake(0, 0, labelSize.width * 3, labelSize.height) andDelegate:self];
    self.navigationItem.titleView = label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.minSize = self.view.bounds.size;
    self.HUD.cornerRadius = 0;
    self.HUD.opacity = 0;
    [self.view addSubview:self.HUD];
    [self.HUD showAnimated:YES whileExecutingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self createUI];
            [self loadData];
        });
    } completionBlock:^{
        [self.HUD removeFromSuperview];
        self.HUD = nil;
    }];
    
}

#pragma mark - 界面进入时的默认数据
- (void)loadData{
    NewNSOrderDetail *noworder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    MovierDCInterfaceSvc_vpQueryCond *QueryCond = [[MovierDCInterfaceSvc_vpQueryCond alloc] init];
    QueryCond.nStyleID = @(noworder.nHeaderAndTailID);
    QueryCond.nFilterID = 0;
    QueryCond.nMusicID = 0;
    QueryCond.nSubtitleID = 0;
    [[SoapOperation Singleton] WS_GetMusicList:QueryCond Start:0 Count:@(160) Success:^(MovierDCInterfaceSvc_vpVDCMusicArray *MList) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dataSource1 addObjectsFromArray:[MList.item copy]];
            [self.tableView reloadData];
        });
    } Fail:^(NSError *error) {
        
    }];
}

#pragma mark - 初始化界面的各个控件及数据
- (void)createUI{
    //默认没有播放音乐
    self.isPlayMusic = NO;
    
    //防止选择图片刚开始出现
    self.selectIndex = nil;
    self.selectRecordIndex = nil;
    self.selectSearchIndex = nil;
    
    //默认没有点击searchBar的取消按钮
    self.isClickCancleButton = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回按钮
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    [leftButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    //完成按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font = ISFont_15;
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    //默认table的初始化
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ISScreen_Width, ISScreen_Height - 64 - 44)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyMusicCell" bundle:nil] forCellReuseIdentifier:@"musicCell"];
    
    //searchBar初始化
    self.searchBa = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 44)];
    [self.view addSubview:self.searchBa];
    self.searchBa.placeholder = @"海量音乐  在线搜索";
    self.searchBa.delegate = self;
    self.searchBa.tintColor = [UIColor redColor];
    self.searchBa.barTintColor = [UIColor whiteColor];
    self.searchBa.keyboardType = UIKeyboardTypeDefault;
    
    //搜索结果table初始化
    self.searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ISScreen_Width, ISScreen_Height - 64 - 44)];
    [self.view addSubview:self.searchTableView];
    self.searchTableView.hidden = YES;
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    [self.searchTableView registerNib:[UINib nibWithNibName:@"MyMusicCell" bundle:nil] forCellReuseIdentifier:@"musicCell"];
//    [self.searchTableView addFooterWithTarget:self action:@selector(loadMoreMusic)];
    
    
    //搜索记录table初始化
    self.recordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ISScreen_Width, ISScreen_Height - 64 - 44)];
    [self.view addSubview:self.recordTableView];
    self.recordTableView.hidden = YES;
    self.recordTableView.delegate = self;
    self.recordTableView.dataSource = self;
    [self.recordTableView registerNib:[UINib nibWithNibName:@"MyMusicCell" bundle:nil] forCellReuseIdentifier:@"musicCell"];
    UIView * myHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 64)];
    UILabel * myLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 0, ISScreen_Width - 66, 64)];
    [myHeaderView addSubview:myLabel];
    myLabel.textColor = [UIColor grayColor];
    myLabel.text = @"所有音乐来源于网络，请勿用于商业用途，作者如有异议，请与我司联系。";
    myLabel.textAlignment = NSTextAlignmentCenter;
    myLabel.numberOfLines = 2;
    myLabel.font = [UIFont boldSystemFontOfSize:12];
    self.recordTableView.tableHeaderView = myHeaderView;
}

#pragma mark - scrollview的代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //滑动先执行该方法
//    NSLog(@"drag");
    if (scrollView == self.recordTableView || scrollView == self.searchTableView) {
        [self.searchBa resignFirstResponder];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"decelerate");
}


#pragma mark - navigationBar按钮的点击放方法
//返回按钮
- (void)leftBarButtonItemAction:(UIButton *)btn{
    [self destroyStreamer];
    [self.navigationController popViewControllerAnimated:YES];
}

//完成按钮
- (void)rightBarButtonItemAction:(UIButton *)btn{
    [self destroyStreamer];
    //选中音乐时，点击完成将音乐传回影片概览界面
    //并且返回影片概览界面
    if (self.tableView.hidden == NO) {
        self.music(self.myMusicInfo, self.selectIndex, @"MovierDCInterfaceSvc_vpVDCMusicC");
    }
    else if (self.recordTableView.hidden == NO){
    }
    else if(self.searchTableView.hidden == NO){
        self.music(self.myMusicInfo, self.selectSearchIndex, @"MovierDCInterfaceSvc_vpVDCMusicEx");
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getMusic:(void (^)(id, NSIndexPath *, NSString *))music
{
    self.music = music;
}

#pragma mark - LQGTitleViewDelegate
//暂时不用（有在线音乐和本地音乐的情况，点击切换两种情况）
//- (void)barButtonAction:(UIButton *)barButton
//{
//    NSLog(@"barButton.tag------------------%ld", (long)barButton.tag);
//}

#pragma mark - searchBar的代理方法
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    [self destroyStreamer];
    if (self.isClickCancleButton == YES) {
        [self.searchBa resignFirstResponder];
        self.searchBa.text = nil;
        self.tableView.hidden = NO;
        self.searchBa.showsCancelButton = NO;
        self.recordTableView.hidden = YES;
        self.searchTableView.hidden = YES;
        [self.recordDataSource removeAllObjects];
        self.isClickCancleButton = NO;
    }
    return YES;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self destroyStreamer];
    self.searchTableView.hidden = YES;
    self.tableView.hidden = YES;
    self.searchBa.showsCancelButton = YES;
    self.recordTableView.hidden = NO;
    [self.recordDataSource removeAllObjects];
    [self.recordDataSource addObjectsFromArray:[[VideoDBOperation Singleton] getAllMusicRecord]];
    [self.recordTableView reloadData];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self destroyStreamer];
    self.isClickCancleButton = YES;
    self.tableView.hidden = NO;
    self.recordTableView.hidden = YES;
    self.searchTableView.hidden = YES;
    [self.searchBa resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.recordTableView.hidden = YES;
    self.searchTableView.hidden = NO;
    self.tableView.hidden = YES;
    [self.searchBa resignFirstResponder];
    self.selectSearchIndex = nil;
    [[VideoDBOperation Singleton] addSearchMusicRecord:self.searchBa.text];
    [self.searchDataSource removeAllObjects];
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    self.HUD.minSize = self.view.bounds.size;
    self.HUD.cornerRadius = 0;
    self.HUD.opacity = 0.6;
    [self.view addSubview:self.HUD];
    [self.HUD show:YES];
    [self loadMoreMusic];
}

- (void)loadMoreMusic{
    [self.searchBa resignFirstResponder];
    self.tableView.hidden = YES;
    self.recordTableView.hidden = YES;
    self.searchTableView.hidden = NO;
    NSString * str = self.searchBa.text;
    if([[str stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0){
        [self.searchDataSource removeAllObjects];
        [self.searchTableView reloadData];
        [self.HUD removeFromSuperview];
        self.HUD = nil;
        return;
    }
    __weak typeof(self) weakSelf = self;
    [[SoapOperation Singleton] WS_SearchMusic:self.searchBa.text Start:@(0) Count:@(1000) Success:^(MovierDCInterfaceSvc_vpVDCMusicExArr *array) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"搜索结果数据源--------------%ld", (unsigned long)array.item.count);
            [weakSelf.searchDataSource removeAllObjects];
            [weakSelf.searchDataSource addObjectsFromArray:[array.item copy]];
            [weakSelf.searchTableView reloadData];
            NSLog(@"weakSelf.searchDataSource.count----------%ld", (unsigned long)weakSelf.searchDataSource.count);
            [weakSelf.searchTableView footerEndRefreshing];
            if (array.item.count < 66) {
                [weakSelf.searchTableView removeFooter];
            }
            [weakSelf.HUD removeFromSuperview];
            weakSelf.HUD = nil;
        });
    } Fail:^(NSError *error) {
        NSLog(@"download---error---------------%@", error);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.searchDataSource removeAllObjects];
            [weakSelf.searchTableView reloadData];
            [weakSelf.HUD removeFromSuperview];
            weakSelf.HUD = nil;
        });
    }];
}

#pragma mark - tableView的代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        switch (section) {
            case 0:
                return @"最佳配乐";
                break;
            case 1:
                return @"推荐音乐";
                break;
            default:
                break;
        }
    }
    else if(tableView == self.searchTableView){
        if(self.searchDataSource.count == 0){
            return nil;
        }
        return @"搜索结果";
    }
    else if(tableView == self.recordTableView){
        return @"历史搜索";
    }
    return nil;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
       return [self.dataSource1 count];
    }
    else if(tableView == self.recordTableView){
        if (self.recordDataSource.count != 0) {
            UILabel * label = (id)[self.view viewWithTag:10001];
            label.text = @"";
            self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            return 1;
        }
        self.recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.recordBGView = [[UIView alloc] initWithFrame:CGRectMake(ISScreen_Width / 2 - 50, ISScreen_Height / 2 - 166, 100, 100)];
        UILabel * mySearchTableBGLabel = [[UILabel alloc] initWithFrame:self.recordBGView.frame];
        [self.recordBGView addSubview:mySearchTableBGLabel];
        mySearchTableBGLabel.tag = 10001;
        mySearchTableBGLabel.text = @"无搜索记录";
        mySearchTableBGLabel.textColor = [UIColor grayColor];
        mySearchTableBGLabel.textAlignment = NSTextAlignmentCenter;
        mySearchTableBGLabel.font = [UIFont fontWithName:@"Helvetica" size:17.f];
        self.recordTableView.backgroundView = self.recordBGView;
    }
    else if(tableView == self.searchTableView){
        if (self.searchDataSource.count != 0) {
            UILabel * label = (id)[self.view viewWithTag:10000];
            label.text = @"";
            self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            return 1;
        }
        else if(self.searchDataSource.count == 0){
            self.searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            self.searchBGView = [[UIView alloc] initWithFrame:CGRectMake(ISScreen_Width / 2 - 50, ISScreen_Height / 2 - 200, 100, 100)];
            UILabel * mySearchTableBGLabel = [[UILabel alloc] initWithFrame:self.searchBGView.frame];
            [self.searchBGView addSubview:mySearchTableBGLabel];
            mySearchTableBGLabel.tag = 10000;
            mySearchTableBGLabel.text = @"无结果";
            mySearchTableBGLabel.textColor = [UIColor grayColor];
            mySearchTableBGLabel.textAlignment = NSTextAlignmentCenter;
            mySearchTableBGLabel.font = [UIFont fontWithName:@"Helvetica" size:17.f];
            self.searchTableView.backgroundView = self.searchBGView;
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tableView){
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                return [self.dataSource1 count];
                break;
            default:
                return 0;
                break;
        }
    }
    else if (tableView == self.recordTableView){
        return self.recordDataSource.count;
    }
    else if(tableView == self.searchTableView){
        return self.searchDataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //展示默认界面的table
    if (tableView == self.tableView) {
        MyMusicCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MyMusicCell" owner:self options:nil] lastObject];
        }
        
        //最佳配乐
        if (indexPath.section == 0) {
            MovierDCInterfaceSvc_vpVDCMusicC * musicInfo = self.recommadMusic;
            if (musicInfo.szName) {
                [cell.musicImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@thumbail.jpg", musicInfo.szUrl]] placeholderImage:[UIImage imageNamed:@"默认封面"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
                cell.musicName.text = musicInfo.szName;
                cell.singer.text = musicInfo.szDesc;
                cell.playButton.image = [UIImage imageNamed:@"继续icon-拷贝-4"];
                cell.myMusicUrl = [NSMutableString stringWithFormat:@"%@", self.recommadMusic.szUrl];
            }
            else{
                cell.musicName.text = @"无最佳配乐";
            }
        }
        
        //推荐音乐
        if (indexPath.section == 1) {
            //有音乐的cell
            MovierDCInterfaceSvc_vpVDCMusicC * musicInfo = self.dataSource1[indexPath.row];
            [cell.musicImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@thumbail.jpg", musicInfo.szUrl]] placeholderImage:[UIImage imageNamed:@"默认封面"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
            cell.musicName.text = musicInfo.szName;
            cell.singer.text = musicInfo.szDesc;
            cell.playButton.image = [UIImage imageNamed:@"继续icon-拷贝-4"];
            if (indexPath.row == 0) {
                cell.musicImage.image = [UIImage imageNamed:@"无音乐icon"];
                cell.musicName.text = @"无音乐";
                cell.playButton.hidden = YES;
            }
            cell.myMusicUrl = [NSMutableString stringWithFormat:@"%@", musicInfo.szUrl];
    }
        if (indexPath == self.selectIndex) {
            cell.musicName.textColor = [UIColor redColor];
            cell.singer.textColor = [UIColor redColor];
            cell.selectImage.image = [UIImage imageNamed:@"勾选"];
            if (self.isPlayMusic == YES) {
                cell.playButton.image = [UIImage imageNamed:@"暂停icon"];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.myIndexPath = indexPath;
        return cell;
    }
    
    //展示搜索记录的table
    else if (tableView == self.recordTableView){
        UITableViewCell * recordCell = [tableView cellForRowAtIndexPath:indexPath];
        if (!recordCell) {
            recordCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        recordCell.textLabel.text = self.recordDataSource[indexPath.row];
        recordCell.textColor = [UIColor grayColor];
        recordCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([self.recordDataSource[indexPath.row] isEqualToString:@"清空记录"]) {
            recordCell.backgroundColor = [UIColor groupTableViewBackgroundColor];
            recordCell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        return recordCell;
    }
    
    //展示搜索结果的table
    else if(tableView == self.searchTableView){
        MyMusicCell * musicCell = [tableView cellForRowAtIndexPath:indexPath];
        if (!musicCell) {
            musicCell = [[[NSBundle mainBundle] loadNibNamed:@"MyMusicCell" owner:self options:nil] lastObject];
        }
        MovierDCInterfaceSvc_vpVDCMusicEx * musicInfo = [MovierDCInterfaceSvc_vpVDCMusicEx new];
        if (indexPath.row < self.searchDataSource.count) {
           musicInfo = self.searchDataSource[indexPath.row];
        }
        musicCell.playButton.image = [UIImage imageNamed:@"继续icon-拷贝-4"];
        [musicCell.musicImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@thumbail.jpg", musicInfo.szUrl]] placeholderImage:[UIImage imageNamed:@"默认封面"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
        musicCell.musicName.text = musicInfo.szName;
        musicCell.singer.text = musicInfo.szArtsit;
       musicCell.myMusicUrl = [NSMutableString stringWithFormat:@"%@", musicInfo.szUrl];
            if (indexPath == self.selectSearchIndex) {
                musicCell.musicName.textColor = [UIColor redColor];
                musicCell.singer.textColor = [UIColor redColor];
                musicCell.selectImage.image = [UIImage imageNamed:@"勾选"];
                if (self.isPlayMusic == YES) {
                   musicCell.playButton.image = [UIImage imageNamed:@"暂停icon"];
                }
        }
        musicCell.selectionStyle = UITableViewCellSelectionStyleNone;
        musicCell.delegate = self;
        musicCell.myIndexPath = indexPath;
        return musicCell;
    }
    
    //防止崩溃
    UITableViewCell * errorCell = [tableView dequeueReusableCellWithIdentifier:@"errorCell"];
    if (!errorCell) {
        errorCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"errorCell"];
    }
    errorCell.textLabel.text = @"防止崩溃cell";
    return errorCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        if (indexPath.section == 0) {
            self.myMusicInfo = self.recommadMusic;
        }
        else if (indexPath.row == 0 && indexPath.section == 1) {
            self.myMusicInfo = nil;
           
        }
        else{
            MovierDCInterfaceSvc_vpVDCMusicC * musicInfo = self.dataSource1[indexPath.row];
            self.myMusicInfo = musicInfo;
        }
        if (self.selectIndex != indexPath) {
            self.isPlayMusic = NO;
            [self destroyStreamer];
        }
        self.selectIndex = indexPath;
        [self.tableView reloadData];
    }
    
    //点击搜索记录cell显示搜索结果
    else if(tableView == self.recordTableView){
        if ([self.recordDataSource[indexPath.row] isEqualToString:@"清空记录"]) {
            [[VideoDBOperation Singleton] deleteSearchMusicRecord];
            [self.recordDataSource removeAllObjects];
            [self.recordDataSource addObjectsFromArray:[[VideoDBOperation Singleton] getAllMusicRecord]];
        }
        else{
        NSString * str = self.recordDataSource[indexPath.row];
            self.searchBa.text = str;
            [self.searchDataSource removeAllObjects];
            [self loadMoreMusic];
        }
        [self.recordTableView reloadData];
    }
    else if(tableView == self.searchTableView){
        MovierDCInterfaceSvc_vpVDCMusicEx * musicInfo = self.searchDataSource[indexPath.row];
        self.myMusicInfo = musicInfo;
        
        if (indexPath != self.selectSearchIndex) {
            self.isPlayMusic = NO;
            [self destroyStreamer];
        }
        self.selectSearchIndex = indexPath;
        [self.searchTableView reloadData];
    }
}

- (void)playButtonAction:(NSIndexPath *)myIndexPath andMusicUrl:(NSString *)musicUrl
{
    NSMutableString * myMusicUrl1 = [[NSMutableString alloc] initWithString:musicUrl];
    NSMutableString * myMusicUrl = [NSMutableString stringWithString:[musicUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSRange myRange = [myMusicUrl rangeOfString:@".mp3"];
    NSRange myRange1 = [myMusicUrl rangeOfString:@".m4a"];
    if (myRange.location == NSNotFound && myRange1.location == NSNotFound) {
        [myMusicUrl1 appendString:@"music.mp3"];
    }
    
    
    if (self.tableView.hidden == NO) {
        if (myIndexPath.section == 0) {
            self.myMusicInfo = self.recommadMusic;
        }
        else if (myIndexPath.row == 0 && myIndexPath.section == 1) {
            self.myMusicInfo = nil;
        }
        else{
            MovierDCInterfaceSvc_vpVDCMusicC * musicInfo = self.dataSource1[myIndexPath.row];
            self.myMusicInfo = musicInfo;
        }
        if (self.selectIndex != myIndexPath) {
            self.isPlayMusic = NO;
            [self destroyStreamer];
        }
         self.selectIndex = myIndexPath;
        [self.tableView reloadData];
        MyMusicCell * cell = [self.tableView cellForRowAtIndexPath:myIndexPath];
        if (self.isPlayMusic == NO && ![cell.musicName.text isEqualToString:@"无音乐"]) {
            self.isPlayMusic = YES;
            cell.playButton.image = [UIImage imageNamed:@""];
            self.HUD = [[MBProgressHUD alloc] initWithView:cell.playButton];
            [cell.playButton addSubview:self.HUD];
            self.HUD.minSize = cell.playButton.frame.size;
            self.HUD.cornerRadius = 0;
            self.HUD.opacity = 0;
            __weak typeof(self) weakSelf = self;
           
            [weakSelf.HUD showAnimated:YES whileExecutingBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf createStreamerWithURL:myMusicUrl1];
                });
            } completionBlock:^{
                [weakSelf.HUD removeFromSuperview];
                weakSelf.HUD = nil;
                cell.playButton.image = [UIImage imageNamed:@"暂停icon"];
            }];
        }
        else{
            cell.playButton.image = [UIImage imageNamed:@"继续icon-拷贝-4"];
            [self destroyStreamer];
            self.isPlayMusic = NO;
        }
    }
    else if (self.searchTableView.hidden == NO) {
            MovierDCInterfaceSvc_vpVDCMusicC * musicInfo = self.searchDataSource[myIndexPath.row];
            self.myMusicInfo = musicInfo;
        if (self.selectSearchIndex != myIndexPath) {
            self.isPlayMusic = NO;
            [self destroyStreamer];
        }
        self.selectSearchIndex = myIndexPath;
        [self.searchTableView reloadData];
        MyMusicCell * cell = [self.searchTableView cellForRowAtIndexPath:myIndexPath];
        if (self.isPlayMusic == NO) {
            self.isPlayMusic = YES;
            cell.playButton.image = [UIImage imageNamed:@""];
            self.HUD = [[MBProgressHUD alloc] initWithView:cell.playButton];
            [cell.playButton addSubview:self.HUD];
            self.HUD.minSize = cell.playButton.frame.size;
            self.HUD.cornerRadius = 0;
            self.HUD.opacity = 0;
            
            __weak typeof(self) weakSelf = self;
            [weakSelf.HUD showAnimated:YES whileExecutingBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf createStreamerWithURL:myMusicUrl1];
                });
            } completionBlock:^{
                cell.playButton.image = [UIImage imageNamed:@"暂停icon"];
                [weakSelf.HUD removeFromSuperview];
                weakSelf.HUD = nil;
            }];
        }
        else{
            cell.playButton.image = [UIImage imageNamed:@"继续icon-拷贝-4"];
            [self destroyStreamer];
            self.isPlayMusic = NO;
        }
    }
}

- (void)createStreamerWithURL:(NSString *)musicUrl
{
    if (self.audioStreamer) {
          [self destroyStreamer];  
    }
    self.audioStreamer = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:musicUrl]];
    [self.audioStreamer start];
}

- (void)destroyStreamer
{
    if (self.audioStreamer)
    {
        [[NSNotificationCenter defaultCenter]
         removeObserver:self
         name:ASStatusChangedNotification
         object:self.audioStreamer];
        [self.audioStreamer stop];
        self.audioStreamer = nil;
    }
}

#pragma mark - 数据源懒加载
- (NSMutableArray *)dataSource1
{
    if (_dataSource1 == nil) {
        _dataSource1 = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSource1;
}

- (NSMutableArray *)recordDataSource{
    if (_recordDataSource == nil) {
        _recordDataSource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _recordDataSource;
}

- (NSMutableArray *)searchDataSource{
    if (_searchDataSource == nil) {
        _searchDataSource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _searchDataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
