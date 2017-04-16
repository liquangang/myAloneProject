//
//  VideoCollectionViewCell.h
//  M-Cut
//
//  Created by liquangang on 16/10/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCollectionViewCell : UICollectionViewCell

/**
 *  获得cell
 */
+ (instancetype)VideoCollectionViewCellWithCollectionView:(UICollectionView *)collectionView
                                                IndexPath:(NSIndexPath *)indexPath
                                              ResuableStr:(NSString *)resuableStr;
@end
