//
//  MessageObj.h
//  M-Cut
//
//  Created by apple on 16/7/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISConst.h"
#import "FMDB.h"
@class VideoInformationObject;

@interface MessageObj : NSObject
/** 被评论内容的内容体*/
CUSTOMEPORPERTY(dstcontent)
/** 被评论内容的id，即a回复b的评论，此处是b的评论内容id*/
CUSTOMEPORPERTY(dstcontentid)
/** 收到消息的用户id，即被评论、被回复、被点赞等的那个用户id*/
CUSTOMEPORPERTY(dstcustomerid)
/** 系统消息的视频labelid*/
CUSTOMEPORPERTY(linklabelid)
/** 链接类型，根据它来判断使用linkurl或者linklabelid获取系统消息内容*/
CUSTOMEPORPERTY(linktype)
/** 系统消息的链接url*/
CUSTOMEPORPERTY(linkurl)
/** 点赞、评论、回复的那个用户的头像url*/
CUSTOMEPORPERTY(srcavatar)
/** 点赞、评论、回复等的内容体*/
CUSTOMEPORPERTY(srccontent)
/** 点赞、评论、回复等内容的id*/
CUSTOMEPORPERTY(srccontentid)
/** 点赞、评论、回复的那个用户的id*/
CUSTOMEPORPERTY(srccustomerid)
/** 点赞、评论、回复的那个用户的昵称*/
CUSTOMEPORPERTY(srcnickname)
/** 术语，用来判断是什么类型的消息*/
CUSTOMEPORPERTY(term)
/** 点赞、评论、回复产生的那个时间*/
CUSTOMEPORPERTY(time)
/** 被点赞、评论、回复的那个影片的videoid*/
CUSTOMEPORPERTY(videoid)
/** 被点赞、评论、回复的那个影片的话题id*/
CUSTOMEPORPERTY(videolabelid)
/** 被点赞、评论、回复的那个影片的话题name*/
CUSTOMEPORPERTY(videolabelname)
/** 被点赞、评论、回复的那个影片的videoname*/
CUSTOMEPORPERTY(videoname)
/** 被点赞、评论、回复的那个影片的videothumbnail*/
CUSTOMEPORPERTY(videothumbnail)
/** 被点赞、评论、回复的那个影片的url*/
CUSTOMEPORPERTY(videourl)
/** 这条消息有没有被读过（1为读过，0未读过）*/
CUSTOMEPORPERTY(isRead)

/** 插入数据*/
+ (void)addOneMesToTabWith:(NSDictionary *)mesJson;
/** 返回具有属性值的消息对象*/
+ (MessageObj *)getMesObjWithDBData:(FMResultSet *)dataResult;
/** 插入新影片生成的数据*/
+ (void)addNewVideoWithObj:(VideoInformationObject *)videoInfo;

/**
 *  当用户删除还没有收到消息的新影片时，执行该方法, 保存一条假数据（防止用户删除新影片后，收到推送消息，消息提示无法消失的问题）（当用户删除影片时执行这个操作）
 *  注意videoID一定要填对
 */
+ (void)saveUserDeleteNewVideoWithVideoID:(NSString *)videoId
                           VideoLabelName:(NSString *)videoLabelName
                               CreateTime:(NSString *)createTime
                             VideoThumail:(NSString *)videoThumailURL
                                 VideoURL:(NSString *)videoURL;
@end
