//
//  VideoLabelViewController.h
//  M-Cut
//
//  Created by apple on 16/11/26.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovierDCInterfaceSvc.h"
#import "HaveLoginAndRegisterWindowViewController.h"

@interface VideoLabelViewController : HaveLoginAndRegisterWindowViewController
@property (nonatomic, strong) MovierDCInterfaceSvc_VDCVideoLabelEx2 *labelInfo;

/**
 *  model转换
 */
+ (MovierDCInterfaceSvc_VDCVideoLabelEx2 *)modelUpdateWithModel1:(MovierDCInterfaceSvc_VDCVideoLabelEx *)videoLabelEx;

/**
 *  字典转model
 */
+ (MovierDCInterfaceSvc_VDCVideoLabelEx2 *)dicToModelWithDic:(NSDictionary *)labelInfoDic;
@end
