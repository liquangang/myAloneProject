//
//  ImageCollectionView.m
//  M-Cut
//
//  Created by liquangang on 2017/1/19.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "ImageCollectionView.h"
#import "ImageCollectionViewCell.h"
#import "XMNAssetModel.h"
#import "SinglePreviewViewController.h"

static NSString *const itemResuableStr = @"ImageCollectionViewCell";
static NSString *const headerResuableStr = @"header";
static NSString *const footerResuableStr = @"footer";

@interface ImageCollectionView()
@property (nonatomic, assign) CGRect myFrame;
@end

@implementation ImageCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.myFrame = frame;
        [self addSubview:self.imageCollectionView];
    }
    return self;
}

- (void)hidden{
    [UIView animateWithDuration:0.6 animations:^{
        self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), 0);
    }];
}

- (void)show{
    [UIView animateWithDuration:0.6 animations:^{
       self.frame = self.myFrame;
    }];
}

#pragma mark - collectiondelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemResuableStr forIndexPath:indexPath];
    XMNAssetModel *assetModel = self.dataSource[indexPath.row];
    cell.backImage.image = assetModel.thumbnail;
    cell.selectButton.selected = assetModel.selectStatus == selected ? YES : NO;
    [cell setSelectBlock:^(UIButton *selectButton) {
        assetModel.selectStatus = selectButton.selected ? selected : unSelect;
    }];
    
    if (assetModel.type == XMNAssetTypeVideo) {
        [cell.previewButton setImage:[UIImage imageNamed:@"视频"] forState:UIControlStateNormal];
        cell.timeLengthLabel.text = assetModel.timeLength;
    }else{
        [cell.previewButton setImage:[UIImage imageNamed:@"图片"] forState:UIControlStateNormal];
        cell.timeLengthLabel.text = @"";
    }
    
    [cell setPreviewBlock:^{
        WEAKSELF2
        [CustomeClass mainQueue:^{
            SinglePreviewViewController *singlePreviewVc = [SinglePreviewViewController new];
            singlePreviewVc.assetModel = assetModel;
            [weakSelf.myNav pushViewController:singlePreviewVc animated:YES];
        }];
    }];

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr forIndexPath:indexPath];
        return headerView;
    }else{
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr forIndexPath:indexPath];
        return footerView;
    }
}

#pragma mark - collectionDataSource

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectBlock(indexPath);
}

#pragma mark - getter

- (UICollectionView *)imageCollectionView{
    if (!_imageCollectionView) {
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.waterLayout];
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        [_imageCollectionView registerNib:[UINib nibWithNibName:itemResuableStr bundle:nil] forCellWithReuseIdentifier:itemResuableStr];
        [_imageCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr];
        [_imageCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr];
        _imageCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _imageCollectionView;
}

- (NSMutableArray *)dataSource{
    LAZYINITMUARRAY(_dataSource)
}

- (WaterLayout *)waterLayout{
    if (!_waterLayout) {
        _waterLayout = [WaterLayout new];
        _waterLayout.rowMargin = 15;
        _waterLayout.columnMargin = 16;
        _waterLayout.columnsCount = 4;
        _waterLayout.sectionEdgeInset = UIEdgeInsetsMake(15, 16, 15, 16);
        WEAKSELF2
        
        [_waterLayout setFooterSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, weakSelf.footerHeight);
        }];
        
        [_waterLayout setHeaderSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, weakSelf.headerHeight);
        }];
        
        [_waterLayout setItemHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            return width;
        }];
    }
    return _waterLayout;
}

@end
