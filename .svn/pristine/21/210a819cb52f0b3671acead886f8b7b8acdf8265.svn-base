//
//  VideoInformationObject.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/3/27.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovierDCInterfaceSvc.h"

@interface VideoInformationObject : NSObject
@property (strong,nonatomic) NSString *videoID;                 //视频ID
@property (strong,nonatomic) NSString *videoName;               //视频名
@property (strong,nonatomic) NSString *ownerID;                 //拥有者ID
@property (strong,nonatomic) NSString *ownerName;               //拥有者名字
@property (strong,nonatomic) NSString *ownerAcatar;             //拥有者头像
@property (strong,nonatomic) NSString *videoLabelName;          //视频Label名
@property (strong,nonatomic) NSString *videoCreateTime;         //视频制作时间
@property (strong,nonatomic) NSString *videoThumbnailUrl;       //视频缩略图url
@property (strong,nonatomic) NSString *videoReferenceUrl;       //视频url
@property (strong,nonatomic) NSString *videoSignature;          //视频签名
@property (strong,nonatomic) NSString *videoNumberOfPraise;     //视频点赞数
@property (strong,nonatomic) NSString *videoNumberOfShare;      //视频分享数
@property (strong,nonatomic) NSString *videoNumberOfFavorite;   //视频收藏数
@property (strong,nonatomic) NSString *videoNumberOfComment;    //视频评论数
@property (strong,nonatomic) NSString *videoCollectStatus;      //视频收藏状态
@property (strong,nonatomic) NSString *videoShare;              //视频公开状态

#pragma mark ----- 新增视频播放状态、次数
@property (copy, nonatomic) NSString *videoPlayCount;   // 视频的播放次数


@property (assign, nonatomic) BOOL hasRead;//是否看过了

@property (nonatomic) int videoLabelsPtr;
@property (nonatomic) int videoLabelsSize;


+ (VideoInformationObject *)setAssignment:(MovierDCInterfaceSvc_VDCVideoInfoEx *)videoInfoEx;
@end
