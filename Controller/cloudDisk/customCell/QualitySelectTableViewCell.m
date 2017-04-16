




//
//  QualitySelectTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/12/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "QualitySelectTableViewCell.h"

@implementation QualitySelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.selectedBackgroundView.backgroundColor = ColorFromRGB(0x2E2E3A, 1.0);
}

@end
