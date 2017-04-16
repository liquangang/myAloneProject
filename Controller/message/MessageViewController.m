//
//  MessageViewController.m
//  M-Cut
//
//  Created by liquangang on 2017/3/9.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "MessageViewController.h"
#import "WaterLayout.h"
#import "MessageNumCollectionViewCell.h"
#import "MessageFriendCollectionViewCell.h"

static NSString *const headerResuableStr = @"MessageNumCollectionViewCell";
static NSString *const firstSectionItemResuableStr = @"MessageFriendCollectionViewCell";
static NSString *const footerResuableStr = @"footer";

@interface MessageViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *messageCollectionView;
@property (nonatomic, strong) WaterLayout *myLayout;
@property (nonatomic, strong) NSMutableArray *friendInfoMuArray;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MyFriendViewController *myFriendVc = [MyFriendViewController new];
    [self addChildViewController:myFriendVc];
    myFriendVc.view.frame = self.view.bounds;
    [self.view addSubview:myFriendVc.view];
    self.navigationItem.rightBarButtonItem = myFriendVc.navigationItem.rightBarButtonItem;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

#pragma mark - collection代理

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.friendInfoMuArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MessageFriendCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:firstSectionItemResuableStr forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MessageNumCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr forIndexPath:indexPath];
        return cell;
    }else{
        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - getter

- (UICollectionView *)messageCollectionView{
    if (!_messageCollectionView) {
        _messageCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.myLayout];
        _messageCollectionView.delegate = self;
        _messageCollectionView.dataSource = self;
        _messageCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [_messageCollectionView registerNib:[UINib nibWithNibName:firstSectionItemResuableStr bundle:nil] forCellWithReuseIdentifier:firstSectionItemResuableStr];
        [_messageCollectionView registerNib:[UINib nibWithNibName:headerResuableStr bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerResuableStr];
        [_messageCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr];
    }
    return _messageCollectionView;
}

- (WaterLayout *)myLayout{
    if (!_myLayout) {
        _myLayout = [WaterLayout new];
        _myLayout.itemWidth = ISScreen_Width / 3;
        _myLayout.columnsCount = 3;
        
        [_myLayout setItemHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            return width;
        }];
        
        [_myLayout setHeaderSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, ISScreen_Width / 3);
        }];
        
        [_myLayout setFooterSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 0);
        }];
    }
    return _myLayout;
}

- (NSMutableArray *)friendInfoMuArray{
    LAZYINITMUARRAY(_friendInfoMuArray)
}

@end
