//
//  AlreadyBindingTelephoneViewController.h
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlreadyBindingTelephoneViewController : UIViewController
@property (nonatomic, copy) NSString * alreadyBindingTelNumStr;
/** 是否从绑定电话号码的界面跳转过来*/
@property (nonatomic, assign) BOOL isPushFormTelBindingVC;
@end
