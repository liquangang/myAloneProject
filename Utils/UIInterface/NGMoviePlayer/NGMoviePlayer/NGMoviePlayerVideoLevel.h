//
//  NGMoviePlayerVideoLevel.h
//  NGMoviePlayer
//
//  Created by Kyle on 14-6-10.
//  Copyright (c) 2014年 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "NGWeak.h"

#define kLevelViewWidth 80

#define kLevelButtonHeight 30

#define kLevelButtomHeight 15

@protocol NGMoviePlayerVideoLevelDelegate;

@interface NGMoviePlayerVideoLevel : UIView

@property (nonatomic, ng_weak) id<NGMoviePlayerVideoLevelDelegate> delegate;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSString *levelName;

@end



@protocol NGMoviePlayerVideoLevelDelegate <NSObject>

- (void)moviePlayerVideoLevel:(NGMoviePlayerVideoLevel *)levelView seletedIdex:(NSInteger)index title:(NSString *)title;

@end