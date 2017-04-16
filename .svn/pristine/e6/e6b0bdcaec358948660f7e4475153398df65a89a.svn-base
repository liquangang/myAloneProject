//
//  VideoLabelDetailFlowLayout.m
//  M-Cut
//
//  Created by liquangang on 16/9/18.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoLabelDetailFlowLayout.h"

@interface VideoLabelDetailFlowLayout()
/** 存储每一列的总高度*/
@property (nonatomic, strong) NSMutableDictionary * columnsHeight;
/** 存放每个item的布局属性*/
@property (nonatomic, strong) NSMutableArray * attrsArray;
@end

@implementation VideoLabelDetailFlowLayout
#pragma mark - 懒加载部分
- (NSMutableDictionary *)columnsHeight{
    if (!_columnsHeight) {
        _columnsHeight = [NSMutableDictionary new];
    }
    return _columnsHeight;
}

- (NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray new];
    }
    return _attrsArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.columnsMargin = 4;
        self.rowMargin = 4;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.columnsCount = 2;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (void)prepareLayout{
    [super prepareLayout];
    [self.collectionView reloadData];
    
    //清空最大的y值
    for (int i = 0; i < self.columnsCount; i++) {
        NSString * column = [NSString stringWithFormat:@"%d", i];
        self.columnsHeight[column] = @(self.sectionInset.top +
        self.heightBlock(ISScreen_Width, [NSIndexPath indexPathForItem:0 inSection:0]));
    }
    
    //计算所有的cell的布局属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes * attrs =
        [self layoutAttributesForItemAtIndexPath:[NSIndexPath
                                indexPathForItem:i
                                       inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

/** 返回所有尺寸*/
- (CGSize)collectionViewContentSize{
    __block NSString * maxColumn = @"0";
    [self.columnsHeight enumerateKeysAndObjectsUsingBlock:^(NSString *column, NSNumber *maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.columnsHeight[maxColumn] floatValue]) {
            maxColumn = column;
        }
    }];
    return CGSizeMake(0, [self.columnsHeight[maxColumn] floatValue]
                      + self.sectionInset.bottom
                      + self.heightBlock(ISScreen_Width, [NSIndexPath indexPathForItem:0 inSection:0]));
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //假设最短的那一列是0
    __block NSString * minColumn = @"0";
    //找出最短的那一列
    [self.columnsHeight enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber * maxY, BOOL * stop) {
        if ([maxY floatValue] < [self.columnsHeight[minColumn] floatValue]) {
            minColumn = column;
        }
    }];
    //计算尺寸
    CGFloat width = self.collectionView.frame.size.width
                    - self.sectionInset.left
                    - self.sectionInset.right
                    - (self.columnsCount - 1) * self.columnsMargin / self.columnsCount;
    CGFloat height = self.heightBlock(width, indexPath);
    
    //计算位置
    CGFloat x = self.sectionInset.left + (width + self.columnsMargin) * [minColumn floatValue];
    CGFloat y = [self.columnsHeight[minColumn] floatValue] + self.columnsMargin;
    
    //更新最大的y值
    self.columnsHeight[minColumn] = @(y + height);
    
    //创建该属性
    UICollectionViewLayoutAttributes * attribute =
    [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attribute.frame = CGRectMake(x, y, width, height);
    return attribute;
}

/** 返回rect范围内的布局属性*/
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}
@end
