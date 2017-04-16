//
//  ExchangeCouponTableViewCell2.h
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeCouponTableViewCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *canUseNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *exchangeButton;
@property (weak, nonatomic) IBOutlet UILabel *missNumPropmtLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponTypeLabel;


/**
 *  获得cell
 */
+ (instancetype)ExchangeCouponTableViewCell2WithTable:(UITableView *)tableView
                                            CanUseNum:(NSInteger)canUseNum
                                              MissNum:(NSInteger)missNum
                                       CouponTypeName:(NSString *)couponTypeName
                                          ResuableStr:(NSString *)resuableStr;

/**
 *  展示获取方式
 */
@property (nonatomic, copy) void(^showGetStyleblock)();

/**
 *  兑换按钮block
 */
@property (nonatomic, copy) void(^exchangeBlock)(UIButton *exchangeButton);

@end
