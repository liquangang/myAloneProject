//
//  LQGCaptionEditeViewController.m
//  M-Cut
//
//  Created by Admin on 16/3/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CaptionEditeNewViewController.h"

@interface CaptionEditeNewViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation CaptionEditeNewViewController

DEALLOCMETHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

#pragma mark - interface

- (void)createUI{
    NAVIGATIONBACKBARBUTTONITEM
    
    //界面标题
    NAVIGATIONBARTITLEVIEW(@"编辑字幕")
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 50, 30);
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font = ISFont_15;[rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.textView.text = self.editText;
}

- (void)rightBarButtonItemAction:(UIButton *)btn{
    NSString *tempString = [[NSMutableString alloc] initWithString:[self.textView.text stringByReplacingOccurrencesOfString:@"\r" withString:@""]];
    NSMutableString *tempMuString = [NSMutableString new];
    NSArray *subtitleArray = [tempString componentsSeparatedByString:@"\n"];
    
    for (NSString *str in subtitleArray) {
        NSString *tempStr = [NSString stringWithFormat:@"%@\r\n", str];
        [tempMuString appendString:tempStr];
    }
    
    self.getEditFinishSubtitleBlock(tempMuString);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backButtonAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
