//
//  ImageCollectionView.h
//  M-Cut
//
//  Created by liquangang on 2017/1/19.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterLayout.h"

@interface ImageCollectionView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *imageCollectionView;
@property (nonatomic, strong) WaterLayout *waterLayout;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, strong) UINavigationController *myNav;
@property (nonatomic, copy) void(^selectBlock)(NSIndexPath *indexPath);
- (void)hidden;
- (void)show;
@end
