//
//  UploadImageManager.m
//  M-Cut
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "UploadImageManager.h"
#import "UploadMaterialModel.h"
#import "OSSManager.h"

@interface UploadImageManager ()
@property (nonatomic, strong) UploadMaterialModel *currentUploadModel;
@end

@implementation UploadImageManager

#pragma mark - interface

static UploadImageManager *instance;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone] ;
    });
    return instance;
}

- (id)copyWithZone:(NSZone *)zone{
    return instance;
}

- (void)uploadSuccess{
    
    //首先修改第一个元素的状态，防止继续上传，然后重新读取数据源，从头开始
    self.currentUploadModel.status = uploadFinish;
    [[VideoDBOperation Singleton] updateDataWithModel:self.currentUploadModel];
    [self startUploadImage];
    
    [CustomeClass mainQueue:^{
        
        //发出上传成功的通知
        POSTNOTI(cloudImageUploadSuccess, @{});
    }];
}

- (void)startUploadImage{
    self.uploadMuArray = nil;
    
    if (self.uploadMuArray.count > 0) {
        
        //从第一个开始新增文件申请
        WEAKSELF2
        UploadMaterialModel *uploadModel;
        for (UploadMaterialModel *uploadMaterialModel in self.uploadMuArray) {
            
            if (uploadMaterialModel.status == uploadStart) {
                uploadModel = uploadMaterialModel;
                self.currentUploadModel = uploadMaterialModel;
                break;
            }
        }
        
        if (!uploadModel) {
            return;
        }
        
        [SINGLETON(AFNetWorkManager) addNewFileWithFileName:uploadModel.fileName FileType:uploadModel.fileType Etag:[CustomeClass md5Str:uploadModel.fileName] CreateTime:uploadModel.createTime ContentSize:uploadModel.contentSize FilePath:[NSString stringWithFormat:@"/%@", uploadModel.yunFileName] Latitude:@"113.11" Longtitude:@"62.42" HorizontalAccuracy:@"0.5" LabelArray:@[@{@"label":@""}] Progress:^(NSProgress *progress) {
            NSLog(@"%@", progress);
        } Success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@", responseObject);
            [weakSelf startUploadDataWithDic:responseObject Model:uploadModel];
        } Fail:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"%@", error);
        }];
    }
}

- (void)startUploadDataWithDic:(NSDictionary *)fileInfoDic Model:(UploadMaterialModel *)uploadModel{
    
    [SINGLETON(OSSManager) resumableUploadWithFilePath:[NSString stringWithFormat:@"%@/%@", [CustomeClass createFileAtSandboxWithName:uploadImageFileName], uploadModel.fileName] ObjectKey:[NSString stringWithFormat:@"%@/%@", fileInfoDic[@"url"][@"prefix"], fileInfoDic[@"url"][@"filename"]] AccessKey:fileInfoDic[@"oss_ak"][@"access_key"] SecretKey:fileInfoDic[@"oss_ak"][@"access_secret_key"] Token:fileInfoDic[@"oss_ak"][@"access_token"] CustomeProperty:fileInfoDic[@"customeProperty"] Complete:^{
        WEAKSELF2
        [weakSelf uploadSuccess];
    }];
}

#pragma mark - getter

- (NSMutableArray *)uploadMuArray{
    if (!_uploadMuArray) {
        _uploadMuArray = [[NSMutableArray alloc] initWithArray:[[VideoDBOperation Singleton] selectUploadMaterialData]];
    }
    return _uploadMuArray;
}

@end
