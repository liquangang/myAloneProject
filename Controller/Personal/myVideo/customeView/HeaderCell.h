//
//  HeaderCell.h
//  M-Cut
//
//  Created by apple on 16/7/4.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoapOperation.h"

typedef void(^UPDATEBACKIMAGE)(UIImageView * backImage, NSMutableDictionary * userDataArray);

@interface HeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *userNameLabelWidth;
@property (weak, nonatomic) IBOutlet UILabel *userSignatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPraiseNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userGenderImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userLevelImage;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImage;
@property (weak, nonatomic) IBOutlet UILabel *videoHeatLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic, strong) UIImageView * backImage;
@property (nonatomic, strong) NSMutableDictionary * userDataDic;

/** 修改背景图片*/
@property (nonatomic, copy) UPDATEBACKIMAGE updateBackImage;

/** 封装复用cell的代码*/
+ (id)getHeaderCellWithTable:(UITableView *)myTable WithUserId:(NSString *)userID;

/** 调用updateBackImage的方法*/
- (void)UpdateBackImage:(UPDATEBACKIMAGE)updateBackImage;
@end
