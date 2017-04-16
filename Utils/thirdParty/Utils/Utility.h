//
//  Utility.h
//  图看
//
//  Created by 严明俊 on 14/10/30.
//  Copyright (c) 2014年 严明俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

typedef enum
{
    LayoutStyleThumbnail = 1,
    LayoutStyleList = 2,
}LayoutStyle;


typedef enum
{
    SearchTypeUser,
    SearchTypeMark,
    SearchTypeGood
}SearchType;


@interface Utility : NSObject

+ (NSUInteger)DeviceSystemMajorVersion;

+ (UIFont *)microsoftYaHeiWithSize:(CGFloat)size;

+ (void)setExtraCellLineHidden: (UITableView *)tableView;
@end
