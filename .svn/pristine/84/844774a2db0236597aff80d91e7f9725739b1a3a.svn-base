//
//  NoticeSetViewController.m
//  M-Cut
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "NoticeSetViewController.h"
//自定义NoticeSetCell
#import "NoticeSetCell.h"
#import "SoapOperation.h"
#import "CustomeClass.h"



@implementation setObj

- (id)initWithName:(NSString *)name Status:(BOOL)onOrOff{
    if (self = [super init]) {
        self.setName = name;
        self.onOrOff = onOrOff;
    }
    return self;
}
@end


@interface NoticeSetViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *setTable;
@property (nonatomic, strong) NSMutableArray * titleMuArray;
/** 点赞设置（对应倒数第五位）*/
@property (nonatomic, strong) UISwitch * praiseSwitch;
/** 评论设置*/
@property (nonatomic, strong) UISwitch * commentSwitch;
/** 通知设置*/
@property (nonatomic, strong) UISwitch * noticeSwitch;
/** 状态字符串*/
@property (nonatomic, copy) NSString * statusStr;
@end

@implementation NoticeSetViewController

#pragma mark - 数据源懒加载
- (NSMutableArray *)titleMuArray{
    if (!_titleMuArray) {
        _titleMuArray = [NSMutableArray new];
    }
    return _titleMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self downloadData];
}

- (void)downloadData{
    __weak typeof(self) weakSelf = self;
    [[SoapOperation Singleton] WS_QueryUserInfo:^(MovierDCInterfaceSvc_VDCCustomerInfo *info) {
        NSMutableString * str = [NSMutableString stringWithFormat:@"0000000000000000"];
        NSString * infoStatus = [CustomeClass toBinarySystemWithDecimalSystem:[info.nStatus stringValue]];
        [str replaceCharactersInRange:NSMakeRange((str.length - 1) - (infoStatus.length - 1), infoStatus.length) withString:infoStatus];
        self.statusStr = [str copy];
        setObj * setObj1 = [[setObj alloc] initWithName:@"点赞" Status:[[self.statusStr substringWithRange:NSMakeRange(11, 1)] boolValue]];
        setObj * setObj2 = [[setObj alloc] initWithName:@"评论" Status:[[self.statusStr substringWithRange:NSMakeRange(10, 1)] boolValue]];
        setObj * setObj3 = [[setObj alloc] initWithName:@"通知" Status:[[self.statusStr substringWithRange:NSMakeRange(9, 1)] boolValue]];
        [_titleMuArray addObjectsFromArray:@[setObj1, setObj2, setObj3]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.setTable reloadData];
        });
    } Fail:^(NSError *error) {
        DEBUGLOG(error);
    }];
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"消息提醒";
    
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
    //上传数据
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)switchAction:(UISwitch *)mySwitch{
    NSMutableString * str = [[NSMutableString alloc] initWithString:self.statusStr];
    NSString * replaceStr = [NSString stringWithFormat:@"%d%d%d%d%d", self.noticeSwitch.isOn, self.noticeSwitch.isOn, self.noticeSwitch.isOn, self.commentSwitch.isOn, self.praiseSwitch.isOn];
    NSRange myRange = NSMakeRange(7, 5);
    [str replaceCharactersInRange:myRange withString:replaceStr];
    self.statusStr = [str copy];
    [self sendStatus];
}

- (void)sendStatus{
    [[SoapOperation Singleton] WS_messagepushonoffWithStatus:[CustomeClass toDecimalSystemWithBinarySystem:self.statusStr] Success:^(NSNumber *num) {
        NSLog(@"修改设置成功");
    } FailL:^(NSError *error) {
        DEBUGLOG(error);
    }];
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleMuArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeSetCell * cell = [NoticeSetCell getNoticeSetCellWithTable:tableView SetObj:self.titleMuArray[indexPath.row]];
    if (indexPath.row == 0) {
        self.praiseSwitch = cell.setSwitch;
        [self.praiseSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }else if (indexPath.row == 1){
        self.commentSwitch = cell.setSwitch;
        [self.commentSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }else{
        self.noticeSwitch = cell.setSwitch;
        [self.noticeSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return cell;
}

@end
