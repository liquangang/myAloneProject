//
//  NGMoviePlayerControlViewDelegate.h
//  NGMoviePlayer
//
//  Created by Tretter Matthias on 13.03.12.
//  Copyright (c) 2012 NOUS Wissensmanagement GmbH. All rights reserved.
//

@class NGMoviePlayerControlView;

typedef enum {
    NGMoviePlayerControlActionStartToPlay,
    NGMoviePlayerControlActionTogglePlayPause,
    NGMoviePlayerControlActionToggleZoomState,
    NGMoviePlayerControlActionBeginSkippingBackwards,
    NGMoviePlayerControlActionBeginSkippingForwards,
    NGMoviePlayerControlActionBeginScrubbing,
    NGMoviePlayerControlActionScrubbingValueChanged,
    NGMoviePlayerControlActionEndScrubbing,
    NGMoviePlayerControlActionEndSkipping,
    NGMoviePlayerControlActionVolumeChanged,
    NGMoviePlayerControlActionWillShowControls,
    NGMoviePlayerControlActionDidShowControls,
    NGMoviePlayerControlActionWillHideControls,
    NGMoviePlayerControlActionDidHideControls,
    NGMoviePlayerControlActionAirPlayMenuActivated,
    NGMoviePlayerControlActionVideoLevelChanged,
    NGMoviePlayerControlActionRelateTableShow,
    NGMoviePlayerControlActionRelateTableScroll,
    NGMoviePlayerControlActionVideoFavorite,
    NGMoviePlayerControlActionVideoDownload,
} NGMoviePlayerControlAction;


@protocol NGMoviePlayerControlActionDelegate <NSObject>

- (void)moviePlayerControl:(id)control changeVideoLevelIndex:(NSInteger)index;
- (void)moviePlayerControl:(id)control didPerformAction:(NGMoviePlayerControlAction)action;
- (BOOL)moviePlayerControl:(id)control messageForAction:(NGMoviePlayerControlAction)action;


@end


@protocol NGMoviePlayerControlDataSource <NSObject>

- (NSString *)moviePlayerControlViewInitLevelTitle:(NGMoviePlayerControlView *)controlView;
- (NSArray *)moviePlayerControlViewLevelTites:(NGMoviePlayerControlView *)controlView;

- (BOOL )moviePlayerControlViewCanFavorited:(NGMoviePlayerControlView *)controlView;
- (BOOL )moviePlayerControlViewHaveFavorited:(NGMoviePlayerControlView *)controlView;

- (BOOL )moviePlayerControlViewCandownload:(NGMoviePlayerControlView *)controlView;

/**** relation table *****/

- (NSInteger)moviePlayerControlView:(NGMoviePlayerControlView *)controlView  numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)moviePlayerControlView:(NGMoviePlayerControlView *)controlView tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)moviePlayerControlView:(NGMoviePlayerControlView *)controlView tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)moviePlayerControlView:(NGMoviePlayerControlView *)controlView tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;


@end
