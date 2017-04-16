//
//  HomeTopController.m
//  M-Cut
//
//  Created by Crab00 on 15/10/6.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "HomeTopController.h"

@interface HomeTopController ()

@end

@implementation HomeTopController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIViewController *firstViewC = [[UIViewController alloc] init];
    firstViewC.title = @"风格";
    UIViewController *secondViewC = [[UIViewController alloc] init];
    secondViewC.title = @"音乐";
    UIViewController *thirdViewC = [[UIViewController alloc] init];
    thirdViewC.title = @"字幕";
//    thirdViewC.view.backgroundColor = [UIColor orangeColor];//测试使用
    
    topTabBar = [[SCNavTabBarController alloc] init];
    topTabBar.showContentView = false;
    topTabBar.subViewControllers = @[firstViewC, secondViewC, thirdViewC];
    [topTabBar addParentController:self];
    //    topTabBar.delegate = self;

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

@end
