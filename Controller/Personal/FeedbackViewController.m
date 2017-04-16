//
//  FeedbackViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/29.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "FeedbackViewController.h"
#import "FeedBack.h"
#import "APPUserPrefs.h"
#import "SoapOperation.h"

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)submitInfo:(id)sender
{
//    int ret = -1;
    if ([self.textView.text isEqualToString:@"说说你对映像的意见:"]) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"MessageBox"
                              message:@"请输入您对映像的意见！"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    } else {
//        FeedBack *feedBack = [[FeedBack alloc] init];
//        feedBack._nContactType = CONTACT_TYPE_QQ;
//        feedBack._szContact = self.contactView.text;
//        feedBack._szContent = self.textView.text;
//        ret = [APPUserPrefs APP_submitfeedback:feedBack];
        
        MovierDCInterfaceSvc_VDCFeedBack *feedBack = [[MovierDCInterfaceSvc_VDCFeedBack alloc] init];
        feedBack.nContactType = [NSNumber numberWithInt:CONTACT_TYPE_TELEPHONE];
        feedBack.szContact = self.contactView.text;
        feedBack.szContent = self.textView.text;
        
        [[SoapOperation Singleton] WS_FeedBack:feedBack Success:^(NSNumber *num) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"MessageBox"
                                      message:@"提交成功！"
                                      delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
            });
        } Fail:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"MessageBox"
                                      message:@"提交失败！"
                                      delegate:nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
            });
        }];
        
//        if (ret == 0) {
//            UIAlertView *alert = [[UIAlertView alloc]
//                                  initWithTitle:@"MessageBox"
//                                  message:@"提交成功！"
//                                  delegate:nil
//                                  cancelButtonTitle:@"OK"
//                                  otherButtonTitles:nil];
//            [alert show];
//        }else{
//            UIAlertView *alert = [[UIAlertView alloc]
//                                  initWithTitle:@"MessageBox"
//                                  message:@"提交失败！"
//                                  delegate:nil
//                                  cancelButtonTitle:@"OK"
//                                  otherButtonTitles:nil];
//            [alert show];
//        }
    }
}



@end
