//
//  PersonalMovieDetailPreviewViewController.h
//  M-Cut
//
//  Created by 刘海香 on 15/4/19.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"
#import "HomepageVideoOrder.h"
#import "APPUserPrefs.h"
#import "NGMoviePlayer.h"


@interface PersonalMovieDetailPreviewViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate,NGMoviePlayerDelegate, UMSocialUIDelegate>
{
    UIActionSheet *_actionSheet;
}
@property (retain,nonatomic) IBOutlet UIButton *ownerAcatarButton;
@property (retain,nonatomic) IBOutlet UILabel *videoNameLabel;
@property (retain,nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (retain,nonatomic) IBOutlet UILabel *videoCreateTimeLabel;
@property (retain,nonatomic) IBOutlet UIImageView *videoThumbnailUrlImage;
@property (retain, nonatomic) IBOutlet UILabel *personalizedSignatureLabel;
@property (retain,nonatomic) IBOutlet UILabel *videoNumberOfPraiseLabel;
@property (retain,nonatomic) IBOutlet UILabel *videoNumberOfShareLabel;
@property (retain,nonatomic) IBOutlet UIButton *videoCollectStatusButton;
@property (retain,nonatomic) IBOutlet UIButton *changVideoShare;

@property (retain,nonatomic) NGMoviePlayer *player;
@property (nonatomic,strong) UIView *containerView;


@end
