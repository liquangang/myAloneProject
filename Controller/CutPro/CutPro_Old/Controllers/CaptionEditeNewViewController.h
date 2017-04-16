//
//  LQGCaptionEditeViewController.h
//  M-Cut
//
//  Created by Admin on 16/3/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaptionEditeNewViewController : UIViewController

/**
 *  获取编辑过的字幕
 */
@property (nonatomic, copy) void(^getEditFinishSubtitleBlock)(NSString *text);

/**
 *  设置编辑的初始内容
 */
@property (nonatomic, copy) NSString *editText;
@end
