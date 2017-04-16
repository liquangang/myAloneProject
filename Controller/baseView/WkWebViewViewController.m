//
//  WkWebViewViewController.m
//  M-Cut
//
//  Created by liquangang on 16/9/23.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "WkWebViewViewController.h"
#import <WebKit/WebKit.h>
#import "TimerManager.h"
#import "CustomeClass.h"

@interface WkWebViewViewController ()<WKUIDelegate, WKNavigationDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) CALayer *progressLayer;
@property (nonatomic, strong) UIView *progress;
@property (nonatomic, assign) NSInteger pushTimes;
@end

@implementation WkWebViewViewController

- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    NSLog(@"dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

#pragma mark - wkwebviewdelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void(^)(WKNavigationResponsePolicy))decisionHandler {
    
    // 在收到响应后，决定是否跳转
    self.pushTimes++;
    if (self.pushTimes == 2) {
        [self setCloseButton];
    }
    decisionHandler(WKNavigationResponsePolicyAllow);
}


#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        WEAKSELF2
        self.progressLayer.opacity = 1;
        
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }

        self.progressLayer.frame = CGRectMake(0, 0, ISScreen_Width * [change[@"new"] floatValue], 3);
        
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.progressLayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                weakSelf.progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - interface

/**
 *  设置ui
 */
- (void)createUI{
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progress];
    [self.progress.layer addSublayer:self.progressLayer];
    NAVIGATIONBACKBARBUTTONITEM
    NAVIGATIONBARTITLEVIEW(self.webView.title.length > 0 ? self.webView.title : self.titleStr)
}

- (void)backButtonAction:(UIButton *)backBtn{
    
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 *  使用WKWebview展示网页
 */
+ (void)showWebWithURL:(NSURL *)openURL
                 Title:(NSString *)title
  NavigationController:(UINavigationController *)nav{
    WkWebViewViewController * wkWebViewVc = [WkWebViewViewController new];
    wkWebViewVc.hidesBottomBarWhenPushed = YES;
    wkWebViewVc.needOpenURL = openURL;
    wkWebViewVc.titleStr = title;
    [nav pushViewController:wkWebViewVc animated:YES];
}

/**
 *  设置关闭按钮
 */
- (void)setCloseButton{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 50, 20);
    leftButton.titleLabel.font = ISFont_15;
    [leftButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [leftButton setTitle:@" 返回" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    UIButton *leftButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton1.frame = CGRectMake(0, 0, 36, 20);
    leftButton1.titleLabel.font = ISFont_15;
    [leftButton1 setTitle:@"关闭" forState:UIControlStateNormal];
    [leftButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton1 addTarget:self action:@selector(leftButton1Action:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem1 = [[UIBarButtonItem alloc] initWithCustomView:leftButton1];
    
    self.navigationItem.leftBarButtonItems = @[leftBarButtonItem, leftBarButtonItem1];
}

- (void)leftButton1Action:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - getter

- (WKWebView *)webView{
    if (!_webView) {
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height - 64)];
        NSURLRequest * webRequest = [NSURLRequest requestWithURL:self.needOpenURL];
        [webView loadRequest:webRequest];
        webView.allowsBackForwardNavigationGestures = YES;
        webView.UIDelegate = self;
        webView.navigationDelegate = self;
        _webView = webView;
    }
    return _webView;
}

- (UIView *)progress{
    if (!_progress) {
        _progress = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 3)];
        _progress.backgroundColor = [UIColor clearColor];
    }
    return _progress;
}

- (CALayer *)progressLayer{
    if (!_progressLayer) {
        _progressLayer = [CALayer layer];
        _progressLayer.frame = CGRectMake(0, 0, 0, 3.5);
        _progressLayer.backgroundColor = ISRedColor.CGColor;
    }
    return _progressLayer;
}

@end
