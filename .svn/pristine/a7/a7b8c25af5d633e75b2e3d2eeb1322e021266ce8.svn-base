//
//  FriendChatCell.h
//  M-Cut
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendChatCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *friendHeadImage;
@property (weak, nonatomic) IBOutlet UITextView *friendChatContentTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *friendContentHeight;

/** 获得复用的FriendChatCell*/
+ (id)getFriendChatCellWithTable:(UITableView *)superTable FriendHeadImageUrl:(NSString *)iconUrl ChatContent:(NSString *)chatContent;
@end
