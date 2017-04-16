//
//  UIAlertView+Extension.m
//  ICloudSpace
//
//  Created by 李亚飞 on 15/10/7.
//
// 

#import "UIAlertView+Extension.h"

@implementation UIAlertView (Extension)
+ (UIAlertView *)alertViewTitle:(NSString *)title message:(NSString *)msg delegate:(id)delegate cancleButton:(NSString *)cancle confirmButton:(NSString *)confirm isNeedsInput:(BOOL)isNeed{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:delegate cancelButtonTitle:cancle otherButtonTitles:confirm, nil];
    
    if (isNeed == YES) {
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        UITextField *textField = [alertView textFieldAtIndex:0];
        
        [textField becomeFirstResponder];
        
        textField.placeholder = title;
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }
    
    [alertView show];
    
    return alertView;
}

/**
 *  用户没有选中任何文件时进行的操作
 */
+ (void)alertViewShowForEmptyChoose {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您没有选中任何文件" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
    [alertView show];
}

+ (void)alertViewshowMessage:(NSString *)msg cancleButton:(NSString *)cancle confirmButton:(NSString *)confirm {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:cancle otherButtonTitles:confirm, nil];
    [alertView show];
}
@end
