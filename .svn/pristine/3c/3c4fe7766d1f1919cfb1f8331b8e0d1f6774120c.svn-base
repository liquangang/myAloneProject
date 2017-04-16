//
//  NoticeSetCell.m
//  M-Cut
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "NoticeSetCell.h"
#import "NoticeSetViewController.h"

@implementation NoticeSetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/** 根据传入数据设置cell内容*/
- (void)setCellWithObj:(setObj *)setObject{
    self.noticeTypelabel.text = setObject.setName;
    [self.setSwitch setOn:setObject.onOrOff];
}

static NSString * noticeSetCellId = @"NoticeSetCell";

+ (id)getNoticeSetCellWithTable:(UITableView *)myTable SetObj:(setObj *)setObj{
    NoticeSetCell * cell = [myTable dequeueReusableCellWithIdentifier:noticeSetCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:noticeSetCellId owner:nil options:nil] lastObject];
    }
    [cell setCellWithObj:setObj];
    return cell;
}
@end
