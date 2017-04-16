//
//  ISCutProStyleDetailViewController.h
//  M-Cut
//
//  Created by 李亚飞 on 15/11/26.
//  Copyright © 2015年 Crab movier. All rights reserved.
//  风格详情

#import <UIKit/UIKit.h>
@class ISStyle;

@interface ISCutProStyleDetailViewController : UIViewController
/**  风格数据模型 */
@property (strong, nonatomic) ISStyle *style;
@end
