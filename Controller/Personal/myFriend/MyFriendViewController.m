//
//  MyFriendViewController.m
//  M-Cut
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MyFriendViewController.h"
//好友类型切换cell
#import "FriendTypeCell.h"
//好友cell
#import "FriendCell.h"
//添加好友界面
#import "AddFriendViewController.h"
#import "SoapOperation.h"
#import <MBProgressHUD.h>
#import "VideoDBOperation.h"
#import "ChatViewController.h"
#import "FriendModel.h"
#import "MyVideoViewController.h"
#import "CustomeClass.h"
#import "ISConst.h"

@interface MyFriendViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *friendTable;
/** 好友数据源*/
@property (nonatomic, strong) NSMutableArray * friendMuArray;
/** 关注数据源*/
@property (nonatomic, strong) NSMutableArray * followMuArray;
/** 粉丝数据源*/
@property (nonatomic, strong) NSMutableArray * fansMuArray;
/** 记录当前展示的好友类型*/
@property (nonatomic, copy) NSString * showFriendType;

@property (nonatomic, strong) MBProgressHUD * HUD;
/** 是否展示没有数据的提示*/
@property (nonatomic, assign) BOOL isShowNoDataLabel;
@end

@implementation MyFriendViewController

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DEBUGSUCCESSLOG(@"dealloc")
}

#pragma mark - 数据源懒加载
- (NSMutableArray *)friendMuArray{
    if (!_friendMuArray) {
        _friendMuArray = [NSMutableArray new];
    }
    return _friendMuArray;
}

- (NSMutableArray *)followMuArray{
    if (!_followMuArray) {
        _followMuArray = [NSMutableArray new];
    }
    return _followMuArray;
}

- (NSMutableArray *)fansMuArray{
    if (!_fansMuArray) {
        _fansMuArray = [NSMutableArray new];
    }
    return _fansMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //修改AppDelegate的isPushToShowMesVc属性
    [self updateMessage];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isShowNoDataLabel = YES;
    if ([self.showFriendType isEqualToString:@"好友"]) {
        [self selectFriend];
    }else if ([self.showFriendType isEqualToString:@"关注"]){
        [self selectFollow];
    }else if ([self.showFriendType isEqualToString:@"粉丝"]){
        [self selectFans];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

/** 修改AppDelegate的isPushToShowMesVc属性*/
- (void)updateMessage{
    AppDelegate * myAppDelegate = APPDELEGATE;
    [myAppDelegate updateshowNoticeVcWithData:friendVc];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    AppDelegate * myAppDelegate = APPDELEGATE;
    [myAppDelegate updateshowNoticeVcWithData:withoutVc];
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"我的好友";
    
    //添加按钮
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 30, 30);
    [addButton setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    //返回按钮
    if (self.navigationController.viewControllers.count > 1) {
        UIButton * backBtn = [UIButton new];
        backBtn.frame = CGRectMake(0, 0, 20, 20);
        [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
    
    self.showFriendType = @"好友";
    
    //添加好友消息增减的通知
    REGISTEREDNOTI(updatePropmtLabel:, UPDATEPROPMTLABELTEXT);
}

- (void)updatePropmtLabel:(NSNotification *)noti{
    //如果当前展示的好友，就刷新，更新提示数字，如果不是就不需要刷新
    if ([self.showFriendType isEqualToString:@"好友"]) {
        [self selectFriend];
    }
}

- (void)hudShow{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.color = [UIColor clearColor];
    self.HUD.activityIndicatorColor = [UIColor lightGrayColor];
    [self.HUD show:YES];
}

- (void)hudHidden{
    [self.HUD show:NO];
    [self.HUD removeFromSuperview];
    self.HUD = nil;
}

#pragma mark - 添加按钮点击方法
- (void)addButtonAction{
    AddFriendViewController * addFriendVc = [AddFriendViewController new];
    [self.navigationController pushViewController:addFriendVc animated:YES];
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    UIView * view = (UIView *)[self.view viewWithTag:1000];
    view.hidden = YES;
    UIView * view2 = (UIView *)[self.view viewWithTag:10000];
    view2.hidden = YES;
    UIView * view3 = (UIView *)[self.view viewWithTag:100000];
    view3.hidden = YES;
    
    if ([self.showFriendType isEqualToString:@"好友"]) {
        if (self.isShowNoDataLabel) {
            BACKPROPMTVIEW(self.friendMuArray.count == 0, 1000, @"您还没有好友", self.friendTable);
        }
        
        return self.friendMuArray.count;
    }else if ([self.showFriendType isEqualToString:@"关注"]){
        if (self.isShowNoDataLabel) {
            BACKPROPMTVIEW(self.followMuArray.count == 0, 10000, @"您还没有关注的导演", self.friendTable);
        }
        
        return self.followMuArray.count;
    }else{
        if (self.isShowNoDataLabel) {
            BACKPROPMTVIEW(self.fansMuArray.count == 0, 100000, @"您还没有粉丝", self.friendTable);
        }
        
        return self.fansMuArray.count;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor groupTableViewBackgroundColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FriendTypeCell * cell = [FriendTypeCell getFriendTypeCellWithTable:tableView FriendType:self.showFriendType];
    __weak typeof(self) weakSelf = self;
    [cell selectFriend:^{
        [weakSelf selectFriend];
    }];
    [cell selectFans:^{
        [weakSelf selectFans];
    }];
    [cell selectFollow:^{
        [weakSelf selectFollow];
    }];
    UIView * myHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 80)];
    REMOVEALLSUBVIEWS(myHeaderView);
    cell.frame = myHeaderView.bounds;
    [myHeaderView addSubview:cell];
    return myHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 78;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendCell * cell = [FriendCell new];
    if ([self.showFriendType isEqualToString:@"好友"]) {
        cell = [FriendCell getFriendCellWithTable:tableView FriendType:self.showFriendType FriendIInfo:self.friendMuArray[indexPath.row]];
    }else if ([self.showFriendType isEqualToString:@"关注"]){
        cell = [FriendCell getFriendCellWithTable:tableView FriendType:self.showFriendType FriendIInfo:self.followMuArray[indexPath.row]];
    }else if ([self.showFriendType isEqualToString:@"粉丝"]){
        cell = [FriendCell getFriendCellWithTable:tableView FriendType:self.showFriendType FriendIInfo:self.fansMuArray[indexPath.row]];
    }
    
    WEAKSELF(weakSelf);
    [cell pushToChatVc:^(FriendModel *friendInfo) {
        [weakSelf pushToChatVc:friendInfo];
    }];
    return cell;
}

- (void)pushToChatVc:(FriendModel *)friendInfo{
    //跳转到私信页面
    ChatViewController * chatVc = [ChatViewController new];
    chatVc.friendInfo = friendInfo;
    [self.navigationController pushViewController:chatVc animated:YES];
}

- (void)pushToPersonVcWithInfo:(FriendModel *)friendInfo{
    //跳转到个人详情页
    MyVideoViewController * other = [MyVideoViewController new];
    other.isShowOtherUserVideo = YES;
    other.userId = friendInfo.userId;
    [self.navigationController pushViewController:other animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FriendModel * friendInfo = nil;
    if ([self.showFriendType isEqualToString:@"好友"]) {
        friendInfo = self.friendMuArray[indexPath.row];
    }else if ([self.showFriendType isEqualToString:@"关注"]){
        friendInfo = self.followMuArray[indexPath.row];
    }else if ([self.showFriendType isEqualToString:@"粉丝"]){
        friendInfo = self.fansMuArray[indexPath.row];
    }
    [self pushToPersonVcWithInfo:friendInfo];
}

/** 插入数据库*/
- (void)insertToDb{
    NSMutableArray * insertArray = [NSMutableArray new];
    if ([self.showFriendType isEqualToString:@"好友"]) {
        [insertArray addObjectsFromArray:[self.friendMuArray copy]];
    }else if ([self.showFriendType isEqualToString:@"关注"]){
        [insertArray addObjectsFromArray:[self.followMuArray copy]];
    }else if ([self.showFriendType isEqualToString:@"粉丝"]){
        [insertArray addObjectsFromArray:[self.fansMuArray copy]];
    }
    
    //插入数据库
    WEAKSELF(weakSelf);
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        
        [[VideoDBOperation Singleton] addFriendWithArray:insertArray FriendType:weakSelf.showFriendType];
        
    }, )
}

//首先加载本地数据，然后判断网络加载后台数据，如果不同就刷新本地数据，并刷新页面数据

- (void)selectFollow{
    
    WEAKSELF(weakSelf);
    self.showFriendType = @"关注";
    
    [weakSelf.followMuArray removeAllObjects];
    [weakSelf.followMuArray addObjectsFromArray:[[VideoDBOperation Singleton] selectFriendTabWithType:weakSelf.showFriendType]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.friendTable reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf reloadFollow];
    });
}

- (void)reloadFollow{
    WEAKSELF(weakSelf);
    //判断如果有网络就去后台请求数据
    if (![[CustomeClass currentInterentStatus] isEqualToString:@"网络不可用"]) {
        
        DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
            [[SoapOperation Singleton] WS_getfollowlistWithOffset:0 Count:666 Success:^(MovierDCInterfaceSvc_VDCFriendArr *followList) {
                
                if (followList.item.count != weakSelf.followMuArray.count) {
                    
                    [weakSelf.followMuArray removeAllObjects];
                    for (MovierDCInterfaceSvc_VDCFriendInfo * friendInfo in followList.item) {
                        [weakSelf.followMuArray addObject:[FriendModel getFriendModelWithFriendInfo:friendInfo FriendType:weakSelf.showFriendType]];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.friendTable reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                    });
                }
                
                [weakSelf insertToDb];
                
            } Fail:^(NSError *error) {
                [CustomeClass hudHiddenWithView:weakSelf.view Tag:12345];
                RELOADSERVERDATA([weakSelf reloadFollow];)
            }];
        }, {})
    }else{
        [CustomeClass showMessage:@"您的网络不可用！" ShowTime:1.5];
    }
}

- (void)selectFans{
    
    WEAKSELF(weakSelf);
    self.showFriendType = @"粉丝";

    [weakSelf.fansMuArray removeAllObjects];
    [weakSelf.fansMuArray addObjectsFromArray:[[VideoDBOperation Singleton] selectFriendTabWithType:weakSelf.showFriendType]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.friendTable reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];        
        [weakSelf reloadFans];
    });
}

- (void)reloadFans{
    WEAKSELF(weakSelf);
    //判断如果有网络就去后台请求数据
    if (![[CustomeClass currentInterentStatus] isEqualToString:@"网络不可用"]) {
        
        DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
            [[SoapOperation Singleton] WS_getfunslistWithOffset:0 Count:666 Success:^(MovierDCInterfaceSvc_VDCFriendArr *followList) {
                
                if (followList.item.count != weakSelf.fansMuArray.count) {
                    
                    [weakSelf.fansMuArray removeAllObjects];
                    for (MovierDCInterfaceSvc_VDCFriendInfo * friendInfo in followList.item) {
                        [weakSelf.fansMuArray addObject:[FriendModel getFriendModelWithFriendInfo:friendInfo FriendType:weakSelf.showFriendType]];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.friendTable reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                    });
                }
                
                [weakSelf insertToDb];
                
            } Fail:^(NSError *error) {
                [CustomeClass hudHiddenWithView:weakSelf.view Tag:12345];
                RELOADSERVERDATA([weakSelf reloadFans];)
            }];
        }, {})
    }else{
        [CustomeClass showMessage:@"您的网络不可用！" ShowTime:1.5];
    }
}

- (void)selectFriend{
    
    WEAKSELF(weakSelf);
    self.showFriendType = @"好友";

    [weakSelf.friendMuArray removeAllObjects];
    [weakSelf.friendMuArray addObjectsFromArray:[[VideoDBOperation Singleton] selectFriendTabWithType:weakSelf.showFriendType]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.friendTable reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        [weakSelf reloadFriend];
    });
}

- (void)reloadFriend{
    WEAKSELF(weakSelf);
    //判断如果有网络就去后台请求数据
    if (![[CustomeClass currentInterentStatus] isEqualToString:@"网络不可用"]) {
        
        DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
            [[SoapOperation Singleton] WS_getfriendlistWithOffset:0 Count:666 Success:^(MovierDCInterfaceSvc_VDCFriendArr *followList) {
                
                if (followList.item.count != weakSelf.friendMuArray.count) {
                    
                    [weakSelf.friendMuArray removeAllObjects];
                    for (MovierDCInterfaceSvc_VDCFriendInfo * friendInfo in followList.item) {
                        [weakSelf.friendMuArray addObject:[FriendModel getFriendModelWithFriendInfo:friendInfo FriendType:weakSelf.showFriendType]];
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.friendTable reloadSections:[[NSIndexSet alloc] initWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                    });
                }
                
                [weakSelf insertToDb];
                
            } Fail:^(NSError *error) {
                [CustomeClass hudHiddenWithView:weakSelf.view Tag:12345];
                RELOADSERVERDATA([weakSelf reloadFriend];)
            }];
        }, {})
    }else{
        [CustomeClass showMessage:@"您的网络不可用！" ShowTime:1.5];
    }
}

@end