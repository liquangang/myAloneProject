//
//  CommentTableViewCell.h
//  M-Cut
//
//  Created by liquangang on 16/9/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MovierDCInterfaceSvc.h"

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *userImageButton;
@property (weak, nonatomic) IBOutlet UILabel *commentCreateTimeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentCreateTimeLabelWidth;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentContentLabelHeight;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

/** 头像点击方法*/
@property (nonatomic, copy) void(^clickUserImage)(NSString * userId);
/** 长按block*/
@property (nonatomic, copy) void(^longGestureBlock)(MovierDCInterfaceSvc_vpVideoComment * commentInfo,
                                                                            NSIndexPath * cellIndexPath);

/*****************************************************************
 函数名称：+ (id)CommentTableViewCellWithCellSuperTable:(UITableView *)cellSuperTableView
                                          CommentInfo:(MovierDCInterfaceSvc_vpVideoComment *)commentInfo
                                                Index:(NSIndexPath *)cellIndexPath;
 函数描述：获得CommentTableViewCell（2016-09-21增加）
 输入参数：cellSuperTableView:所在的UITableView
         commentInfo:cell上需要的信息
         cellIndexPath:cell在table上的位置
 输出参数：N/A
 返回值： 一个初始化完成的cell
 *****************************************************************/
+ (id)CommentTableViewCellWithCellSuperTable:(UITableView *)cellSuperTableView
                                 CommentInfo:(MovierDCInterfaceSvc_vpVideoComment *)commentInfo
                                       Index:(NSIndexPath *)cellIndexPath;
@end
