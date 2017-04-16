//
//  BaseViewController.m
//  M-Cut
//
//  Created by liquangang on 16/9/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //默认显示状态栏
    [self showStatusBar];
}

/** 显示状态栏*/
- (void)hiddenStatusBar{
    self.isShowStatusBar = YES;
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] setNeedsStatusBarAppearanceUpdate];
}

/** 隐藏状态栏*/
- (void)showStatusBar{
    self.isShowStatusBar = NO;
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] setNeedsStatusBarAppearanceUpdate];
}

/** 是否隐藏状态栏*/
- (BOOL)prefersStatusBarHidden{
    return self.isShowStatusBar;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
