//
//  CustomAlertView.h
//  M-Cut
//
//  Created by apple on 16/12/15.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

/**
 *  底部button的点击block
 */
@property (nonatomic, copy) void(^touchBottomButtonBlock)(NSInteger index);

/**
 *  初始化方法
 */
/**
 *@brief    初始化方法
 *@param    title           顶部的标题
 *@param    buttonLabelTitleArray 底部的button
 *@param    width   宽
 *@param    height  高
 */
- (instancetype)initWithTitle:(NSString *)title ButtonTitleArray:(NSArray *)buttonLabelTitleArray Width:(CGFloat)width Height:(CGFloat)height;

/**
 *  添加自定义view
 */
- (void)addCustomeView:(UIView *)customeView;

@end
