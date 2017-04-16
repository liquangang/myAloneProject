//
//  MotionManager.h
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const getMotionDeviceData = @"getMotionDeviceData";
static NSString *const motionDeviceData = @"motionDeviceData";
static NSString *const getGyroData = @"getGyroData";
static NSString *const gyroData = @"gyroData";
static NSString *const getAccelerometerData = @"getAccelerometerData";
static NSString *const accelerometerData = @"accelerometerData";

/**
 *  使用数据要注册通知
 */

@interface MotionManager : NSObject

/**
 *  获得单例
 */
+ (instancetype)shareInstance;

/**
 *  启动陀螺仪和加速计，获得复合数据（如果需要ar动的效果，就调用这个方法）
 */
- (void)startGetDeviceMotionData;

/**
 *  停止获取数据
 */
- (void)stopGetDeviceMotionData;

/**
 *  获取陀螺仪数据
 */
- (void)startGetGyroData;

/**
 *  停止获取陀螺仪数据
 */
- (void)stopGetGyroData;

/**
 *  获取加速度计数据
 */
- (void)startGetAccelerometerData;

/**
 *  停止获取加速度计数据
 */
- (void)stopGetAccelerometerData;
@end
