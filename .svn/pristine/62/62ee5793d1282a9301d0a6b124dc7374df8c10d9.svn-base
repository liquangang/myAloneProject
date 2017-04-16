//
//  MyChatCell.m
//  M-Cut
//
//  Created by apple on 16/7/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MyChatCell.h"
#import "UserEntity.h"
#import <UIImageView+WebCache.h>

static NSString * myChatCellId = @"MyChatCell";

@implementation MyChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.myChatContentTextView.layer.borderColor = ISGRAYCOLOR4.CGColor;
    self.myChatContentTextView.layer.borderWidth = 1;
}

- (void)setCellWithContent:(NSString *)chatContent{
    
    [self.myHeadImage sd_setImageWithURL:[NSURL URLWithString:[UserEntity sharedSingleton].szAcatar] placeholderImage:DEFAULTHEADIMAGE options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    self.myChatContentTextView.text = chatContent;
    //计算回复内容的高度
    CGSize sizeToFit = [self.myChatContentTextView sizeThatFits:CGSizeMake(ISScreen_Width / 2, MAXFLOAT)];
    self.myChatContentTextViewHeight.constant = sizeToFit.height;
    self.myChatContentTextView.attributedText = [[NSAttributedString alloc] initWithString:chatContent attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:ISLIKEGRAYCOLOR}];
    
    
    
}

+ (id)getMyChatCellWithTable:(UITableView *)superTable ChatContent:(NSString *)chatContent{
    MyChatCell * cell = [superTable dequeueReusableCellWithIdentifier:myChatCellId];
    if (!cell) {
        cell = XIBCELL(myChatCellId);
    }
    [cell setCellWithContent:chatContent];
    return cell;
}

@end
