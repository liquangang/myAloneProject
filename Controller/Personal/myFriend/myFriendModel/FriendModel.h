//
//  FriendModel.h
//  M-Cut
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISConst.h"
#import <FMDatabase.h>
#import "MovierDCInterfaceSvc.h"

@interface FriendModel : NSObject
CUSTOMEPORPERTY(userId);
CUSTOMEPORPERTY(iconURL);
CUSTOMEPORPERTY(nickName);
CUSTOMEPORPERTY(videoNum);
CUSTOMEPORPERTY(videoCollectTimes);
CUSTOMEPORPERTY(signature);
CUSTOMEPORPERTY(friendType);
CUSTOMEPORPERTY(toUserId); //关注了userId，这个人的粉丝是userid，这个人的好友是userid

/** 根据传入的数据库结果获得好友model*/
+ (FriendModel *)getFriendModelWithResult:(FMResultSet *)result;

/** 转化数据*/
+ (FriendModel *)getFriendModelWithFriendInfo:(MovierDCInterfaceSvc_VDCFriendInfo *)friendInfo FriendType:(NSString *)friendType;

/** 转化数据*/
+ (FriendModel *)getFriendModelWithFriendInfo:(MovierDCInterfaceSvc_VDCFriendInfo *)friendInfo;
@end
