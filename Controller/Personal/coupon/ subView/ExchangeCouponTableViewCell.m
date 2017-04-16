//
//  ExchangeCouponTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ExchangeCouponTableViewCell.h"

@interface ExchangeCouponTableViewCell()
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation ExchangeCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.selectButton setImage:[UIImage imageNamed:@"tickUnSelectedImage"]
                       forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"tickSelectedImage"]
                       forState:UIControlStateSelected];
}

/**
 *  选中按钮的方法
 */
- (IBAction)selectButtonAction:(id)sender {
    self.selectButton.selected = !self.selectButton.selected;
    self.selectButtonBlock(self.indexPath, (UIButton *)sender);
}

/**
 *  获得cell
 */
+ (instancetype)ExchangeCouponTableViewCellWithTable:(UITableView *)tableView
                                            CellInfo:(NSDictionary *)cellInfo
                                           IndexPath:(NSIndexPath *)indexPath
                                         ResuableStr:(NSString *)resuableStr{
    ExchangeCouponTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:resuableStr];
    if (!cell) {
        cell = XIBCELL(@"ExchangeCouponTableViewCell")
    }
    /*
     Printing description of ((__NSDictionaryM *)0x0000000174646cf0):
     {
     awardid = 9;
     desc = "";
     expendamount = 10;
     expireddate = "2016-12-12";
     name = "50\U5143";
     type = 1; 1-分享券 2-邀请券
     }
     */
    cell.selectButton.selected = NO;
    cell.indexPath = indexPath;
    NSInteger type = [cellInfo[@"type"] integerValue];
    NSString *typeName = type == 1 ? @"分享券" : @"邀请券";
    cell.exchangeNumLabel.text = [NSString stringWithFormat:@"￥%@", cellInfo[@"name"]];
    cell.exchangeNumLabel2.text = [NSString stringWithFormat:@"%@%@兑换", cellInfo[@"expendamount"], typeName];
    cell.canUseTimeLabel.text = [NSString stringWithFormat:@"有效期至%@", cellInfo[@"expireddate"]];
    if ([cellInfo[@"expendamount"] integerValue] < 10) {
        cell.couponBackImage.image = [UIImage imageNamed:@"greenCoupon"];
        cell.exchangeNumLabel2.textColor = UIColorFromRGB(0x74b37c);
    }else if ([cellInfo[@"expendamount"] integerValue] < 100){
        cell.couponBackImage.image = [UIImage imageNamed:@"blueCoupon"];
        cell.exchangeNumLabel2.textColor = UIColorFromRGB(0x4eafd9);
    }else if ([cellInfo[@"expendamount"] integerValue] >= 100){
        cell.couponBackImage.image = [UIImage imageNamed:@"redCoupon"];
        cell.exchangeNumLabel2.textColor = ISRedColor;
    }
    return cell;
}



@end
