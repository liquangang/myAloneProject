//
//  CommentsSecondCell.h
//  M-Cut
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageObj;

typedef void(^COMMENTPUSHPERSONALVC)();
typedef void(^COMMENTPUSHTOVIDEOVC)();
typedef void(^REPLYBLOCK)();

@interface CommentsSecondCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commentsUserReplyheadImage;
@property (weak, nonatomic) IBOutlet UILabel *commentsUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsReplyUserTimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentContentTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentContentTextViewHeight;
@property (weak, nonatomic) IBOutlet UITextView *commentReplyedContentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *commentsReplyVideoImage;
@property (weak, nonatomic) IBOutlet UILabel *commentsReplyVideoLabelNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentsReplyVideoNameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentReplyedContentHeight;


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

/** 获得复用cell*/
+ (id)getCommentReplyCellWithTable:(UITableView *)myTable MessageObj:(MessageObj *)mesObj;
@end
