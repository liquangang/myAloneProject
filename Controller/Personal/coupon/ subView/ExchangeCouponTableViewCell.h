//
//  ExchangeCouponTableViewCell.h
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeCouponTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *exchangeNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *exchangeNumLabel2;
@property (weak, nonatomic) IBOutlet UILabel *canUseTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *couponBackImage;


/**
 *  获得cell
 */
+ (instancetype)ExchangeCouponTableViewCellWithTable:(UITableView *)tableView
                                            CellInfo:(NSDictionary *)cellInfo
                                           IndexPath:(NSIndexPath *)indexPath
                                         ResuableStr:(NSString *)resuableStr;

/**
 *  选中block
 */
@property (nonatomic, copy) void(^selectButtonBlock)(NSIndexPath *indexPath, UIButton *selectButton);
@end
