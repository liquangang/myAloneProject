//
//  XMNAssetCell.h
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMNAssetModel;
@interface XMNAssetCell : UICollectionViewCell
@property (weak, nonatomic, nullable) IBOutlet UIButton *photoStateButton;

/**
 *  具体的资源model
 */
@property (nonatomic, strong, readonly, nonnull) XMNAssetModel *asset;

/**
 *  更新bottombar
 */
@property (nonatomic, copy, nullable) void(^updateBottomBarBlock)();

/**
 *  XMNPhotoCollectionController 中配置collectionView的cell
 *
 *  @param item 具体的AssetModel
 */
- (void)configCellWithItem:(XMNAssetModel * _Nonnull )item;

/**
 *  cell根据选中的素材数组，自动匹配是否显示选中
 */
+ (void)judgeSelectStatusWithSelectMaterialArray:(NSArray *_Nonnull)selectMaterialArray
                                  NeedJudgeModel:(XMNAssetModel * _Nonnull)assModel
                                   Completeblock:(void(^_Nonnull)(BOOL isSelect))completeBlock;

@end
