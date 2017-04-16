//
//  NGMoviePlayerLayout.h
//  NGMoviePlayer
//
//  Created by Matthias Tretter on 10.09.12.
//  Copyright (c) 2012 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "NGMoviePlayerControlStyle.h"
#import "NGWeak.h"

typedef enum {
    NGMoviePlayerControlViewZoomOutButtonPositionRight = 0,
    NGMoviePlayerControlViewZoomOutButtonPositionLeft
} NGMoviePlayerControlViewZoomOutButtonPosition;

typedef enum {
    NGMoviePlayerControlViewTopControlsViewAlignmentCenter = 0,
    NGMoviePlayerControlViewTopControlsViewAlignmentLeft
} NGMoviePlayerControlViewTopControlsViewAlignment;



@class NGMoviePlayer;
@class NGMoviePlayerControlView;
@class NGVolumeControl;
@class NGScrubber;
@class NGMoviePlayerVideoLevel;
@class NGMoviePlayerRelationView;


@protocol NGMoviePlayerLayout <NSObject>

/** customizes the appearance of the top controls view. only get's called when the controlStyle changes */
- (void)customizeTopControlsViewWithControlStyle:(NGMoviePlayerControlStyle)controlStyle;
- (void)customizeBottomControlsViewWithControlStyle:(NGMoviePlayerControlStyle)controlStyle;
- (void)customizeControlsWithControlStyle:(NGMoviePlayerControlStyle)controlStyle;

/** positions the top controls view */
- (void)layoutTopControlsViewWithControlStyle:(NGMoviePlayerControlStyle)controlStyle;
/** positions the bottom controls view */
- (void)layoutBottomControlsViewWithControlStyle:(NGMoviePlayerControlStyle)controlStyle;

/** layouts the controls for the given control style */
- (void)layoutControlsWithControlStyle:(NGMoviePlayerControlStyle)controlStyle;

@end


@interface NGMoviePlayerLayout : NSObject <NGMoviePlayerLayout>

@property (nonatomic, ng_weak, readonly) NGMoviePlayer *moviePlayer;
@property (nonatomic, readonly) NGMoviePlayerControlView *controlsView;
@property (nonatomic, readonly) NGMoviePlayerControlStyle controlStyle;
@property (nonatomic, readonly, getter = isPlayingLivestream) BOOL playingLivestream;

@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;

@property (nonatomic, strong, readonly) UIView *topControlsView;
@property (nonatomic, strong, readonly) UIView *bottomControlsView;
@property (nonatomic, strong, readonly) UIView *topControlsContainerView;

@property (nonatomic, strong, readonly) UIButton *playPauseControl;
@property (nonatomic, strong, readonly) UIButton *rewindControl;
@property (nonatomic, strong, readonly) UIButton *forwardControl;

@property (nonatomic, strong, readonly) NGScrubber *scrubberControl;
@property (nonatomic, strong, readonly) UILabel *currentTimeLabel;
@property (nonatomic, strong, readonly) UILabel *remainingTimeLabel;

@property (nonatomic, strong, readonly) NGVolumeControl *volumeControl;
@property (nonatomic, strong, readonly) UIControl *airPlayControlContainer;
@property (nonatomic, strong, readonly) MPVolumeView *airPlayControl;
@property (nonatomic, readonly, getter = isAirPlayControlVisible) BOOL airPlayControlVisible;

@property (nonatomic, strong, readonly) UIButton *zoomControl;

@property (nonatomic, strong, readonly) UIButton *levelControl;
@property (nonatomic, strong, readonly) UIButton *relationCotrol;
@property (nonatomic, strong, readonly) UIButton *favoriteControl; //收藏
@property (nonatomic, strong, readonly) UIButton *downloadControl;//下载
@property (nonatomic, strong, readonly) UILabel *titleLabel;

@property (nonatomic, strong, readonly) NGMoviePlayerVideoLevel *videoLevelView;
@property (nonatomic, strong, readonly) NGMoviePlayerRelationView *relationView;

@property (nonatomic, assign, readwrite) BOOL levelShow;
@property (nonatomic, assign, readwrite) BOOL relationShow;
@property (nonatomic, assign, readwrite) BOOL downloadShow;
@property (nonatomic, assign, readwrite) BOOL favoriteShow;

- (void)updateControlStyle:(NGMoviePlayerControlStyle)controlStyle;
- (void)invalidateLayout;

@end
