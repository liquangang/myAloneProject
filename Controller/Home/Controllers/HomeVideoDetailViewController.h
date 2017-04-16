//
//  HomeVideoDetailViewController.h
//  M-Cut
//
//  Created by 李亚飞 on 15/11/20.
//  Copyright © 2015年 Crab movier. All rights reserved.
//  替换以前的  MovieDetailPreviewViewController

#import <UIKit/UIKit.h>
#import "Video.h"
#import "HomepageVideoOrder.h"
#import "APPUserPrefs.h"
#import "NGMoviePlayer.h"
#import "CustomLoginAlertView.h"
#import "DescriptionViewController.h"
#import "UMSocial.h"

@interface HomeVideoDetailViewController : UIViewController <NGMoviePlayerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate,UMSocialUIDelegate>
{
    int clickedable;
    UIImageView *imgView;
    CustomLoginAlertView *customLoginAlertView;
    UIWindow *secondWindow;
}

@property (retain,nonatomic) IBOutlet UIButton *ownerAcatarButton;
@property (retain,nonatomic) IBOutlet UILabel *ownerNameLabel;
@property (retain,nonatomic) IBOutlet UILabel *videoCreateTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoPlayNumLabel;
@property (retain,nonatomic) IBOutlet UIButton *praiseButton;
@property (retain,nonatomic) IBOutlet UIImageView *videoThumbnailUrlImage;

@property (weak, nonatomic) IBOutlet UIView *videoView;

@property (retain,nonatomic) IBOutlet UIButton *collectionButton;
@property (retain,nonatomic) IBOutlet UILabel *videoNameLabel;
@property (retain,nonatomic) IBOutlet UILabel *personalizedSignatureLabel;
@property (retain,nonatomic) IBOutlet UILabel *videoNumberOfShareLabel;
@property (retain,nonatomic) IBOutlet UIButton *videoCollectStatusButton;
@property (retain,nonatomic) NGMoviePlayer *player;
@property (nonatomic,strong) UIView *containerView;
@property(nonatomic,retain) MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *videoStyle;

/**  从个人界面跳转 */
@property (assign, nonatomic) BOOL isTransFromPersonal;
/**  是否公开了当前视频 */
@property (copy, nonatomic) NSString *isVideoPublic;
@property (nonatomic, assign) int videoId;
@property (nonatomic, assign) BOOL isHiddenTabbar;
/** 是否从个人页面跳转（头像点击判断用）*/
@property (nonatomic, assign) BOOL isPushFromOtherVc;
@end