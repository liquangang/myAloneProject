//
//  XMNPhotoCollectionController.h
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/29.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XMNAlbumModel;
@class XMNAssetModel;
@interface XMNPhotoCollectionController : UICollectionViewController

/** 具体的相册 */
@property (nonatomic, strong) XMNAlbumModel *album;

/**
 *  根据给定宽度 获取UICollectionViewLayout 实例
 *
 *  @param width collectionView 宽度
 *
 *  @return UICollectionViewLayout实例
 */
+ (UICollectionViewLayout *)photoCollectionViewLayoutWithWidth:(CGFloat)width;

@property (nonatomic, strong) NSIndexPath * collectionViewIndexPath;
@end
