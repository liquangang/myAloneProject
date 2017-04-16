//
//  EditInforCell.h
//  M-Cut
//
//  Created by losehero on 15/12/4.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"
@protocol EditInforCellDelegate <NSObject>
-(void)EditInforCellSelectisBoyDelegate:(BOOL)isboy;
@end


@interface EditInforCell : UITableViewCell
@property (nonatomic,weak) id<EditInforCellDelegate> delegate;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UITextField *editField;
@property (nonatomic,weak) IBOutlet UIImageView *headImageView;
@property (nonatomic,weak) IBOutlet UITextView *textView;
@property (nonatomic,weak) IBOutlet UIButton *boyButton;
@property (nonatomic,weak) IBOutlet UIButton *girlButton;
@property (nonatomic,strong) MovierDCInterfaceSvc_VDCCustomerInfo *userInfo;
@end
