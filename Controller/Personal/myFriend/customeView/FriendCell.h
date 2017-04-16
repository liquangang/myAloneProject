//
//  FriendCell.h
//  M-Cut
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"
#import "FriendModel.h"

typedef void(^PUSHTOCHATVC)(FriendModel * friendInfo);
typedef void(^RIGHTBLOCK)(NSString * actionTypeStr, FriendModel * friendInfo, NSIndexPath * cellIndex);

@interface FriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet UILabel *alreadyFollowLabel;
@property (weak, nonatomic) IBOutlet UIImageView *letterImage;
@property (weak, nonatomic) IBOutlet UILabel *friendPropmtLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendSignatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendCollectTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *friendVideoNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *friendHeadImage;


/** 操作的cell的位置*/
@property (nonatomic, strong) NSIndexPath * cellIndex;

@property (nonatomic, strong) FriendModel * cellFriendInfo;
@property (nonatomic, strong) MovierDCInterfaceSvc_VDCFriendInfo * cellFriendInfo2;
@property (nonatomic, copy) NSString * cellRightText;

@property (nonatomic, copy) PUSHTOCHATVC pushToChatVc;
- (void)pushToChatVc:(PUSHTOCHATVC)pushBlock;

@property (nonatomic, copy) RIGHTBLOCK rightBlock;
- (void)rightAction:(RIGHTBLOCK)rightBlock;

/** 生成复用的friendcell*/
+ (id)getFriendCellWithTable:(UITableView *)myTable FriendType:(NSString *)friendType FriendIInfo:(FriendModel *)friendInfo;

+ (id)getFriendCellWithIconUrl:(NSString *)iconUrl NickName:(NSString *)nickname VideoNam:(NSInteger)videoNum CollectNum:(NSInteger)collectNum Signature:(NSString *)signature FriendType:(NSInteger)friendType Table:(UITableView *)myTable FriendInfo:(MovierDCInterfaceSvc_VDCFriendInfo *)friendInfo Index:(NSIndexPath *)cellIndex;
@end
