//
//  SelectMaterialArray.m
//  M-Cut
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "SelectMaterialArray.h"
#import "CustomeClass.h"
#import "App_vpVDCOrderForCreate.h"

@interface SelectMaterialArray()
@end

@implementation SelectMaterialArray
CREATESINGLETON(SelectMaterialArray)

#pragma mark - 接口

/**
 *  素材时长是否超过180s
 */
- (BOOL)isMaterialLength{
    
    //总时长
    NSInteger timeLength = 0;
    for (id tempModel in SINGLETON(SelectMaterialArray).selectArray) {
        if ([tempModel isKindOfClass:[NewOrderVideoMaterial class]]) {
            NewOrderVideoMaterial *tempObj = (NewOrderVideoMaterial *)tempModel;
            timeLength += tempObj.material_playduration;
        }else{
            XMNAssetModel *tempobj = (XMNAssetModel *)tempModel;
            NSString *timeStr = tempobj.timeLength;
            NSArray *tempArray = [timeStr componentsSeparatedByString:@":"];
            timeLength += [tempArray[0] integerValue] + [tempArray[1] integerValue];
            if ([tempArray[0] integerValue] == 0 && [tempArray[1] integerValue] == 0) {
                timeLength += 3;
            }
        }
    }
    
    if (timeLength > 180) {
        [CustomeClass showMessage:@"素材时长不能超过180s" ShowTime:3];
        return NO;
    }
    return YES;
}

/**
 *  素材数量是否超过20个
 */
- (BOOL)isMaterialNum{
    
    if (self.selectArray.count >= 20) {
        [CustomeClass showMessage:@"素材数量不能超过20个！" ShowTime:3];
        return NO;
    }
    return YES;
}

/**
 *  增加素材
 */
- (BOOL)addMaterial:(id)assModel{
    
    if ([self isMaterialNum] && [self isMaterialLength]) {
        [self.selectArray addObject:assModel];
        
        if ([assModel isKindOfClass:[NewOrderVideoMaterial class]]) {
            NewOrderVideoMaterial *tempObj = (NewOrderVideoMaterial *)assModel;
            [self.selectAssModelURLMuArray addObject:[tempObj.material_localURL lastPathComponent]];
            [self.selectAssModelFileNameMuDic setObject:@(1) forKey:[tempObj.material_localURL lastPathComponent]];
        }else{
            XMNAssetModel *tempModel = (XMNAssetModel *)assModel;
            [self.selectAssModelURLMuArray addObject:tempModel.filename];
            [self.selectAssModelFileNameMuDic setObject:@(1) forKey:tempModel.filename];
        }
        return YES;
    }
    return NO;
}

/**
 *  删除素材
 */
- (void)deleteMaterialWithAssModel:(XMNAssetModel *)assModel{
    for (id tempAssModel in self.selectArray) {
        NSString *imageUrl;
        
        if ([tempAssModel isKindOfClass:[NewOrderVideoMaterial class]]) {
            NewOrderVideoMaterial *tempObj = (NewOrderVideoMaterial *)tempAssModel;
            imageUrl = tempObj.material_assetsURL;
        }else{
            XMNAssetModel *tempModel = (XMNAssetModel *)tempAssModel;
            imageUrl = tempModel.imageUrl;
        }
        
        if ([imageUrl isEqualToString:assModel.imageUrl]) {
            [self.selectArray removeObject:tempAssModel];
            [self.selectAssModelURLMuArray removeObject:imageUrl];
            [self.selectAssModelFileNameMuDic removeObjectForKey:assModel.filename];
            break;
        }
    }
}

/**
 *  是否是创建页面已经添加的素材
 */
- (BOOL)isAlreadyAddWithAssModel:(XMNAssetModel *)assModel{
    BOOL isHave = NO;
    for (id tempAssModel in self.selectArray) {
        NSString *imageUrl;
        if ([tempAssModel isKindOfClass:[NewOrderVideoMaterial class]]) {
            NewOrderVideoMaterial *tempObj = (NewOrderVideoMaterial *)tempAssModel;
            imageUrl = tempObj.material_assetsURL;
        }
        if ([imageUrl isEqualToString:assModel.imageUrl]) {
            isHave = YES;
            break;
        }
    }
    return isHave;
}

/**
 *  匹配素材
 */
- (BOOL)isSelectMaterialWithURL:(NSString *)imageURL{
    
    if (self.selectAssModelURLMuArray.count == 0) {
        return NO;
    }
    
    self.matchCount++;
    
    if (self.matchCount == self.selectAssModelURLMuArray.count) {
        return NO;
    }
    
    for (NSString *imageStr in self.selectAssModelURLMuArray) {
        
        if ([imageStr isEqualToString:imageURL]) {
            return YES;
        }
    }
    
    return NO;
}

/**
 *  删除所有素材
 */
- (void)removeAllMaterial{
    [self.selectAssModelURLMuArray removeAllObjects];
    [self.selectArray removeAllObjects];
    [self.selectAssModelFileNameMuDic removeAllObjects];
}

- (void)judgeSelectStatusWithAssModel:(XMNAssetModel *)assModel CompleteBlock:(void(^)(BOOL isSelect))completeBlock{
    WEAKSELF2
    
    [CustomeClass backgroundAsyncQueue:^{
        
        if (weakSelf.matchCount == weakSelf.selectAssModelURLMuArray.count) {
            completeBlock(NO);
        }
        
        if (assModel.selectStatus == unKnow) {
            NSMutableArray *selectArray = [[NSMutableArray alloc] initWithArray:[self.selectAssModelURLMuArray copy]];
            dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
            dispatch_apply(selectArray.count, queue, ^(size_t index) {
                
                if ([selectArray[index] isEqualToString:assModel.imageUrl]) {
                    assModel.selectStatus = selected;
                    weakSelf.matchCount++;
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

#pragma mark - 懒加载

- (NSMutableArray *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray new];
    }
    return _selectArray;
}

- (NSMutableArray *)selectAssModelURLMuArray{
    LAZYINITMUARRAY(_selectAssModelURLMuArray)
}

- (NSMutableDictionary *)selectAssModelFileNameMuDic{
    if (!_selectAssModelFileNameMuDic) {
        _selectAssModelFileNameMuDic = [NSMutableDictionary new];
    }
    return _selectAssModelFileNameMuDic;
}
@end
