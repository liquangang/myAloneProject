//
//  XMNAssetModel.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNAssetModel.h"
#import "App_vpVDCOrderForCreate.h"
#import "XMNPhotoPickerDefines.h"
#import "XMNPhotoManager.h"
#import "CustomeClass.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "SelectMaterialArray.h"

@interface XMNAssetModel ()


/** PHAsset or ALAsset */
@property (nonatomic, strong) _Nonnull id asset;
/** asset  类型 */
@property (nonatomic, assign) XMNAssetType type;

/// ========================================
/// @name   视频,audio相关信息
/// ========================================

/** asset为Video时 video的时长 */
@property (nonatomic, copy) NSString *timeLength;




@end

@implementation XMNAssetModel
@synthesize originImage = _originImage;
@synthesize thumbnail = _thumbnail;
@synthesize cellThumbnail = _cellThumbnail;
@synthesize previewImage = _previewImage;
@synthesize imageOrientation = _imageOrientation;
@synthesize playerItem = _playerItem;
@synthesize playerItemInfo = _playerItemInfo;
@synthesize filename = _filename;
@synthesize imageUrl = _imageUrl;
@synthesize largerThumbnail = _largerThumbnail;
//@synthesize selectStatus = _selectStatus;

#pragma mark - Methods



/// ========================================
/// @name   Class Methods
/// ========================================

/**
 *  根据asset,type获取XMNAssetModel实例
 *
 *  @param asset 具体的Asset类型 PHAsset or ALAsset
 *  @param type  asset类型
 *
 *  @return XMNAssetModel实例
 */
+ ( XMNAssetModel  * _Nonnull )modelWithAsset:(_Nonnull id)asset type:(XMNAssetType)type {
    return [self modelWithAsset:asset type:type timeLength:@""];
}

/**
 *  根据asset,type,timeLength获取XMNAssetModel实例
 *
 *  @param asset      asset 非空
 *  @param type       asset 类型
 *  @param timeLength video时长
 *
 *  @return XMNAssetModel实例
 */
+ ( XMNAssetModel * _Nonnull )modelWithAsset:(_Nonnull id)asset type:(XMNAssetType)type timeLength:(NSString * _Nullable )timeLength {
    XMNAssetModel *model = [[XMNAssetModel alloc] init];
    model.asset = asset;
    model.type = type;
    model.timeLength = timeLength;
    return model;
}

#pragma mark - Getters

- (UIImage *)originImage {
    if (_originImage) {
        return _originImage;
    }
    __block UIImage *resultImage;
    [[XMNPhotoManager sharedManager] getOriginImageWithAsset:self.asset completionBlock:^(UIImage *image){
        resultImage = image;
    }];
    _originImage = resultImage;
    return resultImage;
}

- (UIImage *)thumbnail {
    if (_thumbnail) {
        return _thumbnail;
    }
    __block UIImage *resultImage;
    [[XMNPhotoManager sharedManager] getThumbnailWithAsset:self.asset size:kXMNThumbnailSize completionBlock:^(UIImage *image){
        resultImage = image;
    }];
    _thumbnail = resultImage;
    return _thumbnail;
}

- (UIImage *)cellThumbnail{
    if (!_cellThumbnail) {
        __block UIImage *resultImage;
        [[XMNPhotoManager sharedManager] getCellThumbnailWithAsset:self.asset size:kXMNThumbnailSize completionBlock:^(UIImage *image){
            resultImage = image;
        }];
        _cellThumbnail = resultImage;
    }
    return _cellThumbnail;
}

- (UIImage *)largerThumbnail {
    if (_largerThumbnail) {
        return _largerThumbnail;
    }
    __block UIImage *resultImage;
    [[XMNPhotoManager sharedManager] getThumbnailWithAsset:self.asset size:CGSizeMake(320, 320) completionBlock:^(UIImage *image){
        resultImage = image;
    }];
    _largerThumbnail = resultImage;
    return _largerThumbnail;
}

- (UIImage *)previewImage {
    if (_previewImage) {
        return _previewImage;
    }
    __block UIImage *resultImage;
    [[XMNPhotoManager sharedManager] getPreviewImageWithAsset:self.asset completionBlock:^(UIImage *image) {
        resultImage = image;
    }];
    _previewImage = resultImage;
    return _previewImage;
}

- (UIImageOrientation)imageOrientation {
    if (_imageOrientation) {
        return _imageOrientation;
    }
    __block UIImageOrientation resultOrientation;
    [[XMNPhotoManager sharedManager] getImageOrientationWithAsset:self.asset completionBlock:^(UIImageOrientation imageOrientation) {
        resultOrientation = imageOrientation;
    }];
    _imageOrientation = resultOrientation;
    return _imageOrientation;
}

- (AVPlayerItem *)playerItem {
    if (_playerItem) {
        return _playerItem;
    }
    __block AVPlayerItem *resultItem;
    __block NSDictionary *resultItemInfo;
    [[XMNPhotoManager sharedManager] getVideoInfoWithAsset:self.asset completionBlock:^(AVPlayerItem *playerItem, NSDictionary *playerItemInfo) {
        resultItem = playerItem;
        resultItemInfo = [playerItemInfo copy];
    }];
    _playerItem = resultItem;
    _playerItemInfo = resultItemInfo ? : _playerItemInfo;
    return _playerItem;
}


- (NSDictionary *)playerItemInfo {
    if (_playerItemInfo) {
        return _playerItemInfo;
    }
    __block AVPlayerItem *resultItem;
    __block NSDictionary *resultItemInfo;
    [[XMNPhotoManager sharedManager] getVideoInfoWithAsset:self.asset completionBlock:^(AVPlayerItem *playerItem, NSDictionary *playerItemInfo) {
        resultItem = playerItem;
        resultItemInfo = [playerItemInfo copy];
    }];
    _playerItem = resultItem ? : _playerItem;
    _playerItemInfo = resultItemInfo;
    return _playerItemInfo;
}

- (NSString *)filename{
    if (!_filename) {
        __block NSString *resultFilename;
        [[XMNPhotoManager sharedManager] getAssetNameWithAsset:self.asset completionBlock:^(NSString * _Nullable info) {
            resultFilename = [info copy];
        }];
        _filename = [resultFilename copy];
    }
    return _filename;
}

- (NSString *)imageUrl{
    if (!_imageUrl) {
        __block NSString * resultFilePath;
        [[XMNPhotoManager sharedManager] getAssetPathWithAsset:self.asset completionBlock:^(NSString * _Nullable info) {
            resultFilePath = [info copy];
        }];
        _imageUrl = [resultFilePath copy];
    }
    return _imageUrl;
}

- (NSURL *)fileAssUrl{
    if (!_fileAssUrl) {
        __block NSString * resultFilePath;
        [[XMNPhotoManager sharedManager] getAssetPathWithAsset:self.asset completionBlock:^(NSString * _Nullable info) {
            resultFilePath = [info copy];
        }];
        _fileAssUrl = [NSURL URLWithString:resultFilePath];
    }
    return _fileAssUrl;
}

//- (SelectStatus)selectStatus{
//    if (_selectStatus == unKnow) {
//        __block SelectStatus isSelect = unKnow;
//        [CustomeClass backgroundAsyncQueue:^{
//            isSelect = unSelect;
//            NSArray *selectArray = SINGLETON(SelectMaterialArray).selectArray;
//            for (id newOrderVideoMaterial in SINGLETON(SelectMaterialArray).selectArray) {
//                NSString *imageUrl;
//                if ([newOrderVideoMaterial isKindOfClass:[NewOrderVideoMaterial class]]) {
//                    NewOrderVideoMaterial *tempObj = (NewOrderVideoMaterial *)newOrderVideoMaterial;
//                    imageUrl = tempObj.material_assetsURL;
//                }else{
//                    XMNAssetModel *tempModel = (XMNAssetModel *)newOrderVideoMaterial;
//                    imageUrl = tempModel.imageUrl;
//                }
//                if ([imageUrl isEqualToString:self.imageUrl]) {
//                    isSelect = selected;
//                    break;
//                }
//            }
//        }];
//        _selectStatus = isSelect;
//    }
//    return _selectStatus == selected ? YES : NO;
//}


- (NSString *)description {
    return [NSString stringWithFormat:@"\n-------XMNAssetModel Desc Start-------\ntype : %d\nsuper :%@\n-------XMNAssetModel Desc End-------",(int)self.type,[super description]];
}
@end
