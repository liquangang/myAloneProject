//
//  GuidePlayView.h
//  M-Cut
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuidePlayView : UIView
/**
 *  按钮block
 */
@property (nonatomic, copy) void(^startBlock)();
@end
