//
//  GuidePlayView.m
//  M-Cut
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "GuidePlayView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface GuidePlayView ()
//播放状态
@property (nonatomic, assign) BOOL isPlay;
//播放器
@property (nonatomic, strong) AVPlayer * videoPalyer;
//播放器layer
@property (nonatomic, strong) AVPlayerLayer * playerLayer;
@end

@implementation GuidePlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"inshow" ofType:@"mp4"];
        NSURL * videoUrl = [NSURL fileURLWithPath:videoPath];
        AVPlayerItem * playItem = [AVPlayerItem playerItemWithURL:videoUrl];
        self.videoPalyer = [AVPlayer playerWithPlayerItem:playItem];
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.videoPalyer];
        self.playerLayer.frame = self.bounds;
        [self.layer addSublayer:self.playerLayer];
        [self.videoPalyer play];
        REGISTEREDNOTI(playFinish:, AVPlayerItemDidPlayToEndTimeNotification);
        
        UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(ISScreen_Width / 2 - 44,
                                                                           ISScreen_Height - 88,
                                                                           88,
                                                                           20)];
        [self addSubview:startButton];
        [startButton setTitle:@"开始映像之旅" forState:UIControlStateNormal];
        [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        startButton.backgroundColor = ISRedColor;
        startButton.titleLabel.font = ISFont_13;
        [startButton addTarget:self
                        action:@selector(startButtonAction:)
              forControlEvents:UIControlEventTouchUpInside];
        startButton.layer.cornerRadius = 4;
        startButton.layer.masksToBounds = YES;
    }
    return self;
}

/**
 *  播放完成
 */
- (void)playFinish:(NSNotification *)noti{
    self.startBlock();
}

- (void)startButtonAction:(UIButton *)startButton{
    self.startBlock();
}

@end
