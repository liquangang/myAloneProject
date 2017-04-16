//
//  ElectrialCollectionViewCell.h
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectrialCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *canUseTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *useConditionLabel;
@property (weak, nonatomic) IBOutlet UILabel *useNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *propmtImage;
@property (weak, nonatomic) IBOutlet UIImageView *couponBackImage;


/**
 *  获得cell
 */
+ (id)ElectrialCollectionViewCellWithCollectionView:(UICollectionView *)superCollectionView
                                        ResuableStr:(NSString *)resuableStr
                                          IndexPath:(NSIndexPath *)cellIndex;
@end
