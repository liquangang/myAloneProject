//
//  EditTextViewController.m
//  M-Cut
//
//  Created by apple on 16/10/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "EditTextViewController.h"

@interface EditTextViewController ()
@property (weak, nonatomic) IBOutlet UITextView *editTextView;
@end

@implementation EditTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark - 功能模块
- (void)setUI{
    NAVIGATIONBACKBARBUTTONITEM;
    NAVIGATIONBARRIGHTBARBUTTONITEM(@"完成")
    self.editTextView.text = self.textStr;
}

- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonItemAction:(UIButton *)btn{
    self.finishBlock(self.editTextView.attributedText);
    [self.navigationController popViewControllerAnimated:YES];
}

@end
