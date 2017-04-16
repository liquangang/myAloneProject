//
//  MySuperViewController.m
//  M-Cut
//
//  Created by liquangang on 2017/1/23.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "MySuperViewController.h"

@interface MySuperViewController ()

@end

@implementation MySuperViewController

DEALLOCMETHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    NAVIGATIONBACKBARBUTTONITEM
}

#pragma mark - interface

NAVIGATIONBACKITEMMETHOD

#pragma mark - rewriteSuperMethod

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}



@end
