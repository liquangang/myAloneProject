//
//  MailboxViewController.h
//  M-Cut
//
//  Created by 彰笑天 on 14/12/30.
//  Copyright (c) 2014年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MailboxViewController : UIViewController{
    IBOutlet UITextField *userName;
    IBOutlet UITextField *userMailbox;
    IBOutlet UITextField *userPassword;
    
}

@property (nonatomic,strong) UITextField *userName;
@property (nonatomic,strong) UITextField *userMailbox;
@property (nonatomic,strong) UITextField *userPassword;

- (IBAction)registers:(id)sender;
- (IBAction)outDone:(id)sender;
@end
