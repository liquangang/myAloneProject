//
//  UIBarButtonItem+Extension.m
//  ICloudSpace
//
//  Created by 李亚飞 on 15/9/25.
//
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+Extension.h"

@implementation UIBarButtonItem (Extension)
/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    button.size = button.currentBackgroundImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

/**
 *  @return 创建一个只有标题的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)font color:(UIColor *)color{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置按钮的属性
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置按钮的尺寸
    button.size = [title sizeWithWidth:MAXFLOAT font:[UIFont systemFontOfSize:font]];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


/**
 *  @return 创建一个只有标题的item, 按钮有普通和选中两种状态
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title selectTitle:(NSString *)selectTitle font:(CGFloat)font color:(UIColor *)color{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置按钮的属性
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:selectTitle forState:UIControlStateSelected];
    
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateSelected];
    
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置按钮的尺寸
    button.size = [title sizeWithWidth:MAXFLOAT font:[UIFont systemFontOfSize:font]];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end
