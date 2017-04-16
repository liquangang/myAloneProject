//
//  MJFriendCell.h
//  02-QQ好友列表
//
//  Created by 成良云 on 15/1/11.
//  Copyright (c) 2015年 dazhuankuai. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJFriend;

@interface MJFriendCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (strong, nonatomic) MJFriend *friendData;
@end
