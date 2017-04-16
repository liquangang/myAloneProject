//
//  PropmtView.h
//  M-Cut
//
//  Created by apple on 16/11/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropmtView : UIView

/**
 *  点击事件
 */
@property (nonatomic, copy) void(^touchBlock)();
@end
