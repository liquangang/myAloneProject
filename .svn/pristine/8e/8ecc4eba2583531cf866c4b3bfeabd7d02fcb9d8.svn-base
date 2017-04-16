//
//  AccountAndSafeTableViewCell.h
//  M-Cut
//
//  Created by liquangang on 16/10/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountAndSafeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *accountNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *noBindingLabel;
@property (weak, nonatomic) IBOutlet UILabel *bindingAccountNicknameLabel;
@property (weak, nonatomic) IBOutlet UIButton *bindingButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accountNameLabelTop;

/** 绑定按钮block*/
@property (nonatomic, copy) void(^bindingBlock)(NSInteger bindingAccountType);

/** 获得cell*/
+ (instancetype)accountAndSafeTableViewCellWithAccountTypeStr:(NSString *)accountTypeStr
                                        AccountBindingStatues:(BOOL)isBinding
                                           AccountNicknameStr:(NSString *)nickname
                                                        Table:(UITableView *)cellSuperTable
                                                  AccountType:(NSInteger)accountType;
@end
