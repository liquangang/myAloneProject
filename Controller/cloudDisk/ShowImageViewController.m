//
//  ShowImageViewController.m
//  M-Cut
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ShowImageViewController.h"

@interface ShowImageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@end

@implementation ShowImageViewController

DEALLOCMETHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVIGATIONBACKBARBUTTONITEM
    NAVIGATIONBARRIGHTBARBUTTONITEM(@"全选")
    [self.view addSubview:self.imageCollectionView];
    [self isHiddenControlView:!self.isAllSelect];
}

#pragma mark - collectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (self.imageInfoMuArray.count > 0 && [self.imageInfoMuArray[0] isKindOfClass:[NSArray class]]) {
        return [self.imageInfoMuArray[section] count];
    }
    return self.imageInfoMuArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (self.imageInfoMuArray.count > 0 && [self.imageInfoMuArray[0] isKindOfClass:[NSArray class]]) {
        return [self.imageInfoMuArray count];
    }
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF2
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellResuableStr forIndexPath:indexPath];
    
    [cell setSelectBlock:^(UIButton *selectButton) {
        [weakSelf handleSelectWithButton:selectButton Index:indexPath];
    }];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        ImageHeaderCollectionViewCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        return header;
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr forIndexPath:indexPath];
        footer.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return footer;
    }
}

#pragma mark - collectionViewDelegate



#pragma mark - interface

- (void)rightBarButtonItemAction:(UIButton *)btn{
    self.isAllSelect = !self.isAllSelect;
    [self isHiddenControlView:!self.isAllSelect];
    [self.imageCollectionView reloadData];
    
    if ([btn.titleLabel.text isEqualToString:@"全选"]) {
        [btn setTitle:@"取消全选" forState:UIControlStateNormal];
        [self.selectMuArray removeAllObjects];
        [self.selectMuArray addObjectsFromArray:[self.imageInfoMuArray copy]];
    }else{
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        [self.selectMuArray removeAllObjects];
    }
}

NAVIGATIONBACKITEMMETHOD

- (void)handleSelectWithButton:(UIButton *)selectButton Index:(NSIndexPath *)indexPath{
    
    if (selectButton.selected) {
        [self.selectMuArray addObject:self.imageInfoMuArray[indexPath.item]];
    }else{
        [self.selectMuArray removeObject:self.imageInfoMuArray[indexPath.item]];
    }
    
    if (self.selectMuArray.count > 0) {
        [self isHiddenControlView:NO];
    }else{
        [self isHiddenControlView:YES];
    }
}

- (void)isHiddenControlView:(BOOL)isHidden{
    
    if (isHidden) {
        self.imageCollectionView.frame = CGRectMake(0, 0, ISScreen_Width, ISScreen_Height - 64);
    }else{
        self.imageCollectionView.frame = CGRectMake(0, 0, ISScreen_Width, ISScreen_Height - 64 - 44);
    }
}

#pragma mark - getter

- (NSMutableArray *)imageInfoMuArray{
    LAZYINITMUARRAY(_imageInfoMuArray)
}

- (UICollectionView *)imageCollectionView{
    
    if (!_imageCollectionView) {
        WEAKSELF2
        WaterLayout *waterLayout = [WaterLayout new];
        waterLayout.rowMargin = 15;
        waterLayout.columnMargin = 16;
        waterLayout.columnsCount = 4;
        waterLayout.sectionEdgeInset = UIEdgeInsetsMake(15, 16, 15, 16);
        
        [waterLayout setFooterSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, weakSelf.footerHeight);
        }];
        
        [waterLayout setHeaderSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, weakSelf.headerHeight);
        }];
        
        [waterLayout setItemHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            weakSelf.itemWidth = width;
            return width;
        }];
        
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ISScreen_Width, ISScreen_Height - 64) collectionViewLayout:waterLayout];
        [_imageCollectionView registerNib:[UINib nibWithNibName:cellResuableStr bundle:nil] forCellWithReuseIdentifier:cellResuableStr];
        [_imageCollectionView registerNib:[UINib nibWithNibName:headerResuableStr bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr];
        [_imageCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr];
        _imageCollectionView.opaque = YES;
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        _imageCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _imageCollectionView;
}

- (NSMutableArray *)selectMuArray{
    LAZYINITMUARRAY(_selectMuArray)
}

@end
