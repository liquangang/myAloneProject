//
//  NGMoviePlayerControlView.m
//  NGMoviePlayer
//
//  Created by Tretter Matthias on 13.03.12.
//  Copyright (c) 2012 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "NGMoviePlayerControlView.h"
#import "NGMoviePlayerControlView+NGPrivate.h"
#import "NGMoviePlayerControlActionDelegate.h"
#import "NGScrubber.h"
#import "NGVolumeControl.h"
#import "NGMoviePlayerFunctions.h"
#import "NGMoviePlayerLayout.h"
#import "NGMoviePlayerVideoLevel.h"
#import "NGMoviePlayerRelationView.h"
#import <AVFoundation/AVFoundation.h>


@interface NGMoviePlayerControlView ()<UITableViewDelegate,UITableViewDataSource,NGMoviePlayerVideoLevelDelegate> {
    BOOL _statusBarHidden;
}

@property (nonatomic, readonly, getter = isPlayingLivestream) BOOL playingLivestream;

// Properties from NGMoviePlayerControlView+NGPrivate
@property (nonatomic, strong) NGMoviePlayerLayout *layout;
@property (nonatomic, strong, readwrite) UIView *topControlsView;
@property (nonatomic, strong, readwrite) UIView *bottomControlsView;
@property (nonatomic, strong, readwrite) UIView *topControlsContainerView;
//@property (nonatomic, strong, readwrite) UIButton *playPauseControl;
@property (nonatomic, strong, readwrite) NGScrubber *scrubberControl;
@property (nonatomic, strong, readwrite) UIButton *rewindControl;
@property (nonatomic, strong, readwrite) UIButton *forwardControl;
@property (nonatomic, strong, readwrite) UILabel *currentTimeLabel;
@property (nonatomic, strong, readwrite) UILabel *remainingTimeLabel;
@property (nonatomic, strong, readwrite) NGVolumeControl *volumeControl;
@property (nonatomic, strong, readwrite) UIControl *airPlayControlContainer;
@property (nonatomic, strong, readwrite) MPVolumeView *airPlayControl;
@property (nonatomic, strong, readwrite) UIButton *zoomControl;

@property (nonatomic, strong, readwrite) UIButton *levelControl; //清晰度
@property (nonatomic, strong, readwrite) UIButton *relationCotrol; //相关
@property (nonatomic, strong, readwrite) UIButton *favoriteControl; //收藏
@property (nonatomic, strong, readwrite) UIButton *downloadControl;//下载
@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@property (nonatomic, strong, readwrite) NGMoviePlayerVideoLevel *videoLevelView;
@property (nonatomic, strong, readwrite) NGMoviePlayerRelationView *relationView;

@end


@implementation NGMoviePlayerControlView

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

        _topControlsView = [[UIView alloc] initWithFrame:CGRectZero];
        _topControlsView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.6f];
        _topControlsView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_topControlsView];

        _topControlsContainerView = [[UIView alloc] initWithFrame:CGRectZero];
        _topControlsContainerView.backgroundColor = [UIColor clearColor];
        [_topControlsView addSubview:_topControlsContainerView];

        _bottomControlsView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _bottomControlsView.userInteractionEnabled = YES;
        _bottomControlsView.backgroundColor = [UIColor clearColor];
        [self addSubview:_bottomControlsView];

        _volumeControl = [[NGVolumeControl alloc] initWithFrame:CGRectZero];
        _volumeControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [_volumeControl addTarget:self action:@selector(handleVolumeChanged:) forControlEvents:UIControlEventValueChanged];
        if (UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPhone) {
            _volumeControl.sliderHeight = 130.f;
        }
        // volume control needs to get added to self instead of bottomControlView because otherwise the expanded slider
        // doesn't receive any touch events
        [self addSubview:_volumeControl];


        // We use the MPVolumeView just for displaying the AirPlay icon
        if ([AVPlayer instancesRespondToSelector:@selector(allowsAirPlayVideo)]) {
            _airPlayControl = [[MPVolumeView alloc] initWithFrame:(CGRect) { .size = CGSizeMake(38.f, 22.f) }];
            _airPlayControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
            _airPlayControl.contentMode = UIViewContentModeCenter;
            _airPlayControl.showsRouteButton = YES;
            _airPlayControl.showsVolumeSlider = NO;

            _airPlayControlContainer = [[UIControl alloc] initWithFrame:CGRectMake(0.f, 0.f, 60.f, 44.f)];
            _airPlayControl.center = CGPointMake(_airPlayControlContainer.frame.size.width/2.f, _airPlayControlContainer.frame.size.height/2.f - 2.f);
            [_airPlayControlContainer addTarget:self action:@selector(handleAirPlayButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            [_airPlayControlContainer addSubview:_airPlayControl];
            [_bottomControlsView addSubview:_airPlayControlContainer];
        }

        _rewindControl = [UIButton buttonWithType:UIButtonTypeCustom];
        _rewindControl.frame = CGRectMake(60.f, 10.f, 40.f, 40.f);
        _rewindControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        _rewindControl.showsTouchWhenHighlighted = YES;
        [_rewindControl setImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/prevtrack"] forState:UIControlStateNormal];
        [_rewindControl addTarget:self action:@selector(handleRewindButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_rewindControl addTarget:self action:@selector(handleRewindButtonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [_rewindControl addTarget:self action:@selector(handleRewindButtonTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [_bottomControlsView addSubview:_rewindControl];

        _forwardControl = [UIButton buttonWithType:UIButtonTypeCustom];
        _forwardControl.frame = _rewindControl.frame;
        _forwardControl.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        _forwardControl.showsTouchWhenHighlighted = YES;
        [_forwardControl setImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/nexttrack"] forState:UIControlStateNormal];
        [_forwardControl addTarget:self action:@selector(handleForwardButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_forwardControl addTarget:self action:@selector(handleForwardButtonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [_forwardControl addTarget:self action:@selector(handleForwardButtonTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
        [_bottomControlsView addSubview:_forwardControl];

        _playPauseControl = [UIButton buttonWithType:UIButtonTypeCustom];
        _playPauseControl.contentMode = UIViewContentModeCenter;
        _playPauseControl.showsTouchWhenHighlighted = YES;
        _playPauseControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [_playPauseControl addTarget:self action:@selector(handlePlayPauseButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomControlsView addSubview:_playPauseControl];

        _scrubberControl = [[NGScrubber alloc] initWithFrame:CGRectZero];
        _scrubberControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_scrubberControl addTarget:self action:@selector(handleBeginScrubbing:) forControlEvents:UIControlEventTouchDown];
        [_scrubberControl addTarget:self action:@selector(handleScrubbingValueChanged:) forControlEvents:UIControlEventValueChanged];
        [_scrubberControl addTarget:self action:@selector(handleEndScrubbing:) forControlEvents:UIControlEventTouchUpInside];
        [_scrubberControl addTarget:self action:@selector(handleEndScrubbing:) forControlEvents:UIControlEventTouchUpOutside];
        [_bottomControlsView addSubview:_scrubberControl];

        _zoomControl = [UIButton buttonWithType:UIButtonTypeCustom];
        _zoomControl.showsTouchWhenHighlighted = YES;
        _zoomControl.contentMode = UIViewContentModeCenter;
        [_zoomControl addTarget:self action:@selector(handleZoomButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [_topControlsView addSubview:_zoomControl];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor blackColor];
        _titleLabel.shadowOffset = CGSizeMake(0.f, 1.f);
        
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
             _titleLabel.font = [UIFont boldSystemFontOfSize:15.];
        }else{
             _titleLabel.font = [UIFont boldSystemFontOfSize:17.];
        }
        
       
        _titleLabel.textAlignment = UITextAlignmentCenter;
        _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [_topControlsView addSubview:_titleLabel];
        
        
        _favoriteControl = [UIButton buttonWithType:UIButtonTypeCustom];
        _favoriteControl.contentMode = UIViewContentModeCenter;
        _favoriteControl.showsTouchWhenHighlighted = YES;
        
        [_favoriteControl setBackgroundImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/player_img_fav_normal"] forState:UIControlStateNormal];
        [_favoriteControl setBackgroundImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/player_img_fav_selected"] forState:UIControlStateHighlighted];
        [_favoriteControl setBackgroundImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/player_img_fav_selected"] forState:UIControlStateSelected];
        _favoriteControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
        [_favoriteControl addTarget:self action:@selector(handleVideoFavoritePress:) forControlEvents:UIControlEventTouchUpInside];
        [_topControlsView addSubview:_favoriteControl];
        
        _levelControl = [UIButton buttonWithType:UIButtonTypeCustom];
        _levelControl.contentMode = UIViewContentModeCenter;
        UIImage *normalImage = [UIImage imageNamed:@"NGMoviePlayer.bundle/player_episode_normal"];
        if ([normalImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
            normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        }else{
            normalImage = [normalImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        }
        
        UIImage *hilightImage = [UIImage imageNamed:@"NGMoviePlayer.bundle/player_episode_selected"];
        if ([hilightImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
            hilightImage = [hilightImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        }else{
            hilightImage = [hilightImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        }
    
        [_levelControl setBackgroundImage:normalImage forState:UIControlStateNormal];
        [_levelControl setBackgroundImage:hilightImage forState:UIControlStateHighlighted];
        [_levelControl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            _levelControl.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        }else{
            _levelControl.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        }

        [_levelControl addTarget:self action:@selector(handleVideoLevelChange:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomControlsView addSubview:_levelControl];
        
        _relationCotrol = [UIButton buttonWithType:UIButtonTypeCustom];
        [_relationCotrol setBackgroundImage:normalImage forState:UIControlStateNormal];
        [_relationCotrol setBackgroundImage:hilightImage forState:UIControlStateHighlighted];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            _relationCotrol.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        }else{
            _relationCotrol.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        }

        [_relationCotrol setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_relationCotrol setTitle:@"选集" forState:UIControlStateNormal];
        _relationCotrol.contentMode = UIViewContentModeCenter;
        [_relationCotrol addTarget:self action:@selector(handleRelationOption:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomControlsView addSubview:_relationCotrol];
        
        _downloadControl = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadControl setBackgroundImage:normalImage forState:UIControlStateNormal];
        [_downloadControl setBackgroundImage:hilightImage forState:UIControlStateHighlighted];
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            _downloadControl.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        }else{
            _downloadControl.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        }
        [_downloadControl setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_downloadControl setImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/player_icon_download"] forState:UIControlStateNormal];
        _downloadControl.contentMode = UIViewContentModeCenter;
        [_downloadControl addTarget:self action:@selector(handleVideoDownloadPress:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomControlsView addSubview:_downloadControl];

        
        
        
        _currentTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _currentTimeLabel.backgroundColor = [UIColor clearColor];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.shadowColor = [UIColor blackColor];
        _currentTimeLabel.shadowOffset = CGSizeMake(0.f, 1.f);
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            _currentTimeLabel.font = [UIFont boldSystemFontOfSize:13.];
        }else{
            _currentTimeLabel.font = [UIFont boldSystemFontOfSize:15.];
        }
        
        _currentTimeLabel.textAlignment = UITextAlignmentRight;
        _currentTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        [_bottomControlsView addSubview:_currentTimeLabel];

        _remainingTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _remainingTimeLabel.backgroundColor = [UIColor clearColor];
        _remainingTimeLabel.shadowColor = [UIColor blackColor];
        _remainingTimeLabel.shadowOffset = CGSizeMake(0.f, 1.f);
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            _remainingTimeLabel.font = [UIFont boldSystemFontOfSize:13.];
        }else{
            _remainingTimeLabel.font = [UIFont boldSystemFontOfSize:15.];
        }
        
        _remainingTimeLabel.textAlignment = UITextAlignmentLeft;
        _remainingTimeLabel.textColor = [UIColor colorWithRed:169.0f/255.0f green:169.0f/255.0f blue:169.0f/255.0f alpha:1.0f];
        _remainingTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [_bottomControlsView addSubview:_remainingTimeLabel];

        _statusBarHidden = [UIApplication sharedApplication].statusBarHidden;

        _controlStyle = NGMoviePlayerControlStyleInline;
        _scrubbingTimeDisplay = NGMoviePlayerControlScrubbingTimeDisplayPopup;
    }

    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIView
////////////////////////////////////////////////////////////////////////

- (void)setAlpha:(CGFloat)alpha {
    // otherwise the airPlayButton isn't positioned correctly on first show-up
    if (alpha > 0.f) {
        [self setNeedsLayout];
    }

    [super setAlpha:alpha];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self.layout layoutTopControlsViewWithControlStyle:self.controlStyle];
    [self.layout layoutBottomControlsViewWithControlStyle:self.controlStyle];
    [self.layout layoutControlsWithControlStyle:self.controlStyle];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.volumeControl.expanded) {
        return [super pointInside:point withEvent:event];
    }

    BOOL insideTopControlsView = CGRectContainsPoint(self.topControlsView.frame, point);
    BOOL insideBottomControlsView = CGRectContainsPoint(self.bottomControlsView.frame, point);
    
    BOOL insideLevelView = FALSE;
    if (!self.videoLevelView.hidden) {
        insideLevelView = CGRectContainsPoint(self.videoLevelView.frame, point);
    }
    
    BOOL insideRelateView = FALSE;
    if (self.relationView != nil) {
        insideRelateView = CGRectContainsPoint(self.relationView.frame, point);
    }

    return  insideTopControlsView || insideBottomControlsView || insideLevelView || insideRelateView;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayerControlView
////////////////////////////////////////////////////////////////////////

- (void)setControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    _controlStyle = controlStyle;
    [self.layout updateControlStyle:controlStyle];
}

- (void)setLayout:(NGMoviePlayerLayout *)layout {
    if (layout != _layout) {
        _layout = layout;
    }
    

    [layout updateControlStyle:self.controlStyle];
}

- (void)resetVideoStatus
{
    if (_dataSource == nil) {
        NSLog(@"_dataSource == nil");
        return;
    }
    
    if ([_dataSource respondsToSelector:@selector(moviePlayerControlViewLevelTites:)]) { //should show level seleted
        
        
        NSArray *titles = [_dataSource moviePlayerControlViewLevelTites:self];
        NSInteger num = titles.count;
        if (titles == nil || num == 0) {
            _layout.levelShow = FALSE;
        }else{
            _layout.levelShow = TRUE;
        }
    }
    
    if ([_dataSource respondsToSelector:@selector(moviePlayerControlView:tableView:numberOfRowsInSection:)]) {
        NSInteger rowsNum =  [_dataSource moviePlayerControlView:self tableView:nil numberOfRowsInSection:0];
        if (rowsNum != 0) {
            _layout.relationShow = TRUE;
        }else{
            _layout.relationShow = FALSE;
        }
    }
    
    if ([_dataSource respondsToSelector:@selector(moviePlayerControlViewCanFavorited:)]) {
        BOOL value = [_dataSource moviePlayerControlViewCanFavorited:self];
        if (value) {
            if ([_dataSource respondsToSelector:@selector(moviePlayerControlViewHaveFavorited:)]) {
                BOOL value =  [_dataSource moviePlayerControlViewHaveFavorited:self];
                _favoriteControl.selected = value;
                _layout.favoriteShow = TRUE;
            }
            
        }else{
            _layout.favoriteShow = FALSE;
        }
    }
    
    if ([_dataSource respondsToSelector:@selector(moviePlayerControlViewCandownload:)]) {
        
         BOOL value = [_dataSource moviePlayerControlViewCandownload:self];
        if (value) {
            _layout.downloadShow = TRUE;
        }else{
            _layout.downloadShow = FALSE;
        }
        
    }
    
    
    

    
}


- (void)setDataSource:(id<NGMoviePlayerControlDataSource>)dataSource
{
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
    }
    
    if ([_dataSource respondsToSelector:@selector(moviePlayerControlViewLevelTites:)]) { //should show level seleted
        
        if ([_dataSource respondsToSelector:@selector(moviePlayerControlViewInitLevelTitle:)]) {
            NSString *title = [_dataSource moviePlayerControlViewInitLevelTitle:self];
            [_levelControl setTitle:title forState:UIControlStateNormal];
        }
        
        NSArray *titles = [_dataSource moviePlayerControlViewLevelTites:self];
        NSInteger num = titles.count;
        if (titles == nil || num == 0) {
            _layout.levelShow = FALSE;
        }else{
            _layout.levelShow = TRUE;
        }
    }
    
    if ([_dataSource respondsToSelector:@selector(moviePlayerControlView:tableView:numberOfRowsInSection:)]) {
        NSInteger rowsNum =  [_dataSource moviePlayerControlView:self tableView:nil numberOfRowsInSection:0];
        if (rowsNum != 0) {
            _layout.relationShow = TRUE;
        }else{
            _layout.relationShow = FALSE;
        }
    }
    
    if ([_dataSource respondsToSelector:@selector(moviePlayerControlViewCanFavorited:)]) {
        BOOL value = [_dataSource moviePlayerControlViewCanFavorited:self];
        if (value) {
            if ([_dataSource respondsToSelector:@selector(moviePlayerControlViewHaveFavorited:)]) {
                BOOL value =  [_dataSource moviePlayerControlViewHaveFavorited:self];
                _favoriteControl.selected = value;
                _layout.favoriteShow = TRUE;
            }
            
        }else{
            _layout.favoriteShow = FALSE;
        }
    }
    
    if ([_dataSource respondsToSelector:@selector(moviePlayerControlViewCandownload:)]) {
        
        BOOL value = [_dataSource moviePlayerControlViewCandownload:self];
        if (value) {
            _layout.downloadShow = TRUE;
        }else{
            _layout.downloadShow = FALSE;
        }
        
    }
    
    
}



- (void)setScrubbingTimeDisplay:(NGMoviePlayerControlScrubbingTimeDisplay)scrubbingTimeDisplay {
    if (scrubbingTimeDisplay != _scrubbingTimeDisplay) {
        _scrubbingTimeDisplay = scrubbingTimeDisplay;

        self.scrubberControl.showPopupDuringScrubbing = (scrubbingTimeDisplay == NGMoviePlayerControlScrubbingTimeDisplayPopup);
    }
}

- (void)setPlayableDuration:(NSTimeInterval)playableDuration {
    self.scrubberControl.playableValue = playableDuration;
}

- (NSTimeInterval)playableDuration {
    return self.scrubberControl.playableValue;
}

- (void)updateScrubberWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration {
    self.currentTimeLabel.text = NGMoviePlayerGetTimeFormatted(currentTime);
    self.remainingTimeLabel.text = NGMoviePlayerGetTimeFormatted(duration);

    [self.scrubberControl setMinimumValue:0.];
    [self.scrubberControl setMaximumValue:duration];
    [self.scrubberControl setValue:currentTime];
}

- (void)updateButtonsWithPlaybackStatus:(BOOL)isPlaying {
    UIImage *image = nil;

    if (self.controlStyle == NGMoviePlayerControlStyleInline) {
        UIImage *normalImage = [UIImage imageNamed:@"NGMoviePlayer.bundle/player_episode_normal"];
        if ([normalImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
            normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        }else{
            normalImage = [normalImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        }
        [self.playPauseControl setBackgroundImage:normalImage forState:UIControlStateNormal];
        image = isPlaying ? [UIImage imageNamed:@"NGMoviePlayer.bundle/minniplayer_icon_pause"] : [UIImage imageNamed:@"NGMoviePlayer.bundle/minniplayer_icon_play"];
    } else {
        image = isPlaying ? [UIImage imageNamed:@"NGMoviePlayer.bundle/player_btn_pause"] : [UIImage imageNamed:@"NGMoviePlayer.bundle/player_btn_play"];
        [self.playPauseControl setBackgroundImage:nil forState:UIControlStateNormal];
    }

    [self.playPauseControl setImage:image forState:UIControlStateNormal];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Private
////////////////////////////////////////////////////////////////////////

- (void)handlePlayPauseButtonPress:(id)sender {
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionTogglePlayPause];
}

- (void)handleRewindButtonTouchDown:(id)sender {
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionBeginSkippingBackwards];
}

- (void)handleRewindButtonTouchUp:(id)sender {
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionEndSkipping];
}

- (void)handleForwardButtonTouchDown:(id)sender {
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionBeginSkippingForwards];
}

- (void)handleForwardButtonTouchUp:(id)sender {
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionEndSkipping];
}

- (void)handleZoomButtonPress:(id)sender {
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionToggleZoomState];
}

- (void)handleVideoFavoritePress:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(moviePlayerControl:messageForAction:)]) {
        _favoriteControl.selected = [self.delegate moviePlayerControl:self messageForAction:NGMoviePlayerControlActionVideoFavorite];
    }
    
   
}


- (void)handleVideoDownloadPress:(id)sender
{
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionVideoDownload];
}


- (void)handleVideoLevelChange:(id)sender
{
    if (_controlStyle == NGMoviePlayerControlStyleInline) {
        return;
    }
    
    if ([self.dataSource respondsToSelector:@selector(moviePlayerControlViewLevelTites:)]) {
        
        NSArray *titles = [self.dataSource moviePlayerControlViewLevelTites:self];
        NSInteger num = titles.count;
        if (titles == nil || num == 0) {
            NSLog(@"handleVideoLevelChange titles == nil || num == 0");
            return;
        }
        
        CGRect rect = [self convertRect:((UIButton*)sender).frame fromView:_bottomControlsView];
        
        if (self.videoLevelView == nil) {
            
            CGFloat originX = CGRectGetMinX(rect) + (CGRectGetWidth(rect) - kLevelViewWidth)/2;
            CGFloat height = kLevelButtonHeight * num + kLevelButtomHeight;
            CGFloat originY = CGRectGetMinY(rect) - height;
    
            self.videoLevelView = [[NGMoviePlayerVideoLevel alloc] initWithFrame:CGRectMake(originX, originY, kLevelViewWidth, height)];
            self.videoLevelView.delegate = self;
            self.videoLevelView.backgroundColor = [UIColor clearColor];
            [self addSubview:self.videoLevelView];
            self.videoLevelView.hidden = YES;
            
        }
        
        self.videoLevelView.titles = titles;
        self.videoLevelView.levelName = _levelControl.titleLabel.text;
        
        
        if (self.videoLevelView.hidden) {
            self.videoLevelView.hidden = FALSE;
            self.videoLevelView.alpha = 0.0f;
            [UIView animateWithDuration:0.25 animations:^(void){
                self.videoLevelView.alpha = 1.0f;
            }];
            
        }else{
            self.videoLevelView.alpha = 1.0f;
            [UIView animateWithDuration:0.25 animations:^(void){
                self.videoLevelView.alpha = 0.0f;
               
            } completion:^(BOOL finish){
                self.videoLevelView.hidden = YES;
                
            }];

        }
        
        [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionVideoLevelChanged];
    }
    
    
}

- (void)hiddenVideoLevelView
{
    if (self.videoLevelView.hidden) {
        return;
    }
    
    self.videoLevelView.alpha = 1.0f;
    [UIView animateWithDuration:0.25 animations:^(void){
        self.videoLevelView.alpha = 0.0f;
        
    } completion:^(BOOL finish){
        self.videoLevelView.hidden = YES;
        
    }];

}





- (void)handleRelationOption:(id)sender
{
    if (_controlStyle == NGMoviePlayerControlStyleInline) {
        return;
    }
    
    
    if ([self.dataSource respondsToSelector:@selector(moviePlayerControlView:tableView:numberOfRowsInSection:)]) {
        
        NSInteger rowsNum = [self.dataSource moviePlayerControlView:self tableView:nil numberOfRowsInSection:0];
        if (rowsNum == 0) {
            NSLog(@"moviePlayerControlView:tableView:numberOfRowsInSection: rowsNum == 0");
            return;
        }
        
    }
    
    if (self.relationView == nil) {
        CGFloat offY = 0;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
        offY = 20.0f;
#endif
        self.relationView = [[NGMoviePlayerRelationView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds), offY, kRelationViewWidth, CGRectGetHeight(self.bounds)-offY)];
        self.relationView.tableView.delegate = self;
        self.relationView.tableView.dataSource = self;
        [self addSubview:self.relationView];
        
    }
    
    CGRect frame = self.relationView.frame;
    if (CGRectGetMinX(frame)==CGRectGetWidth(self.bounds)) {
        
        [self hiddenVideoLevelView];
        
        frame.origin.x = CGRectGetWidth(self.bounds)-CGRectGetWidth(self.relationView.frame);
        self.relationView.hidden = FALSE;
        [UIView animateWithDuration:0.25 animations:^(void){
            self.relationView.frame = frame;
        }];
        
    }else{
        frame.origin.x = CGRectGetWidth(self.bounds);
        [UIView animateWithDuration:0.25 animations:^(void){
            self.relationView.frame = frame;
            
        } completion:^(BOOL finish){
            self.relationView.hidden = TRUE;
        }];
        
    }
    
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionRelateTableShow];
}


- (void)hiddenRelateTableView
{
    CGRect frame = self.relationView.frame;
    frame.origin.x = CGRectGetWidth(self.bounds);
    [UIView animateWithDuration:0.25 animations:^(void){
        self.relationView.frame = frame;
        
    } completion:^(BOOL finish){
        self.relationView.hidden = TRUE;
    }];
}




- (void)handleBeginScrubbing:(id)sender {
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionBeginScrubbing];
}

- (void)handleScrubbingValueChanged:(id)sender {
    if (self.scrubbingTimeDisplay == NGMoviePlayerControlScrubbingTimeDisplayCurrentTime) {
        self.currentTimeLabel.text = NGMoviePlayerGetTimeFormatted(self.scrubberControl.value);
        self.remainingTimeLabel.text = NGMoviePlayerGetTimeFormatted(self.scrubberControl.maximumValue);
    }

    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionScrubbingValueChanged];
}

- (void)handleEndScrubbing:(id)sender {
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionEndScrubbing];
}

- (void)handleVolumeChanged:(id)sender {
    [self.delegate moviePlayerControl:sender didPerformAction:NGMoviePlayerControlActionVolumeChanged];
}

- (void)handleAirPlayButtonPress:(id)sender {
    // forward touch event to airPlay-button
    for (UIView *subview in self.airPlayControl.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;

            [button sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    }

    [self.delegate moviePlayerControl:self.airPlayControl didPerformAction:NGMoviePlayerControlActionAirPlayMenuActivated];
}

#pragma mark
#pragma mark NGMoviePlayerVideoLevelDelegate

- (void)moviePlayerVideoLevel:(NGMoviePlayerVideoLevel *)levelView seletedIdex:(NSInteger)index title:(NSString *)title
{
    [_levelControl setTitle:title forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(moviePlayerControl:changeVideoLevelIndex:)]) {
        [self.delegate moviePlayerControl:nil changeVideoLevelIndex:index];
    }
}

#pragma mark
#pragma mark table delegate datasorce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.dataSource respondsToSelector:@selector(moviePlayerControlView:numberOfSectionsInTableView:)]) {
        return [self.dataSource moviePlayerControlView:self numberOfSectionsInTableView:tableView];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(moviePlayerControlView:tableView:numberOfRowsInSection:)]) {
        return [self.dataSource moviePlayerControlView:self tableView:tableView numberOfRowsInSection:section];
    }
    
    return 0;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(moviePlayerControlView:tableView:heightForRowAtIndexPath:)]) {
        return [self.dataSource moviePlayerControlView:self tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(moviePlayerControlView:tableView:heightForRowAtIndexPath:)]) {
        return [self.dataSource moviePlayerControlView:self tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

#pragma mark
#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.delegate moviePlayerControl:nil didPerformAction:NGMoviePlayerControlActionRelateTableScroll];
}

// called on start of dragging (may require some time and or distance to move)





@end
