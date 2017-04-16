//
//  MJGroup.h
//  02-QQ好友列表
//
//  Created by 成良云 on 15/1/11.
//  Copyright (c) 2015年 dazhuankuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJGroup : NSObject
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) int online;
@property (strong, nonatomic) NSArray *friends;
// 是否打开
@property (assign, nonatomic) BOOL open;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
