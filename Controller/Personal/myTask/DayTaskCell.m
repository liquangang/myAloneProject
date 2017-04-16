//
//  DayTaskCell.m
//  M-Cut
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "DayTaskCell.h"

@implementation DayTaskCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//设置cell上的控件展示的内容
- (void)setCellWithDic:(NSDictionary *)dic{
    self.dayTaskImage.image = [UIImage imageNamed:[dic objectForKey:@"缩略图"]];
    self.dayTaskTitleLabel.text = [dic objectForKey:@"任务名称"];
    self.dayTaskIntegralLabel.text = [NSString stringWithFormat:@"%@  %@", [dic objectForKey:@"任务分数"], [dic objectForKey:@"任务映币"]];
    self.dayTaskDesLabel.text = [dic objectForKey:@"任务描述"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
