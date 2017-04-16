//
//  NGSpeedHUD.m
//  NGMoviePlayer
//
//  Created by Kyle on 14-6-14.
//  Copyright (c) 2014年 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "NGSpeedHUD.h"
#import "NGMoviePlayerFunctions.h"

@interface NGSpeedHUD()

@property (nonatomic, strong) UIImageView *imageIcon;
@property (nonatomic, strong) UILabel *currentTimeLabel;
@property (nonatomic, strong) UILabel *totalTimeLabel;

@end

@implementation NGSpeedHUD

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.imageIcon];
        
        self.currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.currentTimeLabel.backgroundColor = [UIColor clearColor];
        self.currentTimeLabel.font = [UIFont systemFontOfSize:15.0f];
        self.currentTimeLabel.textAlignment = UITextAlignmentCenter;
        self.currentTimeLabel.textColor = [UIColor whiteColor];
        self.currentTimeLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.currentTimeLabel];
        
        self.totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.totalTimeLabel.backgroundColor = [UIColor clearColor];
        self.totalTimeLabel.font = [UIFont systemFontOfSize:15.0f];
        self.totalTimeLabel.textAlignment = UITextAlignmentCenter;
        self.totalTimeLabel.textColor = [UIColor colorWithRed:169.0f/255.0f green:169.0f/255.0f blue:169.0f/255.0f alpha:1.0f];
        self.totalTimeLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.totalTimeLabel];

        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageIcon.frame = CGRectMake((CGRectGetWidth(self.bounds)-83)/2, 0, 83, 74);
    self.currentTimeLabel.frame = CGRectMake(0, CGRectGetMaxX(self.imageIcon.frame), CGRectGetWidth(self.bounds)/2,20);
    self.totalTimeLabel.frame = CGRectMake(CGRectGetMaxX(self.currentTimeLabel.frame), CGRectGetMinY(self.currentTimeLabel.frame), CGRectGetWidth(self.bounds)/2,20);
}

- (void)setSpeedUp:(BOOL)speedUp{
    if (speedUp) {
        self.imageIcon.image =  [UIImage imageNamed:@"NGMoviePlayer.bundle/forward"];
    }else{
        self.imageIcon.image =  [UIImage imageNamed:@"NGMoviePlayer.bundle/backward"];
    }
}


- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    _currentTime = currentTime;
    
    self.currentTimeLabel.text = NGMoviePlayerGetTimeFormatted(_currentTime);
    
}

- (void)setTotalTime:(NSTimeInterval)totalTime
{
    _totalTime = totalTime;
    
    self.totalTimeLabel.text = [NSString stringWithFormat:@"/%@",NGMoviePlayerGetTimeFormatted(_totalTime)];
}


@end
