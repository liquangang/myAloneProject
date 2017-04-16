//
//  CommentsSecondCell.m
//  M-Cut
//
//  Created by apple on 16/7/1.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CommentsSecondCell.h"
#import "MessageObj.h"
#import <UIImageView+WebCache.h>
#import "UserEntity.h"

static NSString * commentsSecondCellId = @"CommentsSecondCell";

@implementation CommentsSecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)pushPersonVC:(UITapGestureRecognizer *)tap{
    self.pushTopersonalVcBlock();
}

- (void)pushtoPersonalVc:(COMMENTPUSHPERSONALVC)pushBlock{
    self.pushTopersonalVcBlock = pushBlock;
}

- (void)pushVideoVc:(UITapGestureRecognizer *)tap{
    self.pushtoVideoVc();
}

- (void)pushToVideoVc:(COMMENTPUSHTOVIDEOVC)pushBlock{
    self.pushtoVideoVc = pushBlock;
}

- (void)reply:(UITapGestureRecognizer *)tap{
    self.replyBlock();
}

- (void)replyComment:(REPLYBLOCK)replyBlock{
    self.replyBlock = replyBlock;
}

- (void)setCellWithMesObj:(MessageObj *)mesObj{
    [self.commentsUserReplyheadImage sd_setImageWithURL:[NSURL URLWithString:mesObj.srcavatar] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    ADDTAPGESTURE(self.commentsUserReplyheadImage, pushPersonVC);
    
    self.commentsUserNameLabel.text = mesObj.srcnickname;
    self.commentsReplyUserTimeLabel.text = mesObj.time;
    self.commentContentTextView.text = mesObj.srccontent;
    ADDTAPGESTURE(self.commentContentTextView, reply);
    //计算回复内容的高度
    CGSize sizeToFit = [self.commentContentTextView sizeThatFits:CGSizeMake(ISScreen_Width - 88, MAXFLOAT)];
    self.commentContentTextViewHeight.constant = sizeToFit.height;
    //设置评论内容字体和颜色
    self.commentContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.commentContentTextView.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:ISLIKEGRAYCOLOR}];
    NSString * commentReplyTextHtml = [NSString stringWithFormat:@"<html><head></head><body><font color=\"#FF4E4C\">%@：</font><font color=\"#404A58\">%@</font></body></html>", CURRENTUSERNICKNAME, mesObj.dstcontent];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[commentReplyTextHtml dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSFontAttributeName:ISFont_14} documentAttributes:nil error:nil];
    self.commentReplyedContentTextView.attributedText = attributedString;
    //计算高度
    CGSize sizeToFit2 = [self.commentReplyedContentTextView sizeThatFits:CGSizeMake(ISScreen_Width - 88, MAXFLOAT)];
    self.commentReplyedContentHeight.constant = sizeToFit2.height;
    
    //视频缩略图
    [self.commentsReplyVideoImage sd_setImageWithURL:[NSURL URLWithString:STRTOUTF8(mesObj.videothumbnail)] placeholderImage:DEFAULTVIDEOTHUMAIL options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    ADDTAPGESTURE(self.commentsReplyVideoImage, pushVideoVc);
    //视频标签
    self.commentsReplyVideoLabelNameLabel.text = [NSString stringWithFormat:@"#%@#", mesObj.videolabelname];
    //视频名称
    self.commentsReplyVideoNameLabel.text = [NSString stringWithFormat:@"《%@》", mesObj.videoname];
    
    self.pushVideoId = mesObj.videoid;
    self.pushPersonId = mesObj.srccustomerid;
    self.mesObj = mesObj;
}

+ (id)getCommentReplyCellWithTable:(UITableView *)myTable MessageObj:(MessageObj *)mesObj{
    CommentsSecondCell * cell = [myTable dequeueReusableCellWithIdentifier:commentsSecondCellId];
    if (!cell) {
        cell = XIBCELL(commentsSecondCellId);
    }
    [cell setCellWithMesObj:mesObj];
    return cell;
}

@end
