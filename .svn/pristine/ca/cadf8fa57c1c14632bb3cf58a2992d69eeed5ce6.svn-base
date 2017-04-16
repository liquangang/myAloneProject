//
//  UIAlertView+Extension.h
//  ICloudSpace
//
//  Created by 李亚飞 on 15/10/7.
//  用于新建文件夹时显示在界面上的提示框
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Extension)
/** 
 *  需要使用内部的 textField
 *  新建文件夹的提示框, 需要对按钮事件进行监听
 */
+ (UIAlertView *)alertViewTitle:(NSString *)title message:(NSString *)msg delegate:(id)delegate cancleButton:(NSString *)cancle confirmButton:(NSString *)confirm isNeedsInput:(BOOL)isNeed;

/**
 *  用户没有选中任何文件时进行的操作
 */
+ (void)alertViewShowForEmptyChoose;

/**
 *  弹出提示框, 不需要监听按钮点击事件
 */
+ (void)alertViewshowMessage:(NSString *)msg cancleButton:(NSString *)cancle confirmButton:(NSString *)confirm;
@end
