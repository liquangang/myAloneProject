//
//  MySearchCell.m
//  M-Cut
//
//  Created by admin on 16/3/10.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MySearchCell.h"

@implementation MySearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)recordButtonAction:(id)sender {
    self.recordButtonBlock(self.titleLabel.text, (UIButton *)sender);
}
@end
