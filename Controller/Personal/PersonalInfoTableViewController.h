//
//  PersonalInfoTableViewController.h
//  M-Cut
//
//  Created by 刘海香 on 15/1/28.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"
#import "PersonalVideoOrder.h"
//#import "NickNameViewController.h"
//#import "NickNameViewController.h"
#import "SexViewController.h"
#import "PersonalSignatureViewController.h"
#import "DistrictTableViewController.h"
#import "PersonalInformationSet.h"
#import "APPUserPrefs.h"
#import "PersonalInfoHeadPortraitTableViewCell.h"
#import "PersonalInfoRightTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DateSelecterViewController.h"
#import "EmailViewController.h"

typedef void(^TabVCellAccessoryTypeBlock)(UITableViewCellAccessoryType accessoryTy);


@interface PersonalInfoTableViewController : UITableViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIActionSheet *photoActionSheet;
    PersonalInfoHeadPortraitTableViewCell *cell_headPortrait;
    PersonalInfoRightTableViewCell *cell_right;
    IBOutlet UITableView *personalInfoTabV;
    PersonalInformationSet *personalInformationSet;
}

@property (nonatomic,copy) TabVCellAccessoryTypeBlock tbVCellAccessoryTypeBlock;

@property (strong, nonatomic) NSArray *personInfoArra;
@property (strong,nonatomic) UIButton *userHeadPortraitButton;

@property (strong,nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (strong,nonatomic) IBOutlet UIImageView *userSexImage;
@property (strong,nonatomic) IBOutlet UILabel *userCelebratedDictumLabel;



//@property (strong,nonatomic) OSSClientZhang *client;//上传头像
@property (strong,nonatomic) NSString *bucketName;
@property (strong,nonatomic) NSString *prefix;
@property (strong,nonatomic) NSString *cloudId;
@property (strong,nonatomic) NSString *cloudKey;
@property (strong,nonatomic) NSString *endPoint;
@property (strong,nonatomic) NSMutableArray *buckets;
@property (strong,nonatomic) NSMutableArray *objects;
@property (strong,nonatomic) NSMutableArray *folders;
@property (strong,nonatomic) NSMutableArray *selectedobjs;
@property(strong,nonatomic) NSMutableArray *objectsURL;


@end