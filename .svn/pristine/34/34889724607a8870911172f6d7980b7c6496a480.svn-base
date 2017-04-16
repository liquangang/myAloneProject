//
//  CustomTaskVideoTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CustomTaskVideoTableViewCell.h"

@implementation CustomTaskVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (id)getCustomTaskVideoTableViewCellWithTable:(UITableView *)myTable InfoDic:(NSDictionary *)videoInfo{
    CustomTaskVideoTableViewCell * cell = [myTable dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CustomTaskVideoTableViewCell" owner:nil options:nil] lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //设置cell上的控件内容
    
    return cell;
}

@end
