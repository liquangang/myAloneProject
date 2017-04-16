//
//  ISSpecialFlowLayout.h
//  M-Cut
//
//  Created by 李亚飞 on 15/12/1.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ISSpecialFlowLayout;

@protocol ISSpecialFlowLayoutDelegate <NSObject>
/**  根据宽度值求出高度 */
- (CGFloat)waterflowLayout:(ISSpecialFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

- (CGFloat)waterflowLayout:(ISSpecialFlowLayout *)waterflowLayout firstCellHeight:(CGFloat)width;
@end

@interface ISSpecialFlowLayout : UICollectionViewLayout

@property (nonatomic, assign) UIEdgeInsets itemInset;
/** 每一列之间的间距 */
@property (nonatomic, assign) CGFloat columnMargin;
/** 每一行之间的间距 */
@property (nonatomic, assign) CGFloat rowMargin;
/** 显示多少列 */
@property (nonatomic, assign) NSInteger columnsCount;

@property (nonatomic, weak) id<ISSpecialFlowLayoutDelegate> delegate;
@end
