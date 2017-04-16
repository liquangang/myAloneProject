//
//  TrangleTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TrangleTableViewCell.h"

@implementation TrangleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (id)TrangleTableViewCellWithTable:(UITableView *)tableView
                        ResuableStr:(NSString *)resuableStr{
    TrangleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:resuableStr];
    if (!cell) {
        cell = XIBCELL(@"TrangleTableViewCell")
    }
    return cell;
}

@end
