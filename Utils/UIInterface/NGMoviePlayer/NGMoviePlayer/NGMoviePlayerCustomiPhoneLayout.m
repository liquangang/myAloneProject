//
//  NGMoviePlayerCustomiPhoneLayout.m
//  NGMoviePlayer
//
//  Created by Kyle on 14-6-11.
//  Copyright (c) 2014年 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "NGMoviePlayerCustomiPhoneLayout.h"
#import "NGScrubber.h"
#import "NGVolumeControl.h"
#import "NGMoviePlayer.h"
#import "NGMoviePlayerView.h"

#define kMinWidthToDisplaySkipButtons          420.f
#define kControlWidth                          (UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPhone ? 44.f : 50.f)

#define kPlayWidth 44
#define kPlayHeigh 44

#define kAboutWidth 50
#define kAboutHeight 30


@interface NGMoviePlayerCustomiPhoneLayout () {
    NSMutableArray *_topControlsButtons;
}

@property (nonatomic, readonly) UIImage *bottomControlFullscreenImage;

@end

@implementation NGMoviePlayerCustomiPhoneLayout

@synthesize bottomControlFullscreenImage = _bottomControlFullscreenImage;

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)init {
    if ((self = [super init])) {
        _scrubberFillColor = [UIColor grayColor];
        _minWidthToDisplaySkipButtons = kMinWidthToDisplaySkipButtons;
        
        _topControlsButtons = [NSMutableArray array];
        _topControlsViewAlignment = NGMoviePlayerControlViewTopControlsViewAlignmentCenter;
        _zoomOutButtonPosition = NGMoviePlayerControlViewZoomOutButtonPositionRight;
        _topControlsViewButtonPadding = 35.f;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayerLayout
////////////////////////////////////////////////////////////////////////

- (void)customizeTopControlsViewWithControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    // do nothing special here
}

- (void)customizeBottomControlsViewWithControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    // update styling of bottom controls view
    UIImageView *bottomControlsImageView = (UIImageView *)self.bottomControlsView;
    
    if (controlStyle == NGMoviePlayerControlStyleFullscreen) {
        bottomControlsImageView.backgroundColor = [UIColor clearColor];
        _bottomControlFullscreenImage = nil;
        bottomControlsImageView.image = self.bottomControlFullscreenImage;
    } else if (controlStyle == NGMoviePlayerControlStyleInline) {
        bottomControlsImageView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.6f];
        bottomControlsImageView.image = nil;
    }
}

- (void)customizeControlsWithControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    [self setupScrubber:self.scrubberControl controlStyle:controlStyle];
}

- (void)layoutTopControlsViewWithControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    CGFloat topControlsViewTop = 0.f;
    
    CGSize windowSize = self.moviePlayer.view.window.bounds.size;
    CGSize playerViewSize = self.moviePlayer.view.frame.size;
    CGSize playerViewInvertedSize = CGSizeMake(playerViewSize.height, playerViewSize.width);
    if (CGSizeEqualToSize(windowSize, playerViewSize) || CGSizeEqualToSize(windowSize, playerViewInvertedSize)) {
        topControlsViewTop = 20.f;
    }
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    topControlsViewTop = 0.0f;
#endif
    
    self.topControlsView.frame = CGRectMake(0.f,
                                            topControlsViewTop,
                                            self.width,
                                            [self topControlsViewHeightForControlStyle:controlStyle]);
    
    if (self.topControlsViewAlignment == NGMoviePlayerControlViewTopControlsViewAlignmentCenter) {
        // center custom controls in top container
        self.topControlsContainerView.frame = CGRectMake(MAX((self.topControlsView.frame.size.width - self.topControlsContainerView.frame.size.width)/2.f, 0.f),
                                                         topControlsViewTop,
                                                         self.topControlsContainerView.frame.size.width,
                                                         [self topControlsViewHeightForControlStyle:controlStyle]);
    } else {
        self.topControlsContainerView.frame = CGRectMake(2.f,
                                                         topControlsViewTop,
                                                         self.topControlsContainerView.frame.size.width,
                                                         [self topControlsViewHeightForControlStyle:controlStyle]);
    }
}

- (void)layoutBottomControlsViewWithControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    CGFloat controlsViewHeight = [self bottomControlsViewHeightForControlStyle:controlStyle];
    CGFloat offset = (self.controlStyle == NGMoviePlayerControlStyleFullscreen ? 0.f : 0.f);
    
    self.bottomControlsView.frame = CGRectMake(offset,
                                               self.height-controlsViewHeight,
                                               self.width - 2.f*offset,
                                               controlsViewHeight);
}

- (void)layoutControlsWithControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    if (controlStyle == NGMoviePlayerControlStyleInline) {
        [self layoutSubviewsForControlStyleInline];
    } else {
        [self layoutSubviewsForControlStyleFullscreen];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - NGMoviePlayerDefaultLayout
////////////////////////////////////////////////////////////////////////

- (void)setScrubberFillColor:(UIColor *)scrubberFillColor {
    self.scrubberControl.fillColor = scrubberFillColor;
    self.volumeControl.minimumTrackColor = scrubberFillColor;
    
    // customize scrubber with new color
    [self updateControlStyle:self.controlStyle];
}

- (void)setScrubberHidden:(BOOL)scrubberHidden {
    if (scrubberHidden != _scrubberHidden) {
        _scrubberHidden = scrubberHidden;
        
        [self invalidateLayout];
    }
}

- (void)setSkipButtonsHidden:(BOOL)skipButtonsHidden {
    if (skipButtonsHidden != _skipButtonsHidden) {
        _skipButtonsHidden = skipButtonsHidden;
        
        [self invalidateLayout];
    }
}

- (void)addTopControlsViewButton:(UIButton *)button {
    CGFloat maxX = 0.f;
    CGFloat height = [self topControlsViewHeightForControlStyle:self.controlStyle];
    
    for (UIView *subview in self.topControlsContainerView.subviews) {
        maxX = MAX(subview.frame.origin.x + subview.frame.size.width, maxX);
    }
    
    if (maxX > 0.f) {
        maxX += self.topControlsViewButtonPadding;
    }
    
    button.frame = CGRectMake(maxX, 0.f, button.frame.size.width, height);
    [self.topControlsContainerView addSubview:button];
    self.topControlsContainerView.frame = CGRectMake(0.f, 0.f, maxX + button.frame.size.width, height);
    
    [_topControlsButtons addObject:button];
}

- (void)setTopControlsViewButtonPadding:(CGFloat)topControlsViewButtonPadding {
    if (topControlsViewButtonPadding != _topControlsViewButtonPadding) {
        _topControlsViewButtonPadding = topControlsViewButtonPadding;
        
        [self layoutTopControlsViewButtons];
    }
}

- (CGFloat)topControlsViewHeightForControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    if (controlStyle == NGMoviePlayerControlStyleFullscreen)  {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
        return 64;
#else
        return 44;
#endif
        
    }else{
        
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
        return 0;
#else
        return 0;
#endif
        
    }
    
//    return [self bottomControlsViewHeightForControlStyle:NGMoviePlayerControlStyleInline];
}

- (CGFloat)bottomControlsViewHeightForControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    if (controlStyle == NGMoviePlayerControlStyleFullscreen) {
        return 70.f;
    } else {
        return 40.f;
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Private
////////////////////////////////////////////////////////////////////////

- (void)setupScrubber:(NGScrubber *)scrubber controlStyle:(NGMoviePlayerControlStyle)controlStyle {
    CGFloat height = 20.f;
    CGFloat radius = 4.f;
    
    if (controlStyle == NGMoviePlayerControlStyleFullscreen) {
        height = 8.f;
        radius = 3.f;
        [scrubber setThumbImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/player_slider_thumb"]
                       forState:UIControlStateNormal];
    } else {
        height = 5.f;
        radius = 2.f;
        [scrubber setThumbImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/scrubberKnob"]
                       forState:UIControlStateNormal];
    }
    
    //Build a roundedRect of appropriate size at origin 0,0
    UIBezierPath* roundedRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.f, 0.f, height, height) cornerRadius:radius];
    //Color for Stroke
    CGColorRef strokeColor = [[UIColor blackColor] CGColor];
    
    // create minimum track image
    UIGraphicsBeginImageContext(CGSizeMake(height, height));
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //Set the fill color
    CGContextSetFillColorWithColor(currentContext, [UIColor colorWithRed:230.0f/255.0f green:153.0f/255.0f blue:40.0f/255.0f alpha:1.0f].CGColor);
    //Fill the color
    [roundedRect fill];
    //Draw stroke
    CGContextSetStrokeColorWithColor(currentContext, strokeColor);
    [roundedRect stroke];
    //Snap the picture and close the context
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //generate stretchable Image
    if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius)];
    } else {
        image = [image stretchableImageWithLeftCapWidth:radius topCapHeight:radius];
    }
    [scrubber setMinimumTrackImage:image forState:UIControlStateNormal];
    
    // create maximum track image
    UIGraphicsBeginImageContext(CGSizeMake(height, height));
    currentContext = UIGraphicsGetCurrentContext();
    //Set the fill color
    CGContextSetFillColorWithColor(currentContext, [UIColor colorWithRed:73.0f/255.0f green:73.0f/255.0f blue:73.0f/255.0f alpha:.6f].CGColor);
    //Fill the color
    [roundedRect fill];
    //Draw stroke
    CGContextSetStrokeColorWithColor(currentContext, strokeColor);
    [roundedRect stroke];
    //Snap the picture and close the context
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //generate stretchable Image
    if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(radius, radius, radius, radius)];
    } else {
        image = [image stretchableImageWithLeftCapWidth:radius topCapHeight:radius];
    }
    [scrubber setMaximumTrackImage:image forState:UIControlStateNormal];
    
    if (controlStyle == NGMoviePlayerControlStyleFullscreen) {
        scrubber.playableValueRoundedRectRadius = radius;
    } else {
        scrubber.playableValueRoundedRectRadius = 2.f;
    }
    
    // force re-draw of playable value of scrubber
    scrubber.playableValue = scrubber.playableValue;
}

- (UIImage *)bottomControlFullscreenImage {
    if (_bottomControlFullscreenImage == nil) {
        _bottomControlFullscreenImage = [UIImage imageNamed:@"NGMoviePlayer.bundle/player_bottom_bg"];
        
        // make it a resizable image
        if ([_bottomControlFullscreenImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
            _bottomControlFullscreenImage = [_bottomControlFullscreenImage resizableImageWithCapInsets:UIEdgeInsetsMake(48.f, 15.f, 46.f, 15.f)];
        } else {
            _bottomControlFullscreenImage = [_bottomControlFullscreenImage stretchableImageWithLeftCapWidth:15 topCapHeight:47];
        }
    }
    
    return _bottomControlFullscreenImage;
}

- (void)layoutSubviewsForControlStyleInline {
    CGFloat width = self.width;
    CGFloat controlsViewHeight = [self bottomControlsViewHeightForControlStyle:self.controlStyle];
    CGFloat leftEdge = 0.f;
    CGFloat rightEdge = width;   // the right edge of the last positioned button in the bottom controls view (starting from right)
    
    // skip buttons always hidden in inline mode
    self.rewindControl.hidden = YES;
    self.forwardControl.hidden = YES;
    
    // play button always on the left
    self.playPauseControl.frame = CGRectMake(0.f, 0.f, controlsViewHeight, controlsViewHeight);
    leftEdge = self.playPauseControl.frame.origin.x + self.playPauseControl.frame.size.width;
    
    [self.bottomControlsView addSubview:self.zoomControl];
    // volume control and zoom button are always on the right
    self.zoomControl.frame = CGRectMake(width-kControlWidth, 0.f, kControlWidth, controlsViewHeight);
    [self.zoomControl setImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/minniplayer_icon_maxsize"] forState:UIControlStateNormal];
    UIImage *normalImage = [UIImage imageNamed:@"NGMoviePlayer.bundle/player_episode_normal"];
    if ([normalImage respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
        normalImage = [normalImage resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    }else{
        normalImage = [normalImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    }
    [self.playPauseControl setBackgroundImage:normalImage forState:UIControlStateNormal];

    [self.zoomControl setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    self.titleLabel.frame = CGRectZero;
    
    self.volumeControl.frame = CGRectMake(rightEdge-kControlWidth, self.bottomControlsView.frame.origin.y, kControlWidth, controlsViewHeight);
    self.volumeControl.hidden = TRUE;
    rightEdge = self.volumeControl.frame.origin.x;
    
    // we always position the airplay button, but only update the left edge when the button is visible
    // this is a workaround for a layout bug I can't remember
    self.airPlayControlContainer.frame = CGRectMake(rightEdge-kControlWidth, 0.f, kControlWidth, controlsViewHeight);
    if (self.airPlayControlVisible) {
        rightEdge = self.airPlayControlContainer.frame.origin.x;
    }
    
    self.currentTimeLabel.frame = CGRectMake(leftEdge, 0.f, 55.f, controlsViewHeight);
    self.currentTimeLabel.textAlignment = UITextAlignmentCenter;
    leftEdge = self.currentTimeLabel.frame.origin.x + self.currentTimeLabel.frame.size.width;
    
    self.remainingTimeLabel.frame = CGRectMake(rightEdge-60.f, 0.f, 60.f, controlsViewHeight);
    self.remainingTimeLabel.textAlignment = UITextAlignmentCenter;
    rightEdge = self.remainingTimeLabel.frame.origin.x;
    
    // scrubber uses remaining width
    self.scrubberControl.frame = CGRectMake(leftEdge, 0.f, rightEdge - leftEdge, controlsViewHeight);
}

- (void)layoutSubviewsForControlStyleFullscreen {
    BOOL displaySkipButtons = !self.skipButtonsHidden && !self.playingLivestream && (self.bottomControlsView.frame.size.width > self.minWidthToDisplaySkipButtons);
    displaySkipButtons = FALSE;
    CGFloat width = self.bottomControlsView.bounds.size.width;
    CGFloat height = self.bottomControlsView.bounds.size.height;
    CGFloat outerPadding = UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPhone ? 5.f : 10.f;
    CGFloat controlWidth = UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPhone ? 44.f : 50.f;
    CGFloat offset = UI_USER_INTERFACE_IDIOM()  == UIUserInterfaceIdiomPhone ? 54.f : 66.f;
    CGFloat controlHeight = 44.f;
    CGFloat topY = 2.f;
    
    // zoom button can be left or right
    UIImage *zoomButtonImage = [UIImage imageNamed:@"NGMoviePlayer.bundle/fullback_normal"];
    UIImage *zoomButtonHightImage = [UIImage imageNamed:@"NGMoviePlayer.bundle/fullback_down"];
    CGFloat zoomButtonWidth = MAX(zoomButtonImage.size.width, 50.f);
    [self.zoomControl setImage:zoomButtonImage forState:UIControlStateNormal];
    [self.zoomControl setImage:zoomButtonHightImage forState:UIControlStateHighlighted];
    [self.zoomControl setBackgroundImage:nil forState:UIControlStateNormal];
    
    CGFloat offY = 0.0f;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    offY = 20.0f;
#endif
    
    [self.topControlsView addSubview:self.zoomControl];
    
    if (self.zoomOutButtonPosition == NGMoviePlayerControlViewZoomOutButtonPositionLeft) {
        self.zoomControl.frame = CGRectMake(0.f, offY, zoomButtonWidth, 44);
    } else {
        self.zoomControl.frame = CGRectMake(0.f, offY, zoomButtonWidth, 44);
//        self.zoomControl.frame = CGRectMake(self.width - zoomButtonWidth, 0.f, zoomButtonWidth, self.topControlsView.bounds.size.height);
    }
    
    if (self.favoriteShow) {
        self.favoriteControl.frame = CGRectMake(width-40, offY+10, 23, 23);
    }else{
        self.favoriteControl.frame = CGRectMake(width-40, offY+10, 0, 0);
    }
    
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.zoomControl.frame)+10, offY, CGRectGetMinX(self.favoriteControl.frame)-CGRectGetMaxX(self.zoomControl.frame)-20, 44);
    
    
    // play/skip segment centered in first row
    self.playPauseControl.frame = CGRectMake(5, CGRectGetHeight(self.bottomControlsView.frame)-5-kPlayHeigh, kPlayWidth, kPlayHeigh);
    self.rewindControl.frame = CGRectOffset(self.playPauseControl.frame, -offset, 0.f);
    self.forwardControl.frame = CGRectOffset(self.playPauseControl.frame, offset, 0.f);
    self.rewindControl.hidden = !displaySkipButtons;
    self.forwardControl.hidden = !displaySkipButtons;
    
    // volume right-aligned in first row
    self.volumeControl.frame = CGRectMake(width + self.bottomControlsView.frame.origin.x - controlWidth - outerPadding, self.bottomControlsView.frame.origin.y + topY, controlWidth, controlHeight);
    self.volumeControl.hidden = YES;
    // airplay left-aligned
    
    if (self.relationShow) {
        
        self.relationCotrol.frame = CGRectMake(width-kAboutWidth-10, height-kAboutHeight-10, kAboutWidth, kAboutHeight);
    }else{
        self.relationCotrol.frame = CGRectMake(width, height-kAboutHeight-10, 0, 0);
    }
    
    if (self.levelShow) {
        self.levelControl.frame = CGRectMake(CGRectGetMinX(self.relationCotrol.frame)-kAboutWidth-10, CGRectGetMinY(self.relationCotrol.frame), kAboutWidth, kAboutHeight);
    }else{
         self.levelControl.frame = CGRectMake(CGRectGetMinX(self.relationCotrol.frame)-kAboutWidth-10, CGRectGetMinY(self.relationCotrol.frame), 0, 0);
    }
    
    if (self.downloadShow) {
        self.downloadControl.frame = CGRectMake(CGRectGetMinX(self.levelControl.frame)-kAboutWidth-10, CGRectGetMinY(self.relationCotrol.frame), kAboutWidth, kAboutHeight);

    }else{
        self.downloadControl.frame = CGRectMake(CGRectGetMinX(self.levelControl.frame)-kAboutWidth-10, CGRectGetMinY(self.relationCotrol.frame), 0, 0);
    }
    
    
    self.airPlayControlContainer.frame = CGRectMake(CGRectGetMinX(self.downloadControl.frame)-controlWidth-10, CGRectGetMinY(self.relationCotrol.frame), controlWidth, controlHeight);
    
    // next row of controls
    topY += controlHeight + 5.f;
    
    self.currentTimeLabel.frame = CGRectMake(0, 0, 65, 20.f);
    self.currentTimeLabel.textAlignment = UITextAlignmentCenter;
    self.remainingTimeLabel.frame = CGRectMake(width - 65.f, 0, 55.f, 20.f);
    self.remainingTimeLabel.textAlignment = UITextAlignmentCenter;
    self.scrubberControl.frame = CGRectMake(CGRectGetMaxX(self.currentTimeLabel.frame) + 4.f, 0, self.remainingTimeLabel.frame.origin.x - CGRectGetMaxX(self.currentTimeLabel.frame) - 8.f, 20.f);
}

- (void)layoutTopControlsViewButtons {
    CGFloat maxX = 0.f;
    CGFloat height = [self topControlsViewHeightForControlStyle:self.controlStyle];
    
    for (UIView *button in self.topControlsButtons) {
        button.frame = CGRectMake(maxX, 0.f, button.frame.size.width, height);
        maxX = button.frame.origin.x + button.frame.size.width + self.topControlsViewButtonPadding;
    }
    
    maxX -= self.topControlsViewButtonPadding;
    self.topControlsContainerView.frame = CGRectMake(0.f, 0.f, maxX, height);
}

@end
