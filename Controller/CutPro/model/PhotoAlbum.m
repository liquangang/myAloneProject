//
//  PhotoAlbum.m
//  M-Cut
//
//  Created by apple on 16/10/20.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "PhotoAlbum.h"
#import "XMNPhotoManager.h"

@interface PhotoAlbum()

//记录是否加载相册信息完成
@property (nonatomic, assign) BOOL isFinish;

//存储所有相册数据对象的字典
@property (nonatomic, strong) NSMutableDictionary * photoAlbumDic;
@end

@implementation PhotoAlbum
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    static PhotoAlbum * photoAlbum = nil;
    dispatch_once(&onceToken, ^{
        photoAlbum = [super new];
        [photoAlbum setPhotoAlbumDicWithBlock:nil];
    });
    return photoAlbum;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [PhotoAlbum shareInstance];
}

- (id)copy{
    return [PhotoAlbum shareInstance];
}

- (NSMutableDictionary *)photoAlbumDic{
    if (!_photoAlbumDic) {
        _photoAlbumDic = [NSMutableDictionary new];
    }
    return _photoAlbumDic;
}

/**
 *  找到所有的相册文件夹
 */
- (void)setPhotoAlbumDicWithBlock:(void(^)())photoAlbumBlock{
    WEAKSELF2
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        [[XMNPhotoManager sharedManager] getAlbumsPickingVideoEnable:YES
                                                     completionBlock:^(NSArray<XMNAlbumModel *> *albums) {
                                                         for (int i = 0; i < albums.count; i++) {
                                                             XMNAlbumModel * albumModel = albums[i];
                                                             [[XMNPhotoManager sharedManager] getAssetsFromResult:albumModel.fetchResult
                                                                                               pickingVideoEnable:YES
                                                                                                  completionBlock:^(NSArray<XMNAssetModel *> *assets) {
                                                                                                      [weakSelf.photoAlbumDic setObject:assets forKey:albumModel.name];
                                                                                                      if (i == albums.count - 1) {
                                                                                                          weakSelf.isFinish = YES;
                                                                                                          photoAlbumBlock();
                                                                                                      }
                                                                                                  }];
                                                         }
                                                     }];
    }, {})
}

/**
 *  调用该字典
 */
- (void)getPhotoAlbumDic:(void(^)(NSDictionary * photoAlbumDic))photoAlbumBlock{
    WEAKSELF2
    if (self.isFinish) {
        photoAlbumBlock(self.photoAlbumDic);
    }else{
        [self setPhotoAlbumDicWithBlock:^(NSDictionary *photoAlbumDic) {
            photoAlbumBlock(weakSelf.photoAlbumDic);
        }];
    }
}
@end
