//
//  Video.m
//  M-Cut
//
//  Created by zhangxiaotian on 15/2/5.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "Video.h"
#import "ISConst.h"


@implementation Video

+ (Video *)Singleton;
{
    static Video *sharedSingleton;

    @synchronized(self)
    {
        if (!sharedSingleton)
            sharedSingleton = [[Video alloc] init];
        return sharedSingleton;
    }
}


-(void)setContent:(VideoInformationObject*)info
{
    [Video Singleton].videoID = info.videoID;
    [Video Singleton].videoName = info.videoName;
    [Video Singleton].ownerID = info.ownerID;
    [Video Singleton].ownerName = info.ownerName;
    [Video Singleton].ownerAcatar = info.ownerAcatar;
    [Video Singleton].videoLabelName = info.videoLabelName;
    [Video Singleton].videoCreateTime = info.videoCreateTime;
    [Video Singleton].videoThumbnailUrl = info.videoThumbnailUrl;
    [Video Singleton].videoReferenceUrl = info.videoReferenceUrl;
    [Video Singleton].videoNumberOfPraise = info.videoNumberOfPraise;
    [Video Singleton].videoNumberOfShare = info.videoNumberOfShare;
    [Video Singleton].videoNumberOfFavorite = info.videoNumberOfFavorite;
    [Video Singleton].videoCollectStatus = info.videoCollectStatus;
    [Video Singleton].videoSignature = info.videoSignature;
    [Video Singleton].videoPlayCount = info.videoPlayCount;
}

-(void)setWSContent:(MovierDCInterfaceSvc_VDCVideoInfoEx*)info
{
    [Video Singleton].videoID = [NSString stringWithFormat:@"%@",info.nVideoID];
    [Video Singleton].videoName = info.szVideoName;
    [Video Singleton].ownerID = [NSString stringWithFormat:@"%@",info.nOwnerID];
    [Video Singleton].ownerName = info.szOwnerName;
    [Video Singleton].ownerAcatar = info.szAcatar;
    [Video Singleton].videoLabelName = info.szVideoLabel;
    [Video Singleton].videoCreateTime = info.szCreateTime;
    [Video Singleton].videoThumbnailUrl = STRTOUTF8(info.szThumbnail);
    [Video Singleton].videoReferenceUrl = STRTOUTF8(info.szReference);
    [Video Singleton].videoNumberOfPraise = [NSString stringWithFormat:@"%@",info.nPraise];
    [Video Singleton].videoNumberOfShare = [NSString stringWithFormat:@"%@",info.nShareNum];
    [Video Singleton].videoNumberOfFavorite = [NSString stringWithFormat:@"%@",info.nFavoritesNum];
    [Video Singleton].videoCollectStatus = [NSString stringWithFormat:@"%@",info.nVideoShare];
    [Video Singleton].videoSignature = [NSString stringWithFormat:@"%@",info.szSignature];
    [Video Singleton].videoPlayCount = [NSString stringWithFormat:@"%@",info.nVisitCount];
    return;
}

/** 根据video对象的属性设置video单例的属性*/
- (void)setVideoWithVideoInfo:(NSMutableDictionary *)videoInfo{
    [Video Singleton].videoID = [videoInfo objectForKey:@"video_id"];
    [Video Singleton].videoName = [videoInfo objectForKey:@"video_name"];
    [Video Singleton].ownerID = [videoInfo objectForKey:@"video_owner"];
    [Video Singleton].ownerName = [videoInfo objectForKey:@"customer_nickname"];
    [Video Singleton].ownerAcatar = [videoInfo objectForKey:@"customer_avatar"];
    [Video Singleton].videoLabelName = [videoInfo objectForKey:@""];
    [Video Singleton].videoCreateTime = [videoInfo objectForKey:@"video_createtime"];
    [Video Singleton].videoThumbnailUrl = STRTOUTF8([videoInfo objectForKey:@"video_thumbnail"]);
    [Video Singleton].videoReferenceUrl = STRTOUTF8([videoInfo objectForKey:@"video_reference"]);
    [Video Singleton].videoNumberOfPraise = [videoInfo objectForKey:@"video_praise"];
    [Video Singleton].videoNumberOfShare = [videoInfo objectForKey:@"video_sharenum"];
    [Video Singleton].videoNumberOfFavorite = [videoInfo objectForKey:@"video_favoritesnum"];
    [Video Singleton].videoCollectStatus =  [videoInfo objectForKey:@""];
    [Video Singleton].videoShare = [videoInfo objectForKey:@"video_share"];}
@end
