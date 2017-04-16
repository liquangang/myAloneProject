//
//  PrivateLoginCacheInformationObject.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/4/3.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrivateLoginCacheInformationObject : NSObject
@property (strong,nonatomic) NSString *userName;//用户名
@property (strong,nonatomic) NSString *userPassword;//用户密码
@property (strong,nonatomic) NSString *userMail;//邮箱
@property (strong,nonatomic) NSString *userMailPassword;//密码
@property (strong,nonatomic) NSString *userTel;//电话号码
@property (strong,nonatomic) NSString *userTelPassword;//密码
@property (strong,nonatomic) NSString *userStatus;//用户登录状态

@end


@interface PrivateLoginCacheInformationObjectArr : NSObject
{
    NSMutableArray *privateLoginCacheInformationObjectArr;
}
@property(retain,nonatomic) NSMutableArray *privateLoginCacheInformationObjectArr;

@end
