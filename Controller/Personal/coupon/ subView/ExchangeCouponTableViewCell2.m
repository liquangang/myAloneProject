//
//  ExchangeCouponTableViewCell2.m
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ExchangeCouponTableViewCell2.h"

@implementation ExchangeCouponTableViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.exchangeButton setImage:[UIImage imageNamed:@"exchangeImage"]
                         forState:UIControlStateSelected];
    [self.exchangeButton setImage:[UIImage imageNamed:@"noExchangeImage"]
                         forState:UIControlStateNormal];
}

- (IBAction)exchangeButtonAction:(id)sender{
    self.exchangeBlock((UIButton *)sender);
}
- (IBAction)getCouponButtonAction:(id)sender{
    self.showGetStyleblock();
}

/**
 *  获得cell
 */
+ (instancetype)ExchangeCouponTableViewCell2WithTable:(UITableView *)tableView
                                            CanUseNum:(NSInteger)canUseNum
                                              MissNum:(NSInteger)missNum
                                       CouponTypeName:(NSString *)couponTypeName
                                          ResuableStr:(NSString *)resuableStr{
    ExchangeCouponTableViewCell2 * cell = [tableView dequeueReusableCellWithIdentifier:resuableStr];
    
    if (!cell) {
        cell = XIBCELL(@"ExchangeCouponTableViewCell2")
    }

    NSString *missText = (missNum == 0 || couponTypeName.length == 0) ? @"选择需要兑换的奖品" : [NSString stringWithFormat:@"还差%ld%@就可以兑换！", (long)(missNum == 0 ? 0 : missNum), couponTypeName.length == 0 ? @"" : couponTypeName];
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:missText];
    if (missText.length > 11) {
        NSString *missNumStr = [NSString stringWithFormat:@"%ld", (long)missNum];
        NSRange redRange = [missText rangeOfString:missNumStr];
        [attriStr addAttribute:NSForegroundColorAttributeName
                         value:ISRedColor
                         range:redRange];
        cell.missNumPropmtLabel.attributedText = attriStr;
    }else{
        cell.missNumPropmtLabel.text = missText;
    }
    
    cell.canUseNumLabel.text = canUseNum == 0 ? 0 : [NSString stringWithFormat:@"%ld", (long)canUseNum];
    cell.couponTypeLabel.text = canUseNum == 0 ? @"没有可以使用的券" : [NSString stringWithFormat:@"可使用%@数量：", couponTypeName];
    
    if (missNum == 0 && canUseNum != 0 && ![missText isEqualToString:@"选择需要兑换的奖品"]) {
        cell.exchangeButton.selected = YES;
    }else{
        cell.exchangeButton.selected = NO;
    }
    return cell;
}


@end
