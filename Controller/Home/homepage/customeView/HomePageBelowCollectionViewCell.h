//
//  HomePageBelowCollectionViewCell.h
//  M-Cut
//
//  Created by liquangang on 16/9/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageLabelModel.h"
#import "MovierDCInterfaceSvc.h"

@interface HomePageBelowCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * backImage;

/** 获得复用的cell*/
+ (id)getHomePageBelowCollectionViewCellWithCollectionView:(UICollectionView *)cellSuperCollectionView
                                                  CellInfo:(HomePageLabelModel *)cellInfo
                                                 CellIndex:(NSIndexPath *)cellIndex
                                               ResuableStr:(NSString *)resuableStr;
@end
