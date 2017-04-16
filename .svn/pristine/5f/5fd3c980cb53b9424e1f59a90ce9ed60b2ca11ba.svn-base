//
//  EditSignatureViewController.m
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "EditSignatureViewController.h"
#import "SoapOperation.h"

@interface EditSignatureViewController ()
@property (weak, nonatomic) IBOutlet UITextField *signatureTextField;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation EditSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

/** 初始化ui*/
- (void)initUI{
//    self.title = @"编辑签名";
    NAVIGATIONBARTITLEVIEW(@"编辑签名")
    
    if (self.myUserInfo.szSignature) {
        self.signatureTextField.text = self.myUserInfo.szSignature;
        self.numLabel.text = [NSString stringWithFormat:@"%d", (int)(30 - self.myUserInfo.szSignature.length > 30 ? 0 : self.myUserInfo.szSignature.length)];
    }
    else{
        self.numLabel.text = @"30";
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
    if (self.signatureTextField.text.length <= 30) {
        self.numLabel.text = [NSString stringWithFormat:@"%d", (int)(30 - self.signatureTextField.text.length)];
    }else if(self.signatureTextField.text.length >= 30){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入30字以内的个性签名" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        self.numLabel.text = @"0";
        self.signatureTextField.text = [NSString stringWithFormat:@"%@", [self.signatureTextField.text substringWithRange:NSMakeRange(0, 30)]];
        [self.signatureTextField resignFirstResponder];
    }
}

/** 返回按钮点击方法*/
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 完成按钮的点击方法*/
- (void)finishButtonAction{
    [self.signatureTextField resignFirstResponder];
    self.myUserInfo.szSignature = self.signatureTextField.text;
    [[SoapOperation Singleton] WS_SetUserInfo:self.myUserInfo
                                      Success:^(NSNumber *num) {
                                          NSLog(@"上传签名成功--------%@", num);
                                      } Fail:^(NSError *error){
                                          NSLog(@"上传签名失败------%@", error);
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
