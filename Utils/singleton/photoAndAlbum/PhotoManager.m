//
//  PhotoManager.m
//  M-Cut
//
//  Created by apple on 16/12/23.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "PhotoManager.h"

@interface PhotoManager()
@property (nonatomic, strong) PHImageManager *imageManager;
@end

@implementation PhotoManager

#pragma mark - interface

/**
 *  创建单例
 */
CREATESINGLETON(PhotoManager)

/**
 *  获得相册胶卷
 */
- (PHFetchResult *)getPhotoAlbum{
    PHFetchOptions * allPhotosOptions = [[PHFetchOptions alloc] init];
    allPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    return [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeImage options:allPhotosOptions];
}

/**
 *  获得某个相册中的所有资源对象
 */
- (PHFetchResult *)getAllPhotoWithFetch:(id)fetchResult{
    PHFetchResult *result = (PHFetchResult *)fetchResult;
    PHAssetCollection *assetCollection = (PHAssetCollection *)[result firstObject];
    PHFetchResult *assetResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    return assetResult;
}

/**
 *  获得某个资源对象对应的缩略图(异步，不一定能获得，但是速度快)
 */
- (void)getAssetThumbnailWithAsset:(PHAsset *)asset TargetSize:(CGSize)size complete:(void(^)(UIImage *))complete{

    [self.imageManager requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        complete ? complete(result) : nil;
    }];
}

/**
 *  同步获取缩略图（一定能获得）
 */
- (void)getAssetThumbnailSyncWithAsset:(PHAsset *)asset
                            TargetSize:(CGSize)size
                              complete:(void(^)(UIImage *))complete{
    PHImageRequestOptions *imageRequestOption = [[PHImageRequestOptions alloc] init];
    imageRequestOption.synchronous = YES;
    
    [self.imageManager requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:imageRequestOption resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if (!result) {
            WEAKSELF2
            [weakSelf getAssetThumbnailSyncWithAsset:asset TargetSize:size complete:nil];
        }else{
            complete ? complete(result) : nil;
        }
    }];
}

/**
 *  获得localURL
 */
- (NSString *)getLocalURLWithAsset:(PHAsset *)asset{
    NSString *KCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [[NSString alloc] initWithFormat: @"%@/%@", KCachesPath, [self getFileNameWithAsset:asset]];
}

/**
 *  获得fileName
 */
- (NSString *)getFileNameWithAsset:(PHAsset *)asset{
    return [[[PHAssetResource assetResourcesForAsset:asset] firstObject] originalFilename];
}

/**
 *  获得assetURL
 */
- (NSString *)getAssetURLWithAsset:(PHAsset *)asset{
    PHAssetResource *assetResource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
    NSString * fileType = [assetResource.originalFilename componentsSeparatedByString:@"."][1];
    NSString * fileId = [assetResource.assetLocalIdentifier componentsSeparatedByString:@"/"][0];
    return [NSString stringWithFormat:@"assets-library://asset/asset.%@?id=%@&ext=%@", fileType, fileId, fileType];
}

/**
 *  获取文件大小
 */
- (void)getFileSizeWithAsset:(PHAsset *)asset complete:(void(^)(CGFloat))complete{
    PHImageRequestOptions *imageRequestOption = [[PHImageRequestOptions alloc] init];
    imageRequestOption.synchronous = YES;
    [self.imageManager requestImageDataForAsset:asset options:imageRequestOption resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info){
        complete ? complete(((CGFloat)imageData.length)/1024/1024) : nil;
     }];
}


#pragma mark - getter

- (PHImageManager *)imageManager{
    if (!_imageManager) {
        _imageManager = [PHImageManager defaultManager];
    }
    return _imageManager;
}

@end
