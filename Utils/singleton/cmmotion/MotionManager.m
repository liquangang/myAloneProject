

//
//  MotionManager.m
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MotionManager.h"
#import <CoreMotion/CoreMotion.h>

@interface MotionManager()
@property (nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation MotionManager

#pragma mark - 功能接口

/**
 *  启动陀螺仪和加速计，获得复合数据（如果需要ar动的效果，就调用这个方法）
 */
- (void)startGetDeviceMotionData{
    if ([self.motionManager isDeviceMotionAvailable]) {
        [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            POSTNOTI(getMotionDeviceData, @{motionDeviceData:motion});
        }];
    }
}

/**
 *  停止获取复合数据
 */
- (void)stopGetDeviceMotionData{
    [self.motionManager stopDeviceMotionUpdates];
}

/**
 *  获取陀螺仪数据
 */
- (void)startGetGyroData{
    if ([self.motionManager isGyroAvailable]) {
        self.motionManager.gyroUpdateInterval = 1;
        
        //开始获取数据
        [self.motionManager startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            POSTNOTI(getGyroData, @{gyroData:gyroData});
        }];
    }
}

/**
 *  停止获取陀螺仪数据
 */
- (void)stopGetGyroData{
    [self.motionManager stopGyroUpdates];
}

/**
 *  获取加速度计数据
 */
- (void)startGetAccelerometerData{
    if ([self.motionManager isAccelerometerAvailable]) {
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
            POSTNOTI(getAccelerometerData, @{accelerometerData:accelerometerData});
        }];
    }
}

/**
 *  停止获取加速度计数据
 */
- (void)stopGetAccelerometerData{
    [self.motionManager stopAccelerometerUpdates];
}

#pragma mark - 创建单例

/**
 *  创建单例
 */

static MotionManager *instance;

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

#pragma mark - 懒加载

/**
 *  陀螺仪、加速度计管理对象
 */
- (CMMotionManager *)motionManager{
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
    }
    return _motionManager;
}
@end
