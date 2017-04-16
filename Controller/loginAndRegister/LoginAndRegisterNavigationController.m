//
//  LoginAndRegisterNavigationController.m
//  M-Cut
//
//  Created by liquangang on 16/9/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "LoginAndRegisterNavigationController.h"

@interface LoginAndRegisterNavigationController ()

@end

@implementation LoginAndRegisterNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIViewController *)childViewControllerForStatusBarHidden{
    return self.topViewController;
}

- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

@end
