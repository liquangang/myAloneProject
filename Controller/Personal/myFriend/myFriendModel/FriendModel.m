//
//  FriendModel.m
//  M-Cut
//
//  Created by apple on 16/7/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "FriendModel.h"
#import "UserEntity.h"
#import "VideoDBOperation.h"


@implementation FriendModel
+ (FriendModel *)getFriendModelWithResult:(FMResultSet *)result{
    FriendModel * friendModel = [FriendModel new];
    friendModel.userId = [result stringForColumn:FRIENDUSERID];
    friendModel.iconURL = [result stringForColumn:FRIENDHEADURL];
    friendModel.nickName = [result stringForColumn:FRIENDNICKNAME];
    friendModel.videoNum = [result stringForColumn:FRIENDVIDEONUM];
    friendModel.videoCollectTimes = [result stringForColumn:FRIENDVIDEOCOLLECTTIMES];
    friendModel.signature = [result stringForColumn:FRIENDSIGNATURE];
    friendModel.friendType = [result stringForColumn:FRIENDTYPE];
    friendModel.toUserId = [result stringForColumn:FRIENDWITHWHO];
    return friendModel;
}

+ (FriendModel *)getFriendModelWithFriendInfo:(MovierDCInterfaceSvc_VDCFriendInfo *)friendInfo FriendType:(NSString *)friendType{
    FriendModel * friendModel = [FriendModel new];
    friendModel.userId = [friendInfo.nCustomerID stringValue];
    friendModel.iconURL = friendInfo.szAvatar;
    friendModel.nickName = friendInfo.szNickName;
    friendModel.videoNum = [friendInfo.nVideoAmount stringValue];
    friendModel.videoCollectTimes = [friendInfo.nCollectAmount stringValue];
    friendModel.signature = friendInfo.szSignature;
    friendModel.friendType = friendType;
    friendModel.toUserId = CURRENTUSERID;
    return friendModel;
}

+ (FriendModel *)getFriendModelWithFriendInfo:(MovierDCInterfaceSvc_VDCFriendInfo *)friendInfo{
    FriendModel * friendModel = [FriendModel new];
    friendModel.userId = [friendInfo.nCustomerID stringValue];
    friendModel.iconURL = friendInfo.szAvatar;
    friendModel.nickName = friendInfo.szNickName;
    friendModel.videoNum = [friendInfo.nVideoAmount stringValue];
    friendModel.videoCollectTimes = [friendInfo.nCollectAmount stringValue];
    friendModel.signature = friendInfo.szSignature;
    friendModel.friendType = [friendInfo.nFriendFlag stringValue];
    friendModel.toUserId = CURRENTUSERID;
    return friendModel;
}
@end