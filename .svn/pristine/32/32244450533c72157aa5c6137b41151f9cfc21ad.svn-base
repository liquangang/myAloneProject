//
//  Utility.m
//  图看
//
//  Created by 严明俊 on 14/10/30.
//  Copyright (c) 2014年 严明俊. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSUInteger)DeviceSystemMajorVersion
{
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] integerValue];
    });
    return _deviceSystemMajorVersion;
}

+ (UIFont *)microsoftYaHeiWithSize:(CGFloat)size
{
    UIFont *font = [UIFont fontWithName:@"MicrosoftYaHei" size:size];
    return font;
}

+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

@end
