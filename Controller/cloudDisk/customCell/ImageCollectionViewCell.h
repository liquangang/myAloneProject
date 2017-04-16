//
//  ImageCollectionViewCell.h
//  M-Cut
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoModel.h"

@interface ImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIButton *previewButton;
@property (weak, nonatomic) IBOutlet UILabel *timeLengthLabel;

/**
 *  选择
 */
@property (nonatomic, copy) void(^selectBlock)(UIButton *selectButton);

/**
 *  预览
 */
@property (nonatomic, copy) void(^previewBlock)();

+ (instancetype)ImageCollectionViewCellWithResuableStr:(NSString *)resuableStr
                                             IndexPath:(NSIndexPath *)indexPath
                                        CollectionView:(UICollectionView *)collectionView
                                              CellInfo:(PhotoModel *)photoModel;
@end
