//
//  TelephoneViewController.h
//  M-Cut
//
//  Created by 彰笑天 on 14/12/30.
//  Copyright (c) 2014年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierTabBarViewController.h"

@interface TelephoneViewController : UIViewController
{
    IBOutlet UITextField *tfTelephone;
    IBOutlet UITextField *tfPassword;
    IBOutlet UITextField *tfVertifyCode;
    
    NSTimer* _timer1;
    NSTimer* _timer2;
    NSTimer* _timer3;
    UIAlertView* _alert1;
    UIAlertView* _alert2;
    UIAlertView* _alert3;
    
    UInt64 times;
    UInt64 timee;
    NSInteger smslefttime;
}

@property (nonatomic,strong) UITextField *tfTelephone;
@property (nonatomic,strong) UITextField *tfPassword;
@property (nonatomic,strong) UITextField *tfVertifyCode;
@property(nonatomic,strong)  UILabel* timeLabel;
@property (retain,nonatomic) IBOutlet UIView *imViewUp;
/**  获取验证码按钮*/
@property (weak, nonatomic) IBOutlet UIButton *SMS_button;
/**  注册按钮或者完成按钮*/
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

- (IBAction)getVertifyCode:(id)sender;
- (IBAction)registers:(id)sender;
-(void)sms_count;

@end
