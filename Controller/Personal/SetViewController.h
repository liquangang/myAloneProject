//
//  SetViewController.h
//  M-Cut
//
//  Created by 刘海香 on 15/1/15.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetViewController : UIViewController<UITableViewDataSource,UITabBarDelegate,UIActionSheetDelegate>
{
    NSInteger cellCount;
    UIActionSheet *logoutActionSheet;
}

@property (strong, nonatomic) NSArray *setArra;
@property (retain, nonatomic) IBOutlet UITableView *setTabView;

//@property (retain, nonatomic) LoginViewController *loginViewController;
//@property (retain, nonatomic) UIWindow *window;

@end
