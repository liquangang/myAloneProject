//
//  NGMoviePlayerDelegate.h
//  NGMoviePlayer
//
//  Created by Philip Messlehner on 06.03.12.
//  Copyright (c) 2012 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "NGMoviePlayerControlStyle.h"
#import <AVFoundation/AVFoundation.h>

@class NGMoviePlayer;


@protocol NGMoviePlayerDelegate <NSObject>

@optional

- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didStartPlaybackOfURL:(NSURL *)URL;
- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didFailToLoadURL:(NSURL *)URL;
- (void)moviePlayer:(NGMoviePlayer *)moviePlayer hasProtectedContentURL:(NSURL *)URL;
- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didFinishPlaybackOfURL:(NSURL *)URL;
- (void)moviePlayerDidPausePlayback:(NGMoviePlayer *)moviePlayer;
- (void)moviePlayerDidResumePlayback:(NGMoviePlayer *)moviePlayer;

- (void)moviePlayerDidBeginScrubbing:(NGMoviePlayer *)moviePlayer;
- (void)moviePlayerDidEndScrubbing:(NGMoviePlayer *)moviePlayer;

- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didDownloadURL:(NSURL *)URL;
- (BOOL)moviePlayer:(NGMoviePlayer *)moviePlayer addFavoriteURL:(NSURL *)URL;

- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didChangeStatus:(AVPlayerStatus)playerStatus;
- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didChangePlaybackRate:(float)rate;
- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didChangeAirPlayActive:(BOOL)airPlayVideoActive;
- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didChangeControlStyle:(NGMoviePlayerControlStyle)controlStyle;
- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didUpdateCurrentTime:(NSTimeInterval)currentTime;

- (void)moviePlayer:(NGMoviePlayer *)moviePlayer videoLevel:(NSInteger)level initialPlaybackTime:(NSTimeInterval)initialPlaybackTime;

@end


@protocol NGMoviePlayerDataSource <NSObject>

@optional
- (NSString *)moviePlayerVideoInitLevelTitle:(NGMoviePlayer *)moviePlayer;
- (NSArray *)moviePlayerVideoLevelTites:(NGMoviePlayer *)moviePlayer;

- (BOOL)moviePlayerVideoCanFavorite:(NGMoviePlayer *)moviePlayer;
- (BOOL)moviePlayerVideoHaveFavorite:(NGMoviePlayer *)moviePlayer;

- (BOOL)moviePlayerVideoCanDownload:(NGMoviePlayer *)moviePlayer;

- (NSInteger)moviePlayer:(NGMoviePlayer *)moviePlayer  numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)moviePlayer:(NGMoviePlayer *)moviePlayer tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)moviePlayer:(NGMoviePlayer *)moviePlayer tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)moviePlayer:(NGMoviePlayer *)moviePlayer tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;


@end


