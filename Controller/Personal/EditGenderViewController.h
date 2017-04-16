//
//  EditGenderViewController.h
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"

@interface EditGenderViewController : UIViewController
/** 用户信息model*/
@property (nonatomic, strong) MovierDCInterfaceSvc_VDCCustomerInfo * myUserInfo;
@end
