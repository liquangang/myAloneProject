//
//  AddFriendCell.m
//  M-Cut
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AddFriendCell.h"

@implementation AddFriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setCellWithDic:(NSDictionary *)myDic{
    self.friendImage.image = [UIImage imageNamed:[myDic objectForKey:@"好友图片"]];
    self.friendTypeLabel.text = [myDic objectForKey:@"好友类型"];
    self.addDesLabel.text = [myDic objectForKey:@"好友简介"];
}

static NSString * addFriendCellId = @"AddFriendCell";

+ (id)getAddFriendCellWithTabel:(UITableView *)myTable Dic:(NSDictionary *)myDic{
    AddFriendCell * cell = [myTable dequeueReusableCellWithIdentifier:addFriendCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:addFriendCellId owner:nil options:nil] lastObject];
    }
    [cell setCellWithDic:myDic];
    return cell;
}

@end
