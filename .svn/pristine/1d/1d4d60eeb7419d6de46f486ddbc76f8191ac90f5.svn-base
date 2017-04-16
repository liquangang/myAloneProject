//
//  PraiseCell.m
//  M-Cut
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "NoticeCell.h"
#import <UIImageView+WebCache.h>

static NSString * noticeCellId = @"NoticeCell";

@implementation NoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)pushPersonVc:(UITapGestureRecognizer *)tapGesture{
    self.pushToPersonalVc();
}

- (void)pushVideoVc:(UITapGestureRecognizer *)tapGesture{
    self.pushToVideoPlayVc();
}

- (void)setCellWithMes:(MessageObj *)mesObj{
    self.pushVideoId = mesObj.videoid;
    self.pushPersonId = mesObj.srccustomerid;
    [self.praiseUserHeadImage sd_setImageWithURL:[NSURL URLWithString:mesObj.srcavatar] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    //添加手势
    self.praiseUserHeadImage.userInteractionEnabled = YES;
    [self.praiseUserHeadImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushPersonVc:)]];
    
    self.userActionLabel.text = mesObj.term;
    self.praiseUserNameLabel.text = mesObj.srcnickname;
    self.praiseTimeLabel.text = mesObj.time;
    [self.praiseVideoImage sd_setImageWithURL:[NSURL URLWithString:STRTOUTF8(mesObj.videothumbnail)] placeholderImage:DEFAULTVIDEOTHUMAIL options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    //添加手势
    self.praiseVideoImage.userInteractionEnabled = YES;
    [self.praiseVideoImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushVideoVc:)]];
    
    self.praiseVideoNameLabel.text = [NSString stringWithFormat:@"《%@》", mesObj.videoname];
    self.praiseVideolabel.text = [NSString stringWithFormat:@"#%@#", mesObj.videolabelname];
}

+ (id)getNoticeCellWithMes:(MessageObj *)mesObj Table:(UITableView *)myTable{
    NoticeCell * cell = [myTable dequeueReusableCellWithIdentifier:noticeCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:noticeCellId owner:nil options:nil] lastObject];
    }
    [cell setCellWithMes:mesObj];
    return cell;
}

- (void)pushToVideoPlayVc:(PUSHTOVIDEOPLAYVC)pushBlock{
    self.pushToVideoPlayVc = pushBlock;
}

- (void)pushToPersonalVc:(PUSHTOPERSONALVC)pushPersonalVcBlock{
    self.pushToPersonalVc = pushPersonalVcBlock;
}

@end
