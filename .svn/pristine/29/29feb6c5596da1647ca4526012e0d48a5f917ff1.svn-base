//
//  MylevelViewController.m
//  M-Cut
//
//  Created by apple on 16/6/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MylevelViewController.h"
#import "UserEntity.h"
#import <UIImageView+WebCache.h>
//积分记录页面
#import "IntegralRecordViewController.h"
//映像等级介绍界面
#import "InShowLevelntroduceViewController.h"
//如何提升等级界面
#import "MyTaskViewController.h"
#import "SoapOperation.h"
#import "CustomeClass.h"
#import "ISConst.h"

@interface MylevelViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *backHeadIconImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayIntegralLabel;
@property (weak, nonatomic) IBOutlet UILabel *myIntegralLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *integralProgressView;
/** 下个界面的总积分*/
@property (nonatomic, copy) NSString * userAllScore;
/** 下载次数*/
@property (nonatomic, assign) int downloadTimes;
@end

@implementation MylevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //初始化ui界面
    [self initUI];
    [self downloadData];
}

#pragma mark - downloadData
- (void)downloadData{
    __weak typeof(self) weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [CustomeClass hudShowWithView:weakSelf.view Tag:1234];
        
        [[SoapOperation Singleton] WS_GetmyscoreinshiancoinWithSuccess:^(MovierDCInterfaceSvc_VDCMyScoreInshianCoin *integralAndLevelInfo) {
            weakSelf.userAllScore = [NSString stringWithFormat:@"%@ 分", [integralAndLevelInfo.nAllScore stringValue]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomeClass hudHiddenWithView:weakSelf.view Tag:1234];
                weakSelf.userLevelLabel.text = [NSString stringWithFormat:@"%@ Lv.%@", integralAndLevelInfo.strLevelName, integralAndLevelInfo.nLevel];
                weakSelf.levelDesLabel.text = [NSString stringWithFormat:@"需%d分到下一等级，新特权在等你！", [integralAndLevelInfo.nMaxScore intValue] - [integralAndLevelInfo.nAllScore intValue]];
                weakSelf.currentLevelLabel.text = [NSString stringWithFormat:@"Lv.%@", integralAndLevelInfo.nLevel];
                weakSelf.nextLevelLabel.text = [NSString stringWithFormat:@"Lv.%d", [integralAndLevelInfo.nLevel intValue] + 1];
                weakSelf.todayIntegralLabel.text = [integralAndLevelInfo.nTodayScore stringValue];
                weakSelf.myIntegralLabel.text = [integralAndLevelInfo.nAllScore stringValue];
                NSString * progressValue = [NSString stringWithFormat:@"%.2f%%", (([integralAndLevelInfo.nAllScore floatValue] - [integralAndLevelInfo.nMinScore floatValue]) / ([integralAndLevelInfo.nMaxScore floatValue] - [integralAndLevelInfo.nMinScore floatValue]))];
                weakSelf.integralProgressView.progress = [progressValue floatValue];
            });
        } Fail:^(NSError *error) {
            [CustomeClass hudHiddenWithView:weakSelf.view Tag:1234];
            RELOADSERVERDATA([weakSelf downloadData];)
        }];
    });
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"我的等级";
    
    //添加毛玻璃盖板
    UIToolbar * myToolbar = [[UIToolbar alloc] initWithFrame:self.backHeadIconImageView.bounds];
    [self.backHeadIconImageView addSubview:myToolbar];
    myToolbar.alpha = 0.95;
    
    //设置毛玻璃下面的头像
    UIImageView * backHeadIcon = [[UIImageView alloc] initWithFrame:CGRectMake(- ISScreen_Width / 2, - ISScreen_Height / 4, ISScreen_Width * 2, ISScreen_Height)];
    [self.backHeadIconImageView insertSubview:backHeadIcon belowSubview:myToolbar];
    [backHeadIcon sd_setImageWithURL:[NSURL URLWithString:[UserEntity sharedSingleton].szAcatar] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    
    //设置头像
    //设置头像为圆形
    self.headIconImageView.layer.masksToBounds = YES;
    self.headIconImageView.layer.cornerRadius = 33;
    [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:[UserEntity sharedSingleton].szAcatar] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    
    self.downloadTimes = 0;
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 返回按钮点击方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        return 88;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.textColor = [UIColor grayColor];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"我的积分记录";
    }
    else if (indexPath.section == 1){
        cell.textLabel.text = @"映像等级介绍";
    }
    else{
        cell.textLabel.text = @"如何提升等级";
        cell.detailTextLabel.text = @"参加不定期的精彩活动，完成每日“我的任务”等，\n就可以获取大把积分。";
        cell.detailTextLabel.numberOfLines = 2;
        cell.detailTextLabel.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1];
    }
    cell.textLabel.textColor = [UIColor colorWithRed:64.0f/255.0f green:74.0f/255.0f blue:88.0f/255.0f alpha:1];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //跳转我的积分记录界面
        IntegralRecordViewController * integralRecordVc = [IntegralRecordViewController new];
        integralRecordVc.userAllScore = self.userAllScore;
        [self.navigationController pushViewController:integralRecordVc animated:YES];
    }else if (indexPath.section == 1){
        //跳转映像等级介绍页面
        InShowLevelntroduceViewController * inShowLevelIntroduceVc = [InShowLevelntroduceViewController new];
        [self.navigationController pushViewController:inShowLevelIntroduceVc animated:YES];
    }else{
        //跳转如何提升等级页面即我的任务界面
        MyTaskViewController * myTaskVc = [MyTaskViewController new];
        [self.navigationController pushViewController:myTaskVc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
