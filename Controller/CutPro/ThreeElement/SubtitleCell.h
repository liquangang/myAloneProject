//
//  SuttitleCell.h
//  M-Cut
//
//  Created by Crab00 on 15/8/19.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"

@interface SubtitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *FirstT;
@property (weak, nonatomic) IBOutlet UIImageView *seleImageView;

/**
 *  编辑block
 */
@property (nonatomic, copy) void(^editButtonBlock)();

/**
 *  获得cell
 */
+ (instancetype)SubtitleCellWithTable:(UITableView *)tableView ResuableStr:(NSString *)resuableStr ModelInfo:(MovierDCInterfaceSvc_vpVDCSubtitleC *)subtitleInfo;
@end
