//
//  NSString+FontSize.m
//  ICloudSpace
//
//  Created by 李亚飞 on 15/9/24.
//
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

/**   根据宽度计算文字的尺寸 */
- (CGSize)sizeWithWidth:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}


/**   判断字符串是否包含汉字  */
- (BOOL)isContainChineseWord {
    if ([self length] == 0)    return NO;
    
    BOOL isContainChineseWord = NO;
    for(int index = 0; index < [self length];index ++){
        int a = [self characterAtIndex:index];
        if( a > 0x4e00 && a < 0x9fff) {
            isContainChineseWord = YES;
        }
    }
    return isContainChineseWord;
}


/**   拼音转汉字 */
- (NSString *)ChineseTransPinyin {
    // @"aa啊啊aa(呵呵)" ---> aa a a aa (a a)
    
    NSMutableString *ms = [[NSMutableString alloc] initWithString:self];
    if ([self length]) {
        // 将汉字  转为  带声调的拼音
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO);
        // 将带声调的拼音  转为  不带声调的拼音
        CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO);
        // 去掉汉字转拼音生成的空格
    }
    NSString *str = [ms stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

/**
 *  给字符串 每隔count个字符后面添加 特殊字符symbol
 */
- (NSString *)addSymbol:(NSString *)symbol space:(NSInteger)count {
    NSMutableString *str = [NSMutableString stringWithString:self];
    
    NSInteger loc = 0;
    NSInteger symbolLength = symbol.length;
    for (NSInteger i = 1; i <= self.length / count; i++) {
        loc = count * i + (i - 1) * symbolLength;
        [str insertString:symbol atIndex:loc];
    }
    
    return str;
}
@end
