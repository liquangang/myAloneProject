//
//  FriendCell.m
//  M-Cut
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "FriendCell.h"
#import "VideoDBOperation.h"
#import <UIImageView+WebCache.h>

@implementation FriendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    ADDTAPGESTURE(self.rightImage, rightButtonAction)
    ADDTAPGESTURE(self.rightImage, rightButtonAction)
}

- (void)pushChatVc:(UITapGestureRecognizer *)tapGesture{
    self.pushToChatVc(self.cellFriendInfo);
}

- (void)pushToChatVc:(PUSHTOCHATVC)pushBlock{
    self.pushToChatVc = pushBlock;
}

static NSString * FriendCellId = @"FriendCell";
static NSString * FriendCellId2 = @"FriendCell2";
static NSString * friendCellId3 = @"FriendCell3";

- (void)setCellWithFriendInfo:(FriendModel *)friendInfo FriendType:(NSString *)friendType{
    
    ADDTAPGESTURE(self.letterImage, pushChatVc);
    
    self.cellFriendInfo = friendInfo;
    
    WEAKSELF(weakSelf);
    //查表获得提示的数字
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSInteger propmtNum = 0;
        propmtNum = [[VideoDBOperation Singleton] selectNoReadPrivateMes:friendInfo.userId];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([friendType isEqualToString:@"好友"]) {
                weakSelf.letterImage.hidden = NO;
                weakSelf.friendPropmtLabel.hidden = NO;
                if (propmtNum > 0) {
                    weakSelf.friendPropmtLabel.text = [NSString stringWithFormat:@"%ld", (long)propmtNum];
                }else{
                    weakSelf.friendPropmtLabel.hidden = YES;
                }
            }else if ([friendType isEqualToString:@"关注"]){
                if (propmtNum > 0) {
                    weakSelf.letterImage.hidden = NO;
                    weakSelf.friendPropmtLabel.hidden = NO;
                    weakSelf.friendPropmtLabel.text = [NSString stringWithFormat:@"%ld", (long)propmtNum];
                }else{
                    weakSelf.letterImage.hidden = YES;
                    weakSelf.friendPropmtLabel.hidden = YES;
                    weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }else if ([friendType isEqualToString:@"粉丝"]){
                weakSelf.letterImage.hidden = YES;
                weakSelf.friendPropmtLabel.hidden = YES;
                weakSelf.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        });
    });
    if (friendInfo.signature && ![friendInfo.signature isEqualToString:@"(null)"] && ![friendInfo.signature isEqualToString:@"null"]) {
        self.friendSignatureLabel.text = friendInfo.signature;
    }
    if (friendInfo.nickName && ![friendInfo.nickName isEqualToString:@"(null)"] && ![friendInfo.nickName isEqualToString:@"null"]) {
        self.friendNameLabel.text = friendInfo.nickName;
    }
    
    self.friendCollectTimesLabel.text = [NSString stringWithFormat:@"%@", friendInfo.videoCollectTimes];
    self.friendVideoNumLabel.text = [NSString stringWithFormat:@"%@", friendInfo.videoNum];
    if (friendInfo.iconURL) {
        [self.friendHeadImage sd_setImageWithURL:[NSURL URLWithString:friendInfo.iconURL] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    }
}

+ (id)getFriendCellWithTable:(UITableView *)myTable FriendType:(NSString *)friendType FriendIInfo:(FriendModel *)friendInfo{
    FriendCell * cell = [myTable dequeueReusableCellWithIdentifier:FriendCellId];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:FriendCellId owner:nil options:nil] lastObject];
    }
    [cell setCellWithFriendInfo:friendInfo FriendType:friendType];
    return cell;
}

+ (id)getFriendCellWithIconUrl:(NSString *)iconUrl NickName:(NSString *)nickname VideoNam:(NSInteger)videoNum CollectNum:(NSInteger)collectNum Signature:(NSString *)signature FriendType:(NSInteger)friendType Table:(UITableView *)myTable FriendInfo:(MovierDCInterfaceSvc_VDCFriendInfo *)friendInfo Index:(NSIndexPath *)cellIndex{
    FriendCell * cell = [myTable dequeueReusableCellWithIdentifier:FriendCellId2];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:FriendCellId owner:nil options:nil] lastObject];
    }
    cell.cellIndex = cellIndex;
    cell.cellFriendInfo = [FriendModel getFriendModelWithFriendInfo:friendInfo];
    cell.friendPropmtLabel.hidden = YES;
    [cell.friendHeadImage sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    cell.friendSignatureLabel.text = signature;
    cell.friendNameLabel.text = nickname;
    cell.friendCollectTimesLabel.text = [NSString stringWithFormat:@"%ld", (long)collectNum];
    cell.friendVideoNumLabel.text = [NSString stringWithFormat:@"%ld", (long)videoNum];
    cell.letterImage.hidden = YES;
    if (friendType == 1) {
        //设置已关注
        cell.alreadyFollowLabel.hidden = NO;
        cell.letterImage.hidden = YES;
    }else if (friendType == 2){
        cell.cellRightText = @"私信";
        cell.rightImage.hidden = NO;
        cell.rightImage.image = [UIImage imageNamed:@"privateMessageImage"];
        
        
    }else{
        cell.cellRightText = @"+关注";
        cell.rightImage.hidden = NO;
        cell.rightImage.image = [UIImage imageNamed:@"addFollowImage"];
        
        
    }
    return cell;
}

- (void)rightButtonAction:(UITapGestureRecognizer *)tap{
    self.rightBlock(self.cellRightText, self.cellFriendInfo, self.cellIndex);
}

- (void)rightAction:(RIGHTBLOCK)rightBlock{
    self.rightBlock = rightBlock;
}

@end
