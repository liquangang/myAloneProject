//
//  MJFriendCell.m
//  02-QQ好友列表
//
//  Created by 成良云 on 15/1/11.
//  Copyright (c) 2015年 dazhuankuai. All rights reserved.
//
#import "MJFriendCell.h"
#import "MJFriend.h"

@implementation MJFriendCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
   static NSString *ID = @"friend";
    MJFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //调用自己画得xib
    cell = [[[NSBundle mainBundle]loadNibNamed:@"MJFriendCell" owner:self options:nil] lastObject];
    if (cell == nil) {
        cell = [[MJFriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return self;
}

- (void)setFriendData:(MJFriend *)friendData
{
    _friendData = friendData;
    
    // 1.图片
    self.imageView.image = [UIImage imageNamed:friendData.icon];
    
    // 2.昵称
    self.textLabel.text = friendData.name;
    self.textLabel.textColor = friendData.vip ? [UIColor redColor] : [UIColor blackColor];
    
    // 3.简介
    self.detailTextLabel.text = friendData.intro;
}

@end
