//
//  HomeBannerWebViewController.m
//  M-Cut
//
//  Created by 李亚飞 on 15/12/3.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "HomeBannerWebViewController.h"

@interface HomeBannerWebViewController () <UIWebViewDelegate>

@end

@implementation HomeBannerWebViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"活动详情";
    
    self.view.backgroundColor = ISBackgroundColor;
    
    [self setupWebView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupWebView {
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = CGRectMake(0, 0,  ISScreen_Width, ISScreen_Height - ISNavigationHeight);
    // 根据页面缩放
    webView.scalesPageToFit = YES;
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

#pragma mark ----  UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [UIAlertView alertViewshowMessage:[error localizedDescription] cancleButton:nil confirmButton:@"确定"];
}

@end
