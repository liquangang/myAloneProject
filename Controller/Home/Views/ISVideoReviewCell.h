//
//  ISVideoReviewCell.h
//  M-Cut
//
//  Created by 李亚飞 on 15/11/22.
//  Copyright © 2015年 Crab movier. All rights reserved.
//  视频页面评论内容的 cell

#import <UIKit/UIKit.h>

typedef void(^LOGNTAPOPERATIOIN)(int commentUserId, int commentId);

@class ISVideoReviewCell, VideoCommentFrame;
@protocol ISVideoReviewCellDelegate <NSObject>
@optional
- (void)cellTap:(int)commmentUserId CommentId:(int)commentId;
- (void)reviewCell:(ISVideoReviewCell *)reviewCell didClickIconButton:(UIButton *)button;
@end

@interface ISVideoReviewCell : UITableViewCell
/**  评论数据模型  */
@property (strong, nonatomic) VideoCommentFrame *commentF;
@property (weak, nonatomic) id<ISVideoReviewCellDelegate> delegate;
@property (nonatomic, assign) int commentUserId;

@property (nonatomic, assign) int commentId;


@property (nonatomic, copy) LOGNTAPOPERATIOIN longTapOperation;

- (void)longTapOperation:(LOGNTAPOPERATIOIN)operationBlock;

+ (instancetype)reviewCellWithTableView:(UITableView *)tableView;
@end
