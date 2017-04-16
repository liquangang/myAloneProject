//
//  VideoCell.h
//  M-Cut
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"

@interface VideoCell : UITableViewCell
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


/*
@interface MovierDCInterfaceSvc_VDCVideoInfoEx : NSObject {
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
}
*/
/** 获得复用cell*/
+ (id)getVideoCellWithTable:(UITableView *)myTable VideoInfo:(NSMutableDictionary *)videoInfo;

/** 获得收藏cell*/
+ (id)getCollectVideoCellWithTable:(UITableView *)myTable VideoInfo:(MovierDCInterfaceSvc_VDCVideoInfoEx *)videoInfo;
@end
