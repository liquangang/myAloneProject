//
//  MovierViewController.h
//  M-Cut
//
//  Created by Crab shell on 12/26/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
//消息解析类
#import "AnalysisMes.h"

@interface MovierTabBarViewController : UITabBarController
{
    UIImageView *_tabBarSelectedImageView;
    NSInteger getossretrytime;//重试次数
}
@property(retain,nonatomic) NSMutableArray *items;
@property(retain,nonatomic) NSArray *selectedImageArray;
@property(assign,nonatomic) NSInteger lastButtonIndex;
@property(retain,nonatomic) NSArray *imageArray;

//-(void)MovierLogin;


@end
