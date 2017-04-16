//
//  ISWaterflowLayout.h
//  INSHOW
//
//  Created by 李亚飞 on 15/11/12.
//  Copyright © 2015年 李亚飞. All rights reserved.
//  cell 顺序添加 伪瀑布流, 第一个 cell 特殊处理

#import <UIKit/UIKit.h>
@class ISWaterflowLayout;

@protocol ISWaterflowLayoutDelegate <NSObject>
/**  根据宽度值求出高度 */
- (CGFloat)waterflowLayout:(ISWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;
@end

@interface ISWaterflowLayout : UICollectionViewLayout
@property (nonatomic, assign) UIEdgeInsets itemInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) NSInteger columnsCount;

@property (nonatomic, weak) id<ISWaterflowLayoutDelegate> delegate;

@end
