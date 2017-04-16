




//
//  CloudUploadViewController.m
//  M-Cut
//
//  Created by apple on 16/12/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudUploadViewController.h"
#import "WaterLayout.h"
#import "CloudUploadCollectionViewCell.h"
#import "ImageHeaderCollectionViewCell.h"
#import "ImageCollectionViewCell.h"
#import "CloudUploadHeaderCollectionViewCell.h"
#import "UploadMaterialModel.h"
#import "UploadSuccessCollectionViewCell.h"

static NSString *const firstHeaderResuableStr = @"ImageHeaderCollectionViewCell";
static NSString *const firstItemResuableStr = @"UploadSuccessCollectionViewCell";
static NSString *const footerResuableStr = @"footer";
static NSString *const secondHeaderResuableStr = @"CloudUploadHeaderCollectionViewCell";
static NSString *const secondItemResuableStr = @"CloudUploadCollectionViewCell";

@interface CloudUploadViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *cloudUploadCollectionView;
@property (nonatomic, strong) NSMutableArray *cloudUploadMuArray;
@property (nonatomic, strong) CloudUploadCollectionViewCell *currentUploadCell;
@end

@implementation CloudUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.cloudUploadCollectionView];
    NAVIGATIONBACKBARBUTTONITEM
    NAVIGATIONBARTITLEVIEW(@"上传界面")
    NAVIGATIONBARRIGHTBARBUTTONITEM(@"暂停备份")
    REGISTEREDNOTI(uploadProgress:, uploadProgress);
    REGISTEREDNOTI(uploadSuccess:, cloudImageUploadSuccess);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return ([self.cloudUploadMuArray[section] count] / 4 + 1) * 4;
    }
    return [self.cloudUploadMuArray[section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.cloudUploadMuArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UploadMaterialModel *uploadModel = nil;
    
    if ([self.cloudUploadMuArray[indexPath.section] count] > indexPath.item && self.cloudUploadMuArray[indexPath.section][indexPath.row]) {
        uploadModel = self.cloudUploadMuArray[indexPath.section][indexPath.item];
    }
    
    if (indexPath.section == 0) {
        UploadSuccessCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:firstItemResuableStr forIndexPath:indexPath];
        cell.backImage.image = uploadModel ? uploadModel.image : [UIImage new];
        return cell;
    }else{
        CloudUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:secondItemResuableStr forIndexPath:indexPath];
        cell.backImage.image = uploadModel.image;
        cell.sizeLabel.text = [NSString stringWithFormat:@"%.1fM", [uploadModel.contentSize floatValue]];
        if (indexPath.item == 0) {
            self.currentUploadCell = cell;
        }
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        if (indexPath.section == 0) {
            ImageHeaderCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:firstHeaderResuableStr forIndexPath:indexPath];
            cell.titleLabel.text = @"   已上传";
            return cell;
        }else{
            CloudUploadHeaderCollectionViewCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:secondHeaderResuableStr forIndexPath:indexPath];
            cell.alreadyUploadNumLabel.text = [NSString stringWithFormat:@" %lu", [self.cloudUploadMuArray[0] count] > 0 ? [self.cloudUploadMuArray[0] count] : 0];
            cell.remainNumLabel.text = [NSString stringWithFormat:@" %lu", [self.cloudUploadMuArray[1] count]];
            return cell;
        }
    }else{
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr forIndexPath:indexPath];
        return footer;
    }
}

#pragma mark - interface 

NAVIGATIONBACKITEMMETHOD

- (void)rightBarButtonItemAction:(UIButton *)btn{
    
}

+ (void)pushToUploadVcWithNav:(UINavigationController *)navigationController{
    CloudUploadViewController *uploadVc = [CloudUploadViewController new];
    [navigationController pushViewController:uploadVc animated:YES];
}

- (void)uploadProgress:(NSNotification *)noti{
    
    if (self.currentUploadCell) {
        
        [CustomeClass mainQueue:^{
           WEAKSELF2
            weakSelf.currentUploadCell.hud.progress = [noti.userInfo[uploadProgress] floatValue];
            NSLog(@"%f", [noti.userInfo[uploadProgress] floatValue]);
        }];
    }
}

- (void)uploadSuccess:(NSNotification *)noti{
    
    [CustomeClass mainQueue:^{
       WEAKSELF2
        if ([weakSelf.cloudUploadMuArray[1] count] > 0) {
            UploadMaterialModel *uploadModel = weakSelf.cloudUploadMuArray[1][0];
            uploadModel.status = uploadFinish;
            [[VideoDBOperation Singleton] updateDataWithModel:uploadModel];
            [weakSelf.cloudUploadMuArray[0] addObject:weakSelf.cloudUploadMuArray[1][0]];
            [weakSelf.cloudUploadMuArray[1] removeObjectAtIndex:0];
            [weakSelf.cloudUploadCollectionView reloadData];
        }
    }];
}

#pragma mark - getter

- (UICollectionView *)cloudUploadCollectionView{
    if (!_cloudUploadCollectionView) {
        WaterLayout *waterLayout = [WaterLayout new];
        waterLayout.rowMargin = 0;
        waterLayout.columnMargin = 0;
        waterLayout.columnsCount = 4;
        waterLayout.sectionEdgeInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [waterLayout setItemHeightBlock:^CGFloat(NSIndexPath *indexPath, CGFloat width) {
            return width;
        }];
        
        [waterLayout setHeaderSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 30);
        }];
        
        [waterLayout setFooterSizeBlock:^CGSize(NSIndexPath *indexPath) {
            return CGSizeMake(ISScreen_Width, 0);
        }];
        
        _cloudUploadCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height - 64) collectionViewLayout:waterLayout];
        _cloudUploadCollectionView.backgroundColor = ColorFromRGB(0x414346, 1);
        _cloudUploadCollectionView.delegate = self;
        _cloudUploadCollectionView.dataSource = self;
        [_cloudUploadCollectionView registerNib:[UINib nibWithNibName:firstHeaderResuableStr bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:firstHeaderResuableStr];
        [_cloudUploadCollectionView registerNib:[UINib nibWithNibName:firstItemResuableStr bundle:nil] forCellWithReuseIdentifier:firstItemResuableStr];
        [_cloudUploadCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerResuableStr];
        [_cloudUploadCollectionView registerNib:[UINib nibWithNibName:secondHeaderResuableStr bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:secondHeaderResuableStr];
        [_cloudUploadCollectionView registerNib:[UINib nibWithNibName:secondItemResuableStr bundle:nil] forCellWithReuseIdentifier:secondItemResuableStr];
    }
    return _cloudUploadCollectionView;
}

- (NSMutableArray *)cloudUploadMuArray{
    if (!_cloudUploadMuArray) {
        _cloudUploadMuArray = [[NSMutableArray alloc] initWithArray:@[[NSMutableArray new], [NSMutableArray new]]];
        NSArray *tempArray = [[VideoDBOperation Singleton] selectAllMaterialData];
        
        for (UploadMaterialModel *uploadModel in tempArray) {
            uploadModel.image = [CustomeClass getImageWithImageFile:[NSString stringWithFormat:@"%@/%@", [CustomeClass createFileAtSandboxWithName:uploadImageFileName], uploadModel.fileName]];
            
            if (uploadModel.status == uploadStart) {
                [_cloudUploadMuArray[1] addObject:uploadModel];
            }else{
                [_cloudUploadMuArray[0] addObject:uploadModel];
            }
        }
    }
    return _cloudUploadMuArray;
}

@end
