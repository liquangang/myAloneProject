


//
//  CouponTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/10/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CouponTableViewCell.h"
#import "ElectrialCollectionViewCell2.h"
#import "SoapOperation.h"
#import "CustomeClass.h"

static NSString * const resuableStr = @"ElectrialCollectionViewCell2";
static NSString *const resuableStr1 = @"footerView";

@interface CouponTableViewCell()<UICollectionViewDelegate,
                                 UICollectionViewDataSource,
                                 UICollectionViewDelegateFlowLayout>
//collectionview
@property (nonatomic, strong) UICollectionView * electrialCollectionView;
//数据源
@property (nonatomic, strong) NSMutableArray * electrialMuArray;
@end

@implementation CouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - collectionview 代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.electrialMuArray[section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.electrialMuArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ElectrialCollectionViewCell2 * cell = [ElectrialCollectionViewCell2 ElectrialCollectionViewCell2WithCollectionView:collectionView
                                                                                                           ResuableStr:resuableStr
                                                                                                                 Index:indexPath
                                                                                                              CellInfo:self.electrialMuArray[indexPath.section][indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
          layout:(UICollectionViewLayout *)collectionViewLayout
          referenceSizeForFooterInSection:(NSInteger)section{
    if (section == self.electrialMuArray.count - 1) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(30, 138);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
                              viewForSupplementaryElementOfKind:(NSString *)kind
                              atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                              withReuseIdentifier:resuableStr1
                                                                                     forIndexPath:indexPath];
    return footerView;
}

#pragma mark - 功能接口

/**
 *  奖品合成
 */
- (IBAction)composeButtonAction:(id)sender {
}

/**
 *  下载数据
 */
- (void)downloadData{
    WEAKSELF2
    [[SoapOperation Singleton] getUserCardWithSuccess:^(NSMutableArray *serverDataArray) {
        
        /*
         Printing description of ((__NSDictionaryM *)0x00000001744588a0):
         {
         amount = 0;
         awardid = 6;
         cardid = 1;
         index = 0;
         url = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/HomePageVideo/rotate_coupon.gif";
         }
         */
        //最大组数
        NSInteger maxGroupNum = serverDataArray.count / 5;
        
        for (int i = 0; i < maxGroupNum; i++) {
            [weakSelf.electrialMuArray addObject:[NSMutableArray new]];
        }
        
        NSInteger section = 0;
        for (NSDictionary *cardInfo in serverDataArray) {
            NSInteger index = [cardInfo[@"index"] integerValue];
            [weakSelf.electrialMuArray[section] addObject:cardInfo];
            if (index == 0 && section != 0) {
                section++;
            }
        }
        
        MAINQUEUEUPDATEUI({
            [weakSelf.electrialCollectionView reloadData];
        })
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf downloadData];);
    }];
}

/**
 *  获得cell
 */
+ (instancetype)CouponTableViewCellWithTable:(UITableView *)superTable
                                 ResubaleStr:(NSString *)resubaleStr{
    CouponTableViewCell * cell = [superTable dequeueReusableCellWithIdentifier:resubaleStr];
    if (!cell) {
        cell = XIBCELL(@"CouponTableViewCell")
    }
    [cell downloadData];
    return cell;
}

#pragma mark - 懒加载

/**
 *  collectionview懒加载
 */
- (UICollectionView *)electrialCollectionView{
    if (!_electrialCollectionView) {
        UICollectionViewFlowLayout * collectionViewFlowLayout = [UICollectionViewFlowLayout new];
        collectionViewFlowLayout.itemSize = CGSizeMake(70,
                                                       138);
        collectionViewFlowLayout.minimumLineSpacing = 0;
        collectionViewFlowLayout.minimumInteritemSpacing = 0;
        collectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(0,
                                                                 10,
                                                                 0,
                                                                 10);
        collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _electrialCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 138)
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
        [_electrialCollectionView registerClass:[UICollectionReusableView class]
                     forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                            withReuseIdentifier:resuableStr1];
    }
    return _electrialCollectionView;
}

/**
 *  数据源懒加载
 */
- (NSMutableArray *)electrialMuArray{
    if (!_electrialMuArray) {
        _electrialMuArray = [NSMutableArray new];
    }
    return _electrialMuArray;
}

@end
