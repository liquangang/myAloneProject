#import "NGMoviePlayer.h"
#import "NGMoviePlayerView.h"
#import "NGMoviePlayerControlView.h"
#import "NGMoviePlayerControlView+NGPrivate.h"
#import "NGMoviePlayerLayout+NGPrivate.h"
#import "NGScrubber.h"
#import "NGMoviePlayerLayerView.h"
#import "NGMoviePlayerControlActionDelegate.h"

#define kNGFadeDuration 0.3f

#define kNGInitialTimeToSkip                    10.     // this value gets added the first time (seconds)
#define kNGRepeatedTimeToSkipStartValue          5.     // this is the starting value the gets added repeatedly while user presses button (increases over time)
#define kNGDefaultSeekingToleranceTime           2.
#define kNGDefaultInitialPlaybackToleranceTime   1000.


NSString * const kRateKey = @"rate";
NSString * const kCurrentItemKye = @"currentItem";

NSString * const kTrackKey = @"tracks";
NSString * const kPlayableKey = @"playable";
NSString * const kHasProtectedContentKey = @"hasProtectedContent";

NSString * const kStatusKey         = @"status";
NSString * const kDrautionKey        = @"duration";
NSString * const kLoadedTimeRangesKey = @"loadedTimeRanges";
NSString * const kPlaybackBufferEmpty = @"playbackBufferEmpty";
NSString * const kPlaybackLikelyToKeepUp = @"playbackLikelyToKeepUp";

NSString * const kAirPlayVideoActiveKey  = @"airPlayVideoActive";


static char playerItemStatusContext;
static char playerItemDurationContext;
static char playerItemLoadedTimeRangesContext;
static char playerItemBufferEmpty;
static char playerItemLikelyToKeepUp;
static char playerCurrentItemContext;
static char playerRateContext;
static char playerAirPlayVideoActiveContext;


@interface NGMoviePlayer () <NGMoviePlayerControlActionDelegate,NGMoviePlayerControlDataSource> {
    // flags for methods implemented in the delegate
    struct {
        unsigned int didStartPlayback:1;
        unsigned int didFailToLoad:1;
        unsigned int didHasProtectedContent:1;
        unsigned int didFinishPlayback:1;
        unsigned int didPausePlayback:1;
        unsigned int didResumePlayback:1;

        unsigned int didBeginScrubbing:1;
        unsigned int didEndScrubbing:1;

        unsigned int didChangeStatus:1;
        unsigned int didChangePlaybackRate:1;
		unsigned int didChangeAirPlayActive:1;
        unsigned int didChangeControlStyle:1;
        unsigned int didUpdateCurrentTime:1;
        
        unsigned int didDownload:1; //下载
        unsigned int didFavorite:1; //下载
        unsigned int didChangeVideoLevel:1; //改变清晰度
        
        unsigned int dataTableRow:1;
        unsigned int dataTitleCell:1;
        unsigned int actionTableTouch:1;

        
	} _delegateFlags;
    
    
    struct {
        unsigned int initLevel:1;
        unsigned int videoLeves:1;
        unsigned int canFavorite:1;
        unsigned int hasFavorite:1;
        unsigned int canDownloaded:1;
        unsigned int realtionViewo:1;
        
        
    }_dataSourceFlags;
    

    BOOL _seekToInitialPlaybackTimeBeforePlay;
    float _rateToRestoreAfterScrubbing;
}

@property (nonatomic, strong, readwrite) AVPlayer *player;  // re-defined as read/write
@property (nonatomic, assign, readwrite, getter = isScrubbing) BOOL scrubbing; // re-defined as read/write
@property (nonatomic, strong) AVAsset *asset;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, readonly) CMTime CMDuration;
@property (nonatomic, strong) id playerTimeObserver;

@property (nonatomic, assign) NSTimeInterval timeToSkip;
@property (nonatomic, ng_weak) NSTimer *skippingTimer;
@property (nonatomic, ng_weak) NSTimer *playableDurationTimer;

@property (nonatomic, assign) BOOL userPause;

@end

@implementation NGMoviePlayer

@dynamic player;
@synthesize view = _view;
@synthesize videoGravity = _videoGravity;
@synthesize title = _title;
@synthesize playerItem = _playerItem;

////////////////////////////////////////////////////////////////////////
#pragma mark - Class Methods
////////////////////////////////////////////////////////////////////////

+ (void)setAudioSessionCategory:(NGMoviePlayerAudioSessionCategory)audioSessionCategory {
    NSError *error = nil;
    [[AVAudioSession sharedInstance] setCategory:NGAVAudioSessionCategoryFromNGMoviePlayerAudioSessionCategory(audioSessionCategory)
                                           error:&error];

    if (error != nil) {
        NSLog(@"There was an error setting the AudioCategory to AVAudioSessionCategoryPlayback");
    }
}

+ (void)initialize {
    if (self == [NGMoviePlayer class]) {
        [self setAudioSessionCategory:NGMoviePlayerAudioSessionCategoryPlayback];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithURL:(NSURL *)URL initialPlaybackTime:(NSTimeInterval)initialPlaybackTime{
    return [self initWithURL:URL initialPlaybackTime:initialPlaybackTime title:nil];
}


- (id)initWithURL:(NSURL *)URL initialPlaybackTime:(NSTimeInterval)initialPlaybackTime title:(NSString *)name{
    if ((self = [super init])) {
        _autostartWhenReady = NO;
        _userPause = FALSE;
        _seekToInitialPlaybackTimeBeforePlay = YES;
        _airPlayEnabled = [AVPlayer instancesRespondToSelector:@selector(allowsAirPlayVideo)];
        _rateToRestoreAfterScrubbing = 1.;
        _initialPlaybackTime = initialPlaybackTime;
        _seekingToleranceTime = kNGDefaultSeekingToleranceTime;
        _initialPlaybackToleranceTime = kNGDefaultInitialPlaybackToleranceTime;
        _videoGravity = NGMoviePlayerVideoGravityResize;
        // calling setter here on purpose
        self.URL = URL;
        self.title = name;
    }
    return self;
}

- (id)initWithURL:(NSURL *)URL {
    return [self initWithURL:URL initialPlaybackTime:0.];
}

- (id)initWithURL:(NSURL *)URL title:(NSString *)name{
    return [self initWithURL:URL initialPlaybackTime:0. title:name];
}


- (id)init {
    return [self initWithURL:nil];
}

- (void)dealloc {
    AVPlayer *player = _view.playerLayer.player;

    [_skippingTimer invalidate];
    [_playableDurationTimer invalidate];
    _delegate = nil;
    _view.delegate = nil;
    _view.dataSource = nil;
    _view.controlsView.delegate = nil;
    _view.controlsView.dataSource = nil;
    [_view removeFromSuperview];

    [self stopObservingPlayerTimeChanges];
    [player pause];

    [player removeObserver:self forKeyPath:kRateKey];
    [player removeObserver:self forKeyPath:kCurrentItemKye];
    
	[_playerItem removeObserver:self forKeyPath:kStatusKey];
    [_playerItem removeObserver:self forKeyPath:kDrautionKey];
    [_playerItem removeObserver:self forKeyPath:kLoadedTimeRangesKey];
    [_playerItem removeObserver:self forKeyPath:kPlaybackBufferEmpty];
    [_playerItem removeObserver:self forKeyPath:kPlaybackLikelyToKeepUp];

    if ([AVPlayer instancesRespondToSelector:@selector(allowsAirPlayVideo)]) {
        [player removeObserver:self forKeyPath:kAirPlayVideoActiveKey];
    }

    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:_playerItem];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject KVO
////////////////////////////////////////////////////////////////////////

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == &playerItemStatusContext) {
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey] integerValue];

        switch (status) {
            case AVPlayerStatusUnknown: {
                [self stopObservingPlayerTimeChanges];
                [self.view updateWithCurrentTime:self.currentPlaybackTime duration:self.duration];
                // TODO: Disable buttons & scrubber
                break;
            }

            case AVPlayerStatusReadyToPlay: {
                // TODO: Enable buttons & scrubber
                if (!self.scrubbing) {
                    if (self.autostartWhenReady && self.view.superview != nil && [UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
                        _autostartWhenReady = NO;
                        [self play];
                    }
                }

                break;
            }

            case AVPlayerStatusFailed: {
                [self stopObservingPlayerTimeChanges];
                [self.view updateWithCurrentTime:self.currentPlaybackTime duration:self.duration];
                // TODO: Disable buttons & scrubber
                break;
            }
        }

        [self.view updateWithPlaybackStatus:self.playing];

        if (_delegateFlags.didChangeStatus) {
            [self.delegate moviePlayer:self didChangeStatus:status];
        }
    }
    
    else if(context == &playerItemBufferEmpty){
        NSLog(@"the MptAVPlayerItemBufferEmpty is did");
        [self pause];
        
        [self.view activityViewShow:YES];
        
    }else if(context == &playerItemLikelyToKeepUp){

        AVPlayerItem * item = (AVPlayerItem *)object;
        NSLog(@"the MptAVPlayerItemLikelyToKeepUp is did");
    
        
        if(item.playbackLikelyToKeepUp) {
            
            if (_userPause) { //用户暂停的
                return;
            }
            
            [self play];
            NSLog(@"Play item due to likelyToKeepUp");
            [self.view activityViewShow:NO];
        } else {
            [self pause];
            NSLog(@"Pause item due to not likelyToKeepUp");
            [self.view activityViewShow:NO];
        }
        
        
        
    }else if(context == & playerItemLoadedTimeRangesContext){
        [self updatePlayableDurationTimerFired:nil];
//        NSLog(@"playerItemLoadedTimeRangesContext");

    }else if (context == &playerItemDurationContext) {
        [self.view updateWithCurrentTime:self.currentPlaybackTime duration:self.duration];
    }

    else if (context == &playerCurrentItemContext) {
        AVPlayerItem *newPlayerItem = [change objectForKey:NSKeyValueChangeNewKey];

        if (newPlayerItem == (id)[NSNull null]) {
            [self stopObservingPlayerTimeChanges];
            // TODO: Disable buttons & scrubber
        } else {
            [self.view updateWithPlaybackStatus:self.playing];
            [self startObservingPlayerTimeChanges];
        }
    }

    else if (context == &playerRateContext) {
        [self.view updateWithPlaybackStatus:self.playing];

        if (_delegateFlags.didChangePlaybackRate) {
            [self.delegate moviePlayer:self didChangePlaybackRate:self.player.rate];
        }
    }

    else if (context == &playerAirPlayVideoActiveContext) {
        if ([AVPlayer instancesRespondToSelector:@selector(isAirPlayVideoActive)]) {
            [self.view updateViewsForCurrentScreenState];

            if (_delegateFlags.didChangeAirPlayActive) {
                BOOL airPlayVideoActive = self.player.airPlayVideoActive;

                [self.delegate moviePlayer:self didChangeAirPlayActive:airPlayVideoActive];
            }
        }
    }

    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayer Video Playback
////////////////////////////////////////////////////////////////////////

- (void)play {
    if (self.player.status == AVPlayerStatusReadyToPlay) {
        if (_seekToInitialPlaybackTimeBeforePlay && _initialPlaybackTime >= 0.) {
            CMTime time = CMTimeMakeWithSeconds(_initialPlaybackTime, NSEC_PER_SEC);
            CMTime tolerance = self.initialPlaybackToleranceCMTime;
            dispatch_block_t afterSeekAction = ^{
                [self.view hidePlaceholderViewAnimated:YES];

                [self moviePlayerDidStartToPlay];
                [self updateControlsViewForLivestreamStatus];

                if (_delegateFlags.didStartPlayback) {
                    [self.delegate moviePlayer:self didStartPlaybackOfURL:self.URL];
                }
            };

            if ([self.player respondsToSelector:@selector(seekToTime:toleranceBefore:toleranceAfter:completionHandler:)]) {
                [self.view showPlaceholderViewAnimated:NO];
                [self.player seekToTime:time
                        toleranceBefore:tolerance
                         toleranceAfter:tolerance
                      completionHandler:^(BOOL finished) {
                    afterSeekAction();
                }];
            } else {
                [self.player seekToTime:time toleranceBefore:tolerance toleranceAfter:tolerance];
                afterSeekAction();
            }

            _seekToInitialPlaybackTimeBeforePlay = NO;
        } else {
            [self.view hidePlaceholderViewAnimated:YES];

            if (_delegateFlags.didResumePlayback) {
                [self.delegate moviePlayerDidResumePlayback:self];
            }

            [self moviePlayerDidResumePlayback];
        }

        [self.player play];
        [self.view setControlsVisible:YES animated:YES];
    } else {
        _autostartWhenReady = YES;
    }
    [self.view activityViewShow:NO];

    [self.playableDurationTimer invalidate];
//    self.playableDurationTimer = [NSTimer scheduledTimerWithTimeInterval:1.
//                                                                  target:self
//                                                                selector:@selector(updatePlayableDurationTimerFired:)
//                                                                userInfo:nil
//                                                                 repeats:YES];
}

- (void)pause {
    [self.player pause];

    [self.playableDurationTimer invalidate];
    self.playableDurationTimer = nil;
    [self.skippingTimer invalidate];
    self.skippingTimer = nil;

    if (_delegateFlags.didPausePlayback) {
        [self.delegate moviePlayerDidPausePlayback:self];
    }

    [self moviePlayerDidPausePlayback];
}

- (void)togglePlaybackState {
    if (self.playing) {
        _userPause = YES;
        [self pause];
    } else {
        _userPause = FALSE;
        [self play];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayer Subclass Hooks
////////////////////////////////////////////////////////////////////////

- (void)moviePlayerDidStartToPlay {
    // do nothing here
}

- (void)moviePlayerDidPausePlayback {
    // do nothing here
}

- (void)moviePlayerDidResumePlayback {
    // do nothing here
}

- (void)moviePlayerDidUpdateCurrentPlaybackTime:(NSTimeInterval)currentPlaybackTime {
    // do nothing here
}

- (void)moviePlayerWillShowControlsWithDuration:(NSTimeInterval)duration {
    // do nothing here
}

- (void)moviePlayerDidShowControls {
    // do nothing here
}

- (void)moviePlayerWillHideControlsWithDuration:(NSTimeInterval)duration {
    // do nothing here
}

- (void)moviePlayerDidHideControls {
    // do nothing here
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayer View
////////////////////////////////////////////////////////////////////////

- (void)addToSuperview:(UIView *)view withFrame:(CGRect)frame {
    self.view.frame = frame;
    [view addSubview:self.view];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayer Properties
////////////////////////////////////////////////////////////////////////

- (NGMoviePlayerView *)view {
    if (_view == nil) {
        _view = [[NGMoviePlayerView alloc] initWithFrame:CGRectZero];
        _view.delegate = self;
        _view.playerLayer.videoGravity = NGAVLayerVideoGravityFromNGMoviePlayerVideoGravity(_videoGravity);
        _view.dataSource = self;

        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            self.layout = [NGMoviePlayerCustomiPhoneLayout new];
        }else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad){
            self.layout = [NGMoviePlayerCustomiPadLayout new];
        }else{
            self.layout = [NGMoviePlayerDefaultLayout new];
        }
        
    }

    return _view;
}

- (AVPlayer *)player {
    return self.view.playerLayer.player;
}

- (void)setPlayer:(AVPlayer *)player {
    if (player != self.view.playerLayer.player) {
        // Support AirPlay?
        if (self.airPlayEnabled) {
            [player setAllowsAirPlayVideo:YES];
            [player setUsesAirPlayVideoWhileAirPlayScreenIsActive:YES];

            [self.view.playerLayer.player removeObserver:self forKeyPath:kAirPlayVideoActiveKey];

            [player addObserver:self
                     forKeyPath:kAirPlayVideoActiveKey
                        options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                        context:&playerAirPlayVideoActiveContext];
        }

        self.view.playerLayer.player = player;
        self.view.delegate = self;
        self.view.dataSource = self;
    }
}

- (void)setAirPlayEnabled:(BOOL)airPlayEnabled {
    if ([AVPlayer instancesRespondToSelector:@selector(allowsAirPlayVideo)]) {
        if (airPlayEnabled != _airPlayEnabled) {
            _airPlayEnabled = airPlayEnabled;
        }
    }
}

- (BOOL)isAirPlayVideoActive {
    return [AVPlayer instancesRespondToSelector:@selector(isAirPlayVideoActive)] && self.player.airPlayVideoActive;
}

- (void)setURL:(NSURL *)URL {
    if (_URL != URL) {
        _URL = URL;

        if (_view != nil) {
            [self.player pause];
            [self.player removeObserver:self forKeyPath:kRateKey];
            [self.player removeObserver:self forKeyPath:kCurrentItemKye];
//            if ([AVPlayer instancesRespondToSelector:@selector(allowsAirPlayVideo)]) {
//                [self.player removeObserver:self forKeyPath:kAirPlayVideoActiveKey];
//            }
            
            self.player = nil;
        }

        if (URL != nil) {
            NSArray *keys = [NSArray arrayWithObjects:kTrackKey, kPlayableKey,kHasProtectedContentKey, nil];

            [self setAsset:[AVURLAsset URLAssetWithURL:URL options:nil]];
            [self.asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self doneLoadingAsset:self.asset withKeys:keys];
                });
            }];

            [self.view updateWithCurrentTime:0. duration:0.];
            [self.view.controlsView resetVideoStatus];
            [self.view showPlaceholderViewAnimated:(self.view.placeholderView.alpha != 1.f)];
        }
    }
}

- (void)setURL:(NSURL *)URL initialPlaybackTime:(NSTimeInterval)initialPlaybackTime title:(NSString *)name
{
    self.initialPlaybackTime = initialPlaybackTime;
    self.URL = URL;
    self.title = name;
    
}


- (void)setURL:(NSURL *)URL initialPlaybackTime:(NSTimeInterval)initialPlaybackTime {
    self.initialPlaybackTime = initialPlaybackTime;
    self.URL = URL;
}

- (void)setURL:(NSURL *)URL title:(NSString *)name
{
    self.initialPlaybackTime = 0;
    self.URL = URL;
    self.title = name;
}

- (void)setTitle:(NSString *)title
{
    if (_title == title) return;
    _title = title;
    _view.title = _title;
}


- (void)setDelegate:(id<NGMoviePlayerDelegate>)delegate {
    if (delegate != _delegate) {
        _delegate = delegate;

        _delegateFlags.didStartPlayback = [delegate respondsToSelector:@selector(moviePlayer:didStartPlaybackOfURL:)];
        _delegateFlags.didFailToLoad = [delegate respondsToSelector:@selector(moviePlayer:didFailToLoadURL:)];
        _delegateFlags.didHasProtectedContent = [delegate respondsToSelector:@selector(moviePlayer:hasProtectedContentURL:)];
        _delegateFlags.didFinishPlayback = [delegate respondsToSelector:@selector(moviePlayer:didFinishPlaybackOfURL:)];
        _delegateFlags.didPausePlayback = [delegate respondsToSelector:@selector(moviePlayerDidPausePlayback:)];
        _delegateFlags.didResumePlayback = [delegate respondsToSelector:@selector(moviePlayerDidResumePlayback:)];
        
        _delegateFlags.didDownload = [delegate respondsToSelector:@selector(moviePlayer:didDownloadURL:)];
        _delegateFlags.didFavorite = [delegate respondsToSelector:@selector(moviePlayer:addFavoriteURL:)];

        _delegateFlags.didBeginScrubbing = [delegate respondsToSelector:@selector(moviePlayerDidBeginScrubbing:)];
        _delegateFlags.didEndScrubbing = [delegate respondsToSelector:@selector(moviePlayerDidEndScrubbing:)];

        _delegateFlags.didChangeStatus = [delegate respondsToSelector:@selector(moviePlayer:didChangeStatus:)];
        _delegateFlags.didChangePlaybackRate = [delegate respondsToSelector:@selector(moviePlayer:didChangePlaybackRate:)];
        _delegateFlags.didChangeAirPlayActive = [delegate respondsToSelector:@selector(moviePlayer:didChangeAirPlayActive:)];
        _delegateFlags.didChangeControlStyle = [delegate respondsToSelector:@selector(moviePlayer:didChangeControlStyle:)];
        _delegateFlags.didUpdateCurrentTime = [delegate respondsToSelector:@selector(moviePlayer:didUpdateCurrentTime:)];
        
        _delegateFlags.didChangeVideoLevel = [delegate respondsToSelector:@selector(moviePlayer:videoLevel:initialPlaybackTime:)];
    }
}


- (void)setDataSource:(id<NGMoviePlayerDataSource>)dataSource
{
    if (dataSource != _dataSource) {
        _dataSource = dataSource;
        _dataSourceFlags.initLevel = [dataSource respondsToSelector:@selector(moviePlayerVideoInitLevelTitle:)];
        _dataSourceFlags.videoLeves = [dataSource respondsToSelector:@selector(moviePlayerVideoLevelTites:)];
        _dataSourceFlags.realtionViewo = [dataSource respondsToSelector:@selector(moviePlayer:tableView:numberOfRowsInSection:)];
        _dataSourceFlags.canFavorite = [dataSource respondsToSelector:@selector(moviePlayerVideoCanFavorite:)];
        _dataSourceFlags.hasFavorite = [dataSource respondsToSelector:@selector(moviePlayerVideoHaveFavorite:)];
        _dataSourceFlags.canDownloaded = [dataSource respondsToSelector:@selector(moviePlayerVideoCanDownload:)];
        self.view.dataSource = self;;
    
    }
}


- (BOOL)isPlaying {
    return self.player != nil && self.player.rate != 0.f;
}

- (BOOL)isPlayingLivestream {
    return self.URL != nil && (isnan(self.duration) || self.duration <= 0.);
}

- (void)setVideoGravity:(NGMoviePlayerVideoGravity)videoGravity {
    self.view.playerLayer.videoGravity = NGAVLayerVideoGravityFromNGMoviePlayerVideoGravity(videoGravity);
    // Hack: otherwise the video gravity doesn't change immediately
    self.view.playerLayer.bounds = self.view.playerLayer.bounds;
}

- (NGMoviePlayerVideoGravity)videoGravity {
    return NGMoviePlayerVideoGravityFromAVLayerVideoGravity(self.view.playerLayer.videoGravity);
}

- (void)setCurrentPlaybackTime:(NSTimeInterval)currentTime {
    currentTime = MAX(currentTime,0.);
    currentTime = MIN(currentTime,self.duration);

     [self.view speedUpTimeByUserShow:YES];
    
    CMTime time = CMTimeMakeWithSeconds(currentTime, NSEC_PER_SEC);
    CMTime tolerance = self.seekingToleranceCMTime;

    // completion handler only supported in iOS 5
    if ([self.player respondsToSelector:@selector(seekToTime:toleranceBefore:toleranceAfter:completionHandler:)]) {
        [self.player seekToTime:time
                toleranceBefore:tolerance
                 toleranceAfter:tolerance
              completionHandler:^(BOOL finished) {
                  if (finished) {
                      [self.view updateWithCurrentTime:self.currentPlaybackTime duration:self.duration];
                  }
              }];
    } else {
        [self.player seekToTime:time toleranceBefore:tolerance toleranceAfter:tolerance];
        [self.view updateWithCurrentTime:currentTime duration:self.duration];
    }
}

- (NSTimeInterval)currentPlaybackTime {
    return CMTimeGetSeconds(self.player.currentTime);
}

- (NSTimeInterval)duration {
    return CMTimeGetSeconds(self.CMDuration);
}

- (NSTimeInterval)playableDuration {
    NSArray *loadedTimeRanges = [self.player.currentItem loadedTimeRanges];

    if (loadedTimeRanges.count > 0) {
        CMTimeRange timeRange = [[loadedTimeRanges objectAtIndex:0] CMTimeRangeValue];
        Float64 startSeconds = CMTimeGetSeconds(timeRange.start);
        Float64 durationSeconds = CMTimeGetSeconds(timeRange.duration);

        return (NSTimeInterval)(startSeconds + durationSeconds);
    } else {
        return 0.;
    }
}

- (void)setLayout:(NGMoviePlayerLayout *)layout {
    layout.moviePlayer = self;
    self.view.controlsView.layout = layout;

    [layout invalidateLayout];
}

- (NGMoviePlayerLayout *)layout {
    return self.view.controlsView.layout;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Notifications
////////////////////////////////////////////////////////////////////////

- (void)playerItemDidPlayToEndTime:(NSNotification *)notification {
    [self.player pause];

    _seekToInitialPlaybackTimeBeforePlay = YES;
    [self.view setControlsVisible:YES animated:YES];

    if (_delegateFlags.didFinishPlayback) {
        [self.delegate moviePlayer:self didFinishPlaybackOfURL:self.URL];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Scrubbing/Skipping
////////////////////////////////////////////////////////////////////////

- (void)beginScrubbing {
    [self stopObservingPlayerTimeChanges];
    [self.view speedUpTimeByUserShow:YES];
    
    _rateToRestoreAfterScrubbing = self.player.rate;
    self.player.rate = 0.f;
    self.scrubbing = YES;

    if (_delegateFlags.didBeginScrubbing) {
        [self.delegate moviePlayerDidBeginScrubbing:self];
    }
}

- (void)endScrubbing {
    // TODO: We need to set this somewhere later (or find another workaround)
    // Current Bug: when the player is paused and the user scrubs player starts
    // playing again because we get a KVO notification that the status changed to ReadyForPlay
    self.scrubbing = NO;
    self.player.rate = _rateToRestoreAfterScrubbing;
    _rateToRestoreAfterScrubbing = 0.f;
    [self.view speedUpTimeByUserShow:NO];

    [self.skippingTimer invalidate];
    self.skippingTimer = nil;
    [self startObservingPlayerTimeChanges];

    if (_delegateFlags.didEndScrubbing) {
        [self.delegate moviePlayerDidEndScrubbing:self];
    }
}

- (void)beginSkippingBackwards {
    [self beginScrubbing];

    self.currentPlaybackTime -= kNGInitialTimeToSkip;
    self.timeToSkip = kNGRepeatedTimeToSkipStartValue;

    self.skippingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(skipTimerFired:)
                                                        userInfo:[NSNumber numberWithInt:NGMoviePlayerControlActionBeginSkippingBackwards]
                                                         repeats:YES];
}

- (void)beginSkippingForwards {
    [self beginScrubbing];

    self.currentPlaybackTime += kNGInitialTimeToSkip;
    self.timeToSkip = kNGRepeatedTimeToSkipStartValue;

    self.skippingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(skipTimerFired:)
                                                        userInfo:[NSNumber numberWithInt:NGMoviePlayerControlActionBeginSkippingForwards]
                                                         repeats:YES];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayerControlViewDelegate
////////////////////////////////////////////////////////////////////////

- (void)moviePlayerControl:(id)control changeVideoLevelIndex:(NSInteger)index
{
    if (_delegateFlags.didChangeVideoLevel) {
        
        [self.delegate moviePlayer:self videoLevel:index initialPlaybackTime:self.currentPlaybackTime];
    }
    [self.view restartFadeOutControlsViewTimer];
    

}

- (BOOL)moviePlayerControl:(id)control messageForAction:(NGMoviePlayerControlAction)action
{
    
    if (action == NGMoviePlayerControlActionVideoFavorite) {
        if ([self.delegate respondsToSelector:@selector(moviePlayer:addFavoriteURL:)]) {
            [self.view restartFadeOutControlsViewTimer];
            return [self.delegate moviePlayer:self addFavoriteURL:self.URL];
        }
    }
    [self.view restartFadeOutControlsViewTimer];
    return FALSE;
}


- (void)moviePlayerControl:(id)control didPerformAction:(NGMoviePlayerControlAction)action {
    [self.view stopFadeOutControlsViewTimer];

    switch (action) {
        case NGMoviePlayerControlActionStartToPlay: {
            [self play];
            [self.view restartFadeOutControlsViewTimer];
            break;
        }

        case NGMoviePlayerControlActionTogglePlayPause: {
            [self togglePlaybackState];
            [self.view restartFadeOutControlsViewTimer];
            break;
        }

        case NGMoviePlayerControlActionToggleZoomState: {
            if (self.view.controlStyle == NGMoviePlayerControlStyleInline) {
                self.view.controlStyle = NGMoviePlayerControlStyleFullscreen;
            } else {
                self.view.controlStyle = NGMoviePlayerControlStyleInline;
            }

            [self.view restartFadeOutControlsViewTimer];

            if (_delegateFlags.didChangeControlStyle) {
                [self.delegate moviePlayer:self didChangeControlStyle:self.view.controlStyle];
            }
            break;
        }

        case NGMoviePlayerControlActionBeginSkippingBackwards: {
            [self beginSkippingBackwards];
            break;
        }

        case NGMoviePlayerControlActionBeginSkippingForwards: {
            [self beginSkippingForwards];
            break;
        }

        case NGMoviePlayerControlActionBeginScrubbing: {
            [self beginScrubbing];
            break;
        }

        case NGMoviePlayerControlActionScrubbingValueChanged: {
            if ([control isKindOfClass:[NGScrubber class]]) {
                NGScrubber *slider = (NGScrubber *)control;

                float value = slider.value;
                [self setCurrentPlaybackTime:value];
                _seekToInitialPlaybackTimeBeforePlay = NO;
            }

            break;
        }

        case NGMoviePlayerControlActionEndScrubbing:
        case NGMoviePlayerControlActionEndSkipping: {
            [self endScrubbing];
            [self.view restartFadeOutControlsViewTimer];
            _seekToInitialPlaybackTimeBeforePlay = NO;
            break;
        }

        case NGMoviePlayerControlActionVolumeChanged: {
            [self.view restartFadeOutControlsViewTimer];
            break;
        }

        case NGMoviePlayerControlActionWillShowControls: {
            [self moviePlayerWillShowControlsWithDuration:kNGFadeDuration];
            [self.view restartFadeOutControlsViewTimer];
            break;
        }

        case NGMoviePlayerControlActionDidShowControls: {
            [self moviePlayerDidShowControls];
            [self.view restartFadeOutControlsViewTimer];
            break;
        }

        case NGMoviePlayerControlActionWillHideControls: {
            [self moviePlayerWillHideControlsWithDuration:kNGFadeDuration];
            [self.view restartFadeOutControlsViewTimer];
            break;
        }

        case NGMoviePlayerControlActionDidHideControls: {
            [self moviePlayerDidHideControls];
            [self.view restartFadeOutControlsViewTimer];
            break;
        }

        case NGMoviePlayerControlActionAirPlayMenuActivated: {
            [self.view restartFadeOutControlsViewTimer];
            break;
        }
        case NGMoviePlayerControlActionRelateTableScroll:{
            [self.view restartHiddenRelateTableView];
        }
            break;
            
        case NGMoviePlayerControlActionVideoLevelChanged: {
            [self.view restartFadeOutControlsViewTimer];
            break;
        }
        case NGMoviePlayerControlActionRelateTableShow: {
            [self.view hiddenTopAndButton];
            break;
        }
        case NGMoviePlayerControlActionVideoDownload:{
            if (_delegateFlags.didDownload) {
                [self.delegate moviePlayer:self didDownloadURL:self.URL];
            }
            [self.view restartFadeOutControlsViewTimer];
            break;
        }

        default:
            // do nothing
            break;

    }
}


////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayerControlDataSource
////////////////////////////////////////////////////////////////////////

- (BOOL )moviePlayerControlViewCanFavorited:(NGMoviePlayerControlView *)controlView
{
    if (_dataSourceFlags.canFavorite) {
        return [_dataSource moviePlayerVideoCanFavorite:self];
    }
    return TRUE;
}

- (BOOL)moviePlayerControlViewHaveFavorited:(NGMoviePlayerControlView *)controlView
{
    if (_dataSourceFlags.hasFavorite) {
        return [self.dataSource moviePlayerVideoHaveFavorite:self];
    }
    
    return FALSE;
}

- (BOOL )moviePlayerControlViewCandownload:(NGMoviePlayerControlView *)controlView
{
    if (_dataSourceFlags.canDownloaded) {
        return [_dataSource moviePlayerVideoCanDownload:self];
    }
    
    return TRUE;
}


- (NSString *)moviePlayerControlViewInitLevelTitle:(NGMoviePlayerControlView *)controlView
{
    if (_dataSourceFlags.initLevel) {
        return [_dataSource moviePlayerVideoInitLevelTitle:self];
    }
    return nil;
}


- (NSArray *)moviePlayerControlViewLevelTites:(NGMoviePlayerControlView *)controlView
{
    if (_dataSourceFlags.videoLeves) {
        return [_dataSource moviePlayerVideoLevelTites:self];
    }
    
    return nil;
}

- (NSInteger)moviePlayerControlView:(NGMoviePlayerControlView *)controlView  numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.dataSource respondsToSelector:@selector(moviePlayer:numberOfSectionsInTableView:)]) {
        return [self.dataSource moviePlayer:self numberOfSectionsInTableView:tableView];
    }
    
    return 1;
}



- (NSInteger)moviePlayerControlView:(NGMoviePlayerControlView *)controlView tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(moviePlayer:tableView:numberOfRowsInSection:)]) {
        return [self.dataSource moviePlayer:self tableView:tableView numberOfRowsInSection:section];
    }
    
    return 0;
}
- (CGFloat)moviePlayerControlView:(NGMoviePlayerControlView *)controlView tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(moviePlayer:tableView:heightForRowAtIndexPath:)]) {
        return [self.dataSource moviePlayer:self tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return 0;

}
- (UITableViewCell *)moviePlayerControlView:(NGMoviePlayerControlView *)controlView tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(moviePlayer:tableView:cellForRowAtIndexPath:)]) {
        return [self.dataSource moviePlayer:self tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    return nil;

}



////////////////////////////////////////////////////////////////////////
#pragma mark - Private
////////////////////////////////////////////////////////////////////////

- (CMTime)CMDuration {
    CMTime duration = kCMTimeInvalid;

    // Peferred in HTTP Live Streaming
    if ([self.playerItem respondsToSelector:@selector(duration)] && // 4.3
        self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {

        if (CMTIME_IS_VALID(self.playerItem.duration)) {
            duration = self.playerItem.duration;
        }
    }

    // when playing over AirPlay the previous duration always returns 1, so we check again
    if ((!CMTIME_IS_VALID(duration) || duration.value/duration.timescale < 2) && CMTIME_IS_VALID(self.player.currentItem.asset.duration)) {
        duration = self.player.currentItem.asset.duration;
    }

    return duration;
}

- (void)doneLoadingAsset:(AVAsset *)asset withKeys:(NSArray *)keys {
    if (!asset.playable) {
        if (_delegateFlags.didFailToLoad) {
            [self.delegate moviePlayer:self didFailToLoadURL:self.URL];
        }

        return;
    }else if(asset.hasProtectedContent){
        if (_delegateFlags.didHasProtectedContent) {
            [self.delegate moviePlayer:self hasProtectedContentURL:self.URL];
        }
        return;
    }

    // Check if all keys are OK
    for (NSString *key in keys) {
        NSError *error = nil;
        AVKeyValueStatus status = [asset statusOfValueForKey:key error:&error];

        if (status == AVKeyValueStatusFailed || status == AVKeyValueStatusCancelled) {
            if (_delegateFlags.didFailToLoad) {
                [self.delegate moviePlayer:self didFailToLoadURL:self.URL];
            }

            return;
        }
    }

    // Remove observer from old playerItem and create new one
    if (self.playerItem) {
        [self.playerItem removeObserver:self forKeyPath:kStatusKey];
        [self.playerItem removeObserver:self forKeyPath:kDrautionKey];
        [self.playerItem removeObserver:self forKeyPath:kLoadedTimeRangesKey];
        [self.playerItem removeObserver:self forKeyPath:kPlaybackBufferEmpty];
        [self.playerItem removeObserver:self forKeyPath:kPlaybackLikelyToKeepUp];

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:AVPlayerItemDidPlayToEndTimeNotification
                                                      object:self.playerItem];
    }

    [self setPlayerItem:[AVPlayerItem playerItemWithAsset:asset]];

    // Observe status, ok -> play
    [self.playerItem addObserver:self
                      forKeyPath:kStatusKey
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:&playerItemStatusContext];

    // Durationchange
    [self.playerItem addObserver:self
                      forKeyPath:kDrautionKey
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:&playerItemDurationContext];
    
    [self.playerItem addObserver:self forKeyPath:kLoadedTimeRangesKey options:NSKeyValueObservingOptionNew context:&playerItemLoadedTimeRangesContext];
    
    // playbackBufferEmpty
    [self.playerItem addObserver:self forKeyPath:kPlaybackBufferEmpty options:NSKeyValueObservingOptionNew context:&playerItemBufferEmpty];
    //playbackLikelyToKeepUp
    [self.playerItem addObserver:self forKeyPath:kPlaybackLikelyToKeepUp options:NSKeyValueObservingOptionNew context:&playerItemLikelyToKeepUp];
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidPlayToEndTime:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.playerItem];

    _seekToInitialPlaybackTimeBeforePlay = YES;

    // Create the player
    if (!self.player) {
        [self setPlayer:[AVPlayer playerWithPlayerItem:self.playerItem]];

        // Observe currentItem, catch the -replaceCurrentItemWithPlayerItem:
        [self.player addObserver:self
                      forKeyPath:kCurrentItemKye
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:&playerCurrentItemContext];

        // Observe rate, play/pause-button?
        [self.player addObserver:self
                      forKeyPath:kRateKey
                         options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                         context:&playerRateContext];

    }

    // New playerItem?
    if (self.player.currentItem != self.playerItem) {
        [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
        [self.view updateWithPlaybackStatus:self.playing];
    }
}

- (void)startObservingPlayerTimeChanges {
    if (self.playerTimeObserver == nil) {
        __ng_weak NGMoviePlayer *weakSelf = self;
        
        self.playerTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(.5, NSEC_PER_SEC)
                                                                            queue:dispatch_get_main_queue()
                                                                       usingBlock:^(CMTime time) {
                                                                           __strong NGMoviePlayer *strongSelf = weakSelf;
                                                                           
                                                                           if (strongSelf != nil && [strongSelf isKindOfClass:[NGMoviePlayer class]]) {
                                                                               if (CMTIME_IS_VALID(strongSelf.player.currentTime) && CMTIME_IS_VALID(strongSelf.CMDuration)) {
                                                                                   [strongSelf.view updateWithCurrentTime:strongSelf.currentPlaybackTime
                                                                                                                 duration:strongSelf.duration];
                                                                                   
                                                                                   [strongSelf moviePlayerDidUpdateCurrentPlaybackTime:strongSelf.currentPlaybackTime];
                                                                                   
                                                                                   if (strongSelf->_delegateFlags.didUpdateCurrentTime) {
                                                                                       [strongSelf.delegate moviePlayer:strongSelf didUpdateCurrentTime:strongSelf.currentPlaybackTime];
                                                                                   }
                                                                               }
                                                                           }
                                                                       }];
    }
}

- (void)stopObservingPlayerTimeChanges {
    if (self.playerTimeObserver != nil) {
        [self.player removeTimeObserver:self.playerTimeObserver];
        self.playerTimeObserver = nil;
    }
}

- (void)updateControlsViewForLivestreamStatus {
    // layout might change when playing livestream
    [self.layout invalidateLayout];
}

- (void)skipTimerFired:(NSTimer *)timer {
    NGMoviePlayerControlAction action = [timer.userInfo intValue];
    
    if (action == NGMoviePlayerControlActionBeginSkippingBackwards) {
        self.currentPlaybackTime -= self.timeToSkip++;
    } else if (action == NGMoviePlayerControlActionBeginSkippingForwards) {
        self.currentPlaybackTime += self.timeToSkip++;
    }
}

- (void)updatePlayableDurationTimerFired:(NSTimer *)timer {
    self.view.controlsView.playableDuration = self.playableDuration;
}

- (CMTime)seekingToleranceCMTime {
    if (self.seekingToleranceTime >= 1000.) {
        return kCMTimePositiveInfinity;
    } else if (self.seekingToleranceTime <= 0.001) {
        return kCMTimeZero;
    } else {
        return CMTimeMakeWithSeconds(self.seekingToleranceTime, NSEC_PER_SEC);
    }
}

- (CMTime)initialPlaybackToleranceCMTime {
    if (self.initialPlaybackToleranceTime >= 1000.) {
        return kCMTimePositiveInfinity;
    } else if (self.initialPlaybackToleranceTime <= 0.001) {
        return kCMTimeZero;
    } else {
        return CMTimeMakeWithSeconds(self.initialPlaybackToleranceTime, NSEC_PER_SEC);
    }
}

@end
