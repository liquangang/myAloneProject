//
//  ISPlaceholderTextView.m
//
//
//  Created by MS on 15/11/23.
//  Copyright (c) 2015年 m. All rights reserved.
//

#import "ISPlaceholderTextView.h"

@implementation ISPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // 不要设置自己的delegate是自己
    //        self.delegate = self;
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    
    // 通知 只有用户手动修改文字才会触发, 但是使用代码通知不能发出
    // 当UITextView 的文字发生改变时, 自己会发出一个UITextViewTextDidChangeNotification通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
}

#pragma mark -- 监听文字发生改变
- (void)textDidChange {
    // 重绘 (重新调用drawRect)
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    // 每次调用该方法, 都会将以前的文字擦除
    // 如果有输入文字, 直接返回, 不画占位文字
    if (self.hasText) return;
    
    // 文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor grayColor];
    
    // 确定文字位置
    CGSize placeHolderSize = [self.placeholder sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, nil]];
    if (self.myTextAlignment != NSTextAlignmentLeft) {
        CGRect placeholderRect = CGRectMake(6, rect.size.height / 2 - placeHolderSize.height / 2, placeHolderSize.width, placeHolderSize.height);
        [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    }
    else{
       CGRect placeholderRect = CGRectMake(ISScreen_Width / 2 - placeHolderSize.width / 2, rect.size.height / 2 - placeHolderSize.height / 2, placeHolderSize.width, placeHolderSize.height);
        [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    }
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
#pragma mark -- setNeedsDisplay, 在下一个消息循环时调用drawRect
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    // 保证插入图片时, 占位文字消失
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    [self setNeedsDisplay];
}

- (void)setPlaceholder:(NSString *)placeholder {
    // 字符串类型重写setter方法, 要使用copy
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
