//
//  VideoDetailCollectionViewCell.m
//  M-Cut
//
//  Created by liquangang on 16/9/19.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoDetailCollectionViewCell.h"

#import <UIImageView+WebCache.h>

@implementation VideoDetailCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (id)getVideoDetailCollectionViewCellWithCollectionView:(UICollectionView *)itemSuperCollectionView
                                                ItemInfo:(NSDictionary *)itemInfo
                                           ItemIndexPath:(NSIndexPath *)itemIndex
                                        ReuserIdentifier:(NSString *)reuserId
{
    VideoDetailCollectionViewCell * cell = [itemSuperCollectionView
                                            dequeueReusableCellWithReuseIdentifier:reuserId
                                            forIndexPath:itemIndex];
    //设置背景图片
    [cell.backImage sd_setImageWithURL:[NSURL URLWithString:STRTOUTF8(itemInfo[@"video_thumbnail"])]
                      placeholderImage:DEFAULTVIDEOTHUMAIL];
    
    //设置用户头像
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:STRTOUTF8(itemInfo[@"customer_avatar"])]
                      placeholderImage:DEFAULTHEADIMAGE];
    
    //设置用户昵称
    cell.userNameLabel.text = itemInfo[@"customer_nickname"];
    
    //设置观看次数
    cell.lookTimesLabel.text = itemInfo[@"visitcount"];
    
    //设置电影名称
    cell.videoNameLabel.text = itemInfo[@"video_name"];
    
    return cell;
}

@end
