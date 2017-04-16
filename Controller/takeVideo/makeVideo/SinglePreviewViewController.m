//
//  SinglePreviewViewController.m
//  M-Cut
//
//  Created by liquangang on 2017/1/20.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "SinglePreviewViewController.h"

@interface SinglePreviewViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (nonatomic, assign) BOOL isPlay;  //播放状态
@property (nonatomic, strong) AVPlayerLayer *playerLayer;   //播放器layer
@end

@implementation SinglePreviewViewController

DEALLOCMETHOD

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.assetModel.previewImage) {
        self.backImageView.image = self.assetModel.previewImage;
    }else if (self.assetModel.originImage){
        self.backImageView.image = self.assetModel.originImage;
    }else{
        self.backImageView.image = self.assetModel.thumbnail;
    }
    
    if (self.assetModel.type == XMNAssetTypeVideo) {
        ADDTAPGESTURE(self.backImageView, touchBackImage)
        [self.view.layer addSublayer:self.playerLayer];
        [self.playButton setImage:[UIImage imageNamed:@"videoPlayerNormalPlayImage"] forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - interface

- (void)touchBackImage:(UITapGestureRecognizer *)tap{
    self.isPlay = !self.isPlay;
    self.playButton.hidden = !self.playButton.hidden;
    
    if (self.isPlay) {
        [self.playerLayer.player play];
    }else{
        [self.playerLayer.player pause];
    }
}

- (IBAction)backButtonAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)playFinish:(NSNotification *)noti{
    [self touchBackImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AVPlayerLayer *)playerLayer{
    if (!_playerLayer) {
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:[AVPlayer playerWithPlayerItem:self.assetModel.playerItem]];
        _playerLayer.frame = self.view.bounds;
        REGISTEREDNOTI(playFinish:, AVPlayerItemDidPlayToEndTimeNotification);
    }
    return _playerLayer;
}

@end
