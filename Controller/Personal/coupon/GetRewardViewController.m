//
//  GetRewardViewController.m
//  M-Cut
//
//  Created by liquangang on 2017/1/23.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "GetRewardViewController.h"

@interface GetRewardViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *receivePersonTextField;
@property (weak, nonatomic) IBOutlet UITextField *receivePersonTelNumTextField;
@property (weak, nonatomic) IBOutlet UITextField *receivePersonAddressTextField;
@end

@implementation GetRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"领取奖品";
}

#pragma mark - textFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([textField isEqual:self.receivePersonTextField]) {
        if (textField.text.length == 0) {
            SHOWALERT(@"收货人不能为空！")
            return;
        }
    }else if ([textField isEqual:self.receivePersonTelNumTextField]){
        
        //不能超过11位
        if (textField.text.length > 11) {
            SHOWALERT(@"手机号码不能超过11位！")
            return;
        }
    }else if ([textField isEqual:self.receivePersonAddressTextField]){
        if (textField.text.length == 0) {
            SHOWALERT(@"地址不能为空！")
            return;
        }
    }
    
    //执行接口调用，完成用户填写完所需信息完之后的逻辑
}

#pragma mark - rewriteSuperMethod

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark - otherInterface

- (IBAction)receiveButtonAction:(id)sender {
    
    //执行提交的逻辑
    
}



@end
