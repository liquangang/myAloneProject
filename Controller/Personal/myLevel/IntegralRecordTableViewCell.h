//
//  IntegralRecordTableViewCell.h
//  M-Cut
//
//  Created by apple on 16/6/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"

@interface IntegralRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *integralImage;
@property (weak, nonatomic) IBOutlet UILabel *integralTaskNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *integralNumLabel;
/** 设置cell的内容*/
- (void)setCellWithObj:(MovierDCInterfaceSvc_VDCMyScoreLog *)myScoreLog needShowImage:(BOOL)isForm;
@end
