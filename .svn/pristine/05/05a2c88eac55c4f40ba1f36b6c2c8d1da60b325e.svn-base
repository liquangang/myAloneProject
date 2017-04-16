//
//  NSString+Date.m
//  TestDate
//
//  Created by 李亚飞 on 15/11/23.
//  Copyright © 2015年 李亚飞. All rights reserved.
//

#import "NSString+Date.h"

@implementation LITime

@end

@implementation NSString (Date)

/**  返回  裁剪后 服务器  的时间 */
- (LITime *)serverTime {
    LITime *time = [[LITime alloc] init];
    
    // 时间格式 yyyy-MM-dd HH:mm:ss
    // 1. 先用空格将字符串裁剪成两部分, 第一个元素是yyyy-MM-dd, 第二个元素是HH:mm:ss
    NSArray *array = [self componentsSeparatedByString:@" "];
    
    // 2. 分别对 array 两个元素裁剪
    if (array.count < 1)    return nil;
    NSString *str1 = array[0];
    // 年月日数组
    NSArray *nyr = [str1 componentsSeparatedByString:@"-"];
    
    if (array.count < 2)    return nil;
    NSString *str2 = array[1];
    // 时分秒数组
    NSArray *sfm = [str2 componentsSeparatedByString:@":"];
    
    // 3. 将年月日数组nyr, 时分秒数组sfm 中的元素添加到 parts 中
    time.year   = [nyr[0] integerValue];
    time.month  = [nyr[1] integerValue];
    time.day    = [nyr[2] integerValue];
    
    time.hour   = [sfm[0] integerValue];
    time.minute = [sfm[1] integerValue];
    time.second = [sfm[2] integerValue];
    
    return time;
}

/**  获得当前时间 */
- (LITime *)currentTime {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDate *now = [NSDate date];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:now];
    
    LITime *time = [[LITime alloc] init];
    time.year   = nowCmps.year;
    time.month  = nowCmps.month;
    time.day    = nowCmps.day;
    time.hour   = nowCmps.hour;
    time.minute = nowCmps.minute;
    time.second = nowCmps.second;
    
    return time;
}


/**
 *  根据是否是今年, 确定是否显示年份
 */
- (NSString *)time_isNeedShowYear {
    LITime *serverTime = [self serverTime];
    LITime *currentTime = [self currentTime];
    
    if (serverTime.year == currentTime.year) {   // 不显示年份
        return [NSString stringWithFormat:@"%zd-%zd %zd:%zd", serverTime.month, serverTime.day, serverTime.hour, serverTime.minute];
    }
    return [NSString stringWithFormat:@"%zd-%zd-%zd %zd:%zd", serverTime.year, serverTime.month, serverTime.day, serverTime.hour, serverTime.minute];
}

/**
 *  根据服务器时间和当前时间, 获得评论的时间显示
 */
- (NSString *)timeStr {
    LITime *serverTime = [self serverTime];
    LITime *currentTime = [self currentTime];
    
    NSString *timeStr = nil;
    if (serverTime.year != currentTime.year) {     // 不是同一年
        timeStr = [NSString stringWithFormat:@"%zd-%zd-%zd %zd:%zd", serverTime.year, serverTime.month, serverTime.day, serverTime.hour, serverTime.minute];
    } else if (serverTime.month != currentTime.month) {     // 同一年, 月份不同
        timeStr = [NSString stringWithFormat:@"%zd-%zd %zd:%zd", serverTime.month, serverTime.day, serverTime.hour, serverTime.minute];
    } else if (serverTime.day != currentTime.day) {     // 同年同月, 天数不同
        if (currentTime.day - serverTime.day >= 3) {
            timeStr = [NSString stringWithFormat:@"%zd-%zd %zd:%zd", serverTime.month, serverTime.day, serverTime.hour, serverTime.minute];
        } else if (currentTime.day - serverTime.day == 2) {
            timeStr = [NSString stringWithFormat:@"前天 %zd:%zd", serverTime.hour, serverTime.minute];
        } else if (currentTime.day - serverTime.day == 1) {
            timeStr = [NSString stringWithFormat:@"昨天 %zd:%zd", serverTime.hour, serverTime.minute];
        }
    } else if (serverTime.hour != currentTime.hour) {   // 同年同月同一天, 小时不同
        // 时间间隔大于1小时, 显示时间  判断时间间隔大于1小时
        NSInteger currentHour   = currentTime.hour;
        NSInteger serverHour    = serverTime.hour;
        NSInteger currentMinute = currentTime.minute;
        NSInteger serverMinute  = serverTime.minute;
        
        if (currentHour - serverHour == 1 && currentMinute < serverMinute) {      // 1小时之内, 要显示多少分钟以前
            timeStr = [NSString stringWithFormat:@"%zd分钟前", currentMinute + 60 - serverMinute];
        } else {
            timeStr = [NSString stringWithFormat:@"今天 %zd:%zd", serverTime.hour, serverTime.minute];
        }
    } else if (serverTime.minute != currentTime.minute) {    // 同年同月同一天, 小时相同, 分钟不同
        NSInteger currentMinute = currentTime.minute;
        NSInteger serverMinute  = serverTime.minute;
        timeStr = [NSString stringWithFormat:@"%zd分钟前", currentMinute - serverMinute];
    } else {
        timeStr =  @"刚刚";
    }
    return timeStr;
    
}
@end
