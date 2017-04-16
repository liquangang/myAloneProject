//
//  HaveLoginAndRegisterWindowViewController.m
//  M-Cut
//
//  Created by liquangang on 16/10/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HaveLoginAndRegisterWindowViewController.h"
#import "LoginAndRegisterWindow.h"

@interface HaveLoginAndRegisterWindowViewController ()
/** 登录注册window*/
@property (nonatomic, strong) LoginAndRegisterWindow * loginAndRegisterVcWindow;
@end

@implementation HaveLoginAndRegisterWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //隐藏window的通知
    REGISTEREDNOTI(hiddenLoginAndRegisterWindow:, HIDDENLOGINANDREGISTERWINDOW);
}

/** 显示登录注册window*/
- (void)showLoginAndRegisterWindow{
    [UIView animateWithDuration:0.5 animations:^{
        [self.loginAndRegisterVcWindow makeKeyAndVisible];
        self.loginAndRegisterVcWindow.frame = CGRectMake(0, 0, ISScreen_Width, ISScreen_Height);
    }];
}

/** 隐藏登录注册window的通知*/
- (void)hiddenLoginAndRegisterWindow:(NSNotification *)noti{
    [UIView animateWithDuration:0.4 animations:^{
        self.loginAndRegisterVcWindow.frame = CGRectMake(0, ISScreen_Height, ISScreen_Width, ISScreen_Height);
        [self.loginAndRegisterVcWindow resignKeyWindow];
        self.loginAndRegisterVcWindow = nil;
        [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
    }];
    
}

/** 登录注册window*/
- (LoginAndRegisterWindow *)loginAndRegisterVcWindow{
    if (!_loginAndRegisterVcWindow) {
        _loginAndRegisterVcWindow = [[LoginAndRegisterWindow alloc] initWithFrame:CGRectMake(0, -ISScreen_Height, ISScreen_Width, ISScreen_Height)];
    }
    return _loginAndRegisterVcWindow;
}

@end