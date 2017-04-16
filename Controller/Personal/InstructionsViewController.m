//
//  InstructionsViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/2/11.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "InstructionsViewController.h"
#import <WebKit/WebKit.h>

@implementation InstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebView * wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0,
                                                                        0,
                                                                        ISScreen_Width,
                                                                        ISScreen_Height - 64)];
    [self.view addSubview:wkWebView];
    
    //读取本地html
    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL * localURL = [NSURL fileURLWithPath:filePath];
    [wkWebView loadFileURL:localURL allowingReadAccessToURL:localURL];
    
    //返回按钮
    NAVIGATIONBACKBARBUTTONITEM
}

#pragma mark - 返回按钮方法
NAVIGATIONBACKITEMMETHOD

@end
