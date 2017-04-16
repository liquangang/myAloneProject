//
//  ChatInputView.m
//  M-Cut
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ChatInputView.h"

@implementation ChatInputView

- (id)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.frame = frame;
        [self addSubview];
    }
    return self;
}

- (void)addSubview{
    UITextField * chatField = [[UITextField alloc] initWithFrame:CGRectMake(10, 5, ISScreen_Width - 84, 34)];
    [self addSubview:chatField];
    
    UILabel * sendLabel = [[UILabel alloc] initWithFrame:CGRectMake(ISScreen_Width - 84, 0, 84, 44)];
    [self addSubview:sendLabel];
    sendLabel.text = @"发送";
    sendLabel.textColor = ISGrayColor;
    sendLabel.font = ISFont_14;
    sendLabel.textAlignment = NSTextAlignmentCenter;
    [sendLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendLabelAction:)]];
}

- (void)sendLabelAction:(UITapGestureRecognizer *)tapGesture{
    self.reloadTabelData();
}

@end
