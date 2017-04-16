//
//  InshowNoticeCell.m
//  M-Cut
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "InshowNoticeCell.h"
#import "MessageObj.h"

static NSString * inshowNotcieCellId = @"InshowNoticeCell";

@implementation InshowNoticeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithMesOBj:(MessageObj *)mesObj{
    self.systemNoticeTimeLabel.text = mesObj.time;
    self.systemNoticeContentTextView.text = mesObj.srccontent;
}

+ (id)getInshowNoticeCellWithTable:(UITableView *)myTable MessageObj:(MessageObj *)mesObj{
    InshowNoticeCell * cell = [myTable dequeueReusableCellWithIdentifier:inshowNotcieCellId];
    if (!cell) {
        cell = XIBCELL(inshowNotcieCellId);
    }
    [cell setCellWithMesOBj:mesObj];
    return cell;
}

@end
