//
//  VideoCell.m
//  M-Cut
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoCell.h"
#import <UIImageView+WebCache.h>
#import "ISConst.h"
#import "UserEntity.h"
#import "VideoDBOperation.h"

static NSString * videoCellId = @"VideoCell";

@implementation VideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithVideoInfo:(NSMutableDictionary *)videoInfo{
    
    /*
     影片信息对象
     MovierDCInterfaceSvc_VDCKeyValueArr
     
     MovierDCInterfaceSvc_VDCKeyValue
     
     po serverDataMuArray[0]
     "customer_avatar" = "http://movier-vdctest.oss-cn-beijing.aliyuncs.com/movier/sysres/9846.jpg";
     "customer_nickname" = "\U6d4b\U8bd5003";
     location = "";
     "video_commentsnum" = 8;
     "video_createtime" = "2016-05-07 15:31:27";
     "video_desc" = "";
     "video_favoritesnum" = 0;
     "video_id" = 15984;
     "video_name" = "\U8ba8\U538c\U7684\U9633\U5149";
     "video_owner" = 9846;
     "video_praise" = 17;
     "video_reference" = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier-users/9846de9e3122c83cf00a8b2e70/\U7cfb\U7edf\U6587\U4ef6\U5939/order-generate/2016-5-7/1462606287576.mp4";
     "video_sharenum" = 0;
     "video_thumbnail" = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier-users/9846de9e3122c83cf00a8b2e70/\U7cfb\U7edf\U6587\U4ef6\U5939/order-generate/2016-5-7/1462606287576.jpg";
     visitcount = 2682;
     */
    
    //更新每个已经生成的影片的订单状态，如果在本地有这个订单信息的话
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[VideoDBOperation Singleton] updateOrderStatusWithOrderId:[videoInfo objectForKey:@"order_id"]];
    });
    WEAKSELF2
    self.commentNumLabel.text = [videoInfo objectForKey:@"video_commentsnum"];
    self.collectNumlabel.text = [videoInfo objectForKey:@"video_favoritesnum"];
    self.videoPraiseLabel.text = [videoInfo objectForKey:@"video_praise"];
    self.videoNameLabel.text = [videoInfo objectForKey:@"video_name"];
    [self.videoThumailImage sd_setImageWithURL:[NSURL URLWithString:STRTOUTF8([videoInfo objectForKey:@"video_thumbnail"])] placeholderImage:DEFAULTVIDEOTHUMAIL options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    self.videoLookTimesLabel.text = [videoInfo objectForKey:@"visitcount"];
    self.videoBornTimeLabel.text = [videoInfo objectForKey:@"video_createtime"];
    self.videoMasterNameLabel.text = [videoInfo objectForKey:@"customer_nickname"];
    [self.videoMasterImage sd_setImageWithURL:[NSURL URLWithString:[videoInfo objectForKey:@"customer_avatar"]] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    if (![[videoInfo objectForKey:@"video_owner"] isEqualToString:CURRENTUSERID]) {
        self.videoPropmtImage.hidden = YES;
    }else{
        //根据数据库检索结果展示是否是新影片
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            //数据库检索
            NSString * readStatus = [[VideoDBOperation Singleton] getNewVideoReadStatus:[NSString stringWithFormat:@"%@", [videoInfo objectForKey:@"video_id"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([readStatus isEqualToString:@"已观看"] || [readStatus isEqualToString:@"表中没有该影片"]) {
                    //已观看
                    weakSelf.videoPropmtImage.hidden = YES;
                }else{
                    //未观看
                    weakSelf.videoPropmtImage.hidden = NO;
                }
                
            });
        });
        
    }
}

//展示影片专用
+ (id)getVideoCellWithTable:(UITableView *)myTable VideoInfo:(NSMutableDictionary *)videoInfo{
    VideoCell * cell = [myTable dequeueReusableCellWithIdentifier:videoCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:videoCellId owner:nil options:nil] lastObject];
    }
    [cell setCellWithVideoInfo:videoInfo];
    return cell;
}

//展示收藏专用
/*
 MovierDCInterfaceSvc_VDCVideoInfoEx
 NSNumber * nVideoID;
	NSString * szVideoName;
	NSNumber * nOwnerID;
	NSString * szOwnerName;
	NSString * szAcatar;
	NSString * szVideoLabel;
	NSString * szCreateTime;
	NSString * szThumbnail;
	NSString * szReference;
	NSString * szSignature;
	NSNumber * nPraise;
	NSNumber * nShareNum;
	NSNumber * nFavoritesNum;
	NSNumber * nCommentsNum;
	NSNumber * nVideoStatus;
	NSNumber * nVideoShare;
	NSNumber * nVisitCount;
	MovierDCInterfaceSvc_VDCLabelForVideo * stLabels;
 
 @property (weak, nonatomic) IBOutlet UIImageView *videoPropmtImage;
 @property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
 @property (weak, nonatomic) IBOutlet UILabel *collectNumlabel;
 @property (weak, nonatomic) IBOutlet UILabel *videoPraiseLabel;
 @property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
 @property (weak, nonatomic) IBOutlet UIButton *videoPlayButton;
 @property (weak, nonatomic) IBOutlet UIImageView *videoThumailImage;
 @property (weak, nonatomic) IBOutlet UILabel *videoLookTimesLabel;
 @property (weak, nonatomic) IBOutlet UILabel *videoBornTimeLabel;
 @property (weak, nonatomic) IBOutlet UILabel *videoMasterNameLabel;
 @property (weak, nonatomic) IBOutlet UIImageView *videoMasterImage;
 */
+ (id)getCollectVideoCellWithTable:(UITableView *)myTable VideoInfo:(MovierDCInterfaceSvc_VDCVideoInfoEx *)videoInfo{
    VideoCell * cell = [myTable dequeueReusableCellWithIdentifier:videoCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:videoCellId owner:nil options:nil] lastObject];
    }
    [cell setCollectCellWithInfo:videoInfo];
    return cell;
}

- (void)setCollectCellWithInfo:(MovierDCInterfaceSvc_VDCVideoInfoEx *)videoInfo{
    self.videoPropmtImage.hidden = YES;
    self.commentNumLabel.text = [NSString stringWithFormat:@"%@", videoInfo.nCommentsNum];
    self.collectNumlabel.text = [NSString stringWithFormat:@"%@", videoInfo.nFavoritesNum];
    self.videoPraiseLabel.text = [NSString stringWithFormat:@"%@", videoInfo.nPraise];
    self.videoNameLabel.text = videoInfo.szVideoName;
    [self.videoThumailImage sd_setImageWithURL:[NSURL URLWithString:STRTOUTF8(videoInfo.szThumbnail)] placeholderImage:DEFAULTVIDEOTHUMAIL options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    self.videoLookTimesLabel.text = [NSString stringWithFormat:@"%@", videoInfo.nVisitCount];
    self.videoBornTimeLabel.text = [NSString stringWithFormat:@"%@", videoInfo.szCreateTime];
    self.videoMasterNameLabel.text = videoInfo.szOwnerName;
    [self.videoMasterImage sd_setImageWithURL:[NSURL URLWithString:videoInfo.szAcatar] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
}

@end
