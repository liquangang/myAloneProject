//
//  NGMoviePlayerCustomiPadLayout.h
//  NGMoviePlayer
//
//  Created by Kyle on 14-6-11.
//  Copyright (c) 2014年 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "NGMoviePlayerLayout.h"

@interface NGMoviePlayerCustomiPadLayout : NGMoviePlayerLayout


@property (nonatomic, readonly) NSArray *topControlsButtons;

@property (nonatomic, assign) BOOL scrubberHidden;
@property (nonatomic, assign) BOOL skipButtonsHidden;
@property (nonatomic, assign) CGFloat minWidthToDisplaySkipButtons;

/** the color of the scrubber */
@property (nonatomic, strong) UIColor *scrubberFillColor;
/** the padding between the buttons in topControlsView */
@property (nonatomic, assign) CGFloat topControlsViewButtonPadding;
/** the position of the zoomout-button in fullscreen-style */
@property (nonatomic, assign) NGMoviePlayerControlViewTopControlsViewAlignment topControlsViewAlignment;
/** the position of the zoomout-button in fullscreen-style */
@property (nonatomic, assign) NGMoviePlayerControlViewZoomOutButtonPosition zoomOutButtonPosition;


- (CGFloat)topControlsViewHeightForControlStyle:(NGMoviePlayerControlStyle)controlStyle;
- (CGFloat)bottomControlsViewHeightForControlStyle:(NGMoviePlayerControlStyle)controlStyle;

- (void)addTopControlsViewButton:(UIButton *)button;

@end
