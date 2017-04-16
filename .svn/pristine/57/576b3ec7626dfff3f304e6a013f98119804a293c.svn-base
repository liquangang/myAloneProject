//
//  DefaultTableViewCell.m
//  M-Cut
//
//  Created by liquangang on 16/9/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "DefaultTableViewCell.h"

static NSString * const cellReusableId = @"DefaultTableViewCell";

@implementation DefaultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (id)DefaultTableViewCellWithTable:(UITableView *)cellTable Title:(NSString *)title{
    DefaultTableViewCell * cell = [cellTable dequeueReusableCellWithIdentifier:cellReusableId];
    if (!cell) {
        cell = XIBCELL(cellReusableId)
    }
    cell.defaultLabel.text = title;
    return cell;
}
@end
