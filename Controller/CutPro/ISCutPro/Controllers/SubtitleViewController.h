//
//  SubtitleViewController.h
//  M-Cut
//
//  Created by apple on 16/11/30.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"

@interface SubtitleViewController : UIViewController
/**
 *  获得字幕block
 */
@property (nonatomic, copy) void(^getSubtitleBlock)(MovierDCInterfaceSvc_vpVDCSubtitleC *subtitleModel);
@end
