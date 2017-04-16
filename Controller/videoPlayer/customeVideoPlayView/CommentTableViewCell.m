//
//  CommentTableViewCell.m
//  M-Cut
//
//  Created by liquangang on 16/9/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CommentTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "NSString+Date.h"
#import "CustomeClass.h"

static NSString * const cellReusableId = @"CommentTableViewCell";

@interface CommentTableViewCell()
@property (nonatomic, strong) MovierDCInterfaceSvc_vpVideoComment * commentInfo;
@property (nonatomic, strong) NSIndexPath * cellIndexPath;

/** 第几次显示actionSheet*/
@property (nonatomic, assign) NSInteger showTimes;
@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //删除或者举报长按手势
    UILongPressGestureRecognizer * longGesture =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(longGesture:)];
    [self.contentView addGestureRecognizer:longGesture];
}

//长按手势
- (void)longGesture:(UILongPressGestureRecognizer *)longGesture{
    self.showTimes++;
    if (self.showTimes == 2) {
        self.showTimes = 0;
        self.longGestureBlock(self.commentInfo, self.cellIndexPath);
    }
}

//头像点击方法
- (IBAction)userImageButtonAction:(id)sender {
    self.clickUserImage([NSString stringWithFormat:@"%@", self.commentInfo.nCustomerID]);
}

+ (id)CommentTableViewCellWithCellSuperTable:(UITableView *)cellSuperTableView
                                 CommentInfo:(MovierDCInterfaceSvc_vpVideoComment *)commentInfo
                                       Index:(NSIndexPath *)cellIndexPath
{
    CommentTableViewCell * cell = [cellSuperTableView dequeueReusableCellWithIdentifier:cellReusableId];
    if (!cell) {
        cell = XIBCELL(cellReusableId)
    }
    
    /*
     @interface MovierDCInterfaceSvc_vpVideoComment : NSObject
     
     
    NSNumber * nCommentID;
    NSNumber * nCustomerID;
    NSNumber * nVideoID;
    NSNumber * nreplyComment;
    NSString * szNickname;
    NSString * szAvatar;
    NSString * szCreateTime;
    NSString * szContent;

     */
    cell.commentInfo = commentInfo;
    
    cell.cellIndexPath = cellIndexPath;
    
    //设置头像
    UIImageView * imageView = [UIImageView new];
    [imageView sd_setImageWithURL:[NSURL URLWithString:commentInfo.szAvatar] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageProgressiveDownload completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        MAINQUEUEUPDATEUI({
            [cell.userImageButton setImage:imageView.image forState:UIControlStateNormal];
        })
    }];
    
    //设置用户名称
    cell.userNameLabel.text = commentInfo.szNickname;
    
    // 评论创建时间
    NSString *timeLabelText = [CustomeClass compareCurrentTime:commentInfo.szCreateTime];
    CGSize timeStrSize = [timeLabelText sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:9]}];
    cell.commentCreateTimeLabelWidth.constant = timeStrSize.width + 16;
    cell.commentCreateTimeLabel.text = timeLabelText;
    
    //设置评论或者回复内容
    cell.commentContentLabel.numberOfLines = 0;
    cell.commentContentLabel.text = commentInfo.szContent;

    return cell;
}
@end
