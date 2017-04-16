//
//  DayTaskCell.h
//  M-Cut
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayTaskCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *dayTaskImage;
@property (weak, nonatomic) IBOutlet UILabel *dayTaskTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayTaskIntegralLabel;
@property (weak, nonatomic) IBOutlet UILabel *dayTaskDesLabel;

/** 设置cell上的控件展示的内容*/
- (void)setCellWithDic:(NSDictionary *)dic;
@end
