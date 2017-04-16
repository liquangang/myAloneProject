//
//  AddViewController.h
//  M-Cut
//
//  Created by Crab shell on 12/21/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "MBProgressHUD.h"
#import "UserEntity.h"
#import "APPUserPrefs.h"
#import "CloudFilesTableViewController.h"
#import "UIViewExt.h"
#import "LocalMaterialsViewController.h"
#import "CutProCollectionViewCell.h"
#import "UzysAssetsPickerController.h"
#import "NewAndDraftboxView.h"
#import "UINavigationController+SGProgress.h"
#import "MVRightOverSlider.h"


@interface CutProViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,MBProgressHUDDelegate,UICollectionViewDelegateFlowLayout,UIAlertViewDelegate,UzysAssetsPickerControllerDelegate,NewAndDraftboxViewDelegate,MVOverslider>
{
    NSInteger UserMaterialNum;
}
    

@property (assign,nonatomic) int isVideo;
@property (strong,nonatomic) UIImagePickerController *imagePicker;
@property (strong,nonatomic) NSMutableArray *deleteMaterialArray;
//@property (strong,nonatomic) NSString *orderCreateTime;

@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,retain) LocalMaterialsViewController *localMVC;
@property (retain,nonatomic) IBOutlet UIButton *cancelButton;
@property (nonatomic) BOOL bl;
@property (retain,nonatomic) IBOutlet UILongPressGestureRecognizer *longPressRecognizer;
@property (retain,nonatomic) CutProCollectionViewCell *cutProCollectionCell;
@property (retain,nonatomic) IBOutlet UIButton *makeSureButton;
@property (retain,nonatomic) IBOutlet UIButton *cloudButton;
@property (assign,nonatomic) BOOL isTrigger;

@property (assign,nonatomic) int sumcount;
@property (strong,nonatomic) NSString *locationDate;
//@property (nonatomic) int current;
@property (strong,nonatomic) NewNSOrderDetail *newsNSOrderDetail;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayerController;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *movieURL;
@property (copy, nonatomic) NSString *lastChosenMediaType;

@property (retain,nonatomic) NSMutableArray *imageOrigArray;

@property (retain,nonatomic) NSString *bucketName;
@property (retain,nonatomic) NSString *prefix;
@property (retain,nonatomic) NSString *cloudId;
@property (retain,nonatomic) NSString *cloudKey;
@property (retain,nonatomic) NSString *endPoint;
@property (retain,nonatomic) NSMutableArray *buckets;
@property (retain,nonatomic) NSMutableArray *objects;
@property (retain,nonatomic) NSMutableArray *folders;
@property (retain,nonatomic) NSMutableArray *selectedobjs;
@property (retain,nonatomic) NSMutableArray *objectsURL;

@property (retain,nonatomic) UIWindow *customWindow;
@property (weak, nonatomic) IBOutlet MVRightOverSlider *sliderbutton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic)float recommondvalue;//记录视频素材总时长
@property (weak, nonatomic) IBOutlet UILabel *labelRecommand;//显示拖动时长

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sliderWidthC;

/**  记录上次传递的进度 */
@property (assign, nonatomic) float lastProgress;

@end
