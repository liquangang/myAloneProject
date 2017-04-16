//
//  ClipseViewC.h
//  M-Cut
//
//  Created by Crab00 on 15/8/14.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NGMoviePlayer.h"
#import "SCNavTabBarController.h"
#import "SubtitleViewC.h"
#import "CaptionEditeNewViewController.h"

@interface ClipsViewC : UIViewController<SCViewChangeDelegate,EditSubtitleDeleget, LQGCaptionEditeViewControllerDelegate>
{
    NSString *EditSelfSubtitle;
}

@end
