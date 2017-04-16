//
//  FriendTypeCell.h
//  M-Cut
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SELECTFRIEND)();
typedef void(^SELECTFANS)();
typedef void(^SELECTFOLLOW)();

@interface FriendTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *friendNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *followNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansNumLabel;
@property (weak, nonatomic) IBOutlet UIView *friendBackView;
@property (weak, nonatomic) IBOutlet UIView *followBackView;
@property (weak, nonatomic) IBOutlet UIView *fansBackView;
@property (weak, nonatomic) IBOutlet UILabel *friendLabel;
@property (weak, nonatomic) IBOutlet UILabel *followLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendDownLabel;
@property (weak, nonatomic) IBOutlet UILabel *followDownLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansDownLabel;

@property (nonatomic, copy) SELECTFANS selectFans;
@property (nonatomic, copy) SELECTFOLLOW selectFollow;
@property (nonatomic, copy) SELECTFRIEND selectFriend;

- (void)selectFans:(SELECTFANS)fansBlock;
- (void)selectFollow:(SELECTFOLLOW)followBlock;
- (void)selectFriend:(SELECTFRIEND)friendBlock;

/** 生成复用FriendTypeCell*/
+ (id)getFriendTypeCellWithTable:(UITableView *)myTable FriendType:(NSString *)friendType;
@end
