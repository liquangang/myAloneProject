//
//  UploadMaterialModel.h
//  M-Cut
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoDBOperation.h"

typedef NS_ENUM(NSInteger, UploadMaterialStatus){
    uploadFinish,
    uploadStart
};

@interface UploadMaterialModel : NSObject
@property (nonatomic, copy) NSString *assetURL;
@property (nonatomic, copy) NSString *localURL;
@property (nonatomic, assign) UploadMaterialStatus status;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *contentSize;
@property (nonatomic, copy) NSString *fileName; //phasset获得的那个filename
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *yunFileName;
@property (nonatomic, copy) NSString *fileType;

+ (UploadMaterialModel *)getModelWithResult:(FMResultSet *)result;
@end
