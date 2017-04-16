//
//  CameraOutView.h
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempVideoOBj.h"

@interface CameraOutView : UIView

/**
 *  开始展示拍摄画面
 */
- (void)startShowCameraImage;

/**
 *  结束拍摄画面展示
 */
- (void)stopShowCameraImage;

/**
 *  保存完成block
 */
@property (nonatomic, copy) void(^saveFinishBlock)(TempVideoOBj *tempVideoObj);

/**
 *  开始保存拍摄数据（即开始拍摄）
 */
- (void)startSaveVideoWithPath:(NSString *)videoSavePath;

/**
 *  停止保存拍摄数据，暂停拍摄
 */
- (void)stopSaveVideo;

/**
 *  切换镜头
 */
- (void)changeCamera;

/**
 *  打开闪光灯
 */
-(void)turnOnLed;

/**
 *  关闭闪光灯
 */
-(void)turnOffLed;
@end
