//
//  MoviePlayerViewController.h
//  M-Cut
//
//  Created by Kyle on 14/12/22.
//  Copyright (c) 2014年 Crab movier. All rights reserved.
//

#import "MyMovieViewController.h"

@interface MoviePlayerViewController : MyMovieViewController


@property(strong,nonatomic)NSData* playdata;
@property(strong,nonatomic)NSString *playfilename;
@property(strong,nonatomic)NSString* playURL;
- (IBAction)returnToFirstPage:(id)sender;

@end
