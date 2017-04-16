//
//  CustomActionSheet.h
//  M-Cut
//
//  Created by apple on 16/12/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropmtModel.h"

typedef NS_ENUM(NSInteger, ActionViewType){
    oneEveryColumnType, //最普通的actionsheet
    fourEveryColumnType //每行四个，用作分享类型
};

@interface CustomActionSheet : UIView

/**
 *  collectionview
 */
@property (nonatomic, strong) UICollectionView *propmtCollectionView;

/**
 *  点击事件
 */
@property (nonatomic, copy) void(^touchBlock)(NSIndexPath *indexPath);

/**
 *  初始化方法
 */

/**
 *@brief    初始化方法
 *@param    frame       所在位置
 *@param    actionType  视图类型
 *@param    dataArray   标题或者model对象的数组
 */
- (instancetype)initWithFrame:(CGRect)frame Type:(ActionViewType)actionType DataArray:(NSArray *)dataArray;

@end
