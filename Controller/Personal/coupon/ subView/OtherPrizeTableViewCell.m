//
//  OtherPrizeTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/10/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "OtherPrizeTableViewCell.h"
#import "CustomeClass.h"
#import "SoapOperation.h"

@interface OtherPrizeTableViewCell()
//分享券数量
@property (nonatomic, assign) NSInteger shareCouponNum;
//邀请券数量
@property (nonatomic, assign) NSInteger invitedCouponNum;
@end

@implementation OtherPrizeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 *  兑换分享券
 */
- (IBAction)exchangeButtonAction:(id)sender {
    self.exchangeBlock(exchangeCoupon, self.shareCouponNum, self.invitedCouponNum);
}

/**
 *  兑换邀请券
 */
- (IBAction)exchangeButton2Action:(id)sender {
    self.exchangeBlock(exchangeInvitation, self.shareCouponNum, self.invitedCouponNum);
}

/**
 *  获得cell
 */
+ (instancetype)OtherPrizeTableViewCellWithTable:(UITableView *)superTable
                                     ResuableStr:(NSString *)resuableStr
{
    OtherPrizeTableViewCell * cell = [superTable dequeueReusableCellWithIdentifier:resuableStr];
    if (!cell) {
        cell = XIBCELL(@"OtherPrizeTableViewCell")
    }
    [cell getCouponNum];
    return cell;
}

/**
 *  当前用户的分享券等的数量
 */
- (void)getCouponNum{
    WEAKSELF2
    [[SoapOperation Singleton] getNumOfCouponWithSuccess:^(NSMutableDictionary *serverDataDictionary) {
        /*
         Printing description of serverDataDictionary:
         {
         expireddate = "2016-12-12";
         invitetokencount = 0;
         sharetokencount = 0;
         }
         */
        weakSelf.shareCouponNum = [serverDataDictionary[@"sharetokencount"] integerValue];
        weakSelf.invitedCouponNum = [serverDataDictionary[@"invitetokencount"] integerValue];
        [CustomeClass mainQueue:^{
            weakSelf.shareCouponNumLabel.text = [NSString stringWithFormat:@"%ld张", (long)weakSelf.shareCouponNum];
            weakSelf.invitedCouponNumLabel.text = [NSString stringWithFormat:@"%ld张", (long)weakSelf.invitedCouponNum];
            weakSelf.shareCouponCanUseTimeLabel.text = [NSString stringWithFormat:@"有效期至%@", serverDataDictionary[@"expireddate"]];
            weakSelf.invitedCouponCanUseTimeLabel.text = [NSString stringWithFormat:@"有效期至%@", serverDataDictionary[@"expireddate"]];
        }];
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf getCouponNum];);
    }];
}

@end
