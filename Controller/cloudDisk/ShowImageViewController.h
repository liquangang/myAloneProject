//
//  ShowImageViewController.h
//  M-Cut
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterLayout.h"
#import "ImageCollectionViewCell.h"
#import "ImageHeaderCollectionViewCell.h"
#import "CustomeClass.h"

typedef NS_ENUM(NSInteger, ShowType) {
    recycleVc,
    albumVc
};

static NSString *const cellResuableStr = @"ImageCollectionViewCell";
static NSString *const headerResuableStr = @"ImageHeaderCollectionViewCell";
static NSString *const footerResuableStr = @"footer";

@interface ShowImageViewController : UIViewController
@property (nonatomic, assign) BOOL isAllSelect;
@property (nonatomic, strong) UICollectionView *imageCollectionView;
@property (nonatomic, strong) NSMutableArray *imageInfoMuArray;
@property (nonatomic, strong) NSMutableArray *selectMuArray;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;

- (void)isHiddenControlView:(BOOL)isHidden;

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath;

- (void)handleSelectWithButton:(UIButton *)selectButton Index:(NSIndexPath *)indexPath;

- (void)rightBarButtonItemAction:(UIButton *)btn;
@end
