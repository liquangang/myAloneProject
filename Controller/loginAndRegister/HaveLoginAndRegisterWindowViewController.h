//
//  HaveLoginAndRegisterWindowViewController.h
//  M-Cut
//
//  Created by liquangang on 16/10/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HaveLoginAndRegisterWindowViewController : UIViewController
/** 显示登录注册window*/
- (void)showLoginAndRegisterWindow;
/** 隐藏登录注册window的通知*/
- (void)hiddenLoginAndRegisterWindow:(NSNotification *)noti;
@end
