//
//  ShowCloudFIleImageViewController.m
//  M-Cut
//
//  Created by liquangang on 2017/1/16.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "ShowCloudFIleImageViewController.h"
#import "AddLabelViewController.h"

@interface ShowCloudFIleImageViewController ()
@property (nonatomic, strong) UIButton *addLabelButton;
@end

@implementation ShowCloudFIleImageViewController

DEALLOCMETHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self downloadData];
}

#pragma mark - collectionDelegate

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [super collectionView:collectionView cellForItemAtIndexPath:indexPath];
    cell.selectButton.hidden = YES;
    return cell;
}

#pragma mark - interface

- (void)downloadData{
    SHOWHUD
    WEAKSELF2
    
    [[AFNetWorkManager shareInstance] searchUserFile:[NSString stringWithFormat:@"/%@", self.title] LabelArray:@[] Progress:^(NSProgress *progress) {
        HIDDENHUD
        NSLog(@"progress --- %@", progress);
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        HIDDENHUD
        NSLog(@"%@", responseObject);
        [weakSelf.imageInfoMuArray removeAllObjects];
        [weakSelf.imageInfoMuArray addObjectsFromArray:responseObject[@"ret"]];
        
        [CustomeClass mainQueue:^{
            [weakSelf.imageCollectionView reloadData];
        }];
    } Fail:^(NSURLSessionDataTask *task, NSError *error) {
        HIDDENHUD
        NSLog(@"%@", error);
    }];
}

- (void)setUI{
    [self.view addSubview:self.addLabelButton];
    NAVIGATIONBACKBARBUTTONITEM
    self.title = [self.albumInfoDic[@"dirname"] isEqual:[NSNull null]] ? @"" : self.albumInfoDic[@"dirname"];
    NAVIGATIONBARRIGHTBARBUTTONITEM(@"相似照片")
    self.imageCollectionView.frame = CGRectMake(0, 0, ISScreen_Width, ISScreen_Height - 64 - 44);
}

- (void)addLabelButtonAction:(UIButton *)btn{
    
}

NAVIGATIONBACKITEMMETHOD

- (void)rightBarButtonItemAction:(UIButton *)btn{
    
}

#pragma mark - getter

- (UIButton *)addLabelButton{
    if (!_addLabelButton) {
        _addLabelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame) - 64 , ISScreen_Width, 44)];
        _addLabelButton.backgroundColor = ColorFromRGB(0x2E2E3A, 1.0);
        [_addLabelButton setTitle:@"批量添加标签" forState:UIControlStateNormal];
        [_addLabelButton addTarget:self action:@selector(addLabelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addLabelButton;
}
@end
