//
//  UILabel+LabelHeightAndWidth.h
//  M-Cut
//
//  Created by apple on 16/10/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
    分类：只能扩充方法（可以用runtime扩充属性）不能添加属性（拓展可以添加属性）虽然Category不能够为类添加新的成员变量，但是Category包含类的所有成员变量，即使是@private的。Category可以重新定义新方法，也可以override继承过来的方法。
    拓展：属性方法都可以添加
 */

@interface UILabel (LabelHeightAndWidth)
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont*)font;

+ (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font;
@end
