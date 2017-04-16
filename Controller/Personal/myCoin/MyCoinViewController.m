//
//  MyCoinViewController.m
//  M-Cut
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MyCoinViewController.h"
#import "UserEntity.h"
#import <UIImageView+WebCache.h>
//我的映币记录页面
#import "IntegralRecordViewController.h"
#import "SoapOperation.h"
#import "CustomeClass.h"

@interface MyCoinViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *levelDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayCoinLabel;
@property (weak, nonatomic) IBOutlet UILabel *allCoinLabel;
/** 下个界面的总积分*/
@property (nonatomic, copy) NSString * userAllScore;
@end

@implementation MyCoinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self downloadData];
}

#pragma mark - 下载数据
- (void)downloadData{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [CustomeClass hudShowWithView:weakSelf.view Tag:1234];
        
        
        [[SoapOperation Singleton] WS_GetmyscoreinshiancoinWithSuccess:^(MovierDCInterfaceSvc_VDCMyScoreInshianCoin *integralAndLevelInfo) {
            weakSelf.userAllScore = [NSString stringWithFormat:@"%@ 映币", [integralAndLevelInfo.nAllInshianCoin stringValue]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomeClass hudHiddenWithView:weakSelf.view Tag:1234];
                weakSelf.levelDesLabel.text = [NSString stringWithFormat:@"%@ Lv.%@", integralAndLevelInfo.strLevelName, integralAndLevelInfo.nLevel];
                weakSelf.todayCoinLabel.text = [integralAndLevelInfo.nTodayInshianCoin stringValue];
                weakSelf.allCoinLabel.text = [integralAndLevelInfo.nAllInshianCoin stringValue];
            });
        } Fail:^(NSError *error) {
            [CustomeClass hudHiddenWithView:weakSelf.view Tag:1234];
            RELOADSERVERDATA([weakSelf downloadData];)
        }];
    });
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"我的映币";
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    //设置头像
    //设置头像为圆形
    self.headIconImageView.layer.masksToBounds = YES;
    self.headIconImageView.layer.cornerRadius = 44;
    [self.headIconImageView sd_setImageWithURL:[NSURL URLWithString:[UserEntity sharedSingleton].szAcatar] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
}

#pragma mark - 我的映币记录点击方法
- (IBAction)coinLogButtonAction:(id)sender {
    IntegralRecordViewController * integralRecordVc = [IntegralRecordViewController new];
    integralRecordVc.userAllScore = self.userAllScore;
    integralRecordVc.isFromMyCoinVc = YES;
    [self.navigationController pushViewController:integralRecordVc animated:YES];
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
