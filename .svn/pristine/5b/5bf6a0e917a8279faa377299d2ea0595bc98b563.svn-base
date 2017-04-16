//
//  ISVideoReviewCell.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/22.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISVideoReviewCell.h"
#import "VideoComment.h"
//#import "VideoCommentFrame.h"
#import "UIButton+WebCache.h"
#import "NSString+Date.h"

@interface ISVideoReviewCell ()
/**  用户图像 */
@property (weak, nonatomic) UIButton *iconButton;
/**  用户昵称 */
@property (weak, nonatomic) UILabel *nickNameLabel;
/**  评论时间 */
@property (weak, nonatomic) UILabel *commentTimeLabel;
/**  评论正文 */
@property (weak, nonatomic) UILabel *commentLabel;
/**  右侧小箭头 */
@property (nonatomic, strong) UIButton * arrowButton;

/** 第几次显示*/
@property (nonatomic, assign) NSInteger showTimes;
@end

@implementation ISVideoReviewCell

- (NSInteger)showTimes{
    if (!_showTimes) {
        _showTimes = 0;
    }
    return _showTimes;
}

+ (instancetype)reviewCellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"videoReview";
    ISVideoReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ISVideoReviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 点击cell时不会变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = ISTestRandomColor;
        // 创建视图
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    /**  用户图像 */
    UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:iconButton];
    [iconButton addTarget:self action:@selector(iconClick:) forControlEvents:UIControlEventTouchUpInside];
    self.iconButton = iconButton;
    
    /**  用户昵称 */
    UILabel *nickNameLabel = [[UILabel alloc] init];
    nickNameLabel.font = ISFont_13;
    nickNameLabel.textColor = ISRGBColor(64, 74, 88);
    [self.contentView addSubview:nickNameLabel];
    self.nickNameLabel = nickNameLabel;
    
    /**  评论时间 */
    UILabel *commentTimeLabel = [[UILabel alloc] init];
    commentTimeLabel.font = ISFont_10;
    commentTimeLabel.textColor = ISGrayColor;
    [self.contentView addSubview:commentTimeLabel];
    self.commentTimeLabel = commentTimeLabel;
    
    /**  评论正文 */
    UILabel *commentLabel = [[UILabel alloc] init];
    commentLabel.font = ISFont_13;
    commentLabel.textColor = ISRGBColor(64, 74, 88);
    commentLabel.numberOfLines = 0;
    [self.contentView addSubview:commentLabel];
    self.commentLabel = commentLabel;
    
    //添加长按手势
    [self.contentView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesture:)]];
}

- (void)longGesture:(UILongPressGestureRecognizer *)longTap{
    self.showTimes++;
    if (self.showTimes == 2) {
        self.showTimes = 0;
        // 长按操作
        self.longTapOperation(self.commentUserId, self.commentId);
    }
}

- (void)longTapOperation:(LOGNTAPOPERATIOIN)operationBlock{
    self.longTapOperation = operationBlock;
}

- (void)setCommentF:(VideoCommentFrame *)commentF {
    _commentF = commentF;
    VideoComment *comment = commentF.comment;
    
    // 服务器时间格式: yyyy-MM-dd HH:mm:ss
    // 图标
    [self.iconButton sd_setImageWithURL:[NSURL URLWithString:comment.szAvatar] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"slideshow"]];
    self.iconButton.frame = commentF.iconF;
    self.iconButton.layer.cornerRadius = commentF.iconF.size.width * 0.5;
    self.iconButton.clipsToBounds = YES;
    
    // 昵称
    self.nickNameLabel.text = comment.szNickname;
    self.nickNameLabel.frame = commentF.nickNameF;
    
    // 评论创建时间
    NSString *createTime = [comment.szCreateTime timeStr];
    self.commentTimeLabel.frame = commentF.commentTimeF;
    self.commentTimeLabel.text = createTime;
    
    //  评论内容
    NSString *content = comment.szContent;
    self.commentLabel.text = content;
    self.commentLabel.frame = commentF.contentF;
}

- (void)iconClick:(UIButton *)sender {
    // 由代理执行跳转到  评论用户 详情界面
    if ([self.delegate respondsToSelector:@selector(reviewCell:didClickIconButton:)]) {
        [self.delegate reviewCell:self didClickIconButton:sender];
    }
}
@end
