//
//  CloudAlbumCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/12/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudAlbumCollectionViewCell.h"

@interface CloudAlbumCollectionViewCell()
@end

@implementation CloudAlbumCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/**
 *  普通相册
 */
- (void)setGeneralAlbumWithImage:(UIImage *)backImage Num:(NSInteger)num Title:(NSString *)title{
    self.backImage.image = backImage;
    self.numLabel.text = [NSString stringWithFormat:@"%lu", num];
    self.titleLabel.text = title;
    self.lockImage.hidden = YES;
}

/**
 *  带锁相册
 */
- (void)setLockAlbumWithTitle:(NSString *)title{
    self.lockImage.hidden = NO;
    self.backImage.backgroundColor = UIColorFromRGB(0x2E2E3A);
    self.numLabel.text = @"";
    self.titleLabel.text = title;
}

/**
 *  空相册
 */
- (void)setNonAlbum{
    self.backImage.image = [UIImage imageNamed:@"首页默认缩略图"];
    self.backImage.backgroundColor = UIColorFromRGB(0x2E2E3A);
    self.numLabel.text = @"";
    self.titleLabel.text = @"";
    self.lockImage.hidden = YES;
}

@end
