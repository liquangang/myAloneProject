//
//  DateSelecterViewController.m
//  M-Cut
//
//  Created by zhangxiaotian on 15/7/24.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "DateSelecterViewController.h"
#import "SoapOperation.h"

#define currentMonth [currentMonthString integerValue]

@interface DateSelecterViewController ()

@end

@implementation DateSelecterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    firstTimeLoad = YES;
//    self.customPicker.hidden = YES;
//    self.toolbarCancelDone.hidden = YES;
    
    NAVIGATIONBARTITLEVIEW(@"设置生日")
    
    self.confirmLabel.layer.masksToBounds = YES;
    self.confirmLabel.layer.cornerRadius = 8;
    
   //返回按钮
    UIButton * backButton = [UIButton new];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString *currentyearString = [NSString stringWithFormat:@"%@",
                                   [formatter stringFromDate:date]];
    [formatter setDateFormat:@"MM"];
    currentMonthString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    [formatter setDateFormat:@"dd"];
    NSString *currentDateString = [NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    yearArray = [[NSMutableArray alloc]init];
    for (int i = 1900; i <= 2050 ; i++)
    {
        [yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    monthArray = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    DaysArray = [[NSMutableArray alloc]init];
    for (int i = 1; i <= 31; i++)
    {
        if (i < 10) {
            [DaysArray addObject:[NSString stringWithFormat:@"0%d",i]];
        }else{
            [DaysArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    //默认显示当前日期
    [self.customPicker selectRow:[yearArray indexOfObject:currentyearString] inComponent:0 animated:YES];
    [self.customPicker selectRow:[monthArray indexOfObject:currentMonthString] inComponent:1 animated:YES];
    [self.customPicker selectRow:[DaysArray indexOfObject:currentDateString] inComponent:2 animated:YES];
}

/** 返回按钮点击方法*/
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0)
    {
        selectedYearRow = (int)row;
        [self.customPicker reloadAllComponents];
    }else if (component == 1)
    {
        selectedMonthRow = (int)row;
        [self.customPicker reloadAllComponents];
    }else if (component == 2)
    {
        selectedDayRow = (int)row;
        [self.customPicker reloadAllComponents];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 50, 60);
        pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    if (component == 0)
    {
        pickerLabel.text =  [yearArray objectAtIndex:row];
    }else if (component == 1){
        pickerLabel.text =  [monthArray objectAtIndex:row];
    }else if (component == 2){
        pickerLabel.text =  [DaysArray objectAtIndex:row];
    }
    return pickerLabel;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return [yearArray count];
    }else if (component == 1){
        return [monthArray count];
    }else{
        if (firstTimeLoad)
        {
            if (currentMonth == 1 || currentMonth == 3 || currentMonth == 5 || currentMonth == 7 || currentMonth == 8 || currentMonth == 10 || currentMonth == 12)
            {
                firstTimeLoad = NO;
                return 31;
            }else if (currentMonth == 2){
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    firstTimeLoad = NO;
                    return 29;
                }else{
                    firstTimeLoad = NO;
                    return 28;
                }
            }else{
                firstTimeLoad = NO;
                return 30;
            }
        }else{
            if (selectedMonthRow == 0 || selectedMonthRow == 2 || selectedMonthRow == 4 || selectedMonthRow == 6 || selectedMonthRow == 7 || selectedMonthRow == 9 || selectedMonthRow == 11)
            {
                return 31;
            }else if (selectedMonthRow == 1){
                int yearint = [[yearArray objectAtIndex:selectedYearRow]intValue ];
                if(((yearint %4==0)&&(yearint %100!=0))||(yearint %400==0)){
                    return 29;
                }else{
                    return 28;
                }
            }else{
                return 30;
            }
        }
    }
}

- (IBAction)actionCancel:(id)sender
{
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                     }
                     completion:^(BOOL finished){
                     }];
}

- (IBAction)actionDone:(id)sender
{
//    self.textFieldEnterDate1.text = [NSString stringWithFormat:@"%@/%@/%@",[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]],[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]],[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]]];
//    self.dateBlock(self.textFieldEnterDate1.text);
    self.myUserInfo.nBirthdayY = @([[yearArray objectAtIndex:[self.customPicker selectedRowInComponent:0]] intValue]);
    self.myUserInfo.nBirthdayM = @([[monthArray objectAtIndex:[self.customPicker selectedRowInComponent:1]] intValue]);
    self.myUserInfo.nBirthdayD = @([[DaysArray objectAtIndex:[self.customPicker selectedRowInComponent:2]] intValue]);
    NSLog(@"self.myUserInfo.nBirthdayY------%@------self.myUserInfo.nBirthdayM--------%@--------self.myUserInfo.nBirthdayD--------%@", self.myUserInfo.nBirthdayY, self.myUserInfo.nBirthdayM, self.myUserInfo.nBirthdayD);
    [[SoapOperation Singleton] WS_SetUserInfo:self.myUserInfo Success:^(NSNumber *num) {
        
        NSLog(@"上传成功");
    } Fail:^(NSError *error) {
        NSLog(@"上传用户生日失败--------%@", error);
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
