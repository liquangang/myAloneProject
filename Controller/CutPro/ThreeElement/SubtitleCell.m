//
//  SuttitleCell.m
//  M-Cut
//
//  Created by Crab00 on 15/8/19.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "SubtitleCell.h"

@implementation SubtitleCell

- (void)awakeFromNib{
    [super awakeFromNib];
}

#pragma mark - interface

- (IBAction)EditSubtitle:(id)sender{
    self.editButtonBlock();
}

/**
 *  获得cell
 */
+ (instancetype)SubtitleCellWithTable:(UITableView *)tableView ResuableStr:(NSString *)resuableStr ModelInfo:(MovierDCInterfaceSvc_vpVDCSubtitleC *)subtitleInfo{
    SubtitleCell *cell = [tableView dequeueReusableCellWithIdentifier:resuableStr];
    cell.FirstT.text = subtitleInfo.szRecommend;
    return cell;
}
@end
