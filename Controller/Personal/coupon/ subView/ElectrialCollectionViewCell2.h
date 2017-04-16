//
//  ElectrialCollectionViewCell2.h
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElectrialCollectionViewCell2 : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *electrialImage;
@property (weak, nonatomic) IBOutlet UILabel *electrialNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *electrialMachine;

/**
 *  获得cell
 */
+ (instancetype)ElectrialCollectionViewCell2WithCollectionView:(UICollectionView *)superCollectionView
                                                   ResuableStr:(NSString *)resuableStr
                                                         Index:(NSIndexPath *)index
                                                      CellInfo:(NSDictionary *)cellInfoDic;
@end