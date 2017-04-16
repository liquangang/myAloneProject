//
//  EditNickNameViewController.m
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "EditNickNameViewController.h"
#import "SoapOperation.h"
#import "CustomeClass.h"

@interface EditNickNameViewController ()

@end

@implementation EditNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)initUI{
    //标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"编辑昵称";
    label.font = ISFont_17;
    label.textColor = [UIColor whiteColor];
    CGSize labelSize = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.titleView = label;
    
    if (self.myUserInfo.szNickname) {
        self.nickNameTextField.text = self.myUserInfo.szNickname;
        self.numLabel.text = [NSString stringWithFormat:@"%d", (int)(10 - self.myUserInfo.szNickname.length)];
    }
    else{
        self.numLabel.text = @"10";
    }
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //完成按钮
    UIButton * finishBtn = [UIButton new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:finishBtn];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    CGSize mySize = [@"完成" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:16], NSFontAttributeName, nil]];
    finishBtn.frame = CGRectMake(0, 0, 40, mySize.height);
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //注册TextField变化的通知
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:UITextFieldTextDidChangeNotification object:nil userInfo:nil]];
    
    //注册接受TextField变化的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    //注册TextField开始编辑的通知
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:UITextFieldTextDidBeginEditingNotification object:nil userInfo:nil]];
    
    //注册接受TextField开始编辑的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

/** TextField开始编辑的通知方法*/
- (void)textFieldBeginEditing:(NSNotification *)noti{

}

/** TextField变化的通知方法*/
- (void)textFieldChange:(NSNotification *)noti{
    self.numLabel.text = [NSString stringWithFormat:@"%d", (int)(10 - self.nickNameTextField.text.length)];
    if (self.nickNameTextField.text.length >= 10) {
        [UIWindow showMessage:@"请输入1-10个字的昵称" withTime:1.5];
    }
}

/** 返回按钮点击方法*/
- (void)backButtonAction{
    [self.nickNameTextField resignFirstResponder];
//    if (self.nickNameTextField.text.length == 0 || self.nickNameTextField.text.length > 10) {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入1-10个字的昵称" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    [self.navigationController popViewControllerAnimated:YES];
}

/** 完成按钮的点击方法*/
- (void)finishButtonAction{
        [self.nickNameTextField resignFirstResponder];
    if (self.nickNameTextField.text.length == 0 || self.nickNameTextField.text.length > 10) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入1-10个字的昵称" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    self.myUserInfo.szNickname = self.nickNameTextField.text;
        [[SoapOperation Singleton] WS_SetUserInfo:self.myUserInfo
                                          Success:^(NSNumber *num) {
                                              NSLog(@"上传昵称成功--------%@", num);
        } Fail:^(NSError *error){
            NSLog(@"上传昵称失败------%@", error);
         }];
        [self.navigationController popViewControllerAnimated:YES];
}

/** 点击空白处退出TextField编辑*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
