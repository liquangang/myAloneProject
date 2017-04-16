//
//  HomepageSecondViewController.m
//  M-Cut
//
//  Created by apple on 16/8/9.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HomepageSecondViewController.h"
#import "HomepageCollectionViewCell.h"
#import "VideoDBOperation.h"

@interface HomepageSecondViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
/** 界面数据源*/
@property (nonatomic, strong) NSMutableArray * labelMuArray;
@property (nonatomic, strong) UICollectionView * homeCollectionView;
@end

static NSString * homepageCollectionViewCellId = @"HomepageCollectionViewCell";

@implementation HomepageSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

#pragma mark - initUI
- (void)initUI{
    //初始化collectionView
    UICollectionViewFlowLayout * homeCollectionViewFlowLayout = [UICollectionViewFlowLayout new];
    homeCollectionViewFlowLayout.itemSize = CGSizeMake(ISScreen_Width / 2, ISScreen_Width / 2);
    homeCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    homeCollectionViewFlowLayout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    self.homeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height) collectionViewLayout:homeCollectionViewFlowLayout];
    [self.view addSubview:self.homeCollectionView];
    self.homeCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.homeCollectionView registerClass:[HomepageCollectionViewCell class] forCellWithReuseIdentifier:homepageCollectionViewCellId];
    
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        [[VideoDBOperation Singleton] setBadgeNum];
    }, )
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}


#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [HomepageCollectionViewCell getHomepageCollectionViewCellWithCellId:homepageCollectionViewCellId CollectionView:collectionView BackImageUrl:nil VideoLabelName:nil Index:indexPath];
}

#pragma mark - 数组懒加载
- (NSMutableArray *)labelMuArray{
    if (!_labelMuArray) {
        _labelMuArray = [NSMutableArray new];
    }
    return _labelMuArray;
}
@end
