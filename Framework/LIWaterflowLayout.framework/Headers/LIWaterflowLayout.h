//
//  LIWaterflowLayout.h
//  04-瀑布流
//
//  Created by apple on 14/12/4.
//  Copyright (c) 2014年 LI. All rights reserved.
//  

#import <UIKit/UIKit.h>
@class LIWaterflowLayout;

@protocol LIWaterflowLayoutDelegate <NSObject>
/**  根据  cell  的宽度计算  cell  的高度 */
- (CGFloat)waterflowLayout:(LIWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

#pragma mark -- collectionView 有头部\底部视图时要求实现
@optional
/**  collectionView  头部视图的尺寸 */
- (CGSize)waterflowLayout:(LIWaterflowLayout *)waterflowLayout sectionHeaderAtIndexPath:(NSIndexPath *)indexPath;
/**  collectionView  底部视图的尺寸 */
- (CGSize)waterflowLayout:(LIWaterflowLayout *)waterflowLayout sectionFooterAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface LIWaterflowLayout : UICollectionViewLayout
/**  每一组之间的间距 */
@property (assign, nonatomic) UIEdgeInsets sectionEdgeInset;
/**  每一个cell之间的间距 */
@property (nonatomic, assign) UIEdgeInsets itemEdgeInset;
/**  每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/**  每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/**  显示多少列 */
@property (nonatomic, assign) int columnsCount;

/**  
 *  瀑布流 cell是否按照顺序添加  
 *  YES:按顺序添加 ---  伪瀑布流
 *  NO:从当前最短的那一列下面添加 --
 */
@property (assign, nonatomic) BOOL addItemByOrder;

@property (nonatomic, weak) id<LIWaterflowLayoutDelegate> delegate;

@end
