//
//  CloudHeaderCollectionViewCell.h
//  M-Cut
//
//  Created by apple on 16/12/5.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudHeaderCollectionViewCell : UICollectionViewCell

/**
 *  删除
 */
@property (nonatomic, copy) void(^deleteBlock)();

/**
 *  增加
 */
@property (nonatomic, copy) void(^addBlock)();

/**
 *  搜索
 */
@property (nonatomic, copy) void(^searchBlock)();
@end
