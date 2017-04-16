//
//  AddAddressBookPersonCell.h
//  M-Cut
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SENDMES)();
typedef void(^FOLLOWUSER)();

@interface AddAddressBookPersonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *friendImage;
@property (weak, nonatomic) IBOutlet UILabel *friendNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendDesLabel;
@property (weak, nonatomic) IBOutlet UIButton *friendFollowButton;

CUSTOMEPORPERTY(userId);

@property (nonatomic, copy) SENDMES sendBlock;
@property (nonatomic, copy) FOLLOWUSER followBlock;

- (void)followUser:(FOLLOWUSER)followBlock;
- (void)sendMes:(SENDMES)sendBlock;

/** 获得复用cell*/
+ (id)getAddAddressBookPersonCellWithTable:(UITableView *)myTable UserIconUrl:(NSString *)iconUrl UserName:(NSString *)userName UserNickName:(NSString *)userNickname UserId:(NSString *)userId FriendType:(NSString *)friendType;
@end
