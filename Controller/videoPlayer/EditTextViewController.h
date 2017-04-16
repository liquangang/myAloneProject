//
//  EditTextViewController.h
//  M-Cut
//
//  Created by apple on 16/10/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTextViewController : UIViewController
@property (nonatomic, copy) void(^finishBlock)(NSAttributedString *textStr);

/**
 *  初始待编辑的文字
 */
@property (nonatomic, copy) NSString * textStr;
@end
