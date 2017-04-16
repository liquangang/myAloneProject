//
//  CustomTextView.m
//  M-Cut
//
//  Created by apple on 16/7/19.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CustomTextView.h"

@implementation CustomTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview];
    }
    return self;
}

- (void)addSubview{
    self.userInteractionEnabled = YES;
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(8, 6, ISScreen_Width - 56, 33)];
    [self addSubview:self.textView];
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.textView.font = ISFont_13;
    self.textView.scrollEnabled = YES;
    self.textView.userInteractionEnabled = NO;
    
//    self.sendButton = [[UIButton alloc] initWithFrame:CGRectMake(ISScreen_Width - 44, 2, 40, 40)];
//    [self addSubview:self.sendButton];
//    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
//    [self.sendButton setTitleColor:ISGrayColor forState:UIControlStateNormal];
//    [self.sendButton addTarget:self action:@selector(sendCommentReply) forControlEvents:UIControlEventTouchUpInside];
}

//- (void)sendCommentReply{
//    self.sendCommentReplyBlock();
//}

//- (void)sendCommentReply:(SENDCOMMENTREPLY)sendBlock{
//    self.sendCommentReplyBlock = sendBlock;
//}

@end
