//
//  FriendChatCell.m
//  M-Cut
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "FriendChatCell.h"
#import <UIImageView+WebCache.h>

static NSString * friendChatCellId = @"FriendChatCell";

@implementation FriendChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellWithUrl:(NSString *)iconUrl Content:(NSString *)chatContent{
    [self.friendHeadImage sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    self.friendChatContentTextView.text = chatContent;
    //计算回复内容的高度
    CGSize sizeToFit = [self.friendChatContentTextView sizeThatFits:CGSizeMake(ISScreen_Width / 2, MAXFLOAT)];
    self.friendContentHeight.constant = sizeToFit.height;
    self.friendChatContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.friendChatContentTextView.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

+ (id)getFriendChatCellWithTable:(UITableView *)superTable FriendHeadImageUrl:(NSString *)iconUrl ChatContent:(NSString *)chatContent{
    FriendChatCell * cell = [superTable dequeueReusableCellWithIdentifier:friendChatCellId];
    if (!cell) {
        cell = XIBCELL(friendChatCellId);
    }
    [cell setCellWithUrl:iconUrl Content:chatContent];
    return cell;
}

@end
