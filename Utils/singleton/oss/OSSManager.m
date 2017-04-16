//
//  OSSManager.m
//  M-Cut
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "OSSManager.h"
#import "UserEntity.h"
#import <AliyunOSSiOS/OSSService.h>

@interface OSSManager()
@property (nonatomic, strong) OSSClient *client;
@property (nonatomic, strong) id<OSSCredentialProvider> credential;
@property (nonatomic, strong) NSString *endPoint;
@end

@implementation OSSManager

#pragma mark - interface

static OSSManager *instance;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        // 打开调试log
        [OSSLog enableLog];
        
    }) ;
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone] ;
    }) ;
    return instance;
}

- (id)copyWithZone:(NSZone *)zone{
    return instance;
}

- (void)setCredentialWithAccessKey:(NSString *)accessKey SecretKey:(NSString *)secretKey Token:(NSString *)token{
    self.client.credentialProvider = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:accessKey secretKeyId:secretKey securityToken:token];
}

- (void)setCallbackWithBucketName:(NSString *)bucketName ObjectKey:(NSString *)objectKey Filepath:(NSString *)filepath CustomeProperty:(NSString *)customeProperty{
    
    //设置callback
    OSSPutObjectRequest * request = [OSSPutObjectRequest new];
    request.bucketName = bucketName;
    request.objectKey = objectKey;
    request.uploadingFileURL = [NSURL fileURLWithPath:filepath];
    
    // 设置回调参数
    request.callbackParam = @{
                              @"callbackUrl":@"http://59.110.5.216/index.php/Home/FileAccess/addfile",
                              @"callbackHost":@"oss-cn-beijing.aliyuncs.com",
                              @"callbackBody":@"{\"bucket\":${bucket},\"object\":${object},\"etag\":${etag},\"size\":${size},\"mimeType\":${mimeType},\"imageInfo.height\":${imageInfo.height},\"imageInfo.width\":${imageInfo.width},\"imageInfo.format\":${imageInfo.format},\"verify_json\":${x:verify_json}}",
                              @"callbackBodyType":@"application/json"
                              };
    
//    // 设置回调参数
//    request.callbackParam = @{
//                              @"callbackUrl":@"http://59.110.5.216/index.php/Home/FileAccess/addfile",
//                              @"callbackHost":@"oss-cn-beijing.aliyuncs.com",
//                              @"callbackBody":@"bucket=${bucket}&object=${object}&etag=${etag}&size=${size}&mimeType=${mimeType}&imageInfo.height=${imageInfo.height}&imageInfo.width=${imageInfo.width}&imageInfo.format=${imageInfo.format}&verify_json=${x:verify_json}",
//                              @"callbackBody":@"{\"bucket\":${bucket},\"object\":${object},\"etag\":${etag},\"size\":${size},\"mimeType\":${mimeType},\"imageInfo.height\":${imageInfo.height},\"imageInfo.width\":${imageInfo.width},\"imageInfo.format\":${imageInfo.format},\"verify_json\":${x:verify_json}}",
//                              @"callbackBodyType":@"application/json"
//                              };
    
    // 设置自定义变量
    request.callbackVar = @{
                            @"x:verify_json": customeProperty
                            };
    
    request.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
    };
    OSSTask * task = [self.client putObject:request];
    
    [task continueWithBlock:^id(OSSTask *task) {
        if (task.error) {
            OSSLogError(@"%@", task.error);
        } else {
            OSSPutObjectResult * result = task.result;
            NSLog(@"Result - requestId: %@, headerFields: %@, servercallback: %@",
                  result.requestId,
                  result.httpResponseHeaderFields,
                  result.serverReturnJsonString);
        }
        return nil;
    }];
}

// 断点续传
- (void)resumableUploadWithFilePath:(NSString *)filePath ObjectKey:(NSString *)objectKey AccessKey:(NSString *)accessKey SecretKey:(NSString *)secretKey Token:(NSString *)token CustomeProperty:(NSString *)customeProperty Complete:(void(^)())completeBlock{
    WEAKSELF2
    __block NSString * recordKey;
    NSString * bucketName = [UserEntity sharedSingleton].ossBucket;
    [self setCredentialWithAccessKey:accessKey SecretKey:secretKey Token:token];
    [self setCallbackWithBucketName:bucketName ObjectKey:objectKey Filepath:filePath CustomeProperty:customeProperty];
    
    [[[[[[OSSTask taskWithResult:nil] continueWithBlock:^id(OSSTask *task) {
        
        // 为该文件构造一个唯一的记录键
        NSURL * fileURL = [NSURL fileURLWithPath:filePath];
        NSDate * lastModified;
        NSError * error;
        [fileURL getResourceValue:&lastModified forKey:NSURLContentModificationDateKey error:&error];
        
        if (error) {
            return [OSSTask taskWithError:error];
        }
        recordKey = [NSString stringWithFormat:@"%@-%@-%@-%@", bucketName, objectKey, [OSSUtil getRelativePath:filePath], lastModified];
        
        // 通过记录键查看本地是否保存有未完成的UploadId
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        return [OSSTask taskWithResult:[userDefault objectForKey:recordKey]];
    }] continueWithSuccessBlock:^id(OSSTask *task) {
        
        if (!task.result) {
            
            // 如果本地尚无记录，调用初始化UploadId接口获取
            OSSInitMultipartUploadRequest * initMultipart = [OSSInitMultipartUploadRequest new];
            initMultipart.bucketName = bucketName;
            initMultipart.objectKey = objectKey;
            initMultipart.contentType = @"application/octet-stream";
            return [weakSelf.client multipartUploadInit:initMultipart];
        }
        OSSLogVerbose(@"An resumable task for uploadid: %@", task.result);
        return task;
    }] continueWithSuccessBlock:^id(OSSTask *task) {
        NSString * uploadId = nil;
        
        if (task.error) {
            return task;
        }
        
        if ([task.result isKindOfClass:[OSSInitMultipartUploadResult class]]) {
            uploadId = ((OSSInitMultipartUploadResult *)task.result).uploadId;
        } else {
            uploadId = task.result;
        }
        
        if (!uploadId) {
            return [OSSTask taskWithError:[NSError errorWithDomain:OSSClientErrorDomain
                                                              code:OSSClientErrorCodeNilUploadid
                                                          userInfo:@{OSSErrorMessageTOKEN: @"Can't get an upload id"}]];
        }
        
        // 将“记录键：UploadId”持久化到本地存储
        NSUserDefaults * userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setObject:uploadId forKey:recordKey];
        [userDefault synchronize];
        return [OSSTask taskWithResult:uploadId];
    }] continueWithSuccessBlock:^id(OSSTask *task) {
        
        // 持有UploadId上传文件
        OSSResumableUploadRequest * resumableUpload = [OSSResumableUploadRequest new];
        resumableUpload.bucketName = bucketName;
        resumableUpload.objectKey = objectKey;
        resumableUpload.uploadId = task.result;
        resumableUpload.uploadingFileURL = [NSURL fileURLWithPath:filePath];
        resumableUpload.uploadProgress = ^(int64_t bytesSent, int64_t totalBytesSent, int64_t totalBytesExpectedToSend) {
            NSLog(@"%lld %lld %lld", bytesSent, totalBytesSent, totalBytesExpectedToSend);
           
            [CustomeClass mainQueue:^{
                
                //发出上传成功的通知
                POSTNOTI(uploadProgress, @{uploadProgress:@((float)totalBytesSent / (float)totalBytesExpectedToSend)});
            }];
        };
        return [weakSelf.client resumableUpload:resumableUpload];
    }] continueWithBlock:^id(OSSTask *task) {
        
        if (task.error) {
            
            if ([task.error.domain isEqualToString:OSSClientErrorDomain] && task.error.code == OSSClientErrorCodeCannotResumeUpload) {
                
                // 如果续传失败且无法恢复，需要删除本地记录的UploadId，然后重启任务
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:recordKey];
            }
        } else {
            NSLog(@"upload completed!");
            
            // 上传成功，删除本地保存的UploadId
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:recordKey];
            completeBlock();
        }
        return nil;
    }];
}

// get local file dir which is readwrite able
- (NSString *)getDocumentDirectory {
    NSString * path = NSHomeDirectory();
    NSLog(@"NSHomeDirectory:%@",path);
    NSString * userName = NSUserName();
    NSString * rootPath = NSHomeDirectoryForUser(userName);
    NSLog(@"NSHomeDirectoryForUser:%@",rootPath);
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

#pragma mark - getter

- (OSSClient *)client{
    if (!_client) {
        _client = [[OSSClient alloc] initWithEndpoint:self.endPoint credentialProvider:self.credential];
    }
    return _client;
}

- (id<OSSCredentialProvider>)credential{
    if (!_credential) {
        _credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:ACCESSKEY secretKey:SECRETKEY];
    }
    return _credential;
}

- (NSString *)endPoint{
    if (!_endPoint) {
        _endPoint = [NSString stringWithFormat:@"http://%@", [UserEntity sharedSingleton].ossEndpoint];
    }
    return _endPoint;
}

@end
