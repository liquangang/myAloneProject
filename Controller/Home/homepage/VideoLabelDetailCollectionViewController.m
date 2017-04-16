//
//  VideoLabelDetailCollectionViewController.m
//  M-Cut
//
//  Created by liquangang on 16/9/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoLabelDetailCollectionViewController.h"

#import "VideoLabelDetailFlowLayout.h"

#import "ActivityDetailView.h"

#import "VideoDetailCollectionViewCell.h"

#import "SoapOperation.h"

#import "CustomeClass.h"

#import "MJRefresh.h"

@interface VideoLabelDetailCollectionViewController ()<UICollectionViewDelegate,
                                                       UICollectionViewDataSource,
                                                       UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableArray * videoMuArray;
@property (nonatomic, strong) ActivityDetailView * activityView;
@property (nonatomic, strong) UICollectionView * collectionView;
@end

@implementation VideoLabelDetailCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const reuseHeaderIdentifier = @"headerCell";


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DEBUGSUCCESSLOG(@"dealloc");
}

#pragma mark - 懒加载
- (NSMutableArray *)videoMuArray{
    if (!_videoMuArray) {
        _videoMuArray = [NSMutableArray new];
    }
    return _videoMuArray;
}

- (UIView *)activityView{
    if (!_activityView) {
        _activityView = [[ActivityDetailView alloc] initWithLabelId:self.labelId
                                                        ActivityDes:self.activityDes];
        [self.collectionView reloadData];
    }
    return _activityView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //设置flowlayout
    VideoLabelDetailFlowLayout * videoLabelDetailFlowLayout = [VideoLabelDetailFlowLayout new];
    videoLabelDetailFlowLayout.heightBlock = ^CGFloat(CGFloat sender, NSIndexPath * indexPath){
        if (indexPath.section == 0) {
            return self.activityView.bounds.size.height;
        }
        return indexPath.row % 2 == 1 ? ISScreen_Width : ISScreen_Width / 2;
    };
    videoLabelDetailFlowLayout.columnsCount = 2;
    
    //设置collectionview
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height)
                                             collectionViewLayout:videoLabelDetailFlowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //注册复用item
    [self.collectionView registerNib:[UINib
                                      nibWithNibName:@"VideoDetailCollectionViewCell"
                                      bundle:[NSBundle mainBundle]]
          forCellWithReuseIdentifier:reuseIdentifier];
    
    //注册复用头部item
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:reuseHeaderIdentifier];
    
    //添加加载功能
    WEAKSELF2
    [self.collectionView addHeaderWithCallback:^{
        [weakSelf downloadDataWithStart:0];
    }];
    [self.collectionView addFooterWithCallback:^{
        [weakSelf downloadDataWithStart:weakSelf.videoMuArray.count];
    }];
    
    //注册点击banner的通知
    REGISTEREDNOTI(pushWithBannerInfo:, CLICKBANNERIMAGE);
    
    //刷新并重新下载数据
    [self downloadDataWithStart:0];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //如果navigationbar在的话就隐藏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark <UICollectionViewDataSource>

- (CGSize)collectionView:(UICollectionView *)collectionView
          layout:(UICollectionViewLayout *)collectionViewLayout
          referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ISScreen_Width, self.activityView.bounds.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.videoMuArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView * headerReusableView =
    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                       withReuseIdentifier:reuseHeaderIdentifier
                                             forIndexPath:indexPath];
    
    [headerReusableView addSubview:self.activityView];
    return headerReusableView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        return [VideoDetailCollectionViewCell
                getVideoDetailCollectionViewCellWithCollectionView:collectionView
                ItemInfo:self.videoMuArray[indexPath.item]
                ItemIndexPath:indexPath
                ReuserIdentifier:reuseIdentifier];
}

#pragma mark - 数据下载
/** 根据开始的位置下载数据*/
- (void)downloadDataWithStart:(NSInteger)dataStart{
    
    //hud开始
    [CustomeClass hudShowWithView:self.collectionView Tag:123456];
    
    //数据下载开始
    WEAKSELF2
    [[SoapOperation Singleton] getVideosByLabelIdWithLabelId:self.labelId
                                                      Offset:dataStart
                                                       Count:16
                                                     Success:^(NSMutableArray *serverDataArray) {
                                                         
        //数据下载结束
        [CustomeClass hudHiddenWithView:weakSelf.collectionView Tag:123456];
        
        //初次进入该界面或者下拉刷新
        if (dataStart == 0) {
            [weakSelf.videoMuArray removeAllObjects];
        }
                                                         
        [weakSelf.videoMuArray addObjectsFromArray:[serverDataArray copy]];
        
        MAINQUEUEUPDATEUI({
            [weakSelf.collectionView footerEndRefreshing];
            [weakSelf.collectionView headerEndRefreshing];
            if (serverDataArray.count == 0) {
                [CustomeClass showMessage:@"没有更多内容了" ShowTime:1.5];
            }
            
            [weakSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        })
        
                                                         
    } Fail:^(NSError *error) {
        [CustomeClass hudHiddenWithView:weakSelf.collectionView Tag:123456];
        RELOADSERVERDATA([weakSelf downloadDataWithStart:dataStart];);
    }];
}

#pragma mark - 点击banner图片方法
- (void)pushWithBannerInfo:(NSNotification *)noti{
    NSDictionary * bannerInfo = noti.userInfo;
    //根据这个字典跳转相应页面
}

@end
