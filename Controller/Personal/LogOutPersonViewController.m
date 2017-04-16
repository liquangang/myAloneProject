//
//  LogOutPersonViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/4/16.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "LogOutPersonViewController.h"
#import "APPUserPrefs.h"
#import "MyCenterCell.h"
#import "WXApi.h"
#import "UMSocial.h"
#import "PerfectPersonalInfoViewController.h"
#import "UpdateSql.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "DraftboxTableViewController.h"
#import "InstructionsViewController.h"
#import "EditMyInforTableViewController.h"
#import "EditPersonalInfoViewController.h"
#import "MyCollectViewController.h"
#import "SetNewViewController.h"
#import "MylevelViewController.h"
#import "TelephoneBindingViewController.h"
#import "MyTaskViewController.h"
#import "MyCoinViewController.h"
#import "AlertsViewController.h"
#import "MyVideoViewController.h"
#import "MyFriendViewController.h"
#import "CustomeClass.h"
#import "ServiceTermsViewController.h"
#import "VideoDetailViewController.h"
#import "TakeVideoViewController.h"
#import "LoginAndRegister.h"
#import "CouponViewController.h"
#import "WkWebViewViewController.h"
#import "TimerManager.h"
#import "MyRewardViewController.h"

#define WIDTH self.navigationController.navigationBar.bounds.size.width
#define CELLHEIGHT cell.contentView.bounds.size.height

@interface LogOutPersonViewController() <UMSocialUIDelegate, UIAlertViewDelegate>
@end

@implementation LogOutPersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册接收跳转到消息通知界面的通知
    REGISTEREDNOTI(pushToMessageVc:, PUSHTOMESSAGEVC);
    //注册接收跳转到好友界面的通知
    REGISTEREDNOTI(pushToFriendVc:, PUSHTOFRIENDVC);
    
    //注册接受在当前页面时修改提示信息的通知
    REGISTEREDNOTI(changePropmtLabel:, UPDATEPROPMTLABELTEXT);
    //注册跳转到我的视频界面的通知
    REGISTEREDNOTI(pushToMyVideoVc:, PUSHTOVIDEOVC);
    //接受用户信息更新的通知
    REGISTEREDNOTI(updateUseInfo:, @"updateUserInfo");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUserInfo];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //禁止侧滑手势
    if (!self.tabBarController.tabBar.hidden) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //打开侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark --tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.TableContent objectAtIndex:section] count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.TableContent count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 2)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 0)
    {
        return 4;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    声明静态字符串型对象，用来标记重用单元格
    static NSString *TableSampleIdentifier = @"PersonalRoot";
    
    //    用TableSampleIdentifier表示需要重用的单元
    MyCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier
                                                         forIndexPath:indexPath];
    NSArray *Section = [self.TableContent objectAtIndex:indexPath.section];
    NSDictionary *dic = [Section objectAtIndex:indexPath.row];
    [cell.iconImageView setImage:[UIImage imageNamed:[[dic allKeys] lastObject]]];
    [cell.iconNameLabel setText:[[dic allValues] lastObject]];
    
    //需求：当用户制作的影片完成时，在改cell上用一个label进行提示
    if ([cell.iconNameLabel.text isEqualToString:@"我的影片"]) {
        cell.tag = 10000;
        [self addPromptLabelWithCellTag:10000 LabelTag:1];
    }
    if ([cell.iconNameLabel.text isEqualToString:@"消息通知"]) {
        cell.tag = 100000;
        [self addPromptLabelWithCellTag:100000 LabelTag:3];
    }
    if ([cell.iconNameLabel.text isEqualToString:@"我的好友"]) {
        cell.tag = 1000000;
        [self addPromptLabelWithCellTag:1000000 LabelTag:2];
    }
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCenterCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if([cell.iconNameLabel.text isEqualToString:@"常见问题"]){
        NSString * filePath = [[NSBundle mainBundle] pathForResource:@"index"
                                                              ofType:@"html"];
        NSURL * localURL = [NSURL fileURLWithPath:filePath];
        [WkWebViewViewController showWebWithURL:localURL
                                          Title:@"常见问题"
                           NavigationController:self.navigationController];
        return;
    }
    if(![[UserEntity sharedSingleton] isAppHasLogin]){
        [self showLoginAndRegisterWindow];
        return;
    }
    if ([cell.iconNameLabel.text isEqualToString:@"我的影片"]) {
        //我的影片（2016.07.04新增）
        MyVideoViewController * myVideoVc = [MyVideoViewController new];
        myVideoVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myVideoVc animated:YES];
    }else if([cell.iconNameLabel.text isEqualToString:@"我的收藏"]){
        MyCollectViewController *collect = [mainStoryboard instantiateViewControllerWithIdentifier:@"CollectTable"];
        collect.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:collect animated:YES];
        
    }else if ([cell.iconNameLabel.text isEqualToString:@"草稿箱"])
    {
        DraftboxTableViewController *draftVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"DraftboxTable"];
        draftVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:draftVC animated:YES];
    }
    else if([cell.iconNameLabel.text isEqualToString:@"我的等级"]){
        MylevelViewController * myLevelVc = [MylevelViewController new];
        myLevelVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myLevelVc animated:YES];
    }
    else if ([cell.iconNameLabel.text isEqualToString:@"我的任务"]){
        MyTaskViewController * myTaskVc = [MyTaskViewController new];
        myTaskVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myTaskVc animated:YES];
    }else if ([cell.iconNameLabel.text isEqualToString:@"我的映币"]){
        MyCoinViewController * myCoinVc = [MyCoinViewController new];
        myCoinVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myCoinVc animated:YES];
    }else if ([cell.iconNameLabel.text isEqualToString:@"我的好友"]){
       
        //跳转我的好友界面
        MyFriendViewController * myFriendVc = [MyFriendViewController new];
        myFriendVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myFriendVc animated:YES];
    }else if ([cell.iconNameLabel.text isEqualToString:@"消息通知"]){
        
        //挑战消息通知界面
        AlertsViewController * alertsVc = [AlertsViewController new];
        alertsVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:alertsVc animated:YES];
    }else if ([cell.iconNameLabel.text isEqualToString:@"我的奖品"]){
        MyRewardViewController *myRewardVc = [MyRewardViewController new];
        myRewardVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:myRewardVc animated:YES];
    }else if ([cell.iconNameLabel.text isEqualToString:@"微信测试"]){
        
    }
}

#pragma mark - interface

- (void)hiddenLoginAndRegisterWindow:(NSNotification *)noti{
    [super hiddenLoginAndRegisterWindow:noti];
    [LoginAndRegister getSessionWhenUserAlreadyLogin];
}

- (void)updateUseInfo:(NSNotification *)noti{
    [self setUserInfo];
}

-(IBAction)gotoMyInforMationView:(id)sender{
    
    // 解决用户没有登录时点击头像按钮可以看到用户信息的问题
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [self showLoginAndRegisterWindow];
        return;
    }
    
    //跳转到个人信息编辑页面
    EditPersonalInfoViewController * editMyInfo = [EditPersonalInfoViewController new];
    editMyInfo.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:editMyInfo animated:YES];
}

/** 每次进入该页面时设置用户的信息*/
- (void)setUserInfo{
    if (![UserEntity sharedSingleton].isAppHasLogin) {
        [avatar setImage:DEFAULTHEADIMAGE];
        _UserSingature.text = @"";
        _UserName.text = @"";
        [_UserName reloadInputViews];
        [_UserSingature reloadInputViews];
        self.userLevelImage.image = nil;
        self.withoutLoginLabel.hidden = NO;
        return;
    }
    
    self.withoutLoginLabel.hidden = YES;
    [avatar sd_setImageWithURL:[NSURL URLWithString:[UserEntity sharedSingleton].szAcatar] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    _UserName.text = [UserEntity sharedSingleton].szNickname;
    _UserSingature.text = [UserEntity sharedSingleton].szSignature;
    [self updateLevel];
    
    //设置所有消息提示标签
    [[VideoDBOperation Singleton] setBadgeNum];
}

- (IBAction)settingButtonClick:(id)sender {
    if ([[UserEntity sharedSingleton] isAppHasLogin]) {
        SetNewViewController * settingVC = [SetNewViewController new];
        settingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:settingVC animated:YES];
    }else{
        [self showLoginAndRegisterWindow];
    }
}

/** 更新用户等级图片*/
- (void)updateLevel{
    __weak typeof(self) weakSelf = self;
    [[SoapOperation Singleton] WS_GetmyscoreinshiancoinWithSuccess:^(MovierDCInterfaceSvc_VDCMyScoreInshianCoin *integralAndLevelInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.userLevelImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"userLevelImage%@", integralAndLevelInfo.nLevel]];
        });
    } Fail:^(NSError *error) {
        DEBUGLOG(error)
    }];
}

- (void)changePropmtLabel:(NSNotification *)notice{
    [self setPropmt];
}

- (void)setPropmt{
    [self setFrendMesLabel];
    [self setNoticeLabel];
    [self setNoPlayVideoPromptLabel];
}

- (void)removePrompt:(NSNotification *)notice{
    
    //隐藏所有提示label
    for (int i = 1; i < 4; i++) {
        UILabel * label = (id)[self.view viewWithTag:i];
        label.hidden = YES;
    }
}

#pragma mark - addPromptLabel
- (void)addPromptLabelWithCellTag:(NSInteger)cellTag LabelTag:(NSInteger)promptLabelTag{
    MyCenterCell * cell = (id)[self.view viewWithTag:cellTag];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(ISScreen_Width / 6 * 5 + 6, CELLHEIGHT / 2 - CELLHEIGHT / 6, CELLHEIGHT / 3, CELLHEIGHT / 3)];
    [cell.contentView addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.layer.cornerRadius = CELLHEIGHT / 6;
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = promptLabelTag;
    label.font = [UIFont boldSystemFontOfSize:8];
    if ([[UserEntity sharedSingleton] isAppHasLogin]) {
        if ([cell.iconNameLabel.text isEqualToString:@"我的影片"]) {
            [self setNoPlayVideoPromptLabel];
        }else if([cell.iconNameLabel.text isEqualToString:@"消息通知"]){
            [self setNoticeLabel];
        }else{
            [self setFrendMesLabel];
        }
    }
}

/** 设置我的好友未读消息数量*/
- (void)setFrendMesLabel{
    UILabel * label = (id)[self.view viewWithTag:2];
    label.layer.backgroundColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1].CGColor;
    label.layer.backgroundColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1].CGColor;
    label.text = [NSString stringWithFormat:@"%ld", (long)[[VideoDBOperation Singleton] selectAllNoReadFriendPrivateMesNum]];
    if ([label.text intValue] <= 0) {
        label.layer.backgroundColor = [UIColor clearColor].CGColor;
        label.text = @"";
    }
}

/** 设置未观看视频的消息数量*/
- (void)setNoPlayVideoPromptLabel{
    UILabel * label = (id)[self.view viewWithTag:1];
    label.layer.backgroundColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1].CGColor;
    label.layer.backgroundColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1].CGColor;
    label.text = [NSString stringWithFormat:@"%ld", (long)[[VideoDBOperation Singleton] getNoPlayNewVideoNum]];
    if ([label.text intValue] <= 0) {
        label.layer.backgroundColor = [UIColor clearColor].CGColor;
        label.text = @"";
    }
}

/** 设置消息通知label未读数量*/
- (void)setNoticeLabel{
    UILabel * label = (id)[self.view viewWithTag:3];
    label.layer.backgroundColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1].CGColor;
    NSInteger praiseNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:PRAISETERM];
    NSInteger commentsNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:COMMENTSTERM];
    NSInteger careNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:CARETERM];
    NSInteger replyNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:REPLYTERM];
    NSInteger collectNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:COLLECTTERM];
    NSInteger systemNum = [[VideoDBOperation Singleton] getAllNoReadDataWithDataTerm:SYSTEMMESTERM];
    label.text = [NSString stringWithFormat:@"%lu", praiseNum + commentsNum + careNum + collectNum + systemNum + replyNum];
    if ([label.text intValue] <= 0) {
        label.layer.backgroundColor = [UIColor clearColor].CGColor;
        label.text = @"";
    }
}

/** 跳转到消息通知界面*/
- (void)pushToMessageVc:(NSNotification *)noti{
    AlertsViewController * alertsVc = [AlertsViewController new];
    alertsVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:alertsVc animated:YES];
}

/** 跳转到好友界面*/
- (void)pushToFriendVc:(NSNotification *)noti{
    MyFriendViewController * myFriendVc = [MyFriendViewController new];
    myFriendVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myFriendVc animated:YES];
}

- (void)pushToMyVideoVc:(NSNotification *)noti{
    MyVideoViewController * myVideoVc = [MyVideoViewController new];
    myVideoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:myVideoVc animated:YES];
}

#pragma mark - getter

- (NSArray *)TableContent{
    if (!_TableContent) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MyCellDataSource" ofType:@"plist"];
        NSArray *dataSource = [NSArray arrayWithContentsOfFile:path];
        _TableContent = dataSource;
    }
    return _TableContent;
}

@end
