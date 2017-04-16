//
//  MJFriend.h
//  02-QQ好友列表
//
//  Created by 成良云 on 15/1/11.
//  Copyright (c) 2015年 dazhuankuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJFriend : NSObject
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) NSString *intro;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL vip;

+ (instancetype)friendWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
