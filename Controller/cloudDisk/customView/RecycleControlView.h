//
//  RecycleControlView.h
//  M-Cut
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecycleControlView : UIView
@property (nonatomic, strong) UIButton *restoreButton;  //恢复按钮
@property (nonatomic, strong) UIButton *deleteButton;   //删除按钮
@property (nonatomic, copy) void(^restoreButtonBlock)();    //恢复按钮点击block
@property (nonatomic, copy) void(^deleteButtonBlock)();     //删除按钮点击block
@end
