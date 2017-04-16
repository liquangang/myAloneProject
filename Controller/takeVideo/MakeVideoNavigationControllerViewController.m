//
//  MakeVideoNavigationControllerViewController.m
//  M-Cut
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MakeVideoNavigationControllerViewController.h"
#import "MakeVideoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MakeVideoNavigationControllerViewController ()

@end

@implementation MakeVideoNavigationControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self pushToMakeVideoVc];
}

- (void)pushToMakeVideoVc{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        MakeVideoViewController *makeVideoVc = [MakeVideoViewController new];
        [weakSelf pushViewController:makeVideoVc animated:YES];
    })
}

@end
