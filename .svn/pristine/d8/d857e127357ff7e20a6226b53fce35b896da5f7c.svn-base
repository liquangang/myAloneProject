//
//  NGMoviePlayerControlView.h
//  NGMoviePlayer
//
//  Created by Tretter Matthias on 13.03.12.
//  Copyright (c) 2012 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "NGMoviePlayerControlStyle.h"
#import "NGWeak.h"


@class NGMoviePlayerLayout;
@protocol NGMoviePlayerControlActionDelegate;
@protocol NGMoviePlayerControlDataSource;


@interface NGMoviePlayerControlView : UIView

@property (nonatomic, ng_weak) id<NGMoviePlayerControlActionDelegate> delegate;
@property (nonatomic, ng_weak) id<NGMoviePlayerControlDataSource> dataSource;

/** Controls whether the player controls are currently in fullscreen- or inlinestyle */
@property (nonatomic, assign) NGMoviePlayerControlStyle controlStyle;

@property (nonatomic, assign) NGMoviePlayerControlScrubbingTimeDisplay scrubbingTimeDisplay;

@property (nonatomic, readonly) NSArray *topControlsViewButtons;
@property (nonatomic, assign) NSTimeInterval playableDuration;
@property (nonatomic, readonly, getter = isAirPlayButtonVisible) BOOL airPlayButtonVisible;


- (void)hiddenRelateTableView;
- (void)hiddenVideoLevelView;
- (void)resetVideoStatus;

/******************************************
 @name Updating
 ******************************************/

- (void)updateScrubberWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration;
- (void)updateButtonsWithPlaybackStatus:(BOOL)isPlaying;


#pragma mark --- -
@property (nonatomic, strong, readwrite) UIButton *playPauseControl;
- (void)handlePlayPauseButtonPress:(id)sender;
@end
