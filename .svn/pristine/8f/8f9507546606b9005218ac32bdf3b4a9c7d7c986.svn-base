//
//  OSSFileManage.h
//  M-Cut
//
//  Created by zhangxiaotian on 15/3/29.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSS.h"
#import "MBProgressHUD.h"
#import "UserEntity.h"
#import "OssTemp.h"


@interface OSSFileManage : NSObject <OSSClientZhangDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,MBProgressHUDDelegate>
@property (strong,nonatomic) NSIndexPath *indexPaths;
@property (strong,nonatomic) OSSClientZhang *client;
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
