//
//  UIBarButtonItem+Extension.h
//  ICloudSpace
//
//  Created by 李亚飞 on 15/9/25.
//  注意: 该分类依赖于"UIView+Extension.h"
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  创建有图片的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

/**
 *  创建只有文字的item, 只有普通状态的文字
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title font:(CGFloat)font color:(UIColor *)color;

/**
 *  @return 创建一个只有标题的item, 按钮有普通和选中两种状态
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action title:(NSString *)title selectTitle:(NSString *)selectTitle font:(CGFloat)font color:(UIColor *)color;
@end
