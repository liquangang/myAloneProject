//
//  integralRecordUserCell.m
//  M-Cut
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "integralRecordUserCell.h"
#import <UIImageView+WebCache.h>
#import "UserEntity.h"

@implementation integralRecordUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userHeadImage.layer.masksToBounds = YES;
    self.userHeadImage.layer.cornerRadius = 33;
    [self.userHeadImage sd_setImageWithURL:[NSURL URLWithString:[UserEntity sharedSingleton].szAcatar] placeholderImage:[UIImage imageNamed:@"head"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    self.userNikeNameLabel.text = [UserEntity sharedSingleton].szNickname;
}

//设置第二个label
- (void)setUserIntegralLabelWithStr:(NSString *)str{
    self.userIntegralLabel.text = str;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
