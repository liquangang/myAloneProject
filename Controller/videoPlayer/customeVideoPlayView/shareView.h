//
//  shareView.h
//  M-Cut
//
//  Created by apple on 16/10/26.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shareView : UIView

//分享的点击block
@property (nonatomic, strong) void(^shareTapBlock)(NSInteger index);

//图文分享按钮
@property (nonatomic, strong) void(^tuwenShareBlock)();

//取消按钮
@property (nonatomic, strong) void(^cancleBlock)();

/**
 *  初始化
 */
- (instancetype)initWithFrame:(CGRect)frame
                   ImageArray:(NSArray *)imageArray
                    NameArray:(NSArray *)nameArray;

/**
 *  隐藏图文分享的初始化
 */
- (instancetype)init2WithFrame:(CGRect)frame
                    ImageArray:(NSArray *)imageArray
                     NameArray:(NSArray *)nameArray;
@end
