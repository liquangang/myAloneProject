//
//  AccountAndSafeTableViewCell.m
//  M-Cut
//
//  Created by liquangang on 16/10/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AccountAndSafeTableViewCell.h"

@interface AccountAndSafeTableViewCell()
@property (nonatomic, assign) NSInteger accountType;
@end

@implementation AccountAndSafeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)bindingButtonAction:(id)sender {
    self.bindingBlock(self.accountType);
}

+ (instancetype)accountAndSafeTableViewCellWithAccountTypeStr:(NSString *)accountTypeStr
                                        AccountBindingStatues:(BOOL)isBinding
                                           AccountNicknameStr:(NSString *)nickname
                                                        Table:(UITableView *)cellSuperTable
                                                  AccountType:(NSInteger)accountType
{
    AccountAndSafeTableViewCell * cell =
    [cellSuperTable dequeueReusableCellWithIdentifier:@"AccountAndSafeTableViewCell"];
    if (!cell) {
        cell = XIBCELL(@"AccountAndSafeTableViewCell")
    }
    
    cell.accountNameLabel.text = accountTypeStr;
    if (isBinding) {
        cell.noBindingLabel.hidden = YES;
        cell.bindingButton.hidden = YES;
        cell.bindingAccountNicknameLabel.text = nickname;
        cell.bindingAccountNicknameLabel.hidden = NO;
        cell.accountType = -1;
        cell.accountNameLabelTop.constant = 15;
    }else{
        cell.noBindingLabel.hidden = NO;
        cell.bindingButton.hidden = NO;
        cell.bindingAccountNicknameLabel.hidden = YES;
        cell.accountType = accountType;
        cell.accountNameLabelTop.constant = 7;
    }
    
    return cell;
}

@end
