//
//  FirstViewController.h
//  M-Cut
//
//  Created by Crab shell on 12/21/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCollectionView.h"
#import "RNGridMenu.h"
#import "Reachability.h"
#import "UserEntity.h"
#import "UIViewExt.h"
#import "HomepageVideoOrder.h"
#import "APPUserPrefs.h"
//#import "HomeCollectionViewCell.h"
#import "SCNavTabBarController.h"
#import "HomeShowViewC.h"

@interface HomeViewController : UIViewController<UICollectionViewDelegateFlowLayout,RNGridMenuDelegate,SelectedVideo>
{
    //九宫格的宽
    CGFloat cellWidth;
    CGFloat cellHeight;
    CGFloat margin;
    //UIView *customLoginAlertView;
    UIView *shadowBgView;
    SCNavTabBarController *topTabBar;
}
@property (strong,nonatomic) NSMutableArray *imageLibraryArra;
@property (nonatomic) NSInteger numberOfArra;
@property (strong,nonatomic) NSMutableArray *videoID;
@property (strong,nonatomic) NSMutableArray *videoName;
@property (strong,nonatomic) NSMutableArray *ownerID;
@property (strong,nonatomic) NSMutableArray *ownerName;
@property (strong,nonatomic) NSMutableArray *ownerAcatar;
@property (strong,nonatomic) NSMutableArray *videoLabelName;
@property (strong,nonatomic) NSMutableArray *videoCreateTime;
@property (strong,nonatomic) NSMutableArray *videoThumbnailUrl;
@property (strong,nonatomic) NSMutableArray *videoReferenceUrl;
@property (strong,nonatomic) NSMutableArray *videoNumberOfPraise;
@property (strong,nonatomic) NSMutableArray *videoNumberOfShare;
@property (strong,nonatomic) NSMutableArray *videoNumberOfFavorite;
@property (strong,nonatomic) NSMutableArray *videoNumberOfComment;
@property (strong,nonatomic) NSMutableArray *videoCollectStatus;
@property (nonatomic,strong) NSMutableArray *szImage;
@property (nonatomic,strong) NSMutableArray *ownerAcatarArr;
@property (nonatomic,strong) NSMutableArray *videoLabelArr;
@property (retain, nonatomic) IBOutlet HomeCollectionView *homeCollectionView;
@property (strong,nonatomic) NSMutableArray *videoLabelID;
@property (nonatomic) int integers;
@property (retain, nonatomic) UIActivityIndicatorView *activityIndicat;
@property (retain, nonatomic) UIWindow *customWindow;
@property (weak, nonatomic) IBOutlet UIView *topButton;


@end

