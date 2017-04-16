//
//  VideoDetailUserInfoTableViewCell.h
//  M-Cut
//
//  Created by liquangang on 16/9/20.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoDetailUserInfoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoCreateTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *careButton;
@property (weak, nonatomic) IBOutlet UILabel *visitCountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *videoCreateTimesLabelWidth;

@property (nonatomic, copy) void(^clickUserImageBlock)();
@property (nonatomic, copy) void(^careButtonBlock)();

/*****************************************************************
 函数名称：+ (id)VideoDetailUserInfoTableViewCellWithCellSuperTable:(UITableView *)cellSuperTable
                                                          InfoDic:(NSMutableDictionary *)infoDic;
 函数描述：获得VideoDetailUserInfoTableViewCell（2016-09-21增加）
 输入参数：cellSuperTable所在的UITableView
         infoDic:cell上需要的信息
 输出参数：N/A
 返回值： 一个初始化完成的cell
 *****************************************************************/
+ (id)VideoDetailUserInfoTableViewCellWithCellSuperTable:(UITableView *)cellSuperTable
                                                 InfoDic:(NSMutableDictionary *)infoDic;
@end
