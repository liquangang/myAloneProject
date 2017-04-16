//
//  EditInforCell.m
//  M-Cut
//
//  Created by losehero on 15/12/4.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "EditInforCell.h"
#import "UIImageView+WebCache.h"
@implementation EditInforCell

-(IBAction)sexSelectAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button == self.girlButton)
    {
        [self.girlButton setSelected:YES];
        [self.boyButton  setSelected:NO];
    }
    else
    {
        [self.girlButton setSelected:NO];
        [self.boyButton  setSelected:YES];
    }
    
    if ([self.delegate respondsToSelector:@selector(EditInforCellSelectisBoyDelegate:)])
    {
        [self.delegate EditInforCellSelectisBoyDelegate:self.boyButton.selected];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIColor  *Color = [UIColor colorWithRed:64.0/255.0
                    green:74.0/255.0
                     blue:88.0/255.0
                    alpha:1];
    
    
    self.titleLabel.textColor = Color;
    self.editField.textColor  = Color;
    self.textView.textColor = Color;
    
    [_headImageView.layer setMasksToBounds:YES];
    [_headImageView.layer setCornerRadius:20.0];
    
    if ([self.titleLabel.text isEqualToString:@"我的账号"] ||
        [self.titleLabel.text isEqualToString:@"生日"] ||
        [self.titleLabel.text isEqualToString:@"地区"])
    {
        self.editField.userInteractionEnabled = NO;
    }
    
    [self reloadDataSource];
    
}
/*
    1 男  2女
 */

-(void)reloadDataSource
{
    if ([self.titleLabel.text isEqualToString:@"头像"])
    {
        [self.headImageView  sd_setImageWithURL:[NSURL URLWithString:self.userInfo.szAcatar] placeholderImage:[UIImage imageNamed:@"overlayBG_shadow"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
    }
    else if([self.titleLabel.text isEqualToString:@"昵称"])
    {
        [self.editField setText:self.userInfo.szNickname];
    }
    else if([self.titleLabel.text isEqualToString:@"我的账号"])
    {
        [self.editField setText:self.userInfo.szCustomerName];
    }
    else if([self.titleLabel.text isEqualToString:@"性别"])
    {
        int  gender = [self.userInfo.nGender intValue];
        if (gender == 1)
        {
            [self.boyButton setSelected:YES];
            [self.girlButton setSelected:NO];
        }
        else if(gender == 2)
        {
            [self.girlButton setSelected:YES];
            [self.boyButton setSelected:NO];
        }
    }
    else if([self.titleLabel.text isEqualToString:@"个人签名"])
    {
        if (self.userInfo.szSignature) {
            [self.textView setText:self.userInfo.szSignature];
            self.textView.textColor = [UIColor blackColor];
        }else
        {
            [self.textView setText:@"请输入50个字以内的个性签名"];
            self.textView.textColor = [UIColor lightGrayColor];
        }
        
    }
    else if([self.titleLabel.text isEqualToString:@"生日"])
    {
        if (self.userInfo.nBirthdayD && self.userInfo.nBirthdayM && self.userInfo.nBirthdayY) {
            [self.editField setText:[NSString stringWithFormat:@"%d-%d-%d",
                                     [self.userInfo.nBirthdayY intValue],
                                     [self.userInfo.nBirthdayM intValue],
                                     [self.userInfo.nBirthdayD intValue]]];
        }

    }
    else if([self.titleLabel.text isEqualToString:@"地区"])
    {
        if (self.userInfo.szLocationProvince.length > 0) {
            [self.editField setText:[NSString stringWithFormat:@"%@-%@",self.userInfo.szLocationProvince,self.userInfo.szLocationCity]];
        }

    }
//    else if([self.titleLabel.text isEqualToString:@"邮箱"])
//    {
//        [self.editField setText:self.userInfo.szEmail];
//    }
    else if([self.titleLabel.text isEqualToString:@"手机"])
    {
        [self.editField setText:self.userInfo.szTel];
    }
}


@end
