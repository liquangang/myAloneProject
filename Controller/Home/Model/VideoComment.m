//
//  VideoComment.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/22.
//  Copyright © 2015年 Crab movier. All rights reserved.
//  视频评论模型

#import "VideoComment.h"
#import "NSString+Date.h"

@implementation VideoComment

@end


@implementation VideoCommentFrame

- (void)setComment:(VideoComment *)comment {
    _comment = comment;
    
    // 控件之间的间距
    CGFloat margin = 16;
    // 按钮和屏幕左右的间距
    CGFloat leftSpace = 13.0 / 375 * ISScreen_Width;
    CGFloat rightSpace = leftSpace;
    
    // 1. 计算按钮的 frame
    CGFloat buttonX = leftSpace;
    CGFloat buttonY = margin;
    CGFloat buttonW = 31.0 / 375 * ISScreen_Width;
    CGFloat buttonH = buttonW;
    _iconF = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    // 2. 评论时间 frame
    NSString *commentTime = [comment.szCreateTime timeStr];
    CGSize commentTimeSize = [commentTime sizeWithWidth:MAXFLOAT font:ISFont_10];
    CGFloat commentTimeW = commentTimeSize.width;
    CGFloat commentTimeH = commentTimeSize.height;
    CGFloat commentTimeX = ISScreen_Width - rightSpace - commentTimeW;
    
    // 3. 昵称 frame
    CGFloat nickX = CGRectGetMaxX(_iconF) + margin;
    CGFloat nickY = buttonY;
    NSString *nickName = comment.szNickname;
    CGFloat nickContentWidth = commentTimeX - CGRectGetMaxX(_iconF) - margin;
    CGSize nickSize = [nickName sizeWithWidth:nickContentWidth font:ISFont_13];
    _nickNameF = (CGRect){{nickX, nickY}, nickSize};
    
    // 评论时间
    CGFloat commentTimeY = CGRectGetMaxY(_nickNameF) - commentTimeH;
    _commentTimeF = CGRectMake(commentTimeX, commentTimeY, commentTimeW, commentTimeH);
    
    // 4. 评论内容
    CGFloat contentX = nickX;
    CGFloat contentY = CGRectGetMaxY(_nickNameF) + margin * 0.5;
    CGFloat contentW = ISScreen_Width - contentX - leftSpace;
    NSString *content = comment.szContent;
    CGSize contentSize = [content sizeWithWidth:contentW font:ISFont_13];
    _contentF = CGRectMake(contentX, contentY, contentW, contentSize.height);
    
    // 5. cell 的高度
    _cellHeight = CGRectGetMaxY(_contentF);
}

@end