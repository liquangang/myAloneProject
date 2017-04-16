//
//  CouponTableViewCell.h
//  M-Cut
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *exchangeNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *canUseTime;
@property (weak, nonatomic) IBOutlet UIButton *composeButton;


/**
 *  获得cell
 */
+ (instancetype)CouponTableViewCellWithTable:(UITableView *)superTable
                                 ResubaleStr:(NSString *)resubaleStr;
@end
