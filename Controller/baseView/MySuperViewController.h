//
//  MySuperViewController.h
//  M-Cut
//
//  Created by liquangang on 2017/1/23.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterLayout.h"
#import <WebKit/WebKit.h>

@interface MySuperViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WaterLayout *waterLayout;
@property (nonatomic, strong) WKWebView *webView;
@end
