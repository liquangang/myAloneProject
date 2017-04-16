//
//  ARRewardView.m
//  M-Cut
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ARRewardView.h"

@interface ARRewardView()
@end

@implementation ARRewardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibView =  [[NSBundle mainBundle] loadNibNamed:@"ARRewardView"owner:self options:nil];
        UIView *backView = [nibView objectAtIndex:0];
        backView.frame = frame;
        [self addSubview:backView];
        [self addTap];
    }
    return self;
}

- (void)addTap{
    //添加手势
    ADDTAPGESTURE(self.arPropertyImage, arPropertyImageTap)
    ADDTAPGESTURE(self.couponImage, couponImageTap)
    ADDTAPGESTURE(self.propmtImage, propmtImageTap)
    ADDTAPGESTURE(self.chestImage, chestImageTap)
    ADDTAPGESTURE(self.virtualElectricImage, virtualElectricImageTap)
}

/**
 *  点击优惠券操作
 */
- (void)couponImageTap:(UITapGestureRecognizer *)tap{
    self.couponBlock();
}

/**
 *  虚拟电器按钮操作
 */
- (void)virtualElectricImageTap:(UITapGestureRecognizer *)tap{
    self.virtualElectricBlock();
}

/**
 *  宝箱操作
 */
- (void)chestImageTap:(UITapGestureRecognizer *)tap{
    self.chestBlock();
}

/**
 *  提示按钮操作
 */
- (void)propmtImageTap:(UITapGestureRecognizer *)tap{
    self.propmtBlock();
}

/**
 *  ar元素点击事件
 */
- (void)arPropertyImageTap:(UITapGestureRecognizer *)tap{
    self.arPropertyBlock();
}

@end
