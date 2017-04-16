//
//  AlertsViewController.m
//  M-Cut
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AlertsViewController.h"
//界面自定义cell
#import "AlertsCell.h"
//自定义Inshow通知cell
#import "InshowNoticeCell.h"
//点赞界面
#import "PraiseViewController.h"
//评论页面
#import "CommentsViewController.h"
//通知界面
#import "NoticeViewController.h"

@interface AlertsViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 界面数据源*/
@property (nonatomic, strong) NSMutableArray * alertsMuArray;
/** 系统通知数据源*/
@property (nonatomic, strong) NSMutableArray * systemNoticeMuArray;
@property (weak, nonatomic) IBOutlet UITableView *alertTable;
@end

static NSString * cellId = @"alertsCell";
static NSString * cellId2 = @"inshowNoticeCell";

@implementation AlertsViewController

#pragma mark - 数组懒加载
- (NSMutableArray *)alertsMuArray{
    if (!_alertsMuArray) {
        _alertsMuArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AlertsData.plist" ofType:nil]];
    }
    return _alertsMuArray;
}

- (NSMutableArray *)systemNoticeMuArray{
    if (!_systemNoticeMuArray) {
        _systemNoticeMuArray = [NSMutableArray arrayWithArray:[[VideoDBOperation Singleton] getDataWithTerm:SYSTEMMESTERM]];
    }
    return _systemNoticeMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateMessage];
    [self initUI];
}

/** 修改AppDelegate的isPushToShowMesVc属性*/
- (void)updateMessage{
    AppDelegate * myAppDelegate = APPDELEGATE;
    [myAppDelegate updateshowNoticeVcWithData:messageVc];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    AppDelegate * myAppDelegate = APPDELEGATE;
    [myAppDelegate updateshowNoticeVcWithData:withoutVc];
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"消息通知";
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    REGISTEREDNOTI(changePropmt:, UPDATEPROPMTLABELTEXT);
}

- (void)changePropmt:(NSNotification *)noti{
    [self.alertTable reloadData];
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }
    return self.systemNoticeMuArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 70;
    }
    return 166;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 12;
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor groupTableViewBackgroundColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [AlertsCell getAlertCellWithDic:self.alertsMuArray[indexPath.row] Table:tableView];;
    }else{
        return [InshowNoticeCell getInshowNoticeCellWithTable:tableView MessageObj:self.systemNoticeMuArray[indexPath.row]];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return;
    }
    AlertsCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.alertsTypeLabel.text isEqualToString:@"点赞"]) {
        //点赞界面
        PraiseViewController * praiseVc = [PraiseViewController new];
        [self.navigationController pushViewController:praiseVc animated:YES];
    }else if ([cell.alertsTypeLabel.text isEqualToString:@"评论"]){
        //评论界面
        CommentsViewController * commentsVc = [CommentsViewController new];
        [self.navigationController pushViewController:commentsVc animated:YES];
    }else if ([cell.alertsTypeLabel.text isEqualToString:@"通知"]){
        //通知界面
        NoticeViewController * noticeVc = [NoticeViewController new];
        [self.navigationController pushViewController:noticeVc animated:YES];
    }
}

@end
