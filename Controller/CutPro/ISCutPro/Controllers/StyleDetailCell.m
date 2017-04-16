//
//  StyleDetailCell.m
//  M-Cut
//
//  Created by apple on 16/5/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "StyleDetailCell.h"
#import <UIImageView+WebCache.h>

@implementation StyleDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置缩略图为圆形
    self.StyleDetailImage.layer.cornerRadius = (((ISScreen_Width - 36) / 4) - 36) / 2;
    self.StyleDetailImage.layer.masksToBounds = YES;
    
    //添加手势
    self.StyleDetailImage.userInteractionEnabled = YES;
    [self.StyleDetailImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(StyleDetailImageGesture:)]];
}

/** 缩略图点击手势*/
- (void)StyleDetailImageGesture:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(didSelectStyleDetailWithIndex:)]) {
        [self.delegate didSelectStyleDetailWithIndex:self.myIndex];
    }
}

/** 设置未被选中的状态*/
- (void)setNormalDetailCellWithStyle:(ISStyleDetailFrame *)myStyleDetail{
    [self.StyleDetailImage sd_setImageWithURL:[NSURL URLWithString:myStyleDetail.styleDetail.thumbnail] placeholderImage:GRAYICON options: SDWebImageRetryFailed | SDWebImageRefreshCached];
    self.titleLabel.text = myStyleDetail.styleDetail.title;
    self.titleLabel.textColor = [UIColor blackColor];
    self.StyleDetailImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.StyleDetailImage.layer.borderWidth = 0;
}

/** 设置被选中的状态*/
- (void)setDidSelectDetailCellWithStyle:(ISStyleDetailFrame *)myStyleDetail{
    [self.StyleDetailImage sd_setImageWithURL:[NSURL URLWithString:myStyleDetail.styleDetail.thumbnail] placeholderImage:GRAYICON options: SDWebImageRetryFailed | SDWebImageRefreshCached];
    self.titleLabel.text = myStyleDetail.styleDetail.title;
    self.titleLabel.textColor = [UIColor redColor];
    self.StyleDetailImage.layer.borderColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1].CGColor;
    self.StyleDetailImage.layer.borderWidth = 1;
}

@end
