//
//  TelephoneBindingViewController.h
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, formWhereVc){
    formAlreadyBindingTelNum,//从已经绑定手机号的界面跳转过来
    formPerfectPersonInfoVc,//从完善用户信息的界面跳转过来
    formAccountAndSafeVc//从账户与安全界面跳过来
};

@interface TelephoneBindingViewController : UIViewController
/** 记录是否从哪个界面跳转*/
@property (nonatomic, assign) formWhereVc formWhere;
@end
