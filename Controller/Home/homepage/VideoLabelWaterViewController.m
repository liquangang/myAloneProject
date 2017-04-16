//
//  VideoLabelWaterViewController.m
//  M-Cut
//
//  Created by apple on 16/11/12.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoLabelWaterViewController.h"
#import "WaterLayout.h"
#import "VideoCollectionViewCell.h"

static NSString * const resuableStr = @"VideoCollectionViewCell";

@interface VideoLabelWaterViewController ()<UICollectionViewDelegate,
                                            UICollectionViewDataSource>
//collectionview
@property (nonatomic, strong) UICollectionView * videoCollectionView;
//数据源
@property (nonatomic, strong) NSMutableArray * videoInfoMuArray;
@end

@implementation VideoLabelWaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark - collectionView代理
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return 100;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoCollectionViewCell * cell = [VideoCollectionViewCell VideoCollectionViewCellWithCollectionView:collectionView
                                                                                              IndexPath:indexPath
                                                                                            ResuableStr:resuableStr];
    cell.backgroundColor = ISTestRandomColor;
    return cell;
}

#pragma mark - 模块
- (void)setUI{
    [self.videoCollectionView reloadData];
}

#pragma mark - 懒加载
- (NSMutableArray *)videoInfoMuArray{
    LAZYINITMUARRAY(_videoInfoMuArray)
}

- (UICollectionView *)videoCollectionView{
    if (!_videoCollectionView) {
        WaterLayout * collectionViewFlowLayout = [WaterLayout new];
        collectionViewFlowLayout.rowCount = 2;
        collectionViewFlowLayout.lineSpace = 0;
        collectionViewFlowLayout.rowSpace = 0;
        collectionViewFlowLayout.itemEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        [collectionViewFlowLayout setItemHeightBlock:^CGFloat(NSIndexPath * indexPath) {
            return 100;
        }];
        _videoCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                                  collectionViewLayout:collectionViewFlowLayout];
        [self.view addSubview:_videoCollectionView];
        _videoCollectionView.delegate = self;
        _videoCollectionView.dataSource = self;
        [_videoCollectionView registerNib:[UINib nibWithNibName:resuableStr bundle:nil]
               forCellWithReuseIdentifier:resuableStr];
    }
    return _videoCollectionView;
}
@end
