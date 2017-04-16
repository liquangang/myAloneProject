//
//  ISProgressView.m
//  M-Cut
//
//  Created by 李亚飞 on 15/12/1.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISProgressView.h"

#define ISProgressViewHeight (20.0 / 667 * ISScreen_Height)

@interface ISProgressView()
/**  标题 label */
@property (weak, nonatomic) UILabel *titleLabel;
@end

@implementation ISProgressView

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
        self.backgroundColor = ISRGBColor(125, 132, 140);
        self.frame = CGRectMake(0, 0, ISScreen_Width, ISProgressViewHeight);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
        self.backgroundColor = ISRGBColor(125, 132, 140);
        self.frame = CGRectMake(0, 0, ISScreen_Width, ISProgressViewHeight);
    }
    return self;
}

- (void)setup {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(0, 0, ISScreen_Width, ISProgressViewHeight);
    NSString *title = nil;
    if (self.title) {
        title = self.title;
    } else {
        title = @"正在上传中...";
    }
    
    UIColor *titleColor = nil;
    if (self.titleColor) {
        titleColor = self.titleColor;
    } else {
        titleColor = [UIColor whiteColor];
    }
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = titleColor;
    titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
}

+ (instancetype)progressView {
    return [[self alloc] init];
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
}

- (void)dissmiss {
    [self removeFromSuperview];
}

- (void)setProgress:(CGFloat)progress {
    if (progress >= 1) {
        [self dissmiss];
        return;
    }
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
}

- (void)drawRect:(CGRect)rect {
    // 绘制进度条
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGFloat x = rect.origin.x;
    CGFloat y = rect.origin.y;
    CGFloat w = rect.size.width * self.progress;
    CGFloat h = rect.size.height;
    CGRect drawRect = CGRectMake(x, y, w, h);
    UIColor *pregressColor = nil;
    if (self.progressColor) {
        pregressColor = self.progressColor;
    } else {
        pregressColor = ISRGBColor(229, 89, 90);
    }
    [pregressColor set];
    CGContextFillRect(ctx, drawRect);
}

@end
