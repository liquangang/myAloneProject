//
//  IntegralRecordTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "IntegralRecordTableViewCell.h"

@implementation IntegralRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//设置cell的内容
- (void)setCellWithObj:(MovierDCInterfaceSvc_VDCMyScoreLog *)myScoreLog needShowImage:(BOOL)isForm{
    if (!isForm) {
        self.integralTaskNameLabel.text = myScoreLog.szScoreActionName;
        self.integralNumLabel.text = [NSString stringWithFormat:@"+%@", myScoreLog.nScore];
    }else{
        self.integralImage.image = [UIImage imageNamed:@"映币icon"];
        self.integralTaskNameLabel.text = myScoreLog.szScoreActionName;
        self.integralNumLabel.text = [NSString stringWithFormat:@"+%@", myScoreLog.nInshianCoin];
    }
}

@end
