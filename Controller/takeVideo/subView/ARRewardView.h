//
//  ARRewardView.h
//  M-Cut
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARRewardView : UIView
//各种券按钮
@property (weak, nonatomic) IBOutlet UIImageView *couponImage;
//虚拟电器按钮
@property (weak, nonatomic) IBOutlet UIImageView *virtualElectricImage;
//宝箱按钮
@property (weak, nonatomic) IBOutlet UIImageView *chestImage;
//提示框按钮
@property (weak, nonatomic) IBOutlet UIImageView *propmtImage;
//ar元素
@property (weak, nonatomic) IBOutlet UIImageView *arPropertyImage;


/**
 *  点击优惠券block
 */
@property (nonatomic, copy) void(^couponBlock)();

/**
 *  点击虚拟电器block
 */
@property (nonatomic, copy) void(^virtualElectricBlock)();

/**
 *  ar元素block
 */
@property (nonatomic, copy) void(^arPropertyBlock)();

/**
 *  宝箱操作block
 */
@property (nonatomic, copy) void(^chestBlock)();

/**
 *  提示操作block
 */
@property (nonatomic, copy) void(^propmtBlock)();

//- (void)addTap;

@end
