//
//  HomeSelectedViewController.m
//  M-Cut
//
//  Created by apple on 16/6/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HomeSelectedViewController.h"

@interface HomeSelectedViewController ()

@end

@implementation HomeSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initHomeSelectedVcUI];
    [self downloadHomeSelectedVcData];
}

#pragma mark - initUI
- (void)initHomeSelectedVcUI{
    self.title = @"首页精选";
    self.praiseStr = @"被首页精选选中的作品数量";
}

#pragma mark - downloadData
- (void)downloadHomeSelectedVcData{
    [self.videoMuArray removeAllObjects];
    [self.videoMuArray addObjectsFromArray:[NSArray arrayWithObjects:@"1", @"1", @"1", @"1", nil]];
}

@end
