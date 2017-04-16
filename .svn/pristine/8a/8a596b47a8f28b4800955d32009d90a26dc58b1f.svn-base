//
//  NSString+Date.h
//  TestDate
//
//  Created by 李亚飞 on 15/11/23.
//  Copyright © 2015年 李亚飞. All rights reserved.
//  根据服务器返回的时间  yyyy-MM-dd HH:mm:ss, 返回字符串

#import <Foundation/Foundation.h>

@interface LITime : NSObject
@property (assign, nonatomic) NSInteger year;
@property (assign, nonatomic) NSInteger month;
@property (assign, nonatomic) NSInteger day;
@property (assign, nonatomic) NSInteger hour;
@property (assign, nonatomic) NSInteger minute;
@property (assign, nonatomic) NSInteger second;
@end

@interface NSString (Date)
/**
 *  根据是否是今年, 确定是否显示年份
 */
- (NSString *)time_isNeedShowYear;

/**
 *  根据服务器时间和当前时间, 获得评论的时间显示
 */
- (NSString *)timeStr;
@end
