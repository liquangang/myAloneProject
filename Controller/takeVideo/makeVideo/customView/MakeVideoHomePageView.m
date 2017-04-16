//
//  MakeVideoHomePageView.m
//  M-Cut
//
//  Created by liquangang on 2017/1/17.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "MakeVideoHomePageView.h"

@implementation MakeVideoHomePageView

#pragma mark - interface

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview];
    }
    return self;
}

- (void)addSubview{
    [self addSubview:self.upImageView];
    [self insertSubview:self.takeVideoButton aboveSubview:self.upImageView];
    [self insertSubview:self.selectImageButton aboveSubview:self.upImageView];
    [self insertSubview:self.togetherButton aboveSubview:self.upImageView];
    [self setFrame];
}

- (void)setFrame{
    WEAKSELF2
    self.upImageView.frame = self.bounds;
    
    
    /*
        选图片button距离顶部距离：屏幕宽度 + （剩余高度的一半 - 自身高度一半）
     */
    [self.selectImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.mas_top).with.offset(ISScreen_Width + ((ISScreen_Height - 49 - ISScreen_Width) / 2 - 20));
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
    [self.togetherButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.selectImageButton.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(200, 25));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
    
    [self.takeVideoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.selectImageButton.mas_top).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(200, 40));
        make.centerX.mas_equalTo(weakSelf.mas_centerX);
    }];
}

- (void)takeVideoButtonAction:(UIButton *)btn{
    self.takeVideoButtonActionBlock();
}

- (void)selectImageButtonActin:(UIButton *)btn{
    self.selectImageButtonActionBlock();
}

- (void)togetherButtonAction:(UIButton *)btn{
    self.togetherButtonActionBlock();
}

#pragma mark - getter

- (UIImageView *)upImageView{
    if (!_upImageView) {
        NSInteger tempNum = [CustomeClass getRandomNumber:1 to:5];
        NSString *tempStr = [NSString stringWithFormat:@"制作首页0%lu", tempNum];
        _upImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:tempStr]];
        _upImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _upImageView;
}

- (UIButton *)takeVideoButton{
    if (!_takeVideoButton) {
        _takeVideoButton = [[UIButton alloc] init];
        [_takeVideoButton setImage:[UIImage imageNamed:@"拍摄小"] forState:UIControlStateNormal];
        [_takeVideoButton setTitle:@" 拍摄新视频" forState:UIControlStateNormal];
        [_takeVideoButton addTarget:self action:@selector(takeVideoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _takeVideoButton.layer.masksToBounds = YES;
        _takeVideoButton.layer.cornerRadius = 7.5;
        _takeVideoButton.layer.borderWidth = 0.5;
        _takeVideoButton.layer.borderColor = ColorFromRGB(0xF4413F, 1.0).CGColor;
        _takeVideoButton.titleLabel.font = ISFont_14;
    }
    return _takeVideoButton;
}

- (UIButton *)selectImageButton{
    if (!_selectImageButton) {
        _selectImageButton = [UIButton new];
        [_selectImageButton setImage:[UIImage imageNamed:@"相册"] forState:UIControlStateNormal];
        [_selectImageButton setTitle:@" 从相册选择" forState:UIControlStateNormal];
        [_selectImageButton addTarget:self action:@selector(selectImageButtonActin:) forControlEvents:UIControlEventTouchUpInside];
        _selectImageButton.layer.masksToBounds = YES;
        _selectImageButton.layer.cornerRadius = 7.5;
        _selectImageButton.layer.borderColor = ColorFromRGB(0xF4413F, 1.0).CGColor;
        _selectImageButton.layer.borderWidth = 0.5;
        _selectImageButton.titleLabel.font = ISFont_14;
    }
    return _selectImageButton;
}

- (UIButton *)togetherButton{
    if (!_togetherButton) {
        _togetherButton = [UIButton new];
        [_togetherButton setImage:[UIImage imageNamed:@"协同制作"] forState:UIControlStateNormal];
        [_togetherButton setTitle:@" 协同制作" forState:UIControlStateNormal];
        [_togetherButton addTarget:self action:@selector(togetherButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _togetherButton.backgroundColor = ColorFromRGB(0x282828, 1.0);
        _togetherButton.layer.masksToBounds = YES;
        _togetherButton.layer.cornerRadius = 7.5;
        _togetherButton.titleLabel.font = ISFont_12;
    }
    return _togetherButton;
}

@end
