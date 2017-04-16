//
//  LogOutPersonViewController.h
//  M-Cut
//
//  Created by 刘海香 on 15/4/16.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TelephoneViewController.h"
#import "HaveLoginAndRegisterWindowViewController.h"

@interface LogOutPersonViewController : HaveLoginAndRegisterWindowViewController <UITableViewDataSource,UITableViewDelegate>
{
    __weak IBOutlet UIImageView *avatar;
}

@property (nonatomic, retain) NSArray *TableContent;
@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *UserSingature;
@property (weak, nonatomic) IBOutlet UIImageView *userLevelImage;
@property (weak, nonatomic) IBOutlet UILabel *withoutLoginLabel;


@end