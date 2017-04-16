//
//  CommentsCell.h
//  M-Cut
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageObj;

typedef void(^COMMENTPUSHPERSONALVC)();
typedef void(^COMMENTPUSHTOVIDEOVC)();
typedef void(^REPLYBLOCK)();

@interface CommentsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *CommentsUserHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *commentsUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentContentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *commentsVideoImage;
@property (weak, nonatomic) IBOutlet UILabel *commentsVideoLabelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsVideoNamelabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentContentTextViewHeight;

@property (nonatomic, copy) COMMENTPUSHPERSONALVC pushTopersonalVcBlock;
@property (nonatomic, copy) COMMENTPUSHTOVIDEOVC pushtoVideoVc;
@property (nonatomic, copy) REPLYBLOCK replyBlock;
@property (nonatomic, copy) NSString * pushVideoId;
@property (nonatomic, copy) NSString * pushPersonId;
@property (nonatomic, strong) MessageObj * mesObj;

/** 跳转到个人页面*/
- (void)pushtoPersonalVc:(COMMENTPUSHPERSONALVC)pushBlock;
/** 跳转到视频播放页面*/
- (void)pushToVideoVc:(COMMENTPUSHTOVIDEOVC)pushBlock;
/** 回复*/
- (void)replyComment:(REPLYBLOCK)replyBlock;

/** 获得复用的Commentscell*/
+ (id)getCommentCellWithMesObj:(MessageObj *)mesObj table:(UITableView *)myTable;
@end
