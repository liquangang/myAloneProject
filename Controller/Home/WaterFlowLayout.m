//
//  WaterFlowLayout.m
//  M-Cut
//
//  Created by 刘海香 on 15/2/1.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "WaterFlowLayout.h"

@implementation WaterFlowLayout{
    NSMutableDictionary *attributesDic;
    NSMutableArray *columnArr;
    NSInteger cellCount;
}
- (void)prepareLayout{
    [super prepareLayout];
    attributesDic = [NSMutableDictionary dictionary];
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    cellCount = [self.collectionView numberOfItemsInSection:0];
    if (cellCount == 0) {
        return;
    }
    columnArr = [NSMutableArray array];
    float top = 0;
    for (int i = 0; i < 2; i++) {
        [columnArr addObject:[NSNumber numberWithFloat:top]];
    }
    for (int i = 0; i < cellCount; i++) {
        [self layoutForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
    }
}

- (void)layoutForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIEdgeInsets edgeInsets  = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.row];;
    CGSize itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    NSInteger column = 0;
    float shortHeight = [[columnArr objectAtIndex:column] floatValue];
    for (int i = 1; i< columnArr.count; i++) {
        float colHeight = [[columnArr objectAtIndex:i] floatValue];
        if (colHeight < shortHeight) {
            shortHeight = colHeight;
            column = i;
        }
    }
    float top = [[columnArr objectAtIndex:column] floatValue];
    CGRect frame = CGRectMake(edgeInsets.left + column*(edgeInsets.left+itemSize.width), top+edgeInsets.top, itemSize.width, itemSize.height);
    [columnArr replaceObjectAtIndex:column withObject:[NSNumber numberWithFloat:top + edgeInsets.top+itemSize.height]];
    [attributesDic setObject:indexPath forKey:NSStringFromCGRect(frame)];
}

- (NSArray *)indexPathsOfItemsInRect:(CGRect)rect{
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (NSString *rectStr in attributesDic) {
        CGRect cellRect = CGRectFromString(rectStr);
        if (CGRectIntersectsRect(rect, cellRect)) {
            NSIndexPath *indexPath = attributesDic[rectStr];
            [indexPaths addObject:indexPath];
        }
    }
    return indexPaths;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *attributes = [NSMutableArray array];
    NSArray *indexPaths = [self indexPathsOfItemsInRect:rect];
    for (NSIndexPath *indexPath in indexPaths) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        [attributes addObject:attribute];
    }
    return attributes;
}

- (CGSize)collectionViewContentSize{
    CGSize size = self.collectionView.frame.size;
    float maxHeight = [[columnArr objectAtIndex:0] floatValue];
    for (int i = 1; i < columnArr.count; i++) {
        float colHeight = [[columnArr objectAtIndex:i] floatValue];
        if (colHeight > maxHeight) {
            maxHeight = colHeight;
        }
    }
    size.height = maxHeight;
    return size;
}
@end
