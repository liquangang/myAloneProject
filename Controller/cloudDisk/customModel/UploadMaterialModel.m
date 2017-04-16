//
//  UploadMaterialModel.m
//  M-Cut
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "UploadMaterialModel.h"

@implementation UploadMaterialModel

+ (UploadMaterialModel *)getModelWithResult:(FMResultSet *)result{
    UploadMaterialModel *uploadMaterialModel = [UploadMaterialModel new];
    uploadMaterialModel.assetURL = [result stringForColumn:UPLOADMATERIALASSETURL];
    uploadMaterialModel.localURL = [result stringForColumn:UPLOADMATERIALLOCALURL];
    uploadMaterialModel.status = (UploadMaterialStatus)[[result stringForColumn:UPLOADMATERIALSTATUS] integerValue];
    uploadMaterialModel.createTime = [result stringForColumn:UPLOADMATERIALCREATETIME];
    uploadMaterialModel.contentSize = [result stringForColumn:UPLOADMATERIALCONTENTSIZE];
    uploadMaterialModel.fileName = [result stringForColumn:UPLOADMATERIALFILENAME];
    uploadMaterialModel.yunFileName = [result stringForColumn:UPLOADMATERIALYUNFILENAME];
    NSString *tempStr = [uploadMaterialModel.fileName componentsSeparatedByString:@"."][1];
    uploadMaterialModel.image = [CustomeClass getImageWithImageFile:[NSString stringWithFormat:@"%@/%@", [CustomeClass createFileAtSandboxWithName:uploadImageFileName], uploadMaterialModel.fileName]];
    
    if ([tempStr isEqualToString:@"JPG"]) {
        uploadMaterialModel.fileType = @"image/jpeg";
    }
    return uploadMaterialModel;
}

@end
