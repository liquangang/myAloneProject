//
//  TimerManager.m
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TimerManager.h"

@interface TimerManager()
//计时器
@property (nonatomic, strong) NSTimer * timer;
@end

@implementation TimerManager

#pragma mark - 功能模块

/**
 *  开始计时
 */
- (void)startWithTimeInterval:(NSInteger)timeInterval{
    [self deallocTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                  target:self
                                                selector:@selector(timerAction:)
                                                userInfo:nil
                                                 repeats:YES];
    
    //开始
    [self.timer setFireDate:[NSDate distantPast]];
}

/**
 *  计时器方法
 */
- (void)timerAction:(NSTimer *)timer{
    POSTNOTI(timerIntervalMethod, nil);
}

/**
 *  计时器停止
 */
- (void)stop{
    [self.timer setFireDate:[NSDate distantFuture]];
    [self deallocTimer];
}

- (void)deallocTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - 创建单例

/**
 *  创建单例
 */

static TimerManager *instance;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone] ;
    }) ;
    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return instance;
}
@end
