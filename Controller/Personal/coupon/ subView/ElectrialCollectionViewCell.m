//
//  ElectrialCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ElectrialCollectionViewCell.h"

@implementation ElectrialCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+ (id)ElectrialCollectionViewCellWithCollectionView:(UICollectionView *)superCollectionView
                                        ResuableStr:(NSString *)resuableStr
                                          IndexPath:(NSIndexPath *)cellIndex
{
    ElectrialCollectionViewCell * cell = [superCollectionView dequeueReusableCellWithReuseIdentifier:resuableStr
                                                                                        forIndexPath:cellIndex];
    return cell;
}

@end
