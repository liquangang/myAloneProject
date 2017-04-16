//
//  SearchUserViewController.h
//  M-Cut
//
//  Created by Admin on 16/3/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchUserVC : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *userTable;

/** 搜索内容*/
@property (nonatomic, copy) NSString * searchBarText;
@end
