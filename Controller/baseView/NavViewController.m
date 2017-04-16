//
//  NavViewController.m
//  M-Cut
//
//  Created by apple on 16/11/12.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "NavViewController.h"
#import "CustomeClass.h"

@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([[super topViewController] isKindOfClass:[viewController class]]) {
        return;
    }
    [self setNavigationBarHidden:NO animated:YES];
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated{
    [self setNavigationBarHidden:NO animated:YES];
    return [super popViewControllerAnimated:animated];
}

@end
