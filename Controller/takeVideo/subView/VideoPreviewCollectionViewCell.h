//
//  VideoPreviewCollectionViewCell.h
//  M-Cut
//
//  Created by apple on 16/10/29.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempVideoOBj.h"

@interface VideoPreviewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoThumailImageView;
@property (weak, nonatomic) IBOutlet UIButton *playImage;

/**
 *  获得cell
 */
+ (id)VideoPreviewCollectionViewCellWithTable:(UICollectionView *)collectionView
                                  ResuableStr:(NSString *)resuableStr
                                    IndexPath:(NSIndexPath *)index
                                     AssModel:(TempVideoOBj *)assModel;
@end
