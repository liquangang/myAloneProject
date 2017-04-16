//
//  UIButton+Extension.m
//  ICloudSpace
//
//  Created by 李亚飞 on 15/9/28.
//
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action title:(NSString *)title selectTitle:(NSString *)selectTitle color:(UIColor *)color font:(CGFloat)font {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置按钮的属性
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:color forState:UIControlStateNormal];
    }
    if (selectTitle) {
        [button setTitle:selectTitle forState:UIControlStateSelected];
        [button setTitleColor:color forState:UIControlStateSelected];
    }
    
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置按钮的尺寸
    NSString *str = title.length > selectTitle.length ? title : selectTitle;
    button.size = [str sizeWithWidth:MAXFLOAT font:[UIFont systemFontOfSize:font]];
    return button;
}


+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image selectImage:(NSString *)selectImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (selectImage) {
        [button setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    }
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.size = button.currentBackgroundImage.size;
    return button;
}

+ (UIButton *)buttonWithTarget:(id)target action:(SEL)action image:(NSString *)image title:(NSString *)title {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (image) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (title) {
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    CGSize titleSize = [title sizeWithWidth:MAXFLOAT font:[UIFont systemFontOfSize:13]];
    CGSize imageSize = button.currentImage.size ;
    
    CGFloat buttonW = imageSize.width + titleSize.width;
    CGFloat buttonH = MAX(imageSize.height, titleSize.height);
    
    button.size = CGSizeMake(buttonW, buttonH);
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}
@end
