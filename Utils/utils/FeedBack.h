//
//  FeedBack.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/2/3.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedBack : NSObject
@property (nonatomic) unsigned short _nContactType;
@property (strong,nonatomic) NSString *_szContact;
@property (strong,nonatomic) NSString *_szContent;

@end
