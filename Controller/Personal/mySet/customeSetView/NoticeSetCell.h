//
//  NoticeSetCell.h
//  M-Cut
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
@class setObj;

@interface NoticeSetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *noticeTypelabel;
@property (weak, nonatomic) IBOutlet UISwitch *setSwitch;

/** 生成复用的NoticeSetCell*/
+ (id)getNoticeSetCellWithTable:(UITableView *)myTable SetObj:(setObj *)setObj;
@end
