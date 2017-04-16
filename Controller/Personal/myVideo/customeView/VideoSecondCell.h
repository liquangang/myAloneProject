//
//  VideoSecondCell.h
//  M-Cut
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"
#import "ISConst.h"

@interface VideoSecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoOwerName;
@property (weak, nonatomic) IBOutlet UIImageView *videoOwerHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *videoPraiseNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoCommentsNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoPropmtImage;
@property (weak, nonatomic) IBOutlet UIButton *videoPlayButton;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UIButton *publishButton;


@property (nonatomic, copy) void(^publishButtonAction)();

/** 获得复用cell*/
+ (id)getVideoSecondCellWithtable:(UITableView *)myTable VideoInfo:(MovierDCInterfaceSvc_VDCVideoInfoEx *)videoInfo;

/** 获得收藏的复用cell*/
+ (id)getCollectSecondCellWithTable:(UITableView *)myTable VideoInfo:(MovierDCInterfaceSvc_VDCVideoInfoEx *)videoInfo;
@end