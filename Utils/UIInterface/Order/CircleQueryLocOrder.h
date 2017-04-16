//
//  CircleQueryLocOrder.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/5/25.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QueryLocOrderDetail:NSObject{
    
}
@property (strong,nonatomic) NSString *createTime;//本地订单创建时间
@property (nonatomic) int order_id;//本地订单ID
@property (nonatomic) int order_st;//本地订单状态
@property (nonatomic) int customer;//本地订单作者

@end


@interface CircleQueryLocOrderList : NSObject
{
    NSMutableArray *querylist;
}


@property(retain,nonatomic) NSMutableArray *querylist;

+ (CircleQueryLocOrderList *)Singleton;
@end