//
//  ISWaterflowLayout.h
//  INSHOW
//
//  Created by 李亚飞 on 15/11/12.
//  Copyright © 2015年 李亚飞. All rights reserved.
//

#import "ISWaterflowLayout.h"
// cell 之间的间距
#define ISHomeCellMargin 4
// 顶部视图的高度
#define ISHomeTopViewRatio (372.0 / 740.0)
#define ISHomeTopViewHeight ((ISScreen_Width - 2 * ISHomeCellMargin) * ISHomeTopViewRatio)

#define ISHomeTopViewRatioWhenSearchBarHidden (288.0 / 740.0)
#define ISHomeTopViewHeightWhenSearchBarHidden ((ISScreen_Width - 2 * ISHomeCellMargin) * ISHomeTopViewRatioWhenSearchBarHidden)
@interface ISWaterflowLayout();

/** 这个字典用来存储每一列 Y 值 */
@property (nonatomic, strong) NSMutableDictionary *heightDict;

/** 存放所有的布局属性 */
@property (nonatomic, strong) NSMutableArray *attrsArray;
@end

@implementation ISWaterflowLayout

- (NSMutableDictionary *)heightDict {
    if (!_heightDict) {
        self.heightDict = [NSMutableDictionary dictionary];
    }
    return _heightDict;
}

- (NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        self.attrsArray = [[NSMutableArray alloc] init];
    }
    return _attrsArray;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.columnMargin = 10;
        self.rowMargin = 10;
        self.itemInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnsCount = 3;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  每次布局之前的准备
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    // 1.清空最大的Y值
    for (NSInteger column = 0; column < self.columnsCount; column++) {
        self.heightDict[@(column)] = @(self.itemInset.top);
    }
    
    // 2.计算所有cell的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i<count; i++) {
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

/**
 *  返回所有的尺寸
 */
- (CGSize)collectionViewContentSize
{
    __block NSNumber *maxColumn = @(0);
    [self.heightDict enumerateKeysAndObjectsUsingBlock:^(NSNumber *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.heightDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.heightDict[maxColumn] floatValue] + self.itemInset.bottom);
}

/**
 *  返回rect范围内的布局属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

#pragma  mark ---- 下面是对第一个 cell 进行特殊处理的布局
/**
 *  返回indexPath这个位置Item的布局属性
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.item == 0) {
        attrs.frame = CGRectMake(self.rowMargin, 0, self.collectionView.size.width - self.rowMargin * 2, ISHomeTopViewHeightWhenSearchBarHidden);
        return attrs;
    } else {
    
        // 顺序添加, 计算列号
        NSInteger column = (indexPath.item - 1) % self.columnsCount;
    
        // 计算尺寸
        CGFloat width = (self.collectionView.frame.size.width - self.itemInset.left - self.itemInset.right - (self.columnsCount - 1) * self.columnMargin)/self.columnsCount;
        CGFloat height = [self.delegate waterflowLayout:self heightForWidth:width atIndexPath:indexPath];
        
        // 计算位置
        CGFloat x = self.itemInset.left + column * (width + self.columnMargin);
        CGFloat y = [self.heightDict[@(column)] floatValue] + self.rowMargin;
        
        // 更新这一列的最大Y值
        self.heightDict[@(column)] = @(y + height);
        
        // 创建属性
//        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attrs.frame = CGRectMake(x, y, width, height);
        return attrs;
    }
    //    return attrs;
}

@end
