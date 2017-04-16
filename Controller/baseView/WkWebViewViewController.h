//
//  WkWebViewViewController.h
//  M-Cut
//
//  Created by liquangang on 16/9/23.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WkWebViewViewController : UIViewController
/** 需要设置的title*/
@property (nonatomic, copy) NSString * titleStr;
/** 需要打开的URL(需要注意区分本地URL和网络URL)*/
@property (nonatomic, strong) NSURL * needOpenURL;

/**
 *@brief    使用WKWebview展示网页
 *@param    openURL 需要展示的网页链接（注意区分本地url和网络url）
 *@param    title   如果需要设置导航栏标题，请设置这个参数
 *@param    nav     跳转的导航控制器
 */
+ (void)showWebWithURL:(NSURL *)openURL
                 Title:(NSString *)title
  NavigationController:(UINavigationController *)nav;
@end
