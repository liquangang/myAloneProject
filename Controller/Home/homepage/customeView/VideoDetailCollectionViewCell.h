//
//  VideoDetailCollectionViewCell.h
//  M-Cut
//
//  Created by liquangang on 16/9/19.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoDetailCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lookTimesLabel;

/*****************************************************************
 函数名称：+ (id)getVideoDetailCollectionViewCellWithCollectionView:(UICollectionView *)itemSuperCollectionView
                                                         ItemInfo:(NSDictionary *)itemInfo
                                                    ItemIndexPath:(NSIndexPath *)itemIndex
                                                 ReuserIdentifier:(NSString *)reuserId;
 函数描述： 获得复用cell（2016-09-19增加）
 输入参数：itemSuperCollectionView:item所在的collectionview
         itemInfo：item上需要的信息
         itemIndex：item的位置
         reuserId：item的复用标识
 输出参数：N/A
 返回值： 一个初始化完成的item
 *****************************************************************/
+ (id)getVideoDetailCollectionViewCellWithCollectionView:(UICollectionView *)itemSuperCollectionView
                                                ItemInfo:(NSDictionary *)itemInfo
                                           ItemIndexPath:(NSIndexPath *)itemIndex
                                        ReuserIdentifier:(NSString *)reuserId;
@end
