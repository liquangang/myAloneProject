//
//  HomepageCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HomepageCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@implementation HomepageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (id)getHomepageCollectionViewCellWithCellId:(NSString *)cellId CollectionView:(UICollectionView *)cellCollectionView BackImageUrl:(NSString *)imageUrl VideoLabelName:(NSString *)videoLabelName Index:(NSIndexPath *)cellIndex{
    HomepageCollectionViewCell * cell = [cellCollectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:cellIndex];
//    [cell.backImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:DEFAULTVIDEOTHUMAIL options:SDWebImageRetryFailed | SDWebImageRefreshCached];
//    cell.videoLabelNameLabel.text = videoLabelName;
    return cell;
}

@end
