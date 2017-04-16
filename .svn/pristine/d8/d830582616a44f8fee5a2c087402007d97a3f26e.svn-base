




//
//  VideoPlayerTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoPlayerTableViewCell.h"

static NSString * VideoPlayerTableViewCellId = @"VideoPlayerTableViewCell";

@implementation VideoPlayerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _playView.videoURL = [NSURL
                          URLWithString:@"http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/Template/Samples/Style/A001.mp4"];
    _playView.playerLayerGravity = ZFPlayerLayerGravityResizeAspect;
    _playView.hasDownload = NO;
    _playView.controlView.backBtn.hidden = YES;
    _playView.isLocked = YES;
    ZFPlayerShared.isLockScreen = YES;
    _playView.isPorPrait = YES;
    [_playView autoPlayTheVideo];
}

+ (id)getVideoPlayerTableViewCellWithTable:(UITableView *)cellSuperTable{
    VideoPlayerTableViewCell * cell = [cellSuperTable
                                       dequeueReusableCellWithIdentifier:VideoPlayerTableViewCellId];
    if (!cell) {
        cell = XIBCELL(VideoPlayerTableViewCellId)
    }
    return cell;
}

@end
