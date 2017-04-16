//
//  CircleQueryLocOrder.m
//  M-Cut
//
//  Created by zhangxiaotian on 15/5/25.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "CircleQueryLocOrder.h"

@implementation CircleQueryLocOrderList

@synthesize querylist;
static CircleQueryLocOrderList *Singleton;
+ (CircleQueryLocOrderList *)Singleton
{
    @synchronized(self)
    {
        if (!Singleton)
            Singleton = [[CircleQueryLocOrderList alloc] init];
        return Singleton;
    }
}

-(id) init
{
    self = [super init];
    self.querylist = [[NSMutableArray alloc] initWithCapacity:10];
    
    return self;
}

@end


@implementation QueryLocOrderDetail

@synthesize createTime,order_id,order_st,customer;

-(id)init
{
    self=[super init];
    return self;
}

@end