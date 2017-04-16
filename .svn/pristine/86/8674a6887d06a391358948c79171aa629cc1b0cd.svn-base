

//
//  UploadCell.m
//  M-Cut
//
//  Created by apple on 16/7/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "UploadCell.h"

static NSString * uploadCellId = @"UploadCell";

@implementation UploadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (id)getUploadCellWithTable:(UITableView *)myTable VideoInfo:(NewNSOrderDetail *)orderDetail{
    UploadCell * cell = [myTable dequeueReusableCellWithIdentifier:uploadCellId];
    if (!cell) {
        cell = XIBCELL(uploadCellId);
    }
    cell.videoNameLabel.text = orderDetail.szVideoName;
    return cell;
}

@end
