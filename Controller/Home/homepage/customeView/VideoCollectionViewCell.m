//
//  VideoCollectionViewCell.m
//  M-Cut
//
//  Created by liquangang on 16/10/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoCollectionViewCell.h"

@implementation VideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (instancetype)VideoCollectionViewCellWithCollectionView:(UICollectionView *)collectionView
                                                IndexPath:(NSIndexPath *)indexPath
                                              ResuableStr:(NSString *)resuableStr{
    VideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:resuableStr
                                                                               forIndexPath:indexPath];
    return cell;
}

@end
