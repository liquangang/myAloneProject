//
//  AnalysisMes.h
//  M-Cut
//
//  Created by apple on 16/7/12.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
//数据库操作类
#import "VideoDBOperation.h"
//消息通知对象类
#import "MessageObj.h"
#import "AppDelegate.h"
//app的tabbar
#import "MovierTabBarViewController.h"

@interface AnalysisMes : NSObject

/**
 *  解析消息
 *
 *  @param msg      需要解析的消息json字符串
 */
+ (void)analysisMes:(NSString *)msg;

/**
 *  从传入的字典里获得术语，然后根据术语跳转
 *
 *  @param msg      获得术语的字典内容
 */
+ (void)pushVcWithDic:(NSDictionary *)pushUserInfo;
@end
