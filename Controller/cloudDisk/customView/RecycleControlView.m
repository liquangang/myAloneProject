//
//  RecycleControlView.m
//  M-Cut
//
//  Created by apple on 16/12/20.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "RecycleControlView.h"
#import <Masonry.h>

@implementation RecycleControlView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    self.restoreButton = [UIButton new];
    [self addSubview:self.restoreButton];
    [self.restoreButton setTitle:@"恢复" forState:UIControlStateNormal];
    self.restoreButton.backgroundColor = ColorFromRGB(0x2E2E3A, 1.0);
    [self.restoreButton addTarget:self action:@selector(restoreButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lineLabel = [UILabel new];
    [self addSubview:lineLabel];
    lineLabel.backgroundColor = ColorFromRGB(0x6D717D, 0.5);
    
    self.deleteButton = [UIButton new];
    [self addSubview:self.deleteButton];
    [self.deleteButton setTitle:@"彻底删除" forState:UIControlStateNormal];
    self.deleteButton.backgroundColor = ColorFromRGB(0x2E2E3A, 1.0);
    [self.deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    WEAKSELF2
    [self.restoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.right.equalTo(lineLabel.mas_left).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.width.equalTo(weakSelf.deleteButton);
    }];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.mas_equalTo(weakSelf.mas_top).with.offset(0);
        make.bottom.mas_equalTo(weakSelf.mas_bottom).with.offset(0);
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineLabel.mas_right).with.offset(0);
        make.top.equalTo(weakSelf.mas_top).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).with.offset(0);
        make.width.equalTo(weakSelf.restoreButton);
    }];
}

- (void)restoreButtonAction{
    self.restoreButtonBlock();
}

- (void)deleteButtonAction{
    self.deleteButtonBlock();
}

@end
