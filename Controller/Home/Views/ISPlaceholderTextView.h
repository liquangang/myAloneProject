//
//  ISPlaceholderTextView.h
//
//
//  Created by MS on 15/11/23.
//  Copyright (c) 2015年 m. All rights reserved.
//  有占位文字的UITextView
//  自定义控件的属性, 要再修改后马上改变, 一定要重写setter方法, 要及时响应用户的修改

#import <UIKit/UIKit.h>

@interface ISPlaceholderTextView : UITextView
/**   占位文字  */
@property (nonatomic, copy) NSString *placeholder;
/**   占位文字颜色  */
@property (nonatomic, strong) UIColor *placeholderColor;
/**   占位文字对齐位置*/
@property (nonatomic, assign) UITextAlignment myTextAlignment;
@end
