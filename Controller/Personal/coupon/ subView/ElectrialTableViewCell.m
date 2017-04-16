//
//  ElectrialTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/10/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ElectrialTableViewCell.h"
#import "ElectrialCollectionViewCell.h"
#import "SoapOperation.h"
#import "CustomeClass.h"

static NSString * const resuableStr = @"ElectrialCollectionViewCell";
static NSString *const resuableStr2 = @"UICollectionViewCell";

@interface ElectrialTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

//横向混动的collectionview
@property (nonatomic, strong) UICollectionView * electrialCollectionView;

//数据源
@property (nonatomic, strong) NSMutableArray * couponDataMuArray;
@end

@implementation ElectrialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

#pragma mark - collectionView 代理

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return self.couponDataMuArray.count > 0 ? self.couponDataMuArray.count : 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.couponDataMuArray.count == 0) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:resuableStr2
                                                                               forIndexPath:indexPath];
        UILabel *propmtLabel = (UILabel *)[cell.contentView viewWithTag:111111];
        if (!propmtLabel) {
            propmtLabel = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
            [cell.contentView addSubview:propmtLabel];
            propmtLabel.text = @"还没有优惠券";
            propmtLabel.textAlignment = NSTextAlignmentCenter;
        }
        return cell;
    }
    ElectrialCollectionViewCell * cell = [ElectrialCollectionViewCell ElectrialCollectionViewCellWithCollectionView:collectionView
                                                                                                        ResuableStr:resuableStr
                                                                                                          IndexPath:indexPath];
    return cell;
}

#pragma mark - 功能模块

/**
 *  获得cell
 */
+ (instancetype)ElectrialTableViewCellWithTable:(UITableView *)superTableView
                                    ResuableStr:(NSString *)resuableStr
{
    ElectrialTableViewCell * cell = [superTableView dequeueReusableCellWithIdentifier:resuableStr];
    if (!cell) {
        cell = XIBCELL(@"ElectrialTableViewCell")
    }
    [cell downloadData];
    return cell;
}

/**
 *  加载数据刷新collectionview
 */
- (void)downloadData{
    WEAKSELF2
    [[SoapOperation Singleton] getARRewardWithSuccess:^(NSMutableArray *serverDataArray) {
        NSLog(@"%@", serverDataArray);
        [CustomeClass mainQueue:^{
            [weakSelf.electrialCollectionView reloadData];
        }];
    } Fail:^(NSError *error) {
        DEBUGLOG(error)
    }];
}

#pragma mark - 懒加载

/**
 *  collectionview懒加载
 */
- (UICollectionView *)electrialCollectionView{
    if (!_electrialCollectionView) {
        UICollectionViewFlowLayout * collectionViewFlowLayout = [UICollectionViewFlowLayout new];
        collectionViewFlowLayout.itemSize = CGSizeMake(ISScreen_Width,
                                                       self.contentView.bounds.size.height);
        collectionViewFlowLayout.minimumLineSpacing = 0;
        collectionViewFlowLayout.minimumInteritemSpacing = 0;
        collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0,
                                                                 0,
                                                                 0,
                                                                 0);
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _electrialCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 130)
                                                      collectionViewLayout:collectionViewFlowLayout];
        [self.contentView addSubview:_electrialCollectionView];
        _electrialCollectionView.delegate = self;
        _electrialCollectionView.dataSource = self;
        _electrialCollectionView.clipsToBounds = YES;
        _electrialCollectionView.backgroundColor = [UIColor whiteColor];
        _electrialCollectionView.showsHorizontalScrollIndicator = NO;
        
        //注册cell
        [_electrialCollectionView registerNib:[UINib nibWithNibName:resuableStr bundle:nil]
                   forCellWithReuseIdentifier:resuableStr];
        [_electrialCollectionView registerClass:[UICollectionViewCell class]
                     forCellWithReuseIdentifier:resuableStr2];
    }
    return _electrialCollectionView;
}

/**
 *  数据源懒加载
 */
- (NSMutableArray *)couponDataMuArray{
    if (!_couponDataMuArray) {
        _couponDataMuArray = [NSMutableArray new];
    }
    return _couponDataMuArray;
}
@end
