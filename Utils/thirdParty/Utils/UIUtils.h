//
//  UIUtils.h
//  M-Cut
//
//  Created by 刘海香 on 15/1/21.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject

// date 格式化为 string
+ (NSString*) stringFromFomate:(NSDate*)date formate:(NSString*)formate;
// string 格式化为 date
+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate;

+ (NSString *)fomateString:(NSString *)datestring;


//+(NSString *)subText:(NSString *)srcStr;

//+(NSString *)parseTextLink:(NSString *)text;

@end