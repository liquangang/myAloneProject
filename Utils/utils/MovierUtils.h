//
//  MovierUtils.h
//  M-Cut
//
//  Created by Crab00 on 15/7/30.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovierUtils : NSObject
+ (NSString *)stringFromDate:(NSDate *)date;
+(NSString*)stringFromDateaa:(NSDate*)date;
+(UIImage *)getImageFromImage:(UIImage *)in scale:(float)tosize;
+(UIImage *)getSquareImage:(UIImage *)in;
+(NSString*)GetCurrntNet;

+(void)videoWithUrl:(NSURL *)url withFileName:(NSString *)fileName;
@end
