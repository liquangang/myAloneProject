//
//  styleCell.m
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "styleCell.h"
#import <UIImageView+WebCache.h>

@implementation styleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.thumbnailImage.layer.cornerRadius = (((ISScreen_Width - 12) / 4) - 12) / 2;
    self.thumbnailImage.layer.masksToBounds = YES;
    [self.contentView insertSubview:self.grayImage aboveSubview:self.thumbnailImage];
    [self.contentView insertSubview:self.grayImage aboveSubview:self.titleLabel];
    [self.contentView insertSubview:self.redLineLabel aboveSubview:self.grayImage];
    [self.contentView insertSubview:self.arrowImage aboveSubview:self.redLineLabel];
    
    //缩略图添加手势
    self.thumbnailImage.userInteractionEnabled = YES;
    [self.thumbnailImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thumbnailImageGesture:)]];
    
    //设置底部横线的颜色
    self.redLineLabel.backgroundColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1];
}

/** 缩略图手势方法*/
- (void)thumbnailImageGesture:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(didSelectStyleCellWithIndex:)]) {
        [self.delegate didSelectStyleCellWithIndex:self.myIndex];
    }
}

/** 普通状态*/
- (void)setNormalCellWithStyle:(ISStyle *)myStyle{
    self.hidden = NO;
    [self.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:myStyle.szThumbnail] placeholderImage:GRAYICON options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    self.titleLabel.text = myStyle.szName;
    self.titleLabel.textColor = [UIColor blackColor];
    self.thumbnailImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.thumbnailImage.layer.borderWidth = 0;
    self.grayImage.hidden = YES;
    self.arrowImage.hidden = YES;
    self.redLineLabel.hidden = YES;
}

/** 选中的状态 未被选中的cell设置*/
- (void)setSelectCellWithStyle:(ISStyle *)myStyle{
    self.hidden = NO;
    [self.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:myStyle.szThumbnail] placeholderImage:GRAYICON options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    self.titleLabel.text = myStyle.szName;
    self.titleLabel.textColor = [UIColor blackColor];
    self.thumbnailImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.thumbnailImage.layer.borderWidth = 0;
    self.grayImage.hidden = NO;
    self.arrowImage.hidden = YES;
    self.redLineLabel.hidden = NO;
}

/** 选中的状态 被选中的cell设置*/
- (void)setDidSelectCellWithStyle:(ISStyle *)myStyle{
    self.hidden = NO;
    [self.thumbnailImage sd_setImageWithURL:[NSURL URLWithString:myStyle.szThumbnail] placeholderImage:GRAYICON options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    self.titleLabel.text = myStyle.szName;
    self.titleLabel.textColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1];
    self.thumbnailImage.layer.borderColor = [UIColor colorWithRed:255/255.0f green:78/255.0f blue:77/255.0f alpha:1].CGColor;
    self.thumbnailImage.layer.borderWidth = 1.2;
    self.grayImage.hidden = YES;
    self.arrowImage.hidden = NO;
    self.redLineLabel.hidden = NO;
}

@end
