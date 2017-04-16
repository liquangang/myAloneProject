//
//  MyTaskViewController.m
//  M-Cut
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MyTaskViewController.h"
#import "CustomCollectionView.h"
//具体积分和映币规则
#import "IntegralAndCoinRuleViewController.h"
//日常任务和挑战任务自定义的cell
#import "DayTaskCell.h"
//海量点赞界面
#import "MorePraiseViewController.h"
//海量浏览界面
#import "MoreBrowseViewController.h"
//参与活动界面
#import "JoinActivitiesViewController.h"
//首页精选界面
#import "HomeSelectedViewController.h"
#import "SoapOperation.h"
//账户安全界面
#import "AccountBindingViewController.h"
//个人信息编辑页面
#import "EditPersonalInfoViewController.h"

@interface MyTaskViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCollectionViewDelegate>
/** 存放界面的所有数据*/
@property (nonatomic, strong) NSMutableArray * allDataMuArray;
/** 存放界面当前的展示数据*/
@property (nonatomic, strong) NSMutableArray * currentDataMuArray;
@property (weak, nonatomic) IBOutlet UITableView *taskTable;
/** 是否显示新手任务*/
@property (nonatomic, assign) BOOL isShowNewUserTask;
/** 存放新手任务是否完成的数据*/
@property (nonatomic, strong) MovierDCInterfaceSvc_VDCNewUserScoreTask * myUserScoreTask;
@end

@implementation MyTaskViewController

#pragma mark - 数组懒加载
- (NSMutableArray *)allDataMuArray{
    if (!_allDataMuArray) {
        _allDataMuArray = [[NSMutableArray alloc] initWithObjects:[NSMutableArray new], [NSMutableArray new], [NSMutableArray new], [NSMutableArray new], nil];
    }
    return _allDataMuArray;
}

- (NSMutableArray *)currentDataMuArray{
    if (!_currentDataMuArray) {
        _currentDataMuArray = [[NSMutableArray alloc] initWithObjects:[NSMutableArray new], [NSMutableArray new], [NSMutableArray new], [NSMutableArray new], nil];
    }
    return _currentDataMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self downloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self downloadData];
}

#pragma mark - 下载数据
- (void)downloadData{
    [[SoapOperation Singleton] WS_IsCustomerHaveInfoSuccess:^(MovierDCInterfaceSvc_VDCNewUserScoreTask *isHaveInfo) {
        self.myUserScoreTask = isHaveInfo;
    } Fail:^(NSError *error) {
        NSLog(@"下载新手任务是否完成的信息失败-----------%@", error);
    }];
    
    [[SoapOperation Singleton] WS_IsCustomerHaveInfoSuccess:^(MovierDCInterfaceSvc_VDCNewUserScoreTask *isHaveInfo) {
        if (isHaveInfo.IsBindTel.boolValue && isHaveInfo.HaveNickName.boolValue && isHaveInfo.HaveAvatar.boolValue && isHaveInfo.HaveBirthday.boolValue) {
            self.isShowNewUserTask = NO;
        }else{
            self.isShowNewUserTask = YES;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.taskTable reloadData];
        });
    } Fail:^(NSError *error) {
        NSLog(@"下载新手任务是否完成的信息失败-----------%@", error);
    }];
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"我的任务";
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.isShowNewUserTask) {
        return 4;
    }
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.isShowNewUserTask) {
        if (section == 3) {
            return 0;
        }
        return [self.currentDataMuArray[section] count];
    }
    if (section == 2) {
        return 0;
    }
    return [self.currentDataMuArray[section + 1] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isShowNewUserTask) {
        if (indexPath.section == 0) {
            return ISScreen_Width / 4 * 2;
        }
    }
    return 66;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 36;
}

//返回自定义的头视图
- (UIView *)makeHeaderViewWithText:(NSString *)taskDesStr section:(NSInteger)section{
    //headerView
    UIView * mySectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 36)];
    mySectionHeaderView.backgroundColor = [UIColor whiteColor];
    [mySectionHeaderView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionViewAction:)]];
    mySectionHeaderView.tag = section + 100;
    
    //任务描述
    UILabel * taskLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 7, 188, 22)];
    [mySectionHeaderView addSubview:taskLabel];
    taskLabel.text = taskDesStr;
    
    //箭头
    UIImageView * arrowImage = [[UIImageView alloc] initWithFrame:CGRectMake(ISScreen_Width - 36, 12, 12, 8)];
    [mySectionHeaderView addSubview:arrowImage];
    arrowImage.image = [UIImage imageNamed:@"展开"];
    
    //是否需要旋转
    if (section < 3 && [self.currentDataMuArray[section] count] > 0) {
        arrowImage.transform = CGAffineTransformMakeRotation(-M_PI);
    }
    
    //最底部的不需要旋转
    if ([taskDesStr isEqualToString:@"具体积分和映币规则"]) {
        arrowImage.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }
    
    //底部横线
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, ISScreen_Width, 1)];
    [mySectionHeaderView addSubview:lineLabel];
    lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    return mySectionHeaderView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.isShowNewUserTask) {
        if (section == 0) {
            return [self makeHeaderViewWithText:@"新手任务" section:0];
        }else if (section == 1){
            return [self makeHeaderViewWithText:@"日常任务" section:1];
        }else if (section == 2){
            return [self makeHeaderViewWithText:@"挑战任务" section:2];
        }else{
            return [self makeHeaderViewWithText:@"具体积分和映币规则" section:3];
        }
    }
    if (section == 0){
        return [self makeHeaderViewWithText:@"日常任务" section:1];
    }else if (section == 1){
        return [self makeHeaderViewWithText:@"挑战任务" section:2];
    }else{
        return [self makeHeaderViewWithText:@"具体积分和映币规则" section:3];
    }
}

#pragma mark - 每组头视图点击方法
- (void)sectionViewAction:(UITapGestureRecognizer *)tap{
    UIView * myView = [tap view];
    if (myView.tag == 100) {
        //展开关闭新手任务
        if ([self.currentDataMuArray[0] count] > 0) {
            [self.currentDataMuArray[0] removeAllObjects];
        }else{
            [self.currentDataMuArray[0] addObject:@"展示新手任务"];
        }
    }else if (myView.tag == 101){
        //展开关闭日常任务
        if ([self.currentDataMuArray[1] count] > 0) {
            [self.currentDataMuArray[1] removeAllObjects];
        }else{
         [self.currentDataMuArray[1] addObjectsFromArray:[[NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DayTaskDesList" ofType:@"plist"]] copy]];
        }
    }else if (myView.tag == 102){
        if ([self.currentDataMuArray[2] count] > 0) {
            [self.currentDataMuArray[2] removeAllObjects];
        }else{
            [self.currentDataMuArray[2] addObjectsFromArray:[[NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ChallengeTaskPList" ofType:@"plist"]] copy]];
        }
    }else if (myView.tag == 103){
        //跳转具体积分和映币规则页面
        IntegralAndCoinRuleViewController * integralAndCoinVc = [IntegralAndCoinRuleViewController new];
        [self.navigationController pushViewController:integralAndCoinVc animated:YES];
        return;
    }
    [self.taskTable reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.isShowNewUserTask) {
        if (section == 3) {
            return 1;
        }
        return 8;
    }
    if (section == 2) {
        return 1;
    }
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isShowNewUserTask) {
        if (indexPath.section == 0) {
            UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell0"];
            }
            [cell.contentView addSubview:[CustomCollectionView collectionWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Width / 4 * 2) andItemSize:CGSizeMake(ISScreen_Width / 3, ISScreen_Width / 4) Delegate:self UserScoreTask:self.myUserScoreTask]];
            return cell;
        }else if (indexPath.section == 1 || indexPath.section == 2) {
            DayTaskCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            if (!cell) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"DayTaskCell" owner:nil options:nil] lastObject];
            }
            [cell setCellWithDic:self.currentDataMuArray[indexPath.section][indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    if (indexPath.section == 0 || indexPath.section == 1) {
        DayTaskCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"DayTaskCell" owner:nil options:nil] lastObject];
        }
        [cell setCellWithDic:self.currentDataMuArray[indexPath.section + 1][indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (self.isShowNewUserTask) {
//        if (indexPath.section == 2 && indexPath.row == 0) {
//            MorePraiseViewController * morePraiseVc = [MorePraiseViewController new];
//            [self.navigationController pushViewController:morePraiseVc animated:YES];
//        }else if (indexPath.section == 2 && indexPath.row == 1){
//            MoreBrowseViewController * moreBrowseVc = [MoreBrowseViewController new];
//            [self.navigationController pushViewController:moreBrowseVc animated:YES];
//        }
//        else if (indexPath.section == 2 && indexPath.row == 2){
//            JoinActivitiesViewController * joinActivitiesVc = [JoinActivitiesViewController new];
//            [self.navigationController pushViewController:joinActivitiesVc animated:YES];
//        }else if (indexPath.section == 2 && indexPath.row == 3){
//            HomeSelectedViewController * homeSelectedVc = [HomeSelectedViewController new];
//            [self.navigationController pushViewController:homeSelectedVc animated:YES];
//        }
//    }
//    else{
//        if (indexPath.section == 1 && indexPath.row == 0) {
//            MorePraiseViewController * morePraiseVc = [MorePraiseViewController new];
//            [self.navigationController pushViewController:morePraiseVc animated:YES];
//        }else if (indexPath.section == 1 && indexPath.row == 1){
//            MoreBrowseViewController * moreBrowseVc = [MoreBrowseViewController new];
//            [self.navigationController pushViewController:moreBrowseVc animated:YES];
//        }
//        else if (indexPath.section == 1 && indexPath.row == 2){
//            JoinActivitiesViewController * joinActivitiesVc = [JoinActivitiesViewController new];
//            [self.navigationController pushViewController:joinActivitiesVc animated:YES];
//        }else if (indexPath.section == 1 && indexPath.row == 3){
//            HomeSelectedViewController * homeSelectedVc = [HomeSelectedViewController new];
//            [self.navigationController pushViewController:homeSelectedVc animated:YES];
//        }
//    }
}


#pragma mark - CustomCollectionViewDelegate
- (void)pushVcWithIndex:(NSIndexPath *)myIndex{
    if (myIndex.row == 1) {
        AccountBindingViewController * accountAndSafeVc = [AccountBindingViewController new];
        [self.navigationController pushViewController:accountAndSafeVc animated:YES];
    }else if (myIndex.row == 2 || myIndex.row == 3 || myIndex.row == 4){
        EditPersonalInfoViewController * editPersonInfoVc = [EditPersonalInfoViewController new];
        [self.navigationController pushViewController:editPersonInfoVc animated:YES];
    }
}
@end
