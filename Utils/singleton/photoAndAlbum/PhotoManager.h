//
//  PhotoManager.h
//  M-Cut
//
//  Created by apple on 16/12/23.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoManager : NSObject

/**
 *  单例调用方法
 */
INSTANCEMETHOD

/**
 *  获得相册胶卷
 */
- (PHFetchResult<PHAsset *> *)getPhotoAlbum;

/**
 *  获得某个相册中的所有资源对象
 */
- (PHFetchResult<PHAsset *> *)getAllPhotoWithFetch:(id)fetchResult;

/**
 *  获得某个资源对象对应的缩略图
 */
- (void)getAssetThumbnailWithAsset:(PHAsset *)asset TargetSize:(CGSize)size complete:(void(^)(UIImage *))complete;

/**
 *  同步获取缩略图（一定能获得）
 */
- (void)getAssetThumbnailSyncWithAsset:(PHAsset *)asset
                            TargetSize:(CGSize)size
                              complete:(void(^)(UIImage *))complete;

/**
 *  获得localURL
 */
- (NSString *)getLocalURLWithAsset:(PHAsset *)asset;

/**
 *  获得assetURL
 */
- (NSString *)getAssetURLWithAsset:(PHAsset *)asset;

/**
 *  获取文件大小
 */
- (void)getFileSizeWithAsset:(PHAsset *)asset complete:(void(^)(CGFloat))complete;

/**
 *  获得fileName
 */
- (NSString *)getFileNameWithAsset:(PHAsset *)asset;
@end
