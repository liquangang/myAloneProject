//
//  ISCutProCell.h
//  M-Cut
//
//  Created by 李亚飞 on 15/11/24.
//  Copyright © 2015年 Crab movier. All rights reserved.
//  制作 cell

#import <UIKit/UIKit.h>
#import "HTKDraggableCollectionViewCell.h"
@class ISCutProCell;

@protocol ISCutProCellDelegate <NSObject>

@optional
- (void)cutproCell:(ISCutProCell *)cutproCell deleteClick:(UIButton *)button;
@end

@interface ISCutProCell : HTKDraggableCollectionViewCell
/**  删除代理 */
@property (weak, nonatomic) id<ISCutProCellDelegate> delegate;

/**  设置对应位置的图片 */
- (void)setContent:(UIImage *)image  atIndex:(NSInteger)index totalCount:(NSInteger)count materialPath:(NSString *)materialUrl;

/**
 *  根据arid设置奖品图片的显示隐藏
 */
- (void)setRewardImageWithArray:(NSArray *)takeVideoArray;

/**
 *  根据arid设置奖品图片的显示隐藏
 */
- (void)setCouponImageWithArid:(NSString *)arId;
@end