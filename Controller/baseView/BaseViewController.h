//
//  BaseViewController.h
//  M-Cut
//
//  Created by liquangang on 16/9/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  继承该vc，可以实现隐藏打开状态栏，调用方法即可，默认打开
 */

@interface BaseViewController : UIViewController
/** 是否显示状态栏*/
@property (nonatomic, assign) BOOL isShowStatusBar;

/** 显示状态栏*/
- (void)hiddenStatusBar;

/** 隐藏状态栏*/
- (void)showStatusBar;
@end
