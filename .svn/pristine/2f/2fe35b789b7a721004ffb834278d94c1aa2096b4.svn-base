//
//  LQGCaptionEditeViewController.m
//  M-Cut
//
//  Created by Admin on 16/3/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//
/**  屏幕宽度 */
#define ISScreen_Width [UIScreen mainScreen].bounds.size.width
/**  屏幕高度 */
#define ISScreen_Height [UIScreen mainScreen].bounds.size.height

#import "LQGCaptionEditeViewController.h"

@interface LQGCaptionEditeViewController ()<UITextViewDelegate>

@end

@implementation LQGCaptionEditeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createUI];
}

- (void)createUI
{
    //界面标题
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"编辑字幕";
    titleLabel.font = ISFont_17;
    CGSize labelSize = [titleLabel.text sizeWithWidth:MAXFLOAT font:ISFont_17];
    titleLabel.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.titleView = titleLabel;
    
    //初始化textview
    CGSize mySize;
    mySize.width = ISScreen_Width;
    mySize.height = MAXFLOAT;
    CGSize sizeFrame = [self.stringText sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:mySize lineBreakMode:UILineBreakModeWordWrap];
    self.textView.frame = CGRectMake(0, 0, ISScreen_Width, sizeFrame.height);
    self.textView.textColor = [UIColor blackColor];
    self.textView.font = [UIFont boldSystemFontOfSize:17];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.text = self.stringText;
    self.textView.scrollEnabled = YES;
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    //navigationbar返回按钮
    UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
}

- (void)backBtnAction:(UIButton *)btn
{
    [self.delegate changeText:self.textView.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGSize mySize;
    mySize.width = ISScreen_Width;
    mySize.height = MAXFLOAT;
    CGSize sizeFrame = [self.stringText sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:mySize lineBreakMode:UILineBreakModeWordWrap];
    self.textView.frame = CGRectMake(0, 0, ISScreen_Width, sizeFrame.height);
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
