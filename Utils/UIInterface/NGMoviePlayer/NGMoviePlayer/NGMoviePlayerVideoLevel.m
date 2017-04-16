//
//  NGMoviePlayerVideoLevel.m
//  NGMoviePlayer
//
//  Created by Kyle on 14-6-10.
//  Copyright (c) 2014年 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "NGMoviePlayerVideoLevel.h"

#define kButtonMarginX 8
#define kButtonMarginY 2
#define kButtonPaddY 2

@interface NGMoviePlayerVideoLevel(){
    
}

@property (nonatomic, strong) NSMutableArray *levelButtons;


@end

@implementation NGMoviePlayerVideoLevel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds))];
        leftImageView.userInteractionEnabled = YES;
        leftImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UIImage *leftImage = [UIImage imageNamed:@"NGMoviePlayer.bundle/player_popup_bg_clarity_left"];
        if ([leftImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
            leftImage = [leftImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 14, 16, 8)];
        }else{
            leftImage = [leftImage stretchableImageWithLeftCapWidth:30 topCapHeight:20];
        }
        leftImageView.image = leftImage;
        [self addSubview:leftImageView];
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame), 0, CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds))];
        rightImageView.userInteractionEnabled = YES;
        rightImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UIImage *rightImage = [UIImage imageNamed:@"NGMoviePlayer.bundle/player_popup_bg_clarity_right"];
        if ([rightImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
            rightImage = [rightImage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 8, 16, 14)];
        }else{
            rightImage = [rightImage stretchableImageWithLeftCapWidth:12 topCapHeight:30];
        }
        rightImageView.image = rightImage;
        [self addSubview:rightImageView];

        
        
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger number = [_titles count];
    NSInteger cnt = [self.levelButtons count];
    
    for (; cnt>number; cnt--) {
        UIView *view = [_levelButtons objectAtIndex:cnt];
        [view removeFromSuperview];
        [self.levelButtons removeObjectAtIndex:cnt];
    }
    
    for (; cnt<number; cnt++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kButtonMarginX, 0, CGRectGetWidth(self.bounds)-2*kButtonMarginX, kLevelButtonHeight-2*kButtonMarginY)];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.titleLabel.textColor = [UIColor whiteColor];
        UIImage *hilightImage = [UIImage imageNamed:@"NGMoviePlayer.bundle/player_episode_selected"];
        if ([hilightImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
            hilightImage = [hilightImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        }else{
            hilightImage = [hilightImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        }
        button.showsTouchWhenHighlighted = YES;
        [button setBackgroundImage:hilightImage forState:UIControlStateSelected];
        [button addTarget:self action:@selector(levelSeleted:) forControlEvents:UIControlEventTouchUpInside];
        [self.levelButtons addObject: button];
        [self addSubview:button];
    }
    
    CGFloat originY = 8;
    for (NSInteger i = 0; i<number; i++) {
        NSString *title = [_titles objectAtIndex:i];
        UIButton *button = [self.levelButtons objectAtIndex:i];
        if ([title isEqualToString:self.levelName]) {
            button.selected = TRUE;
        }else{
            button.selected = FALSE;
        }
        [button setTitle:title forState:UIControlStateNormal];
        CGRect frame = button.frame;
        frame.origin.y = originY;
        button.frame = frame;
        
        originY += CGRectGetHeight(frame)+kButtonPaddY;
    }
    
    
}


- (void)setTitles:(NSArray *)titles
{
    if (_titles == titles) {
        return;
    }
    _titles = titles;
    [self setNeedsLayout];
    
}


- (NSMutableArray *)levelButtons
{
    if (_levelButtons != nil) {
        return _levelButtons;
    }
    
    _levelButtons = [[NSMutableArray alloc] initWithCapacity:3];
    return _levelButtons;
}


- (void)levelSeleted:(UIButton*)button
{
    
    NSInteger index = -1;
    for (NSUInteger i=0; i<[self.levelButtons count]; i++) {
        UIButton *subButton = [self.levelButtons objectAtIndex:i];
        if (subButton == button) {
            subButton.selected = TRUE;
            index = i;
        }else{
            subButton.selected = FALSE;
        }
        
    }
    if (index == -1) {
        NSLog(@"NGMoviePlayerVideoLevel levelSeleted error index = -1;");
        return;
    }
    
    if (index >= [self.titles count]) {
        NSLog(@"NGMoviePlayerVideoLevel index:%ld >= [self.titles count] %ld",(long)index,[self.titles count]);
        return;
    }
    
    NSString *title = [self.titles objectAtIndex:index];
    
    if ([self.delegate respondsToSelector:@selector(moviePlayerVideoLevel:seletedIdex:title:)]) {
        [self.delegate moviePlayerVideoLevel:self seletedIdex:index title:title];
    }
    
    
}


@end
