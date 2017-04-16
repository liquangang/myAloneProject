//
//  CloudSpaceViewController.m
//  M-Cut
//
//  Created by apple on 16/12/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CloudSpaceViewController.h"

@interface CloudSpaceViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *spaceImage;
@property (weak, nonatomic) IBOutlet UISlider *spaceSlider;
@property (weak, nonatomic) IBOutlet UILabel *allSpaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *noUseSpaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel1;
@property (weak, nonatomic) IBOutlet UILabel *percentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentSpaceLabel1;
@property (weak, nonatomic) IBOutlet UILabel *persentLabel2;
@property (weak, nonatomic) IBOutlet UILabel *percentSpaceLabel2;
@property (weak, nonatomic) IBOutlet UILabel *precentTitle2;

@end

@implementation CloudSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVIGATIONBACKBARBUTTONITEM
    NAVIGATIONBARTITLEVIEW(@"云空间")
    NAVIGATIONBARRIGHTBARBUTTONITEM(@"扩容")
}

#pragma mark - interface

NAVIGATIONBACKITEMMETHOD

- (void)rightBarButtonItemAction:(UIButton *)btn{
    
}

@end
