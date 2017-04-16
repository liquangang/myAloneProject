//
//  CloudFilesTableViewController.h
//  M-Cut
//
//  Created by Crab shell on 12/22/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "UserEntity.h"

@interface CloudFilesTableViewController : UITableViewController <UIActionSheetDelegate,UIImagePickerControllerDelegate,MBProgressHUDDelegate>
{
    NSIndexPath *_indexPath ;
}
@property (strong,nonatomic) NSString *bucketName;
@property (strong,nonatomic) NSString *prefix;
@property (strong,nonatomic) NSString *cloudId;
@property (strong,nonatomic) NSString *cloudKey;
@property (strong,nonatomic) NSString *endPoint;
@property (strong,nonatomic) NSMutableArray *buckets;
@property (strong,nonatomic) NSMutableArray *objects;
@property (strong,nonatomic) NSMutableArray *folders;
@property (strong,nonatomic) NSMutableArray *objectsst;
@property (strong,nonatomic) NSMutableArray *foldersst;

@end
