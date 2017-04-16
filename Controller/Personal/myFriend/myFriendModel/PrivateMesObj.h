//
//  PrivateMesObj.h
//  M-Cut
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISConst.h"
#import <FMDB.h>
#import "MessageObj.h"
#import "MovierDCInterfaceSvc.h"
#import "FriendModel.h"

@interface PrivateMesObj : NSObject
CUSTOMEPORPERTY(mesStartId);
CUSTOMEPORPERTY(mesEndId);
CUSTOMEPORPERTY(startUserNickName);
CUSTOMEPORPERTY(readStatus);
CUSTOMEPORPERTY(mesContent);
CUSTOMEPORPERTY(startUserIconUrl);
CUSTOMEPORPERTY(time);

/** 数据库查找数据时使用*/
+ (PrivateMesObj *)getPrivateMesObjWithDBResult:(FMResultSet *)result;

/** 接收到私信消息保存到数据库中*/
+ (void)receiveMesAndSave:(MessageObj *)mesObj;

/** 保存当前登录用户的消息到数据库中并返回保存的对象*/
+ (PrivateMesObj *)saveCurrentLoginUserChatContent:(FriendModel *)friendInfo Content:(NSString *)contentStr;
@end
