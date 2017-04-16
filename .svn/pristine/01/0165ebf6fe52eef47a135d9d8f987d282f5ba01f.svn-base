//
//  CareCell.m
//  M-Cut
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CareCell.h"
#import "MessageObj.h"
#import <UIImageView+WebCache.h>

static NSString * careCellId = @"CareCell";

@implementation CareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)pushPersonVC:(UITapGestureRecognizer *)tap{
    self.pushTopersonalVcBlock();
}

- (void)pushtoPersonalVc:(COMMENTPUSHPERSONALVC)pushBlock{
    self.pushTopersonalVcBlock = pushBlock;
}

- (void)setCareCellWithMesObj:(MessageObj *)mesObj{
    [self.careUserHeadImage sd_setImageWithURL:[NSURL URLWithString:mesObj.srcavatar] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    ADDTAPGESTURE(self.careUserHeadImage, pushPersonVC);
    self.careUserNIckNameLabel.text = mesObj.srcnickname;
    self.caretimeLabel.text = mesObj.time;
    self.pushPersonId = mesObj.srccustomerid;
}

+ (id)getCareCellWithTable:(UITableView *)myTable MessageObj:(MessageObj *)mesObj{
    CareCell * cell = [myTable dequeueReusableCellWithIdentifier:careCellId];
    if (!cell) {
        cell = XIBCELL(careCellId);
    }
    [cell setCareCellWithMesObj:mesObj];
    return cell;
}

@end
