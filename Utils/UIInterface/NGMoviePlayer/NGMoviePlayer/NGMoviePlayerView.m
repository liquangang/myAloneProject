#import "NGMoviePlayerView.h"
#import "NGVolumeControl.h"
#import "NGMoviePlayerLayerView.h"
#import "NGMoviePlayerControlView.h"
#import "NGMoviePlayerControlView+NGPrivate.h"
#import "NGMoviePlayerPlaceholderView.h"
#import "NGMoviePlayerControlActionDelegate.h"
#import "NGMoviePlayerVideoGravity.h"
#import "NGScrubber.h"
#import "NGMoviePlayerVideoLevel.h"
#import "NGMoviePlayerRelationView.h"
#import "NGSpeedHUD.h"
#import <MediaPlayer/MediaPlayer.h>

#define kNGFadeDuration                     0.33


#define kNGControlVisibilityDuration        5.

#define kNGRelateTableViewDuration 10.

#define kSpeedUpFadeTime .1
#define kIndicatorFadeTimn .1

#define kMinVolumeChangeLength 10
#define kMinVideoChangeLength 20
#define kMaxTimeInterVal (15*60) // 1 minutes


static char playerLayerReadyForDisplayContext;


@interface NGMoviePlayerView () <UIGestureRecognizerDelegate> {
    BOOL _statusBarVisible;
    UIStatusBarStyle _statusBarStyle;
    BOOL _shouldHideControls;
    NSTimeInterval _preTimer;
}

@property (nonatomic, strong, readwrite) NGMoviePlayerControlView *controlsView;  // re-defined as read/write
@property (nonatomic, strong) NGMoviePlayerLayerView *playerLayerView;
@property (nonatomic, strong) UIWindow *externalWindow;
@property (nonatomic, strong) UIView *externalScreenPlaceholder;
@property (nonatomic, strong) UIView *videoOverlaySuperview;

@property (nonatomic, strong) UIView *activityHUD;
@property (nonatomic, strong) NGSpeedHUD *speedHUD;

@property (nonatomic, assign) CGPoint initialTouchLocation;
@property (nonatomic, assign) CGPoint previousTouchLocation;
@property (nonatomic, assign) NGPanDirection panDirection;

@property (nonatomic, readonly, getter = isAirPlayVideoActive) BOOL airPlayVideoActive;

@end


@implementation NGMoviePlayerView

@dynamic playerLayer;

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor clearColor];
        _shouldShowStatusBarInFullScreenMode = YES;
        [self setup];
    }

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setup];
    }

    return self;
}

- (void)dealloc {
    AVPlayerLayer *playerLayer = (AVPlayerLayer *)[_playerLayerView layer];

    [_placeholderView removeFromSuperview];
    [_playerLayerView removeFromSuperview];
    [playerLayer removeFromSuperlayer];
    [playerLayer removeObserver:self forKeyPath:@"readyForDisplay"];

    [_externalScreenPlaceholder removeFromSuperview];
    [_videoOverlaySuperview removeFromSuperview];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenDidDisconnectNotification object:nil];
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOutControls) object:nil];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject KVO
////////////////////////////////////////////////////////////////////////

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == &playerLayerReadyForDisplayContext) {
        BOOL readyForDisplay = [[change valueForKey:NSKeyValueChangeNewKey] boolValue];

        if (self.playerLayerView.layer.opacity == 0.f && readyForDisplay) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];

            animation.duration = kNGFadeDuration;
            animation.fromValue = [NSNumber numberWithFloat:0.];
            animation.toValue = [NSNumber numberWithFloat:1.];
            animation.removedOnCompletion = NO;

            self.playerLayerView.layer.opacity = 1.f;
            [self.playerLayerView.layer addAnimation:animation forKey:nil];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIView
////////////////////////////////////////////////////////////////////////

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        [self.playerLayer.player pause];
    }

    [super willMoveToSuperview:newSuperview];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (newWindow == nil) {
        [self.playerLayer.player pause];
    }

    [super willMoveToWindow:newWindow];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayerView Properties
////////////////////////////////////////////////////////////////////////

- (void)setDelegate:(id<NGMoviePlayerControlActionDelegate>)delegate {
    if (delegate != _delegate) {
        _delegate = delegate;
    }

    self.controlsView.delegate = delegate;
}

- (void)setDataSource:(id<NGMoviePlayerControlDataSource>)dataSource
{
    if (dataSource != _dataSource) {
        _dataSource = dataSource;
    }
    self.controlsView.dataSource = dataSource;
    
}


- (void)setControlsVisible:(BOOL)controlsVisible {
    [self setControlsVisible:controlsVisible animated:NO];
}

- (void)setControlsVisible:(BOOL)controlsVisible animated:(BOOL)animated {
    if (controlsVisible) {
        [self bringSubviewToFront:self.controlsView];
    } else {
        [self.controlsView.volumeControl setExpanded:NO animated:YES];
    }

    if (controlsVisible != _controlsVisible) {
        _controlsVisible = controlsVisible;

        NSTimeInterval duration = animated ? kNGFadeDuration : 0.;
        NGMoviePlayerControlAction willAction = controlsVisible ? NGMoviePlayerControlActionWillShowControls : NGMoviePlayerControlActionWillHideControls;
        NGMoviePlayerControlAction didAction = controlsVisible ? NGMoviePlayerControlActionDidShowControls : NGMoviePlayerControlActionDidHideControls;

        [self.delegate moviePlayerControl:self.controlsView didPerformAction:willAction];

        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOutControls) object:nil];
        // Doesn't work on device (doesn't fade but jumps from alpha 0 to 1) -> currently deactivated
        // rasterization fades out the view as a whole instead of setting alpha on each subview
        // it's similar to setting UIViewGroupOpacity, but only for this particular view
        // self.controlsView.scrubberControl.layer.shouldRasterize = YES;
        // self.controlsView.scrubberControl.layer.rasterizationScale = [UIScreen mainScreen].scale;
        
        if (!controlsVisible) {
            [self.controlsView hiddenVideoLevelView];
        }
        

        [UIView animateWithDuration:duration
                              delay:0.
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.controlsView.alpha = controlsVisible ? 1.f : 0.f;
                         } completion:^(BOOL finished) {
                             [self restartFadeOutControlsViewTimer];
                             [self.delegate moviePlayerControl:self.controlsView didPerformAction:didAction];

                             //self.controlsView.scrubberControl.layer.shouldRasterize = NO;
                         }];

        if (self.controlStyle == NGMoviePlayerControlStyleFullscreen) {
            BOOL statusBarHidden = (!controlsVisible || !self.shouldShowStatusBarInFullScreenMode);
            if (animated) {
                [[UIApplication sharedApplication] setStatusBarHidden:statusBarHidden withAnimation:UIStatusBarAnimationFade];
            } else {
                [[UIApplication sharedApplication] setStatusBarHidden:statusBarHidden withAnimation:UIStatusBarAnimationNone];
            }
        }
    }
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    if (placeholderView != _placeholderView) {
        [_placeholderView removeFromSuperview];
        _placeholderView = placeholderView;
        _placeholderView.frame = self.bounds;
        _placeholderView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_placeholderView];
    }
}

- (void)setTitle:(NSString *)title{
    if (_title == title) return;
    _title = title;
    _controlsView.titleLabel.text = _title;
    ((NGMoviePlayerPlaceholderView *)_placeholderView).infoText = _title;
}

- (void)speedUpTimeByUserShow:(BOOL)show{
    
    if (self.controlStyle == NGMoviePlayerControlStyleInline) {
        self.speedHUD.alpha = 0.0f;
        return;
    }
    
    float curTime = self.controlsView.scrubberControl.value;
    float totalTime = self.controlsView.scrubberControl.maximumValue;
    BOOL value =  curTime>_preTimer?YES:FALSE;
    
    self.speedHUD.currentTime = curTime;
    self.speedHUD.totalTime = totalTime;
    self.speedHUD.speedUp = value;
    self.activityHUD.alpha = 0.0f;
    self.speedHUD.center = self.center;
    
    _preTimer = curTime;
    
    if (show) {
        [self bringSubviewToFront:self.speedHUD];
        if (self.speedHUD.alpha != 0.0f) {
            return;
        }
        [UIView animateWithDuration:kSpeedUpFadeTime animations:^(void){self.speedHUD.alpha = 0.8f;}];
        
    }else{
        [self sendSubviewToBack:self.speedHUD];
        if (self.speedHUD.alpha == 0.0f) {
            return;
        }
        [UIView animateWithDuration:kSpeedUpFadeTime animations:^(void){self.speedHUD.alpha = 0.0f;}];
    }

}


- (void)activityViewShow:(BOOL)value{
    
    
    
    if (self.speedHUD.alpha != 0.0f) {
        self.activityHUD.alpha = .0f;
        return;
    }
    
    
    if (value) {
        [self bringSubviewToFront:self.activityHUD];
        //        [self.controlsView updateButtonsWithPlayBufferEnable:NO];
        self.activityHUD.center = self.center;
        NSLog(@"center x:%0.1f y:%0.1f",self.center.x,self.center.y);
        if (self.activityHUD.alpha != 0.0f) {
            return;
        }
        [UIView animateWithDuration:kIndicatorFadeTimn animations:^(void){self.activityHUD.alpha = 0.8f;}];
    }else{
        [self sendSubviewToBack:self.activityHUD];
        self.activityHUD.alpha = 0.0f;
        //        [self.controlsView updateButtonsWithPlayBufferEnable:YES];
        if (self.activityHUD.alpha == 0.0f) {
            return;
        }
        [UIView animateWithDuration:kIndicatorFadeTimn animations:^(void){self.activityHUD.alpha = 0.0f;}];
    }
    
    
}



- (void)hidePlaceholderViewAnimated:(BOOL)animated {
    self.backgroundColor = [UIColor blackColor];

    if (animated) {
        [UIView animateWithDuration:kNGFadeDuration
                         animations:^{
                             self.placeholderView.alpha = 0.f;
                         } completion:^(BOOL finished) {
                             [self.placeholderView removeFromSuperview];
                         }];
    } else {
        [self.placeholderView removeFromSuperview];
    }
}

- (void)showPlaceholderViewAnimated:(BOOL)animated {
    if ([self.placeholderView isKindOfClass:[NGMoviePlayerPlaceholderView class]]) {
        NGMoviePlayerPlaceholderView *placeholderView = (NGMoviePlayerPlaceholderView *)self.placeholderView;
        placeholderView.frame = self.bounds;
        if (self.controlStyle == NGMoviePlayerControlStyleInline) {
            placeholderView.backBtn.hidden = TRUE;
        }else{
            placeholderView.backBtn.hidden = FALSE;

        }
        [placeholderView resetToInitialState];
    }

    if (animated) {
        self.placeholderView.alpha = 0.f;
        [self addSubview:self.placeholderView];
        [UIView animateWithDuration:kNGFadeDuration
                         animations:^{
                             self.placeholderView.alpha = 1.f;
                         }];
    } else {
        self.placeholderView.alpha = 1.f;
        [self addSubview:self.placeholderView];
    }
}

- (void)setControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    if (controlStyle != self.controlsView.controlStyle) {
        self.controlsView.controlStyle = controlStyle;
        [self.controlsView updateButtonsWithPlaybackStatus:self.playerLayer.player.rate > 0.f];

        BOOL isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;

        // hide status bar in fullscreen, restore to previous state
        if (controlStyle == NGMoviePlayerControlStyleFullscreen) {
            [[UIApplication sharedApplication] setStatusBarStyle: (isIPad ? UIStatusBarStyleBlackOpaque : UIStatusBarStyleBlackTranslucent)];
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        } else {
            [[UIApplication sharedApplication] setStatusBarStyle:_statusBarStyle];
            [[UIApplication sharedApplication] setStatusBarHidden:!_statusBarVisible withAnimation:UIStatusBarAnimationFade];
        }
    }

    self.controlsVisible = NO;
}

- (NGMoviePlayerControlStyle)controlStyle {
    return self.controlsView.controlStyle;
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)[self.playerLayerView layer];
}

- (NGMoviePlayerScreenState)screenState {
    if (self.externalWindow != nil) {
        return NGMoviePlayerScreenStateExternal;
    } else if (self.airPlayVideoActive) {
        return NGMoviePlayerScreenStateAirPlay;
    } else {
        return NGMoviePlayerScreenStateDevice;
    }
}

- (UIView *)externalScreenPlaceholder {
    if(_externalScreenPlaceholder == nil) {
        BOOL isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;

        _externalScreenPlaceholder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/playerBackground"]];
        _externalScreenPlaceholder.userInteractionEnabled = YES;
        _externalScreenPlaceholder.frame = self.bounds;
        _externalScreenPlaceholder.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

        UIView *externalScreenPlaceholderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, (isIPad ? 280 : 140))];

        UIImageView *externalScreenPlaceholderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:(isIPad ? @"NGMoviePlayer.bundle/wildcatNoContentVideos@2x" : @"NGMoviePlayer.bundle/wildcatNoContentVideos")]];
        externalScreenPlaceholderImageView.frame = CGRectMake((320-externalScreenPlaceholderImageView.image.size.width)/2, 0, externalScreenPlaceholderImageView.image.size.width, externalScreenPlaceholderImageView.image.size.height);
        [externalScreenPlaceholderView addSubview:externalScreenPlaceholderImageView];

        UILabel *externalScreenLabel = [[UILabel alloc] initWithFrame:CGRectMake(29, externalScreenPlaceholderImageView.frame.size.height + (isIPad ? 15 : 5), 262, 30)];
        externalScreenLabel.font = [UIFont systemFontOfSize:(isIPad ? 26.0f : 20.0f)];
        externalScreenLabel.textAlignment = UITextAlignmentCenter;
        externalScreenLabel.backgroundColor = [UIColor clearColor];
        externalScreenLabel.textColor = [UIColor darkGrayColor];
        externalScreenLabel.text = self.airPlayVideoActive ? @"AirPlay" : @"VGA";
        [externalScreenPlaceholderView addSubview:externalScreenLabel];

        UILabel *externalScreenDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, externalScreenLabel.frame.origin.y + (isIPad ? 35 : 20), 320, 30)];
        externalScreenDescriptionLabel.font = [UIFont systemFontOfSize:(isIPad ? 14.0f : 10.0f)];
        externalScreenDescriptionLabel.textAlignment = UITextAlignmentCenter;
        externalScreenDescriptionLabel.backgroundColor = [UIColor clearColor];
        externalScreenDescriptionLabel.textColor = [UIColor lightGrayColor];
        externalScreenDescriptionLabel.text = [NSString stringWithFormat:@"Dieses Video wird %@ wiedergegeben.", externalScreenLabel.text];
        [externalScreenPlaceholderView addSubview:externalScreenDescriptionLabel];

        externalScreenPlaceholderView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        externalScreenPlaceholderView.center = _externalScreenPlaceholder.center;

        [_externalScreenPlaceholder addSubview:externalScreenPlaceholderView];
    }

    return _externalScreenPlaceholder;
}

- (CGFloat)topControlsViewHeight {
    return CGRectGetMaxY(self.controlsView.topControlsView.frame);
}

- (CGFloat)bottomControlsViewHeight {
    CGFloat height = CGRectGetHeight(self.controlsView.frame);

    return  height - CGRectGetMinY(self.controlsView.bottomControlsView.frame) + 2*(height - CGRectGetMaxY(self.controlsView.bottomControlsView.frame));
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayerView UI Update
////////////////////////////////////////////////////////////////////////

- (void)updateWithCurrentTime:(NSTimeInterval)currentTime duration:(NSTimeInterval)duration {
    if (!isnan(currentTime) && !isnan(duration)) {
        [self.controlsView updateScrubberWithCurrentTime:currentTime duration:duration];
    }
}

- (void)updateWithPlaybackStatus:(BOOL)isPlaying {
    [self.controlsView updateButtonsWithPlaybackStatus:isPlaying];

    _shouldHideControls = isPlaying;
}

- (void)addVideoOverlayView:(UIView *)overlayView {
    if (overlayView != nil) {
        if (_videoOverlaySuperview == nil) {
            UIView *superview = self.playerLayerView.superview;

            _videoOverlaySuperview = [[UIView alloc] initWithFrame:superview.bounds];
            _videoOverlaySuperview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [superview insertSubview:_videoOverlaySuperview aboveSubview:self.playerLayerView];
        }

        [self.videoOverlaySuperview addSubview:overlayView];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Controls
////////////////////////////////////////////////////////////////////////

- (void)stopFadeOutControlsViewTimer {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(fadeOutControls) object:nil];
}

- (void)restartFadeOutControlsViewTimer {
    [self stopFadeOutControlsViewTimer];

    [self performSelector:@selector(fadeOutControls) withObject:nil afterDelay:kNGControlVisibilityDuration];
}

- (void)stopHiddenRelateTableView {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hiddenRelateView) object:nil];
}


- (void)restartHiddenRelateTableView
{    [self stopHiddenRelateTableView];
     [self performSelector:@selector(hiddenRelateView) withObject:nil afterDelay:kNGRelateTableViewDuration];
}


- (void)hiddenTopAndButton{
    [self stopFadeOutControlsViewTimer];

    [UIView animateWithDuration:.2
                          delay:0.
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.controlsView.topControlsView.alpha = 0;
                         self.controlsView.bottomControlsView.alpha = 0;
                     } completion:^(BOOL finished) {
                         
                         [self restartHiddenRelateTableView];
                         
                         //self.controlsView.scrubberControl.layer.shouldRasterize = NO;
                     }];
}

- (void)hiddenRelateView
{
    [self.controlsView hiddenRelateTableView];
    
    [UIView animateWithDuration:0.25 animations:^(void){
       self.controlsView.alpha = .0f;
        
    } completion:^(BOOL finish){
        [self.controlsView hiddenVideoLevelView];
        self.controlsView.topControlsView.alpha = 1;
        self.controlsView.bottomControlsView.alpha = 1;
        _controlsVisible = FALSE;
        [self restartFadeOutControlsViewTimer];
    }];
    
    
}





////////////////////////////////////////////////////////////////////////
#pragma mark - External Screen (VGA)
////////////////////////////////////////////////////////////////////////

- (void)setupExternalWindowForScreen:(UIScreen *)screen {
    if (screen != nil) {
        self.externalWindow = [[UIWindow alloc] initWithFrame:screen.applicationFrame];
        self.externalWindow.hidden = NO;
        self.externalWindow.clipsToBounds = YES;

        if (screen.availableModes.count > 0) {
            UIScreenMode *desiredMode = [screen.availableModes objectAtIndex:screen.availableModes.count-1];
            screen.currentMode = desiredMode;
        }

        self.externalWindow.screen = screen;
        [self.externalWindow makeKeyAndVisible];
    } else {
        [self.externalWindow removeFromSuperview];
        [self.externalWindow resignKeyWindow];
        self.externalWindow.hidden = YES;
        self.externalWindow = nil;
    }
}

- (void)updateViewsForCurrentScreenState {
    [self positionViewsForState:self.screenState];

    [self setControlsVisible:NO];

    if (self.placeholderView.superview == nil) {
        int64_t delayInSeconds = 1.;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self setControlsVisible:YES animated:YES];
        });
    }
}

- (void)positionViewsForState:(NGMoviePlayerScreenState)screenState {
    UIView *viewBeneathOverlayViews = self.playerLayerView;

    switch (screenState) {
        case NGMoviePlayerScreenStateExternal: {
            self.playerLayerView.frame = self.externalWindow.bounds;
            [self.externalWindow addSubview:self.playerLayerView];
            [self insertSubview:self.externalScreenPlaceholder belowSubview:self.placeholderView];
            viewBeneathOverlayViews = self.externalScreenPlaceholder;
            break;
        }

        case NGMoviePlayerScreenStateAirPlay: {
            self.playerLayerView.frame = self.bounds;
            [self insertSubview:self.playerLayerView belowSubview:self.placeholderView];
            [self insertSubview:self.externalScreenPlaceholder belowSubview:self.placeholderView];
            viewBeneathOverlayViews = self.externalScreenPlaceholder;
            break;
        }

        case NGMoviePlayerScreenStateDevice:
        default: {
            self.playerLayerView.frame = self.bounds;
            [self insertSubview:self.playerLayerView belowSubview:self.placeholderView];
            [self.externalScreenPlaceholder removeFromSuperview];
            self.externalScreenPlaceholder = nil;
            break;
        }
    }

    UIView *superview = self.playerLayerView.superview;

    self.videoOverlaySuperview.frame = self.playerLayerView.frame;
    [superview insertSubview:self.videoOverlaySuperview aboveSubview:viewBeneathOverlayViews];

    [self bringSubviewToFront:self.controlsView];
    [self bringSubviewToFront:self.placeholderView];
}

- (void)externalScreenDidConnect:(NSNotification *)notification {
    UIScreen *screen = [notification object];

    [self setupExternalWindowForScreen:screen];
    [self positionViewsForState:self.screenState];
}

- (void)externalScreenDidDisconnect:(NSNotification *)notification {
    [self setupExternalWindowForScreen:nil];
    [self positionViewsForState:self.screenState];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIGestureRecognizerDelegate
////////////////////////////////////////////////////////////////////////

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (self.controlsVisible || self.placeholderView.alpha > 0.f) {
        id playButton = nil;

        if (self.controlsView.volumeControl.expanded) {
            return NO;
        }

        if ([self.placeholderView respondsToSelector:@selector(playButton)]) {
            playButton = [self.placeholderView performSelector:@selector(playButton)];
        }

        // We here rely on the fact that nil terminates a list, because playButton can be nil
        // ATTENTION: DO NOT CONVERT THIS TO MODERN OBJC-SYNTAX @[]
        NSArray *controls = [NSArray arrayWithObjects:self.controlsView.topControlsView, self.controlsView.bottomControlsView, playButton, nil];
        
        if (!self.controlsView.videoLevelView.hidden) {
            if ([self.controlsView.videoLevelView pointInside:[touch locationInView:self.controlsView.videoLevelView] withEvent:nil]) {
                return NO;
            }
        }
        
        if (self.controlsView.relationView != nil) {
            if ([self.controlsView.relationView pointInside:[touch locationInView:self.controlsView.videoLevelView] withEvent:nil]) {
                return NO;
            }
        }
        

        // We dont want to to hide the controls when we tap em
        for (UIView *view in controls) {
            if ([view pointInside:[touch locationInView:view] withEvent:nil]) {
                return NO;
            }
        }
    }

    return YES;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Private
////////////////////////////////////////////////////////////////////////

- (void)setup {
    self.controlStyle = NGMoviePlayerControlStyleInline;
    _controlsVisible = NO;
    _statusBarVisible = ![UIApplication sharedApplication].statusBarHidden;
    _statusBarStyle = [UIApplication sharedApplication].statusBarStyle;

    // Player Layer
    _playerLayerView = [[NGMoviePlayerLayerView alloc] initWithFrame:self.bounds];
    _playerLayerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _playerLayerView.alpha = 0.f;

    [self.playerLayer addObserver:self
                       forKeyPath:@"readyForDisplay"
                          options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
                          context:&playerLayerReadyForDisplayContext];

    // Controls
    _controlsView = [[NGMoviePlayerControlView alloc] initWithFrame:self.bounds];
    _controlsView.alpha = 0.f;
    [self addSubview:_controlsView];

    [_controlsView.volumeControl addTarget:self action:@selector(volumeControlValueChanged:) forControlEvents:UIControlEventValueChanged];

    // Placeholder
    NGMoviePlayerPlaceholderView *placeholderView = [[NGMoviePlayerPlaceholderView alloc] initWithFrame:self.bounds];
    placeholderView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [placeholderView addPlayButtonTarget:self action:@selector(handlePlayButtonPress:)];
    [placeholderView addBackButtonTarget:self action:@selector(handlebackButtonPress:)];
    placeholderView.infoText = _title;
    placeholderView.backBtn.hidden = FALSE;
    _placeholderView = placeholderView;
    [self addSubview:_placeholderView];
    
    
    self.activityHUD = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    self.activityHUD.center = self.center;
    self.activityHUD.backgroundColor = [UIColor blackColor];
    self.activityHUD.layer.cornerRadius = 5.0;
    self.activityHUD.layer.masksToBounds = YES;
    UIActivityIndicatorView *indicatro = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.activityHUD addSubview:indicatro];
    [indicatro startAnimating];
    
    CGRect frame = indicatro.frame;
    frame.origin.x = CGRectGetWidth(self.activityHUD.frame)/2-CGRectGetWidth(frame)/2;
    frame.origin.y = CGRectGetHeight(self.activityHUD.frame)/2-CGRectGetHeight(frame)/2;;
    indicatro.frame = frame;
    [self addSubview:self.activityHUD];
    
    self.speedHUD = [[NGSpeedHUD alloc] initWithFrame:CGRectMake(0, 0, 140, 140)];
    self.speedHUD.backgroundColor = [UIColor blackColor];
    self.speedHUD.layer.cornerRadius = 8.0;
    self.speedHUD.layer.masksToBounds = YES;
    self.speedHUD.alpha = 0.0f;
    [self addSubview:self.speedHUD];

    // Gesture Recognizer for self
    UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    doubleTapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:doubleTapGestureRecognizer];

    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    singleTapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:singleTapGestureRecognizer];
    
    
    UIPanGestureRecognizer *panGestureRecongnizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecongnizer:)];
    panGestureRecongnizer.delegate = self;
    [self addGestureRecognizer:panGestureRecongnizer];
    

    // Gesture Recognizer for controlsView
    doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapGestureRecognizer.numberOfTapsRequired = 2;
    doubleTapGestureRecognizer.delegate = self;
    [self.controlsView addGestureRecognizer:doubleTapGestureRecognizer];

    singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
    singleTapGestureRecognizer.delegate = self;
    [self.controlsView addGestureRecognizer:singleTapGestureRecognizer];
    
    panGestureRecongnizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCotnrolSwipGestureRecongnizer:)];
    panGestureRecongnizer.delegate = self;
    [self.controlsView addGestureRecognizer:panGestureRecongnizer];


    // Check for external screen
    if ([UIScreen screens].count > 1) {
        for (UIScreen *screen in [UIScreen screens]) {
            if (screen != [UIScreen mainScreen]) {
                [self setupExternalWindowForScreen:screen];
                break;
            }
        }

        NSAssert(self.externalWindow != nil, @"External screen counldn't be determined, no window was created");
    }

    [self positionViewsForState:self.screenState];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(externalScreenDidConnect:) name:UIScreenDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(externalScreenDidDisconnect:) name:UIScreenDidDisconnectNotification object:nil];
    
    _preTimer = self.controlsView.scrubberControl.value;
}

- (void)fadeOutControls {
    if (_shouldHideControls && self.screenState == NGMoviePlayerScreenStateDevice) {
        [self setControlsVisible:NO animated:YES];
    }
}

- (BOOL)isAirPlayVideoActive {
    if ([AVPlayer instancesRespondToSelector:@selector(isAirPlayVideoActive)]) {
        return self.playerLayer.player.airPlayVideoActive;
    }

    return NO;
}

- (void)handleSingleTap:(UITapGestureRecognizer *)tap {
    if ((tap.state & UIGestureRecognizerStateRecognized) == UIGestureRecognizerStateRecognized) {
        
        if (self.controlsView.relationView && !self.controlsView.relationView.hidden) {
            [self hiddenRelateView];
        }else if (self.placeholderView.alpha == 0.f) {
            
            [self setControlsVisible:!self.controlsVisible animated:YES];
        }
    }
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    if ((tap.state & UIGestureRecognizerStateRecognized) == UIGestureRecognizerStateRecognized) {
        if (self.placeholderView.alpha == 0.f) {
            // Toggle video gravity on double tap
            self.playerLayer.videoGravity = NGAVLayerVideoGravityNext(self.playerLayer.videoGravity);
            // BUG: otherwise the video gravity doesn't change immediately
            self.playerLayer.bounds = self.playerLayer.bounds;
        }
    }
}


- (void)panGestureRecongnizer:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            [self handleSelfVolumeGestureBeganWithRecognizer:recognizer];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self handleSelfVolumeGestureChangedWithRecognizer:recognizer];
            break;
            
        case UIGestureRecognizerStateEnded:
            [self handleSelfPanGestureEndedWithRecognizer:recognizer];
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [self handleSelfPanGestureEndedWithRecognizer:recognizer];
            break;
            
        default:
        {
            
        }
            break;
    }
}

- (void)panCotnrolSwipGestureRecongnizer:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state)
    {
        case UIGestureRecognizerStateBegan:
            [self handleContainVolumeGestureBeganWithRecognizer:recognizer];
            break;
            
        case UIGestureRecognizerStateChanged:
            [self handleContainfVolumeGestureChangedWithRecognizer:recognizer];
            break;
            
        case UIGestureRecognizerStateEnded:
            [self handleContainPanGestureEndedWithRecognizer:recognizer];
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
            [self handleContainPanGestureEndedWithRecognizer:recognizer];
            break;
            
        default:
        {
            
        }
            break;
    }
}


#pragma mark - volumeGesture



- (void)handleSelfVolumeGestureBeganWithRecognizer:(UIPanGestureRecognizer *)recognizer
{
    self.panDirection = NGPanDirection_NONE;
    self.initialTouchLocation = [recognizer locationInView:self];
    self.previousTouchLocation = self.initialTouchLocation;
}

- (void)handleSelfVolumeGestureChangedWithRecognizer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint currentTouchLocation = [recognizer locationInView:self];
    CGFloat deltaY = currentTouchLocation.y - self.previousTouchLocation.y;
    CGFloat deltaX = currentTouchLocation.x - self.previousTouchLocation.x;
    CGFloat offset;
    CGFloat precent;
    
    if (self.panDirection == NGPanDirection_NONE) { //find morve direct
        if (ABS(deltaX)>ABS(deltaY) && ABS(deltaX)>kMinVideoChangeLength) {
            self.panDirection = NGPanDirection_LEFT;
            [self.controlsView.scrubberControl sendActionsForControlEvents:UIControlEventTouchDown];
        }else if (ABS(deltaY)>ABS(deltaX) && ABS(deltaY)>kMinVolumeChangeLength) {
            self.panDirection = NGPanDirection_UP;
        }else{
            return;
        }
    }
    
    if (self.panDirection == NGPanDirection_LEFT) {
        offset = deltaX;
        if (ABS(offset)<kMinVideoChangeLength) {
            return;
        }
        precent = offset/CGRectGetWidth(self.bounds);
        [self videoAddPercent:precent];
        
    }else if (self.panDirection == NGPanDirection_UP){
        offset = deltaY;
        if (ABS(offset)<kMinVolumeChangeLength) {
            return;
        }
        
        precent = offset/CGRectGetHeight(self.bounds);
        [self volumeAddPercent:precent];
    }
    
    self.previousTouchLocation = currentTouchLocation;
    
    
}

- (void)handleSelfPanGestureEndedWithRecognizer:(UIPanGestureRecognizer *)recognizer
{
    if (self.panDirection == NGPanDirection_LEFT) {
        [self.controlsView.scrubberControl sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)handleContainVolumeGestureBeganWithRecognizer:(UIPanGestureRecognizer *)recognizer
{
    self.initialTouchLocation = [recognizer locationInView:self.controlsView];
    self.previousTouchLocation = self.initialTouchLocation;
}

- (void)handleContainfVolumeGestureChangedWithRecognizer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint currentTouchLocation = [recognizer locationInView:self.controlsView];
    CGFloat deltaY = currentTouchLocation.y - self.previousTouchLocation.y;
    CGFloat deltaX = currentTouchLocation.x - self.previousTouchLocation.x;
    CGFloat offset;
    CGFloat precent;
    
    if (self.panDirection == NGPanDirection_NONE) {
        if (ABS(deltaX)>ABS(deltaY) && ABS(deltaX)>kMinVideoChangeLength) {
            self.panDirection = NGPanDirection_LEFT;
            [self.controlsView.scrubberControl sendActionsForControlEvents:UIControlEventTouchDown];
        }
        if (ABS(deltaY)>ABS(deltaX) && ABS(deltaY)>kMinVolumeChangeLength) {
            self.panDirection = NGPanDirection_UP;
        }
    }
    
    if (self.panDirection == NGPanDirection_LEFT) {
        offset = deltaX;
        if (ABS(offset)<kMinVideoChangeLength) {
            return;
        }
        precent = offset/CGRectGetWidth(self.bounds);
        [self videoAddPercent:precent];
        
    }else if (self.panDirection == NGPanDirection_UP){
        offset = deltaY;
        if (ABS(offset)<kMinVolumeChangeLength) {
            return;
        }
        
        precent = offset/CGRectGetHeight(self.bounds);
        [self volumeAddPercent:precent];
    }
    
    
    self.previousTouchLocation = currentTouchLocation;
    
    
}

- (void)handleContainPanGestureEndedWithRecognizer:(UIPanGestureRecognizer *)recognizer
{
    if (self.panDirection == NGPanDirection_LEFT) {
        [self.controlsView.scrubberControl sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)setBrightness:(CGFloat)bright
{
    [[UIScreen mainScreen] setBrightness:bright];
}

- (CGFloat)systemBrightness
{
    return [UIScreen mainScreen].brightness;
}


- (void)setSystemVolume:(float)systemVolume {
    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    musicPlayer.volume = systemVolume;
}

- (float)systemVolume {
    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    return musicPlayer.volume;
}

- (void)volumeAddPercent:(CGFloat)precent{
    
    if (self.initialTouchLocation.x < CGRectGetWidth(self.bounds)/2) {
        
        CGFloat curBrightness = [self systemBrightness] - precent;
        curBrightness = MAX(0,MIN(curBrightness, 1.0));
        [self setBrightness:curBrightness];
        
    }else{
    
        CGFloat curVolume = [self systemVolume] - precent;
        curVolume = MAX(0,MIN(curVolume, 1.0));
        [self setSystemVolume:curVolume];
    }
}



- (void)videoAddPercent:(CGFloat)percent{
    
    
    NGScrubber *slider = self.controlsView.scrubberControl;
    
    float value = slider.value;
    float addValue = 0;
    
    
    addValue = percent*MIN(slider.maximumValue, kMaxTimeInterVal) ;
    value = value+addValue;
    value = MIN(slider.maximumValue,MAX(value, 0));
    self.controlsView.scrubberControl.value = value;
    [self.controlsView.scrubberControl sendActionsForControlEvents:UIControlEventValueChanged];
    
}



- (void)handlePlayButtonPress:(id)playControl {
    [self.delegate moviePlayerControl:playControl didPerformAction:NGMoviePlayerControlActionStartToPlay];
}

- (void)handlebackButtonPress:(id)playControl{
    [self.delegate moviePlayerControl:playControl didPerformAction:NGMoviePlayerControlActionToggleZoomState];
}

- (void)volumeControlValueChanged:(id)sender {
    [self restartFadeOutControlsViewTimer];
}

@end
