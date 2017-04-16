//
//  ARViewControl.h
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ARRewardView.h"

@interface ARViewControl : NSObject

/**
 *  获得arrewardview
 */
- (ARRewardView *)getARRewardViewWithFrame:(CGRect)arRewardViewFrame;
@end
