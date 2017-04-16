//
//  WaterVideoCollectionViewController.m
//  M-Cut
//
//  Created by liquangang on 16/10/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "WaterVideoCollectionViewController.h"
#import "WaterLayout.h"
#import "SoapOperation.h"
#import "CustomeClass.h"
#import "MJRefresh.h"
#import "VideoCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface WaterVideoCollectionViewController ()<UICollectionViewDelegate,
                                                 UICollectionViewDataSource,
                                                 UICollectionViewDelegateFlowLayout>
/** 数据源*/
@property (nonatomic, strong) NSMutableArray * videoInfoMuArray;
@property (nonatomic, strong) WaterLayout * waterFlowLayout;
@end

@implementation WaterVideoCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)dealloc{
    DEBUGSUCCESSLOG(@"dealloc")
}

- (instancetype)init
{
    //创建布局
    self.waterFlowLayout = [[WaterLayout alloc] init];
    self.waterFlowLayout.rowCount = 2;
    [self.waterFlowLayout setItemHeightBlock:^CGFloat(NSIndexPath * itemIndexPath) {
        return ISScreen_Width / 2;
    }];
    return [super initWithCollectionViewLayout:self.waterFlowLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self downloadDataWithStart:0];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.videoInfoMuArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                              forIndexPath:indexPath];
    cell.videoImage.backgroundColor = ISTestRandomColor;
    NSMutableDictionary * videoInfo = self.videoInfoMuArray[indexPath.row];
    [cell.videoImage
    sd_setImageWithURL:[NSURL URLWithString:STRTOUTF8(videoInfo[@"video_thumbnail"])]
    placeholderImage:DEFAULTVIDEOTHUMAIL
    options:SDWebImageRetryFailed | SDWebImageProgressiveDownload];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>



#pragma mark - 功能模块

/** 初始化ui*/
- (void)setUI{
    self.title = self.labelInfo.szLabelName;
    NAVIGATIONBACKBARBUTTONITEM
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"VideoCollectionViewCell"
                                                    bundle:nil]
          forCellWithReuseIdentifier:reuseIdentifier];
    WEAKSELF2
    [self.collectionView addFooterWithCallback:^{
        [weakSelf downloadDataWithStart:weakSelf.videoInfoMuArray.count];
    }];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)backButtonAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 下载数据*/
- (void)downloadDataWithStart:(NSInteger)dataStart{
    WEAKSELF2
    [CustomeClass hudShowWithView:self.view Tag:123456];
    NSString * labelId = [NSString stringWithFormat:@"%@", weakSelf.labelInfo.nLabelID];
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        [[SoapOperation Singleton]
         getVideosByLabelIdWithLabelId:labelId
                                Offset:dataStart
                                 Count:66
                               Success:^(NSMutableArray *serverDataArray) {
            MAINQUEUEUPDATEUI({
                [CustomeClass hudHiddenWithView:weakSelf.view Tag:123456];
                [weakSelf.collectionView footerEndRefreshing];
            })
            if (serverDataArray.count == 0) {
                [weakSelf.collectionView removeFooter];
                [CustomeClass showMessage:@"没有更多影片了" ShowTime:1.5];
                return;
            }
            if (dataStart == 0) {
                [weakSelf.videoInfoMuArray removeAllObjects];
            }
            [weakSelf.videoInfoMuArray addObjectsFromArray:[serverDataArray copy]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collectionView reloadData];
            });
        } Fail:^(NSError *error) {
            [CustomeClass hudHiddenWithView:self.view Tag:123456];
            RELOADSERVERDATA([weakSelf downloadDataWithStart:dataStart];);
        }];
    }, {})
}


#pragma mark - 懒加载
- (NSMutableArray *)videoInfoMuArray{
    if (!_videoInfoMuArray) {
        _videoInfoMuArray = [NSMutableArray new];
    }
    return _videoInfoMuArray;
}

@end
