//
//  CameraControlView.m
//  M-Cut
//
//  Created by apple on 16/11/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CameraControlView.h"

@implementation CameraControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = [UIColor clearColor];
        
        //取消按钮
        self.cancleButton = [[UIButton alloc] init];
        [self.cancleButton setImage:[UIImage imageNamed:@"X号2"] forState:UIControlStateNormal];
        self.cancleButton.frame = CGRectMake(20,
                                             20,
                                             20,
                                             20);
        
        //拍照提示label
        self.takePropmtLabel = [[UILabel alloc] initWithFrame:CGRectMake(ISScreen_Width / 2 - 25,
                                                                         self.bounds.size.height - 70,
                                                                         50,
                                                                         16)];
        self.takePropmtLabel.font = [UIFont systemFontOfSize:11];
        self.takePropmtLabel.textColor = [UIColor whiteColor];
        self.takePropmtLabel.textAlignment = NSTextAlignmentCenter;
        self.takePropmtLabel.text = @"点击拍摄";
        
        //拍照按钮
        self.takeVideoButton = [[UIButton alloc] init];
        self.takeVideoButton.frame = CGRectMake(ISScreen_Width / 2 - 25,
                                                self.bounds.size.height - 54,
                                                50,
                                                50);
        [self.takeVideoButton setImage:[UIImage imageNamed:@"pauseTakeVideoImage"]
                              forState:UIControlStateNormal];
        [self.takeVideoButton setImage:[UIImage imageNamed:@"startTakeVideoImage"]
                              forState:UIControlStateSelected];
        
        //使用该视频
        self.useVideoButton = [[UIButton alloc] init];
        self.useVideoButton.frame = CGRectMake(ISScreen_Width / 3 * 2,
                                               self.bounds.size.height - 70,
                                               ISScreen_Width / 3,
                                               70);
        [self.useVideoButton setTitleColor:[UIColor whiteColor]
                                  forState:UIControlStateNormal];
        [self.useVideoButton setTitle:@"下一步"
                             forState:UIControlStateNormal];
        self.useVideoButton.hidden = YES;
        
        //切换镜头按钮
        self.changeCameraButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 60, 30)];
        [self.changeCameraButton setImage:[UIImage imageNamed:@"changeCameraImage"]
                                 forState:UIControlStateNormal];
        [self.changeCameraButton setBackgroundColor:ColorFromRGB(0x2E2E3A, 0.6)];
        self.changeCameraButton.layer.cornerRadius = 6;
        self.changeCameraButton.layer.masksToBounds = YES;
        
        //添加视频展示table
        self.videoShowView = [[TakeVideoView alloc] initWithFrame:CGRectMake(self.frame.size.width - 90,
                                                                             0,
                                                                             90,
                                                                             275)];
        
        //闪光灯控制
        self.ledControlButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 55, 60, 30)];
        [self.ledControlButton setImage:[UIImage imageNamed:@"ledTurnOffImage"]
                                 forState:UIControlStateNormal];
        [self.ledControlButton setImage:[UIImage imageNamed:@"ledTurnOnImage"]
                               forState:UIControlStateSelected];
        [self.ledControlButton setBackgroundColor:ColorFromRGB(0x2E2E3A, 0.6)];
        self.ledControlButton.layer.cornerRadius = 6;
        self.ledControlButton.layer.masksToBounds = YES;
        
        //打开相册
        self.openAlbumButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 70, ISScreen_Width / 3, 70)];
//        [self.openAlbumButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.openAlbumButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.openAlbumButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.openAlbumButton.layer.masksToBounds = YES;
        self.openAlbumButton.layer.cornerRadius = 4;
    }
    return self;
}

@end
