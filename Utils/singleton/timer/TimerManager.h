//
//  TimerManager.h
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

/**
 *  使用数据要注册通知
 */

#import <Foundation/Foundation.h>

@interface TimerManager : NSObject

/**
 *  获得单例
 */
+ (instancetype)shareInstance;

/**
 *  开始计时(参数是时间间隔)
 */
- (void)startWithTimeInterval:(NSInteger)timeInterval;

/**
 *  计时器停止
 */
- (void)stop;
@end
