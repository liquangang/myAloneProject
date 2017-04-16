//
//  InputView.m
//  M-Cut
//
//  Created by liquangang on 16/9/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "InputView.h"

@interface InputView()<UITextViewDelegate>
/** 显示输入字数的label*/
@property (nonatomic, strong) UILabel * inputTextNumLabel;
@end

@implementation InputView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //输入框
        UITextView * inputTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, ISScreen_Width - 60, 44 - 10)];
        [self addSubview:inputTextView];
        inputTextView.layer.cornerRadius = 5;
        inputTextView.layer.masksToBounds = YES;
        inputTextView.text = @"     点击这里发表你的评论！";
        inputTextView.textColor = [UIColor grayColor];
        inputTextView.delegate = self;
        self.inputTextView = inputTextView;
        inputTextView.font = [UIFont systemFontOfSize:15];
        
        //发送按钮
        UIButton * sendButton = [[UIButton alloc] initWithFrame:CGRectMake(ISScreen_Width - 55, 11, 55, 44 - 11)];
        [self addSubview:sendButton];
        [sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [sendButton setTitleColor:ISLIKEGRAYCOLOR forState:UIControlStateNormal];
        sendButton.backgroundColor = [UIColor clearColor];
        [sendButton addTarget:self action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
        sendButton.titleLabel.font = ISFont_13;
        
        //字数label
        UILabel * inputTextNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(ISScreen_Width - 55, 5, 55, 11)];
        [self addSubview:inputTextNumLabel];
        inputTextNumLabel.textAlignment = NSTextAlignmentCenter;
        inputTextNumLabel.textColor = ISLIKEGRAYCOLOR;
        inputTextNumLabel.backgroundColor = [UIColor clearColor];
        self.inputTextNumLabel = inputTextNumLabel;
        inputTextNumLabel.font = [UIFont systemFontOfSize:9];
        inputTextNumLabel.text = @"0/110";
        
        //监听textview的编辑状态
        REGISTEREDNOTI(beginEdit:, UITextViewTextDidBeginEditingNotification);
        REGISTEREDNOTI(endEdit:, UITextViewTextDidEndEditingNotification);
    }
    return self;
}

#pragma mark - textview状态通知
- (void)beginEdit:(NSNotification *)noti{
    self.editStatus = beginEdit;
    NSLog(@"status --- %lu", self.editStatus);
    POSTNOTI(@"showKeyBoard", nil);
}

- (void)endEdit:(NSNotification *)noti{
    self.editStatus = endEdit;
    NSLog(@"status --- %lu", self.editStatus);
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    [self setInputNumLabel];
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    textView.textColor = ColorFromRGB(0x2E2E3A, 1);
    textView.text = @"";
    [self setInputNumLabel];
}

#pragma mark - 发送按钮点击方法
- (void)sendButtonAction{
    [self.inputTextView endEditing:YES];
    self.sendInputContentBlock(self.inputTextView.text);
    self.inputTextView.text = @"";
    [self setInputNumLabel];
}

- (void)setInputNumLabel{
   self.inputTextNumLabel.text = [NSString stringWithFormat:@"%lu/110", self.inputTextView.text.length];
}
@end
