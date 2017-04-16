//
//  CameraControlView.h
//  M-Cut
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TakeVideoView.h"

@interface CameraControlView : UIView
//取消按钮
@property (nonatomic, strong) UIButton *cancleButton;
//拍照按钮
@property (nonatomic, strong) UIButton *takeVideoButton;
//使用该视频
@property (nonatomic, strong) UIButton *useVideoButton;
//拍摄暂停label
@property (nonatomic, strong) UILabel *takePropmtLabel;
//视频展示table
@property (nonatomic, strong) TakeVideoView *videoShowView;
//切换摄像头按钮
@property (nonatomic, strong) UIButton *changeCameraButton;
//闪光灯按钮
@property (nonatomic, strong) UIButton *ledControlButton;
//切换相册按钮
@property (nonatomic, strong) UIButton *openAlbumButton;
@end
