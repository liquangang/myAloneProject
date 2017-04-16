//
//  TelephoneBindingViewController.m
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TelephoneBindingViewController.h"
#import "ValidateFuc.h"
#import "SoapOperation.h"
#import "TelephoneViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "AlreadyBindingTelephoneViewController.h"

@interface TelephoneBindingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfTelephone;
@property (weak, nonatomic) IBOutlet UIButton *SMS_button;
@property (weak, nonatomic) IBOutlet UITextField *tfVertifyCode;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (nonatomic, assign) NSInteger smslefttime;
@property (nonatomic, strong) NSTimer * timer1;
@end

@implementation TelephoneBindingViewController

- (void)dealloc{
    DEBUGSUCCESSLOG(@"dealloc")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

#pragma mark - initUI
- (void)initUI{
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    //标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"更绑手机";
    if (self.formWhere == formPerfectPersonInfoVc) {
        label.text = @"绑定手机";
        NAVIGATIONBARRIGHTBARBUTTONITEM(@"跳过")
    }else if (self.formWhere == formAccountAndSafeVc){
        label.text = @"绑定手机";
    }
    label.font = ISFont_17;
    label.textColor = [UIColor whiteColor];
    CGSize labelSize = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.titleView = label;
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

#pragma mark - 返回按钮点击方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 右侧按钮点击方法*/
- (void)rightBarButtonItemAction:(UIBarButtonItem *)barButtonItem{
    HIDDENLOGINANDREGISTERWINDOWNOTI
}

- (IBAction)getVerifyCode:(id)sender {
    [self.view endEditing:YES];
    if(![ValidateFuc validateMobile:(_tfTelephone.text)]){
        //之前判断号码是否准确的正则表达式
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示:", nil)
                                                      message:[NSString stringWithFormat:@"%@号码格式错误",_tfTelephone.text]
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                            otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    _smslefttime = 60;
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sms_count) userInfo:nil repeats:YES];
    [_SMS_button setEnabled:FALSE];
    //                            [_SMS_button setTitle:[NSString stringWithFormat:@"剩余时间(%02ld)",(long)smslefttime] forState:UIControlStateDisabled];
    [[SoapOperation Singleton] WS_CheckTelphone:_tfTelephone.text Success:^(NSNumber *ret,NSNumber *count) {
        
        if ([ret isEqualToNumber:@(20)]==YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示:", nil)
                                                              message:[NSString stringWithFormat:@"%@号码已经注册,请直接登录!",_tfTelephone.text]
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                    otherButtonTitles:nil, nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert show];
                });
                _smslefttime = -1;
                return;
            });
        }else{//手机号存在
            
//            if ([count compare:@(3)]==NSOrderedDescending){
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示:", nil)
//                                                                  message:[NSString stringWithFormat:@"%@号码24小时内仅允许请求三次",_tfTelephone.text]
//                                                                 delegate:self
//                                                        cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                        otherButtonTitles:nil, nil];
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [alert show];
//                    });
//                    _smslefttime = -1;
//                    return ;
//                });
//            }
            
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:_tfTelephone.text zone:@"86" customIdentifier:nil result:^(NSError *error)
             {
                 if (!error){
                     NSLog(@"block 获取验证码成功");
                 }
                 else{
                     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                                     message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"getVerificationCode"]]
                                                                    delegate:self
                                                           cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                           otherButtonTitles:nil, nil];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [alert show];
                     });
                 }
                 }];
            }
        } Fail:^(NSError *error) {
        }];
}

-(void)sms_count{
    _smslefttime--;
    if (_smslefttime>0) {
        [_SMS_button setTitle:[NSString stringWithFormat:@"剩余%02ld秒",(long)_smslefttime] forState:UIControlStateDisabled];
    }else{
        [_SMS_button setTitle:@"发送验证码" forState:UIControlStateDisabled];
        [_SMS_button setEnabled:YES];
        [_timer1 invalidate];
    }
}

- (IBAction)finishUpdateTelnum:(id)sender {
    [self.view endEditing:YES];
    WEAKSELF2
    if(_tfVertifyCode.text.length!=4)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil)
                                                      message:NSLocalizedString(@"验证码格式不正确。", nil)
                                                     delegate:self
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [SMSSDK commitVerificationCode:_tfVertifyCode.text phoneNumber:_tfTelephone.text zone:@"86" result:^(NSError *error) {
            
            if (!error)
            {
//                NSString* str=[NSString stringWithFormat:NSLocalizedString(@"验证成功", nil)];
//                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"验证成功", nil)
//                                                              message:str
//                                                             delegate:self
//                                                    cancelButtonTitle:NSLocalizedString(@"确定", nil)
//                                                    otherButtonTitles:nil, nil];
                
//                [[SoapOperation Singleton] WS_UpdateTelNumEx:_tfTelephone.text andPassword:_passwordTextField.text andSuccess:^(NSNumber *num) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        
//                        if (self.formWhere == formPerfectPersonInfoVc) {
//                            HIDDENLOGINANDREGISTERWINDOWNOTI
//                            [CustomeClass showMessage:@"手机绑定成功" ShowTime:1.5];
//                        }else{
//                            [self.navigationController popViewControllerAnimated:YES];
//                            [CustomeClass showMessage:@"手机更绑成功" ShowTime:1.5];
//                        }
//                    });
//                } andFail:^(NSError *error) {
//                     NSLog(@"更改电话号码失败--------%@", error);
//                }];
                [weakSelf bindingthirtPartyWithAccountStr:weakSelf.tfTelephone.text
                                                 Password:weakSelf.passwordTextField.text];
            }
        }];
    }

}

/** 绑定三方账户*/
- (void)bindingthirtPartyWithAccountStr:(NSString *)accountStr
                               Password:(NSString *)passwordStr
{
    WEAKSELF2
    [[SoapOperation Singleton] bindaccountWithAccount:accountStr
                                             Nickname:nil
                                          AccountType:0
                                             Password:passwordStr
                                              Success:^(NSNumber *successInfo) {
        MAINQUEUEUPDATEUI({
            [CustomeClass showMessage:@"绑定成功" ShowTime:3.0];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        })
                                                  
    } Fail:^(NSError *error) {
        if (error.code == 20) {
            [CustomeClass showMessage:@"手机号已存在" ShowTime:3.0];
        }else{
            RELOADSERVERDATA([weakSelf bindingthirtPartyWithAccountStr:accountStr
                                                              Password:passwordStr
            ];);
        }
    }];
}

@end
