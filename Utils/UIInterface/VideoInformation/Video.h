//
//  Video.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/2/5.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoInformationObject.h"
#import "MovierDCInterfaceSvc.h"
//视频对象
@interface Video : VideoInformationObject


+ (Video *)Singleton;

-(void)setContent:(VideoInformationObject*)info;
-(void)setWSContent:(MovierDCInterfaceSvc_VDCVideoInfoEx*)info;

/** 根据video对象的属性设置video单例的属性*/
- (void)setVideoWithVideoInfo:(NSMutableDictionary *)videoInfoEx;
@end
