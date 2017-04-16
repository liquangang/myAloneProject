//
//  XMNAssetCell.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/28.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNAssetCell.h"
#import "XMNAssetModel.h"
#import "XMNPhotoManager.h"
#import "UIView+Animations.h"
#import "CustomeClass.h"
#import "SelectMaterialArray.h"
#import "App_vpVDCOrderForCreate.h"

@interface XMNAssetCell ()
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *videoLengthLabel;
@end

@implementation XMNAssetCell
@synthesize asset = _asset;

#pragma mark - Methods

/**
 *  XMNPhotoCollectionController 中配置collectionView的cell
 *
 *  @param item 具体的AssetModel
 */
- (void)configCellWithItem:(XMNAssetModel * _Nonnull )item{
    _asset = item;
    self.photoImageView.image = item.cellThumbnail;
    switch (item.type) {
        case XMNAssetTypeVideo:
        case XMNAssetTypeAudio:
        {
            self.videoView.hidden = NO;
            self.videoLengthLabel.text = item.timeLength;
        }
            break;
        case XMNAssetTypeLivePhoto:
        case XMNAssetTypePhoto:
        {
            self.videoView.hidden = YES;
        }
            break;
    }
}

/**
 *  cell根据选中的素材数组，自动匹配是否显示选中
 */
+ (void)judgeSelectStatusWithSelectMaterialArray:(NSArray *)selectMaterialArray
                                  NeedJudgeModel:(XMNAssetModel *)assModel
                                   Completeblock:(void(^)(BOOL isSelect))completeBlock{
    
    [CustomeClass backgroundQueue:^{
        
        if (assModel.selectStatus == unKnow) {
            assModel.selectStatus = unSelect;
            
            //            for (id newOrderVideoMaterial in selectMaterialArray) {
            //                NSString *imageUrl;
            //
            //                if ([newOrderVideoMaterial isKindOfClass:[NewOrderVideoMaterial class]]) {
            //                    NewOrderVideoMaterial *tempObj = (NewOrderVideoMaterial *)newOrderVideoMaterial;
            //                    imageUrl = tempObj.material_assetsURL;
            //                }else{
            //                    XMNAssetModel *tempModel = (XMNAssetModel *)newOrderVideoMaterial;
            //                    imageUrl = tempModel.imageUrl;
            //                }
            //
            //                if ([imageUrl isEqualToString:assModel.imageUrl]) {
            //                    assModel.selectStatus = selected;
            //                    break;
            //                }
            //            }
            if ([selectMaterialArray containsObject:assModel.imageUrl]) {
                assModel.selectStatus = selected;
            }
            completeBlock(assModel.selectStatus - 1);
        }else{
            completeBlock(assModel.selectStatus - 1);
        }
    }];
    
    
}

- (void)judgeSelectStatusWithArray:(NSArray *)selectArray
                          AssModel:(XMNAssetModel *)assModel
                        MatchCount:(NSInteger)matchCount
                     CompleteBlock:(void(^)(BOOL isSelect))completeBlock{
    
    [CustomeClass backgroundAsyncQueue:^{
        
        if (matchCount == selectArray.count) {
            completeBlock(NO);
        }
        
        if (assModel.selectStatus == unKnow) {
            dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
            dispatch_apply(selectArray.count, queue, ^(size_t index) {
                
                if ([selectArray[index] isEqualToString:assModel.imageUrl]) {
                    assModel.selectStatus = selected;
                    completeBlock(YES);
                }
                
                if (index == selectArray.count - 1) {
                    assModel.selectStatus = unSelect;
                    completeBlock(NO);
                }
            });
        }else{
            completeBlock(assModel.selectStatus - 1);
        }
    }];
}

/**
 *  处理stateButton的点击动作
 *
 *  @param sender button
 */
- (IBAction)_handleButtonAction:(UIButton *)sender {
    
    //如果是已经添加到创建页面的话，提示不能取消
    if (sender.selected && [SINGLETON(SelectMaterialArray) isAlreadyAddWithAssModel:self.asset]) {
        ALERT(@"素材已添加！")
        return;
    }
    
    if (sender.selected) {
        
        //已选中，此时需取消选中
        [SINGLETON(SelectMaterialArray) deleteMaterialWithAssModel:self.asset];
        
        //更改bottombar
        self.updateBottomBarBlock();
    }else{
        
        //未选中，此时需选中
        if ([SINGLETON(SelectMaterialArray) addMaterial:self.asset]) {
            self.updateBottomBarBlock();
        }else{
            return;
        }
        
    }
    sender.selected = !sender.selected;
    
    if (self.photoStateButton.selected) {
        self.asset.selectStatus = selected;
    }else{
        self.asset.selectStatus = unSelect;
    }
    
        self.asset.selected = sender.selected;
}

@end
