//
//  MovieDetailPreviewViewController.h
//  M-Cut
//
//  Created by 刘海香 on 15/2/1.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"
#import "HomepageVideoOrder.h"
#import "APPUserPrefs.h"
#import "NGMoviePlayer.h"
#import "CustomLoginAlertView.h"
#import "DescriptionViewController.h"
#import "UMSocial.h"
//#import "VKVideoPlayerViewController.h"

@interface MovieDetailPreviewViewController : UIViewController<NGMoviePlayerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UMSocialUIDelegate>
{
    int clickedable;
    UIImageView *imgView;
    CustomLoginAlertView *customLoginAlertView;
    UIWindow *secondWindow;
    UIActionSheet *actionsheet;
    int actionselect;
    int select;
}

@property (retain,nonatomic) IBOutlet UIButton *collectionButton;
@property (retain,nonatomic) IBOutlet UIButton *ownerAcatarButton;
@property (retain,nonatomic) IBOutlet UILabel *videoNameLabel;
@property (retain,nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (retain,nonatomic) IBOutlet UILabel *videoCreateTimeLabel;
@property (retain,nonatomic) IBOutlet UIImageView *videoThumbnailUrlImage;
@property (retain,nonatomic) IBOutlet UILabel *personalizedSignatureLabel;
@property (retain,nonatomic) IBOutlet UILabel *videoNumberOfPraiseLabel;
@property (retain,nonatomic) IBOutlet UILabel *videoNumberOfShareLabel;
@property (retain,nonatomic) IBOutlet UIButton *praiseButton;
@property (retain,nonatomic) IBOutlet UIButton *videoCollectStatusButton;
@property (retain,nonatomic) NGMoviePlayer *player;
@property(nonatomic,strong) VKVideoPlayer *vkplayer;
@property (nonatomic,strong) UIView *containerView;

@property (weak, nonatomic) IBOutlet UILabel *videoPlayNumLabel;

@end
