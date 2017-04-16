//
//  OnlyOneView.h
//  M-Cut
//
//  Created by apple on 16/11/15.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OnlyOneView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *needShowImage;

/**
 *@brief    展示该image
 *@param    showImage 展示的image数据
 */
- (void)showOnlyImageWithImage:(UIImage *)showImage;

/**
 *@brief    隐藏该image
 */
- (void)hiddenImage;

/**
 *  交互block
 */
@property (nonatomic, copy) void(^imageTapBlock)();

@end
