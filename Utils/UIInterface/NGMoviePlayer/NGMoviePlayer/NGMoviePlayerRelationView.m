//
//  NGMoviePlayerRelationView.m
//  NGMoviePlayer
//
//  Created by Kyle on 14-6-11.
//  Copyright (c) 2014年 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "NGMoviePlayerRelationView.h"


@interface NGMoviePlayerRelationView()


@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation NGMoviePlayerRelationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.image = [UIImage imageNamed:@"NGMoviePlayer.bundle/minniplayer_bg"];
        [self addSubview:imageView];
        
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.separatorColor = [UIColor clearColor];
        self.tableView.scrollsToTop = YES;
        self.tableView.showsHorizontalScrollIndicator = NO;
        self.tableView.allowsSelection = NO;
        self.tableView.allowsSelectionDuringEditing = NO;
        [self addSubview:self.tableView];
        
        
    }
    return self;
}



@end
