//
//  InputView.h
//  M-Cut
//
//  Created by liquangang on 16/9/21.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EditStatus){
    beginEdit,
    endEdit,
    unKnown
};

@interface InputView : UIView
/** 发送按钮方法*/
@property (nonatomic, copy) void(^sendInputContentBlock)(NSString * contentStr);
/** 输入框*/
@property (nonatomic, strong) UITextView * inputTextView;
/** 输入框编辑状态*/
@property (nonatomic, assign) EditStatus editStatus;
@end
