

//
//  CustomActionSheet.m
//  M-Cut
//
//  Created by apple on 16/12/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CustomActionSheet.h"
#import "WaterLayout.h"
#import "PropmtImageCollectionCell.h"
#import "TitleCollectionViewCell.h"
#import "CustomeClass.h"

static NSString *const headerResuableStr = @"header";
static NSString *const imageItemResuableStr = @"item1";
static NSString *const titleItemResuableStr = @"item2";
static NSString *const footerResuableStr = @"footer";
static NSString *const propmtImgaeCellNibName = @"PropmtImageCollectionCell";
static NSString *const titleCellNibName = @"TitleCollectionViewCell";

@interface CustomActionSheet()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) WaterLayout *waterLayout;
@property (nonatomic, strong) NSArray *dataSource;  //存放数据源 如果只有标题，直接存字符串，否则存propmtModel
@property (nonatomic, copy) NSString *title;    //标题
@property (nonatomic, assign) ActionViewType actionViewType;    //视图类型
@end

@implementation CustomActionSheet

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.actionViewType == oneEveryColumnType) {
        TitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:titleItemResuableStr forIndexPath:indexPath];
        [cell.titleButton setTitle:self.dataSource[indexPath.item] forState:UIControlStateNormal];
        return cell;
    }else if (self.actionViewType == fourEveryColumnType){
        PropmtImageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageItemResuableStr forIndexPath:indexPath];
        PropmtModel *propmtModel = self.dataSource[indexPath.item];
        cell.titleLabel.text = propmtModel.title;
        cell.backImage.image = propmtModel.backImage;
        return cell;
    }else{
        return nil;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TitleCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr forIndexPath:indexPath];
        [cell.titleButton setTitle:self.title forState:UIControlStateNormal];
        return cell;
    }else{
        TitleCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr forIndexPath:indexPath];
        [cell.titleButton setTitle:@"取消" forState:UIControlStateNormal];
        WEAKSELF2
        
        [cell setTitleButtonTouchBlock:^{
            [CustomeClass mainQueue:^{
                [UIView animateWithDuration:0.6 animations:^{
                    weakSelf.frame = CGRectMake(0, ISScreen_Height, ISScreen_Width, 0);
                }];
            }];
        }];
        return cell;
    }
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.touchBlock(indexPath);
}

#pragma mark - interface

- (instancetype)initWithFrame:(CGRect)frame Type:(ActionViewType)actionType DataArray:(NSArray *)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = dataArray;
        self.frame = CGRectMake(0, ISScreen_Height, ISScreen_Width, 0);
        [self setWaterLayoutWithType:actionType];
        [self addSubview:self.propmtCollectionView];
        
        WEAKSELF2
        [UIView animateWithDuration:0.6 animations:^{
            weakSelf.frame = frame;
        }];
    }
    return self;
}

- (void)setWaterLayoutWithType:(ActionViewType)actionType{
    
    if (self.actionViewType == oneEveryColumnType) {
        self.waterLayout.columnsCount = 1;
    }else if (self.actionViewType == fourEveryColumnType){
        self.waterLayout.columnsCount = 4;
    }
}

- (CGFloat)itemHeightWithIndexPath:(NSIndexPath *)indexPath Width:(CGFloat)width{
    
    if (self.actionViewType == oneEveryColumnType) {
        return ISScreen_Width;
    }else if (self.actionViewType == fourEveryColumnType){
        return width;
    }else{
        return 0;
    }
}


#pragma mark - getter 

- (WaterLayout *)waterLayout{
    
    if (!_waterLayout) {
        WEAKSELF2
        _waterLayout = [WaterLayout new];
        _waterLayout.rowMargin = 0;
        _waterLayout.columnMargin = 0;
        _waterLayout.sectionEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [_waterLayout setItemHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            return [weakSelf itemHeightWithIndexPath:indexPath Width:width];
        }];
        
        [_waterLayout setHeaderSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 30);
        }];
        
        [_waterLayout setFooterSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 44);
        }];
    }
    return _waterLayout;
}

- (UICollectionView *)propmtCollectionView{
    if (_propmtCollectionView) {
        _propmtCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:self.waterLayout];
        _propmtCollectionView.delegate = self;
        _propmtCollectionView.dataSource = self;
        [_propmtCollectionView registerNib:[UINib nibWithNibName:titleCellNibName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr];
        [_propmtCollectionView registerNib:[UINib nibWithNibName:propmtImgaeCellNibName bundle:nil] forCellWithReuseIdentifier:imageItemResuableStr];
        [_propmtCollectionView registerNib:[UINib nibWithNibName:titleCellNibName bundle:nil] forCellWithReuseIdentifier:titleItemResuableStr];
        [_propmtCollectionView registerNib:[UINib nibWithNibName:titleCellNibName bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr];
        _propmtCollectionView.opaque = YES;
    }
    return _propmtCollectionView;
}

- (NSArray *)dataSource{
    LAZYINITARRAY(_dataSource)
}

@end
