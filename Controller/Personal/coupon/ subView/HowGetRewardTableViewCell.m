

//
//  HowGetRewardTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HowGetRewardTableViewCell.h"

@implementation HowGetRewardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)HowGetRewardTableViewCellWithTable:(UITableView *)table
                                       ResuableStr:(NSString *)resuableStr{
    HowGetRewardTableViewCell * cell = [table dequeueReusableCellWithIdentifier:resuableStr];
    if (!cell) {
        cell = XIBCELL(@"HowGetRewardTableViewCell")
    }
    return cell;
}

@end
