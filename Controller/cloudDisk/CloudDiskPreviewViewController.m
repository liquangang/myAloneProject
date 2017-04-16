

//
//  PreviewViewController.m
//  M-Cut
//
//  Created by apple on 16/12/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudDiskPreviewViewController.h"
#import "LabelsView.h"
#import "CustomeClass.h"

@interface CloudDiskPreviewViewController ()
@property (weak, nonatomic) IBOutlet UIView *controlView;
@property (nonatomic, strong) LabelsView *labelsView;
@property (nonatomic, strong) NSMutableArray *labelTitleArray;
@end

@implementation CloudDiskPreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVIGATIONBARTITLEVIEW(@"预览")
    NAVIGATIONBACKBARBUTTONITEM
    [self.view addSubview:self.labelsView];
}

#pragma mark - interface

NAVIGATIONBACKITEMMETHOD

/**
 *  设置标签
 */
- (IBAction)setLabelButtonAction:(id)sender {
    
}

/**
 *  删除
 */
- (IBAction)deleteButtonAction:(id)sender {
    
}

/**
 *  下载
 */
- (IBAction)downloadButtonAction:(id)sender {
    
}

/**
 *  移动
 */
- (IBAction)moveButttonAction:(id)sender {
    
}

+ (void)pushToMeWithNav:(UINavigationController *)nav{
    CloudDiskPreviewViewController *previewVc = [CloudDiskPreviewViewController new];
    [nav pushViewController:previewVc animated:YES];
}

#pragma mark - getter

- (LabelsView *)labelsView{
    if (!_labelsView) {
        [self.labelTitleArray addObjectsFromArray:@[@"比较是否",
                                                   @"那么比较",
                                                   @"初始化基本类型的时候尽",
                                                   @"量设置初始值,",
                                                   @"因为编译器分配的初始值并不确定",
                                                   @"oc的属性默认是atomic(原子的), ",
                                                   @"也就是说是线程",
                                                   @"安全的, 这个时候是不允许重写set和",
                                                   @"get方法的, 因为内部的setter和getter会做出处理, 保证线程安全, 但是我们经常使用的是noatomic, 因为访问的速度比较快, 并且可以",
                                                    @"自己重写getter和setter"]];
        
        _labelsView = [[LabelsView alloc] initWithWidth:ISScreen_Width LabelTitleArray:self.labelTitleArray];
        
        [_labelsView setFrameWithPoint:^CGPoint(CGSize mySize) {
            return CGPointMake(0, ISScreen_Height - 50 - mySize.height - 64);
        }];
        
        [_labelsView setTouchLabelBlock:^(NSInteger index) {
            
        }];
    }
    return _labelsView;
}

- (NSMutableArray *)labelTitleArray{
    LAZYINITMUARRAY(_labelTitleArray)
}

@end
