//
//  PersonalSignatureViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/29.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "PersonalSignatureViewController.h"
#import "APPUserPrefs.h"

@implementation PersonalSignatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [_textView becomeFirstResponder];
    self.textView.text = szPersonalSignature;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)PersonalSignatureCancelButtonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)PersonalSignatureSaveButtonAction:(id)sender {
    if (self.personalSignatureBlock) {
        self.personalSignatureBlock(_textView.text);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
