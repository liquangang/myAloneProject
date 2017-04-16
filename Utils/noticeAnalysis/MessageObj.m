
//
//  MessageObj.m
//  M-Cut
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MessageObj.h"
#import "VideoDBOperation.h"
#import "PrivateMesObj.h"
#import "ISConst.h"
#import "UserEntity.h"

@implementation MessageObj

/** 插入数据*/
+ (void)addOneMesToTabWith:(NSDictionary *)mesJson{
    MessageObj * mesObj = [MessageObj new];
    mesObj.dstcontent = [mesJson objectForKey:DSTCONTENT];
    mesObj.dstcontentid = [mesJson objectForKey:DSTCONTENTID];
    mesObj.dstcustomerid = [mesJson objectForKey:DSTCUSTOMERID];
    mesObj.linklabelid = [mesJson objectForKey:LINKLABELID];
    mesObj.linktype = [mesJson objectForKey:LINKTYPE];
    mesObj.linkurl = [mesJson objectForKey:LINKURL];
    mesObj.srcavatar = [mesJson objectForKey:SRCAVATAR];
    mesObj.srccontent = [mesJson objectForKey:SRCCONTENT];
    mesObj.srccontentid = [mesJson objectForKey:SRCCONTENTID];
    mesObj.srccustomerid = [mesJson objectForKey:SRCCUSTOMERID];
    mesObj.srcnickname = [mesJson objectForKey:SRCNICKNAME];
    mesObj.term = [mesJson objectForKey:TERM];
    mesObj.time = [mesJson objectForKey:TIME];
    mesObj.videoid = [mesJson objectForKey:MESVIDEOID];
    mesObj.videolabelid = [mesJson objectForKey:VIDEOLABELID];
    mesObj.videolabelname = [mesJson objectForKey:MESVIDEOLABELNAME];
    mesObj.videoname = [mesJson objectForKey:MESVIDEONAME];
    mesObj.videothumbnail = [mesJson objectForKey:VIDEOTHUMBNAIL];
    mesObj.videourl = [mesJson objectForKey:MESVIDEOURL];
    mesObj.isRead = @"0";
    
    //如果是私信消息，发送通知告诉私信界面刷新界面，先存储到数据库，然后return
    if ([mesObj.term isEqualToString:FRIENDMESSAGETERM]) {
        [PrivateMesObj receiveMesAndSave:mesObj];
        return;
    }
    
    [[VideoDBOperation Singleton] addMesWithObj:mesObj];
}

/** 插入新影片生成的数据*/
+ (void)addNewVideoWithObj:(VideoInformationObject *)videoInfo{
    MessageObj * mesObj = [MessageObj new];
    mesObj.dstcustomerid = videoInfo.ownerID;
    mesObj.videoname = videoInfo.videoName;
    mesObj.isRead = @"0";
    mesObj.videoid = videoInfo.videoID;
    mesObj.videolabelname = videoInfo.videoLabelName;
    mesObj.time = videoInfo.videoCreateTime;
    mesObj.videothumbnail = videoInfo.videoThumbnailUrl;
    mesObj.videourl = videoInfo.videoReferenceUrl;
    mesObj.term = NEWVIDEOTERM;
    [self judgeNewVideoNewsAndSaveWith:mesObj];
}

/**
 *  先判断是否存在这条新影片消息，如果不存在就保存这条消息
 */
+ (void)judgeNewVideoNewsAndSaveWith:(MessageObj *)mesObj{
    //新影片插入有重复，判断如果表中已经存在就不运行下面的代码，如果没有插入，就插入并且提示用户已经生成新的影片
    if (![[VideoDBOperation Singleton] selectOneNewVideoBornMesWithVideoId:mesObj.videoid]) {
        //如果存在就不需要进行其他操作，不存在就继续运行
        [[VideoDBOperation Singleton] addMesWithObj:mesObj];
    }
}

/**
 *  当用户删除还没有收到消息的新影片时，执行该方法, 保存一条假数据（防止用户删除新影片后，收到推送消息，消息提示无法消失的问题）（当用户删除影片时执行这个操作）
 */
+ (void)saveUserDeleteNewVideoWithVideoID:(NSString *)videoId
                          VideoLabelName:(NSString *)videoLabelName
                              CreateTime:(NSString *)createTime
                            VideoThumail:(NSString *)videoThumailURL
                                VideoURL:(NSString *)videoURL{
    MessageObj * mesObj = [MessageObj new];
    mesObj.dstcustomerid = CURRENTUSERID;
    mesObj.videoname = @"已删除的新影片";
    mesObj.isRead = @"1";
    mesObj.videoid = videoId;
    mesObj.videolabelname = videoLabelName;
    mesObj.time = createTime;
    mesObj.videothumbnail = videoThumailURL;
    mesObj.videourl = videoURL;
    mesObj.term = NEWVIDEOTERM;
    [self judgeNewVideoNewsAndSaveWith:mesObj];
}

//返回具有属性值的消息对象
+ (MessageObj *)getMesObjWithDBData:(FMResultSet *)dataResult{
    MessageObj * mesObj = [MessageObj new];
    mesObj.dstcontent = [dataResult stringForColumn:DSTCONTENT];
    mesObj.dstcontentid = [dataResult stringForColumn:DSTCONTENTID];
    mesObj.dstcustomerid = [dataResult stringForColumn:DSTCUSTOMERID];
    mesObj.linklabelid = [dataResult stringForColumn:LINKLABELID];
    mesObj.linktype = [dataResult stringForColumn:LINKTYPE];
    mesObj.linkurl = [dataResult stringForColumn:LINKURL];
    mesObj.srcavatar = [dataResult stringForColumn:SRCAVATAR];
    mesObj.srccontent = [dataResult stringForColumn:SRCCONTENT];
    mesObj.srccontentid = [dataResult stringForColumn:SRCCONTENTID];
    mesObj.srccustomerid = [dataResult stringForColumn:SRCCUSTOMERID];
    mesObj.srcnickname = [dataResult stringForColumn:SRCNICKNAME];
    mesObj.term = [dataResult stringForColumn:TERM];
    mesObj.time = [dataResult stringForColumn:TIME];
    mesObj.videoid = [dataResult stringForColumn:MESVIDEOID];
    mesObj.videolabelid = [dataResult stringForColumn:VIDEOLABELID];
    mesObj.videolabelname = [dataResult stringForColumn:MESVIDEOLABELNAME];
    mesObj.videoname = [dataResult stringForColumn:MESVIDEONAME];
    mesObj.videothumbnail = [dataResult stringForColumn:VIDEOTHUMBNAIL];
    mesObj.videourl = [dataResult stringForColumn:MESVIDEOURL];
    mesObj.isRead = [dataResult stringForColumn:ISREAD];
    return mesObj;
}
@end
