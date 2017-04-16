//
//  AuditCell.m
//  M-Cut
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AuditCell.h"

static NSString * AuditCellId = @"AuditCell";

@implementation AuditCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (id)getAuditCellWithTable:(UITableView *)myTable VideoInfo:(NewNSOrderDetail *)orderDetail{
    AuditCell * cell = [myTable dequeueReusableCellWithIdentifier:AuditCellId];
    if (!cell) {
        cell = XIBCELL(AuditCellId);
    }
    cell.videoNameLabel.text = orderDetail.szVideoName;
    return cell;
}

@end
