//
//  VideoPlayerTableViewCell.h
//  M-Cut
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZFPlayerView.h"

@interface VideoPlayerTableViewCell : UITableViewCell
/** 播放界面*/
@property (weak, nonatomic) IBOutlet ZFPlayerView *playView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playViewWidth;

/** 获得复用cell*/
+ (id)getVideoPlayerTableViewCellWithTable:(UITableView *)cellSuperTable;
@end
