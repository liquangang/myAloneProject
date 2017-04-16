//
//  NSString+FontSize.h
//  ICloudSpace
//
//  Created by 李亚飞 on 15/9/24.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

/**
 *  根据宽度计算文字的尺寸
 */
- (CGSize)sizeWithWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  判断字符串是否包含汉字
 */
- (BOOL)isContainChineseWord;

/**
 *  拼音转汉字
 */
- (NSString *)ChineseTransPinyin;

/**
 *  给字符串 每隔 count个字符后面添加 特殊字符symbol
 */
- (NSString *)addSymbol:(NSString *)symbol space:(NSInteger)count;
@end