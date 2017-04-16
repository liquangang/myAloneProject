//
//  LabelsView.h
//  M-Cut
//
//  Created by apple on 16/12/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelsView : UIView

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

/**
 *  根据array设置label
 */
- (instancetype)initWithWidth:(CGFloat)width LabelTitleArray:(NSArray *)labelTitleArray;

/**
 *  设置frame(必须调用该方法设置frame)
 */
- (void)setFrameWithPoint:(CGPoint(^)(CGSize mySize))pointBlock;

/**
 *  点击方法
 */
@property (nonatomic, copy) void(^touchLabelBlock)(NSInteger Index);

@end
