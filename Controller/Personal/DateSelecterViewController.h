//
//  DateSelecterViewController.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/7/24.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"

typedef void(^DateBlock)(NSString *strin);
@interface DateSelecterViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableArray *yearArray;
    NSArray *monthArray;
    NSMutableArray *DaysArray;
    NSString *currentMonthString;
    int selectedYearRow;
    int selectedMonthRow;
    int selectedDayRow;
    BOOL firstTimeLoad;
}

@property (nonatomic,copy)DateBlock dateBlock;
@property (weak, nonatomic) IBOutlet UILabel *textFieldEnterDate1;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbarCancelDone;
@property (weak, nonatomic) IBOutlet UIPickerView *customPicker;
- (IBAction)actionCancel:(id)sender;
- (IBAction)actionDone:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *confirmButton;
@property (weak, nonatomic) IBOutlet UILabel *confirmLabel;

/** 存储当前登录的用户信息*/
@property (nonatomic, strong) MovierDCInterfaceSvc_VDCCustomerInfo * myUserInfo;
@end
