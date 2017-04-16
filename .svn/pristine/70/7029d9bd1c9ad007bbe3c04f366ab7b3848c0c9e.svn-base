//
//  DistrictTableViewController.h
//  M-Cut
//
//  Created by 刘海香 on 15/1/29.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvincialTableViewCell.h"
#import "APPUserPrefs.h"
#import "MovierDCInterfaceSvc.h"

typedef void(^DistrictBlock)(NSString *st);
@interface DistrictTableViewController : UITableViewController
{
    NSArray *provinces, *cities, *areas;
}
@property(retain,nonatomic)NSArray *districtArray;
@property(nonatomic,copy)DistrictBlock districtBlock;
@property (strong,nonatomic) IBOutlet UITableView *districtTabV;

/** 当前登录用户的信息对象*/
@property (nonatomic, strong) MovierDCInterfaceSvc_VDCCustomerInfo * myUserInfo;
@end
