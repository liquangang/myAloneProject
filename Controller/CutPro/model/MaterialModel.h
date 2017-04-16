//
//  MaterialModel.h
//  M-Cut
//
//  Created by apple on 16/10/11.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RewardType){
    //代金券
    voucher,
    //虚拟电器
    virtualElectric,
    //虚拟卡牌
    virtualCard
};

@interface MaterialModel : NSObject
//oss链接
@property (nonatomic, copy) NSString * materialUrl;
//素材的序号
@property (nonatomic, assign) NSInteger materialIndex;
//奖品类型
@property (nonatomic, assign) RewardType rewardType;
//奖品id
@property (nonatomic, copy) NSString * rewardLogId;
@end
