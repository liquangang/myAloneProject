//
//  CloudAlbumCollectionViewCell.h
//  M-Cut
//
//  Created by apple on 16/12/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudAlbumCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lockImage;

/**
 *  普通相册
 */
- (void)setGeneralAlbumWithImage:(UIImage *)backImage Num:(NSInteger)num Title:(NSString *)title;
@end
