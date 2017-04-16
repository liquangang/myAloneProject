//
//  UIUtils.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/21.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "UIUtils.h"
#import <CommonCrypto/CommonDigest.h>
//#import "RTLabel.h"

@implementation UIUtils


+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [formatter setLocale:locale];
    
    NSDate *date = [formatter dateFromString:datestring];
    return date;
}

//Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    return text;
}



////<a href="http://app.weibo.com/t/feed/3G5oUM" rel="nofollow">iPhone 5s</a>
//+(NSString *)subText:(NSString *)srcStr
//{
//    int start = [srcStr rangeOfString:@">"].location;
//    int end = [srcStr rangeOfString:@"<" options:NSBackwardsSearch].location;
//    NSString *subStr = [srcStr substringWithRange:NSMakeRange(start+1, end-start-1)];
//    return [NSString stringWithFormat:@"来自%@", subStr];
//}
//
//
//+(NSString *)parseTextLink:(NSString *)text
//{
//    //目标样式<a href='http://www.google.com'>@丽丽</a>
//    //有三种不同形式的链接
//    //<a href='user://zhang'>@zhang</a>        //@zhang
//    //<a href='topic://#话题#'>%@</a>
//    //<a href='http://www.google.com'>http://www.google.com</a>
//    
//    NSString *regEx = @"(@[\\w-]{2,30})|(#[^#]+#)|(http(s)?://([a-zA-Z0-9_./-]+))";
//    //使用系统自带的类库
//    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:regEx options:NSRegularExpressionCaseInsensitive error:NULL];
//    //NSMatchingReportProgress 搜索所有的结果
//    NSArray *resultArr5 = [reg matchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, text.length)];
//    
//    NSString *tempStr = text;
//    NSString *replaceStr = nil;
//    for (NSTextCheckingResult *result in resultArr5) {
//        NSString *linkStr = [text substringWithRange:result.range];
//        
//        if ([linkStr hasPrefix:@"@"]) { //用户
//            replaceStr = [NSString stringWithFormat:@"<a href='user://%@'>%@</a>", [[linkStr substringFromIndex:1] URLEncodedString], linkStr];
//        }else if ([linkStr hasPrefix:@"#"]){
//            replaceStr = [NSString stringWithFormat:@"<a href='topic://%@'>%@</a>", [linkStr URLEncodedString], linkStr];
//        }else if ([linkStr hasPrefix:@"http"]){
//            replaceStr = [NSString stringWithFormat:@"<a href='%@'>%@</a>", linkStr, linkStr];
//        }
//        
//        //替换
//        if (replaceStr) {
//            //只要出现了linkStr的地方,都需要替换成replaceStr
//            tempStr = [tempStr stringByReplacingOccurrencesOfString:linkStr withString:replaceStr];
//        }
//    }
//    
//    
//    return tempStr;
//}
//
@end
