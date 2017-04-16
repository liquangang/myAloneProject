//
//  UIWindow+Extension.m
//  ICloudSpace
//
//  Created by 李亚飞 on 15/10/14.
//
//

#import "UIWindow+Extension.h"
// 屏幕宽高
#define LIScreenWidth [UIScreen mainScreen].bounds.size.width
#define LIScreenHeight [UIScreen mainScreen].bounds.size.height

// 遮罩和左右屏幕边界的距离
#define LIScreenMargin 100
#define LIContentMargin 10
#define LIRatio (LIScreenWidth / LIScreenHeight * 0.35)

@implementation UIWindow (Extension)
/**
 *  显示提示框
 */
- (void)showMessage:(NSString *)message withTime:(CGFloat)time {
    MAINQUEUEUPDATEUI({
        UIView *msgView = [self showMessage:message font:0 toView:nil];
        // 2秒后删除 msgView
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [msgView removeFromSuperview];
        });
    })
}

+ (void)showMessage:(NSString *)message withTime:(CGFloat)time {
    MAINQUEUEUPDATEUI({
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window showMessage:message withTime:time];
    })
}

/**
 *  显示提示框
 */
- (UIView *)showMessage:(NSString *)message font:(CGFloat)font toView:(UIView *)view {\
    MAINQUEUEUPDATEUI({
        
    })
    if (!view)   view = self;
    
    // 提示框的尺寸
    CGFloat msgViewW = LIScreenWidth - LIScreenMargin * 1.5;
    CGFloat msgViewH = LIScreenHeight * LIRatio * 0.7;
    CGFloat msgViewX = (LIScreenWidth - msgViewW) * 0.5;
    CGFloat msgViewY = (LIScreenHeight - msgViewH) * 0.5;
    CGRect frame = CGRectMake(msgViewX, msgViewY, msgViewW, msgViewH);
    
    // 添加到屏幕中间
    UILabel *label = [[UILabel alloc] init];
    CGFloat labelW = msgViewW - LIContentMargin * 2;
    CGFloat labelH = msgViewH - LIContentMargin * 2;
    label.frame = CGRectMake(LIContentMargin, LIContentMargin, labelW, labelH);
    label.text = message;
    UIFont *textFont = nil;
    if (font != 0) {
        textFont = [UIFont systemFontOfSize:font];
    } else {
        textFont = [UIFont systemFontOfSize:12];
    }
    label.font = textFont;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    
    UIView *msgView = [[UIView alloc] initWithFrame:frame];
    msgView.layer.cornerRadius = 5;
    msgView.clipsToBounds = YES;
    msgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [msgView addSubview:label];
#pragma mark - 此处会崩溃（等待排查）
    MAINQUEUEUPDATEUI({
        [self addSubview:msgView];
    })
    
    return msgView;
}

+ (UIView *)showMessage:(NSString *)message font:(CGFloat)font toView:(UIView *)view {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *coverView = [window showMessage:message font:font toView:view];
    return coverView;
}

@end
