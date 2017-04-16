//
//  BaseNavigationBar.m
//  M-Cut
//
//  Created by 刘海香 on 15/2/10.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "BaseNavigationBar.h"

@implementation BaseNavigationBar

-(void)awakeFromNib{
    [super awakeFromNib];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:ColorFromRGB(0x2E2E3A, 1.0)];
    [[UINavigationBar appearance] setBackgroundColor:ColorFromRGB(0x2E2E3A, 1.0)];
    [UINavigationBar appearance].translucent = NO;
}

@end
