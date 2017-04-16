//
//  AlreadyBindingTelephoneViewController.m
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AlreadyBindingTelephoneViewController.h"
#import "TelephoneBindingViewController.h"
#import "SoapOperation.h"

@interface AlreadyBindingTelephoneViewController ()
@property (weak, nonatomic) IBOutlet UILabel *alreadyBiindingTelNum;

@end

@implementation AlreadyBindingTelephoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

#pragma mark - downloadData
- (void)downloadData{
    __weak typeof(self) weakSelf = self;
    [[SoapOperation Singleton]WS_QueryUserInfo:^(MovierDCInterfaceSvc_VDCCustomerInfo *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.alreadyBiindingTelNum.text = [NSString stringWithFormat:@"已绑定手机: %@", info.szTel];
        });
    } Fail:^(NSError *error) {
        NSLog(@"更换后的手机号下载失败");
    }];
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"手机绑定";
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.alreadyBiindingTelNum.text = [NSString stringWithFormat:@"已绑定手机: %@", self.alreadyBindingTelNumStr];
    
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
    if (self.isPushFormTelBindingVC) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[0] animated:YES];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)updateTelNum:(id)sender {
    TelephoneBindingViewController * telBindingVc = [TelephoneBindingViewController new];
    [self.navigationController pushViewController:telBindingVc animated:YES];
}

#pragma mark - viewwillappear
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self downloadData];
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
