//
//  AddAddressBookPersonCell.m
//  M-Cut
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AddAddressBookPersonCell.h"
#import <UIImageView+WebCache.h>
#import "VideoDBOperation.h"

static NSString * AddAddressBookPersonCellId = @"AddAddressBookPersonCell";

@implementation AddAddressBookPersonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (id)getAddAddressBookPersonCellWithTable:(UITableView *)myTable UserIconUrl:(NSString *)iconUrl UserName:(NSString *)userName UserNickName:(NSString *)userNickname UserId:(NSString *)userId FriendType:(NSString *)friendType{
    AddAddressBookPersonCell * cell = [myTable dequeueReusableCellWithIdentifier:AddAddressBookPersonCellId];

    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:AddAddressBookPersonCellId owner:nil options:nil] lastObject];
    }
    
    
    
    if (iconUrl) {
        [cell.friendImage sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    }
    
    cell.friendNameLabel.text = userName;
    
    if (userNickname) {
        cell.userId = userId;
        cell.friendDesLabel.text = [NSString stringWithFormat:@"映像：%@", userNickname];
        //判断此人是否被当前用户关注，若关注就显示已关注，未关注就显示关注
                if ([friendType isEqualToString:@"1"] || [friendType isEqualToString:@"2"]) {
                    [cell.friendFollowButton setTitle:@"已关注" forState:UIControlStateNormal];
                    [cell.friendFollowButton setBackgroundColor:[UIColor whiteColor]];
                    [cell.friendFollowButton setTitleColor:ISGrayColor forState:UIControlStateNormal];
                }else{
                    [cell.friendFollowButton setTitle:@"关注" forState:UIControlStateNormal];
                }
    }
    return cell;
}
- (IBAction)addButtonAction:(id)sender {
    UIButton * btn = (UIButton *)sender;
    if ([btn.titleLabel.text isEqualToString:@"邀请"]) {
        self.sendBlock();
    }else if([btn.titleLabel.text isEqualToString:@"关注"]){
        self.followBlock();
    }
}

- (void)sendMes:(SENDMES)sendBlock{
    self.sendBlock = sendBlock;
}

- (void)followUser:(FOLLOWUSER)followBlock{
    self.followBlock = followBlock;
}

@end
