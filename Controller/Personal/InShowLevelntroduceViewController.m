//
//  InShowLevelntroduceViewController.m
//  M-Cut
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "InShowLevelntroduceViewController.h"

@interface InShowLevelntroduceViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *introduceWebView;

@end

@implementation InShowLevelntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"映像等级介绍";
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    //加载网页内容
    [self.introduceWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.inshowtv.com/intro/level.html"]]];
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
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
