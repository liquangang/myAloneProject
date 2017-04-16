//
//  PrivateMesObj.m
//  M-Cut
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "PrivateMesObj.h"
#import "VideoDBOperation.h"
#import "CustomeClass.h"
#import "UserEntity.h"

//时间格式2016-07-21 20:12:41
#define TIMEFORMAT               @"YYYY-MM-dd hh:mm:ss"

@implementation PrivateMesObj
+ (PrivateMesObj *)getPrivateMesObjWithDBResult:(FMResultSet *)result{
    PrivateMesObj * priMesObj = [PrivateMesObj new];
    priMesObj.mesStartId = [result stringForColumn:FRIENDMESSTARTUSER];
    priMesObj.mesEndId = [result stringForColumn:FRIENDMESENDUSERID];
    priMesObj.startUserNickName = [result stringForColumn:FRIENDSTARTUSERNICKNAME];
    priMesObj.readStatus = [result stringForColumn:FRIENDMESREADSTATUS];
    priMesObj.mesContent = [result stringForColumn:FRIENDMESCONTENT];
    priMesObj.startUserIconUrl = [result stringForColumn:FRIENDHEADIMAGEURL];
    priMesObj.time = [result stringForColumn:FRIENDMESSTARTTIME];
    return priMesObj;
}

+ (void)receiveMesAndSave:(MessageObj *)mesObj{
    //存储到数据库
    [[VideoDBOperation Singleton] addMesWithMesObj:mesObj];
    
    //通知私信界面刷新数据
    POSTNOTI(PRIVATEMESNOTI, nil);
}

+ (PrivateMesObj *)saveCurrentLoginUserChatContent:(FriendModel *)friendInfo Content:(NSString *)contentStr{
    PrivateMesObj * privateMesObj = [PrivateMesObj new];
    privateMesObj.mesStartId = CURRENTUSERID;
    privateMesObj.mesEndId = friendInfo.userId;
    privateMesObj.startUserNickName = CURRENTUSERNICKNAME;
    privateMesObj.readStatus = @"1";
    privateMesObj.mesContent = contentStr;
    privateMesObj.startUserIconUrl = CURRENTUSERICONURL;
    privateMesObj.time = [CustomeClass getCurrentTimeWithFormatter:TIMEFORMAT];
    
    [[VideoDBOperation Singleton] addMesWithPrivateMesObj:privateMesObj];
    
    return privateMesObj;
}
@end
