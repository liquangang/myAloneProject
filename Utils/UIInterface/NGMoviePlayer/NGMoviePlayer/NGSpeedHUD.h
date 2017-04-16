//
//  NGSpeedHUD.h
//  NGMoviePlayer
//
//  Created by Kyle on 14-6-14.
//  Copyright (c) 2014年 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NGSpeedHUD : UIView


@property (nonatomic, assign) BOOL speedUp;
@property (nonatomic, assign) NSTimeInterval totalTime;
@property (nonatomic, assign) NSTimeInterval currentTime;

@end
