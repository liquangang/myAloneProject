//
//  SelectMaterialArray.h
//  M-Cut
//
//  Created by apple on 16/11/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMNAssetModel.h"

/**
 *  该数组保存的是已选择的素材自定义对象 (保存两种对象，以保存到数据库中的和刚刚选中的)
 */

@interface SelectMaterialArray : NSObject
INSTANCEMETHOD

/**
 *  数组
 */
@property (nonatomic, strong) NSMutableArray *selectArray;

/**
 *  url数组
 */
@property (nonatomic, strong) NSMutableArray *selectAssModelURLMuArray;

/**
 *  url字典
 */
@property (nonatomic, strong) NSMutableDictionary *selectAssModelFileNameMuDic;

/**
 *  记录匹配次数，如果达到匹配次数，就不再匹配
 */
@property (nonatomic, assign) NSInteger matchCount;

/**
 *  增加素材
 */
- (BOOL)addMaterial:(id)assModel;

/**
 *  删除素材
 */
- (void)deleteMaterialWithAssModel:(XMNAssetModel *)assModel;

/**
 *  是否是创建页面已经添加的素材
 */
- (BOOL)isAlreadyAddWithAssModel:(XMNAssetModel *)assModel;

/**
 *  匹配素材
 */
- (void)judgeSelectStatusWithAssModel:(XMNAssetModel *)assModel CompleteBlock:(void(^)(BOOL isSelect))completeBlock;

/**
 *  删除所有素材
 */
- (void)removeAllMaterial;
@end
