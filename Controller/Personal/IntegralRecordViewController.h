//
//  IntegralRecordViewController.h
//  M-Cut
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralRecordViewController : UIViewController
/** 当前用户总得分*/
@property (nonatomic, copy) NSString * userAllScore;
/** 是否从我的映币界面跳转过来*/
@property (nonatomic, assign) BOOL isFromMyCoinVc;
@end
