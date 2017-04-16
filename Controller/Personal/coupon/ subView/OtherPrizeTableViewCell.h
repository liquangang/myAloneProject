//
//  OtherPrizeTableViewCell.h
//  M-Cut
//
//  Created by apple on 16/10/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ExchangeType){
    exchangeCoupon,
    exchangeInvitation
};

@interface OtherPrizeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shareCouponNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareCouponCanUseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *invitedCouponNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *invitedCouponCanUseTimeLabel;

//兑换点击操作
@property (nonatomic, copy) void(^exchangeBlock)(ExchangeType exchangeType, NSInteger shareNum, NSInteger invitedNum);

/**
 *  获得cell
 */
+ (instancetype)OtherPrizeTableViewCellWithTable:(UITableView *)superTable
                                     ResuableStr:(NSString *)resuableStr;
@end
