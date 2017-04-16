//
//  PPImageScrollingCellView.m
//  PPImageScrollingTableViewDemo
//
//  Created by popochess on 13/8/9.
//  Copyright (c) 2013年 popochess. All rights reserved.
//

#import "PPImageScrollingCellView.h"
#import "PPCollectionViewCell.h"

@interface  PPImageScrollingCellView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) PPCollectionViewCell *myCollectionViewCell;
@property (strong, nonatomic) UICollectionView *myCollectionView;
@property (strong, nonatomic) NSArray *collectionImageData;
@property (strong, nonatomic) NSArray *collectionURL;
@property (nonatomic) CGFloat imagetitleWidth;
@property (nonatomic) CGFloat imagetitleHeight;
@property (strong, nonatomic) UIColor *imageTilteBackgroundColor;
@property (strong, nonatomic) UIColor *imageTilteTextColor;


@end

@implementation PPImageScrollingCellView

- (id)initWithFrame:(CGRect)frame
{
     self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code

        /* Set flowLayout for CollectionView*/
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemSize = CGSizeMake(frame.size.height-2, frame.size.height-2);
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 5, 2, 5);
        flowLayout.minimumLineSpacing = 1;

        /* Init and Set CollectionView */
        self.myCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        self.myCollectionView.delegate = self;
        self.myCollectionView.dataSource = self;
        self.myCollectionView.showsHorizontalScrollIndicator = NO;

        [self.myCollectionView registerClass:[PPCollectionViewCell class] forCellWithReuseIdentifier:@"PPCollectionCell"];
        [self addSubview:_myCollectionView];
    }
    return self;
}

- (void) setImageData:(NSArray*)collectionImageData URL:(NSArray*)collectionURL{

    _collectionURL = collectionURL;
    _collectionImageData = collectionImageData;
    [_myCollectionView reloadData];
}

- (void) setBackgroundColor:(UIColor*)color{

    self.myCollectionView.backgroundColor = color;
    [_myCollectionView reloadData];
}

- (void) setImageTitleLabelWitdh:(CGFloat)width withHeight:(CGFloat)height{
    _imagetitleWidth = width;
    _imagetitleHeight = height;
}
- (void) setImageTitleTextColor:(UIColor*)textColor withBackgroundColor:(UIColor*)bgColor{
    
    _imageTilteTextColor = textColor;
    _imageTilteBackgroundColor = bgColor;
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionImageData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    PPCollectionViewCell *cell = (PPCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"PPCollectionCell" forIndexPath:indexPath];
    NSDictionary *imageDic = [self.collectionImageData objectAtIndex:[indexPath row]];
    
//    [cell setImage:[UIImage imageNamed:[imageDic objectForKey:@"name"]]];
//    [cell setImage:[UIImage imageNamed:@"Default"]];
    [cell setURLImage:[imageDic objectForKey:@"URL"]];
    [cell setImageTitleLabelWitdh:_imagetitleWidth withHeight:_imagetitleHeight];
    [cell setImageTitleTextColor:_imageTilteTextColor withBackgroundColor:_imageTilteBackgroundColor];
    [cell setTitle:[imageDic objectForKey:@"title"]];
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    [self.delegate collectionView:self didSelectImageItemAtIndexPath:(NSIndexPath*)indexPath];
//    
//}

- (BOOL)collectionView:(UICollectionView * )collectionView
shouldHighlightItemAtIndexPath:(NSIndexPath * )indexPath{
    PPCollectionViewCell * cell = (PPCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.highlighted = TRUE;
    cell.selected = TRUE;
    //设置背景
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    UIColor *color = [UIColor colorWithRed:(CGFloat)44.0/256 green:(CGFloat)168/256 blue:(CGFloat)151/256 alpha:1.0];
    selectedBGView.backgroundColor = color;
    cell.selectedBackgroundView = selectedBGView;
    //代理进入
    [self.delegate collectionView:self didSelectImageItemAtIndexPath:(NSIndexPath*)indexPath];
    return TRUE;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
