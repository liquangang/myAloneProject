//
//  XMNPhotoPreviewCell.h
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/29.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMNAssetModel;
@interface XMNPhotoPreviewCell : UICollectionViewCell

@property (nonatomic, copy, nullable)   void(^singleTapBlock)();
@property (nonatomic, copy, nullable) void(^setPlayer)();

- (void)configCellWithItem:(XMNAssetModel * _Nonnull )item;

- (void)setPlayButtonHidden:(BOOL)isHidden;
@end