//
//  LQGTitleView.m
//  TestDemo
//
//  Created by apple on 16/3/29.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "TitleNewView.h"

@interface TitleNewView ()
/**  记录导航栏按钮是否被选中*/
@property (nonatomic, assign) BOOL isSelect;
@end

@implementation TitleNewView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame andDelegate:(NSObject <LQGTitleViewDelegate>*)lqgDelegate{
    if (self = [super initWithFrame:(CGRect)frame]) {
        self.delegate = lqgDelegate;
        self.isSelect = YES;
        [self createUIWithFrame:frame];
        [self alterButtonColor1];
    }
    return self;
}

- (void)createUIWithFrame:(CGRect)frame
{
    self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, frame.size.width / 2, frame.size.height)];
    [self addSubview:self.button1];
    [self.button1 setTitle:@"在线音乐" forState:UIControlStateNormal];
    [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.button1.tag = 11;
    
    self.button2 = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width / 2, 0, frame.size.width / 2, frame.size.height)];
    [self addSubview:self.button2];
    [self.button2 setTitle:@"本地音乐" forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.button2.tag = 12;
    
    self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height + 2, frame.size.width / 2, 2)];
    [self addSubview:self.label1];
    self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 2, frame.size.height + 2, frame.size.width / 2, 2)];
    [self addSubview:self.label2];
    
}

- (void)buttonAction:(UIButton *)button{
    if (self.isSelect == YES) {
        [self alterButtonColor1];
        self.isSelect = NO;
    }
    else
    {
        [self alterButtonColor2];
        self.isSelect = YES;
    }
    if ([self.delegate respondsToSelector:@selector(barButtonAction:)]) {
        [self.delegate barButtonAction:button];
    }
}

- (void)alterButtonColor1
{
    [self.button1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.label1.backgroundColor = [UIColor redColor];
    [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.label2.backgroundColor = [UIColor clearColor];
}

- (void)alterButtonColor2
{
    [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.label1.backgroundColor = [UIColor clearColor];
    [self.button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.label2.backgroundColor = [UIColor redColor];
}

@end
