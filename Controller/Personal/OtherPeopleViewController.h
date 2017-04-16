//
//  OtherPeopleViewController.h
//  M-Cut
//
//  Created by 刘海香 on 15/4/20.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserEntity.h"
#import "UIImageView+WebCache.h"
#import "UIViewExt.h"
#import "APPUserPrefs.h"
#import "MyMovieCell2.h"
#import "MJRefresh.h"
#import "Video.h"
#import "PersonalInformationSet.h"
#import "Video2.h"

@interface OtherPeopleViewController : UIViewController<UICollectionViewDelegateFlowLayout>
{
    IBOutlet UITableView *personTabV;
    PersonalInformationSet *personalInformationSet;
}

@property (strong,nonatomic) NSMutableArray *imageLibraryArra;
@property (nonatomic) NSInteger numberOfArra;


@property (strong,nonatomic) NSString *userHeadPortraitUrl;
@property (strong,nonatomic) NSString *userNickName;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *userSex;
@property (strong,nonatomic) NSString *userRegion;
@property (strong,nonatomic) NSString *userCelebratedDictum;
@property (nonatomic) int userID;
@property (retain,nonatomic) UIButton *ownerAcatarButton;
@property (strong,nonatomic) UIButton *userHeadPortraitButton;
@property (strong,nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (strong,nonatomic) IBOutlet UIImageView *userSexImage;
@property (strong,nonatomic) IBOutlet UILabel *userCelebratedDictumLabel;
@property (strong,nonatomic) IBOutlet UIImageView *ownerAcatarImage;

/**  标记是否从评论界面跳转 */
@property (assign, nonatomic)  BOOL isTransFromCommentList;
/**  记录评论人的 customID */
@property (assign, nonatomic) int customID;
/**  记录  从定制界面 跳转 的图片url */
@property (copy, nonatomic) NSString *iconUrl;
@end

