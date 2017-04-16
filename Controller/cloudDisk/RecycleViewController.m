//
//  RecycleViewController.m
//  M-Cut
//
//  Created by apple on 16/12/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "RecycleViewController.h"
#import "RecycleControlView.h"

@interface RecycleViewController ()
@property (nonatomic, strong) RecycleControlView *recycleView;
@end

@implementation RecycleViewController

DEALLOCMETHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVIGATIONBARTITLEVIEW(@"回收站")
    [self.view insertSubview:self.recycleView belowSubview:self.imageCollectionView];
}

#pragma mark - interface

- (void)restore{
    
}

- (void)delete{
    
}

#pragma mark - getter

- (RecycleControlView *)recycleView{

    if (!_recycleView) {
        WEAKSELF2
        _recycleView = [[RecycleControlView alloc] initWithFrame:CGRectMake(0, ISScreen_Height - 44 - 64, ISScreen_Width, 44)];

        [_recycleView setRestoreButtonBlock:^{
            [weakSelf restore];
        }];

        [_recycleView setDeleteButtonBlock:^{
            [weakSelf delete];
        }];
    }
    return _recycleView;
}

@end
