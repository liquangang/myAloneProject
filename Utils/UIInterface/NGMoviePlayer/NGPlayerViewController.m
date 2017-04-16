//
//  NGPlayerTableViewController.m
//  M-Cut
//
//  Created by Kyle on 15/1/18.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "NGPlayerViewController.h"
#import "NGMoviePlayer.h"
#import "Video.h"

@interface NGPlayerViewController ()<NGMoviePlayerDelegate,NGMoviePlayerDataSource>
{
    CGFloat _offset;
    CGFloat _usedDone;
    CGFloat _moviePlayerHeight;
    CGFloat _initPlaybackTime;
    BOOL _adShow;
}

@property (nonatomic, strong) NSString *strUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong,readwrite) NGMoviePlayer *moviePlayer;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *zoomBtn;

@end

@implementation NGPlayerViewController
@synthesize strUrl = _strUrl;
@synthesize name = _name;

- (id)initWithUrl:(NSString *)url title:(NSString *)name{
    self = [super init];
    if (self) {
        _strUrl = url;
        _name = name;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _strUrl = [Video Singleton].videoReferenceUrl;
    _name = [Video Singleton].videoName;
    
    _offset = 0;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        _offset = 20;
    }
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        _moviePlayerHeight = 432;
    }else{
        _moviePlayerHeight = 180;
    }
    
    self.moviePlayer = [[NGMoviePlayer alloc] init];
    self.moviePlayer.autostartWhenReady = YES;
    self.moviePlayer.dataSource = self;
    self.moviePlayer.delegate = self;
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, _offset, self.view.bounds.size.width,_moviePlayerHeight)];
    self.containerView.backgroundColor = [UIColor darkTextColor];
    
    [self.moviePlayer addToSuperview:self.containerView withFrame:self.containerView.bounds];
    
    
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(5,_offset+5, 49, 44)];
    
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/demoback"] forState:UIControlStateNormal];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/demobackdown"] forState:UIControlStateHighlighted];
    //    backBtn.showsTouchWhenHighlighted = YES;
    self.backBtn.backgroundColor = [UIColor clearColor];
    [self.backBtn addTarget:self action:@selector(backMethod:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    self.zoomBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.view.bounds)-40,CGRectGetMinY(self.backBtn.frame), 30, 30)];
//    
//    [self.zoomBtn setBackgroundImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/minniplayer_icon_maxsize"] forState:UIControlStateNormal];
//    [self.zoomBtn setBackgroundImage:[UIImage imageNamed:@"NGMoviePlayer.bundle/minniplayer_icon_maxsize"] forState:UIControlStateHighlighted];
//    //    backBtn.showsTouchWhenHighlighted = YES;
//    self.zoomBtn.backgroundColor = [UIColor clearColor];
//    [self.zoomBtn addTarget:self action:@selector(videoZoom:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.containerView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.zoomBtn];
    [self.moviePlayer setURL:[NSURL URLWithString:_strUrl] title:_name];
}

- (void)backMethod:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)videoZoom:(id)sender
{
    self.moviePlayer.view.controlStyle = NGMoviePlayerControlStyleFullscreen;
    [self moviePlayer:self.moviePlayer didChangeControlStyle:self.moviePlayer.view.controlStyle];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UIApplication sharedApplication] setStatusBarHidden:FALSE];
    [super viewWillDisappear:animated];
}

- (void)dealloc
{
    [self.moviePlayer dealloc];
    [super dealloc];
}


#pragma mark
#pragma mark NGMoviePlayerDelegate

- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didChangeControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    if (controlStyle == NGMoviePlayerControlStyleInline) {
        _usedDone = FALSE;
        [self updateToOrientation:UIDeviceOrientationPortrait];
    } else {
        [self updateToOrientation:UIDeviceOrientationLandscapeLeft];
        _usedDone = YES;
    }
}

- (void)updateToOrientation:(UIDeviceOrientation)orientation
{
    //    if (_usedDone) {
    //        return;
    //    }
    CGRect bounds = [[ UIScreen mainScreen ] bounds ];
    CGRect videoBounds = [[ UIScreen mainScreen ] bounds ];
    CGAffineTransform t;
    CGFloat r = 0;
    switch (orientation ) {
        case UIDeviceOrientationLandscapeRight:
            r = -(M_PI / 2);
            break;
        case UIDeviceOrientationLandscapeLeft:
            r  = M_PI / 2;
            break;
        default :
            break;
    }
    if( r != 0 ){
        self.navigationController.navigationBar.hidden = YES;
        CGSize sz = bounds.size;
        bounds.size.width = sz.height;
        bounds.size.height = sz.width;
        videoBounds = bounds;
        t = CGAffineTransformMakeRotation( r );
        self.backBtn.hidden = YES;
        self.zoomBtn.hidden = YES;
        UIApplication *application = [ UIApplication sharedApplication];
        self.containerView.bounds = videoBounds;
        self.containerView.center = CGPointMake(CGRectGetHeight(bounds)/2, CGRectGetWidth(bounds)/2-([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0f?64:0));
//        self.containerView.center = CGPointMake(CGRectGetHeight(bounds)/2, CGRectGetWidth(bounds)/2 - 64);
        [UIView animateWithDuration:[ application statusBarOrientationAnimationDuration ] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
            self.containerView.transform = t;
            //            self.containerView.bounds = videoBounds;
            //            self.containerView.center = CGPointMake(CGRectGetWidth(videoBounds)/2, CGRectGetHeight(videoBounds)/2);
            //            self.otherView.frame = CGRectMake(0, CGRectGetMaxY(self.containerView.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-CGRectGetMaxY(self.containerView.frame));
        }completion:^(BOOL finish){
            //            self.containerView.center = CGPointMake(CGRectGetWidth(videoBounds)/2, CGRectGetHeight(videoBounds)/2);
        }];
        [application setStatusBarOrientation:(UIInterfaceOrientation)orientation animated: YES ];
        //        videoBounds.origin.y = -120;
        //        videoBounds.origin.y = -140;
    }else{
        self.navigationController.navigationBar.hidden = NO;
        CGSize sz = bounds.size;
        bounds.size.width = sz.width;
        bounds.size.height = sz.height;
        videoBounds.size.width = sz.width;
        videoBounds.size.height = _moviePlayerHeight;
        //        self.wantsFullScreenLayout = NO;
        //        videoBounds.origin.y = 20;
        t = CGAffineTransformMakeRotation( r );
        UIApplication *application = [ UIApplication sharedApplication];
        self.containerView.bounds = videoBounds;
        self.containerView.center = CGPointMake(CGRectGetWidth(videoBounds)/2, CGRectGetHeight(videoBounds)/2+_offset);
        [UIView animateWithDuration:[application statusBarOrientationAnimationDuration ] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
            //            self.view.transform = t;
            //            self.view.bounds = bounds;
            //            self.view.center = CGPointMake(CGRectGetWidth(bounds)/2, CGRectGetHeight(bounds)/2);
            
            self.containerView.transform = t;
            
            //            self.otherView.frame = CGRectMake(0, CGRectGetMaxY(self.containerView.frame), CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-CGRectGetMaxY(self.containerView.frame));
        }completion:^(BOOL finish){
            //           self.containerView.frame = videoBounds;
            //            CGRect frme = self.backBtn.frame;
            //            frme.origin.y = 20;
            //            self.backBtn.frame = frme;
            self.backBtn.hidden = NO;
            self.zoomBtn.hidden = NO;
            //            [self setAdPosition:CGPointMake(AD_POS_CENTER, AD_POS_REWIND)];
        }];
        [application setStatusBarOrientation:(UIInterfaceOrientation)orientation animated: YES ];
    }
}

#pragma mark
#pragma mark NGMoviePlayerDataSource

- (NSArray *)moviePlayerVideoLevelTites:(NGMoviePlayer *)moviePlayer;
{
    return nil;
}

- (BOOL)moviePlayerVideoHaveFavorite:(NGMoviePlayer *)moviePlayer
{
    return FALSE;
}

- (BOOL)moviePlayerVideoCanFavorite:(NGMoviePlayer *)moviePlayer
{
    return FALSE;
}

- (BOOL)moviePlayerVideoCanDownload:(NGMoviePlayer *)moviePlayer
{
    return FALSE;
}

@end
