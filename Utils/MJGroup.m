//
//  MJGroup.m
//  02-QQ好友列表
//
//  Created by 成良云 on 15/1/11.
//  Copyright (c) 2015年 dazhuankuai. All rights reserved.
//

#import "MJGroup.h"
#import "MJFriend.h"
@implementation MJGroup
+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        // 1.设置基本属性
        [self setValuesForKeysWithDictionary:dict];
        
        // 2.friends字典转模型
        NSMutableArray *friendArray = [NSMutableArray array];
        for (NSDictionary *dict in self.friends) {
            MJFriend *f = [MJFriend friendWithDict:dict];
            [friendArray addObject:f];
        }
        self.friends = friendArray;
    }
    return self;
}


@end
