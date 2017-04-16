//
//  MJGroupHeader.h
//  02-QQ好友列表
//
//  Created by 成良云 on 15/1/11.
//  Copyright (c) 2015年 dazhuankuai. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJGroup, MJGroupHeader;

@protocol MJGroupHeaderDelegate  <NSObject>

@optional
- (void)groupHeaderClick:(MJGroupHeader *)header;

@end

@interface MJGroupHeader : UITableViewHeaderFooterView
+ (instancetype)headerWithTableView:(UITableView *)tableView;

@property (strong, nonatomic) MJGroup *group;

@property (weak, nonatomic) id<MJGroupHeaderDelegate> delegate;

@end

