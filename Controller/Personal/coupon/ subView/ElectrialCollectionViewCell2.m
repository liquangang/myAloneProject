//
//  ElectrialCollectionViewCell2.m
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ElectrialCollectionViewCell2.h"

@implementation ElectrialCollectionViewCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)ElectrialCollectionViewCell2WithCollectionView:(UICollectionView *)superCollectionView
                                                   ResuableStr:(NSString *)resuableStr
                                                         Index:(NSIndexPath *)index
                                                      CellInfo:(NSDictionary *)cellInfoDic{
    ElectrialCollectionViewCell2 * cell = [superCollectionView dequeueReusableCellWithReuseIdentifier:resuableStr
                                                                                         forIndexPath:index];
    /*
     Printing description of ((__NSDictionaryM *)0x00000001744588a0):
     {
     amount = 0;
     awardid = 6;
     cardid = 1;
     index = 0;
     url = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/HomePageVideo/rotate_coupon.gif";
     }
     */
    cell.electrialNumLabel.text = cellInfoDic[@"amount"];
    if ([cellInfoDic[@"amount"] integerValue] > 0) {
        cell.electrialMachine.hidden = NO;
    }else{
        cell.electrialMachine.hidden = YES;
    }
    return cell;
}

@end
