//
//  OperationTableViewCell.h
//  M-Cut
//
//  Created by liquangang on 16/9/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OperationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UILabel *commentNumLabel;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UILabel *grayLabel1;

/** 分享block*/
@property (nonatomic, copy) void(^shareBlock)();
/** 一键照做block*/
@property (nonatomic, copy) void(^followMakeBlock)();
/** 未登录block*/
@property (nonatomic, copy) void(^noLoginBlock)();
@property (nonatomic, copy) void(^updatePraiseBlock)(NSInteger praiseNum);
@property (nonatomic, copy) void(^updateCollectBlock)(NSInteger collectNum);

/*****************************************************************
 函数名称：+ (id)OperationTableViewCellWithTable:(UITableView *)cellSuperTable
                                      CellInfo:(NSMutableDictionary *)infoDic;
 函数描述：获得OperationTableViewCell（2016-09-21增加）
 输入参数：cellSuperTable:所在的UITableView
         infoDic:cell上需要的信息
 输出参数：N/A
 返回值： 一个初始化完成的cell
 *****************************************************************/
+ (id)OperationTableViewCellWithTable:(UITableView *)cellSuperTable
                             CellInfo:(NSMutableDictionary *)infoDic;
@end