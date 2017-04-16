//
//  CommentsCell.m
//  M-Cut
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CommentsCell.h"
//消息model
#import "MessageObj.h"
#import <UIImageView+WebCache.h>

static NSString * commentsCellId = @"CommentsCell";

@implementation CommentsCell

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
    [self.CommentsUserHeadImage sd_setImageWithURL:[NSURL URLWithString:mesObj.srcavatar] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    //添加手势
    ADDTAPGESTURE(self.CommentsUserHeadImage, pushPersonVC);
    
    self.commentsUserNameLabel.text = mesObj.srcnickname;
    self.commentsTimeLabel.text = mesObj.time;
    self.commentContentTextView.text = mesObj.srccontent;
    
    //计算回复内容的高度
    CGSize sizeToFit = [self.commentContentTextView sizeThatFits:CGSizeMake(ISScreen_Width - 88, MAXFLOAT)];
    self.commentContentTextViewHeight.constant = sizeToFit.height;
    //设置评论内容字体和颜色
    self.commentContentTextView.attributedText = [[NSAttributedString alloc] initWithString:self.commentContentTextView.text attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:ISLIKEGRAYCOLOR}];
    //添加手势
    ADDTAPGESTURE(self.commentContentTextView, reply)
    
    
    [self.commentsVideoImage sd_setImageWithURL:[NSURL URLWithString:STRTOUTF8(mesObj.videothumbnail)] placeholderImage:DEFAULTVIDEOTHUMAIL options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    //添加手势
    ADDTAPGESTURE(self.commentsVideoImage, pushVideoVc);
    
    self.commentsVideoLabelNameLabel.text = [NSString stringWithFormat:@"#%@#", mesObj.videolabelname];
    self.commentsVideoNamelabel.text = [NSString stringWithFormat:@"《%@》", mesObj.videoname];
    
    self.pushVideoId = mesObj.videoid;
    self.pushPersonId = mesObj.srccustomerid;
    self.mesObj = mesObj;
}

+ (id)getCommentCellWithMesObj:(MessageObj *)mesObj table:(UITableView *)myTable{
    CommentsCell * cell = [myTable dequeueReusableCellWithIdentifier:commentsCellId];
    if (!cell) {
        cell = XIBCELL(commentsCellId)
    }
    //设置cell的内容
    [cell setCellWithMesObj:mesObj];
    return cell;
}

@end
