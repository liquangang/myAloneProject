//
//  APPUserData.h
//  M-Cut
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//
/**
 *  存储用户设置的类
 *  提供读值和改值得方法
 *
 */
#import <Foundation/Foundation.h>

@interface APPUserData : NSObject<NSCoding>
/** 是否打开流量环境下的数据上传下载*/
@property (nonatomic, assign) BOOL isOpenMobileData;

#pragma mark - 流量开关
/**
 *@brief:   2016.06.28读操作
 *@return   是否打开流量环境下上传下载的开关
 */
+ (BOOL)getUserSetInfo;

/**
 *@brief:   2016.06.28写操作
 *@prama:   isOpen 用户是否打开流量环境的上传开关
 *@return   存储是否打开流量环境下上传下载的开关的信息
 */
+ (void)writeUserInfoWithMobileStatus:(BOOL)isOpen;
@end
