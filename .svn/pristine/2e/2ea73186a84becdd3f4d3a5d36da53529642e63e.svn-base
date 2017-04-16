//
//  VideoInformationObject.m
//  M-Cut
//
//  Created by zhangxiaotian on 15/3/27.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "VideoInformationObject.h"

@implementation VideoInformationObject

+ (VideoInformationObject *)setAssignment:(MovierDCInterfaceSvc_VDCVideoInfoEx *)videoInfoEx
{
    VideoInformationObject * videoInfo = [[VideoInformationObject alloc] init];
    videoInfo.videoID = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoID];
    videoInfo.videoName = videoInfoEx.szVideoName;
    videoInfo.ownerID = [NSString stringWithFormat:@"%@", videoInfoEx.nOwnerID];
    videoInfo.ownerName = videoInfoEx.szOwnerName;
    videoInfo.ownerAcatar = videoInfoEx.szAcatar;
    videoInfo.videoLabelName = videoInfoEx.szVideoLabel;
    videoInfo.videoCreateTime = videoInfoEx.szCreateTime;
    videoInfo.videoThumbnailUrl = [videoInfoEx.szThumbnail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    videoInfo.videoReferenceUrl = [videoInfoEx.szReference stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    videoInfo.videoSignature = videoInfoEx.szSignature;
    videoInfo.videoNumberOfPraise = [NSString stringWithFormat:@"%@", videoInfoEx.nPraise];
    videoInfo.videoNumberOfShare = [NSString stringWithFormat:@"%@", videoInfoEx.nShareNum];
    videoInfo.videoNumberOfFavorite = [NSString stringWithFormat:@"%@", videoInfoEx.nFavoritesNum];
    videoInfo.videoNumberOfComment = [NSString stringWithFormat:@"%@", videoInfoEx.nCommentsNum];
    videoInfo.videoCollectStatus = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoStatus];
    videoInfo.videoShare = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoShare];
    videoInfo.videoPlayCount = [NSString stringWithFormat:@"%@", videoInfoEx.nVisitCount];
    return videoInfo;
}
@end
