//
//  OssFileDown.m
//  M-Cut
//
//  Created by Crab00 on 16/1/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "OssFileDown.h"
#import "UserEntity.h"

@implementation OssFileDown
+ (OssFileDown *)Singleton
{
    static OssFileDown *Singleton;
    
    @synchronized(self)
    {
        if (!Singleton)
        {
            Singleton = [[OssFileDown alloc] init];
            NSString* accessKey = [UserEntity sharedSingleton].ossID;
            NSString* secretKey = [UserEntity sharedSingleton].ossKey;
            //测试阶段，写死这两个数据
            /*
             ID：zGVpCiAsMnFfAJpg
             Secret：7nfKkKFs5MZUj9ktXUGrLMJQD1XDPu
             */
//            NSString * accessKey = ACCESSKEY;
//            NSString * secretKey = SECRETKEY;
            NSString* yourHostId = [NSString stringWithFormat:@"http://%@",[UserEntity sharedSingleton].ossEndpoint];
//            NSString* yourHostId = [NSString stringWithFormat:@"http://movier-vdc.oss-cn-beijing.aliyuncs.com"];
            // 明文设置secret的方式建议只在测试时使用，更多鉴权模式请参考后面的`访问控制`章节
            id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:accessKey secretKey:secretKey];
            Singleton.client = [[OSSClient alloc] initWithEndpoint:yourHostId credentialProvider:credential];
        }
        return Singleton;
    }
}

- (void)downloadHomepageBackground:(NSString *)ossURL Ext:(NSString *)ext LocalFile:(NSString *)localpath{
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    // 必填字段
    request.bucketName = @"movier-vdc";
    
    NSRange range = [ossURL rangeOfString:@"aliyuncs.com/"];
    
    ossURL = [ossURL substringFromIndex:range.location+[@"aliyuncs.com" length]+1];
    
    request.objectKey = ossURL;
    // 可选字段
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) { // 当前下载段长度、当前已经下载总长度、一共需要下载的总长度
        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        if ([self.delegate respondsToSelector:@selector(OssFileDown:Process:)]) {
            [self.delegate OssFileDown:self Process:(float)totalBytesWritten/totalBytesExpectedToWrite];
        }
    };
    // request.range = [[OSSRange alloc] initWithStart:0 withEnd:99]; // bytes=0-99,指定范围下载
    request.downloadToFileURL = [NSURL fileURLWithPath:localpath]; // 如果需要直接下载到文件,需要指明目标 文件地址
    OSSTask * getTask = [_client getObject:request];
    [getTask continueWithBlock:^id(OSSTask *task) { if (!task.error) {
        NSLog(@"download object success!");
        if ([self.delegate respondsToSelector:@selector(OssFileDown:Status:Fileinfo:)]) {
            [self.delegate OssFileDown:self Status:YES Fileinfo:localpath];
        }
        //        OSSGetObjectResult * getResult = task.result;
        //        NSLog(@"download result: %@", getResult.downloadedData);
    } else {
        NSLog(@"download object failed, error: %@" ,task.error);
        if ([self.delegate respondsToSelector:@selector(OssFileDown:Status:Fileinfo:)]) {
            [self.delegate OssFileDown:self Status:NO Fileinfo:localpath];
        }
    }
        return nil;
    }];
}

-(void)SimpleDown:(NSString*)ossURL EXt:(NSString*)ext LocalFile:(NSString*)localpath{
    OSSGetObjectRequest * request = [OSSGetObjectRequest new];
    // 必填字段
    request.bucketName = [UserEntity sharedSingleton].ossBucket;
    
    NSRange range = [ossURL rangeOfString:@"aliyuncs.com/"];
    
    ossURL = [ossURL substringFromIndex:range.location+[@"aliyuncs.com" length]+1];
    
    request.objectKey = ossURL;
    // 可选字段
    request.downloadProgress = ^(int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) { // 当前下载段长度、当前已经下载总长度、一共需要下载的总长度
        NSLog(@"%lld, %lld, %lld", bytesWritten, totalBytesWritten, totalBytesExpectedToWrite);
        if ([self.delegate respondsToSelector:@selector(OssFileDown:Process:)]) {
            [self.delegate OssFileDown:self Process:(float)totalBytesWritten/totalBytesExpectedToWrite];
        }
    };
    // request.range = [[OSSRange alloc] initWithStart:0 withEnd:99]; // bytes=0-99,指定范围下载
    if (!localpath) {
        return;
    }
    request.downloadToFileURL = [NSURL fileURLWithPath:localpath]; // 如果需要直接下载到文件,需要指明目标 文件地址
    OSSTask * getTask = [_client getObject:request];
    [getTask continueWithBlock:^id(OSSTask *task) { if (!task.error) {
        NSLog(@"download object success!");
        if ([self.delegate respondsToSelector:@selector(OssFileDown:Status:Fileinfo:)]) {
            [self.delegate OssFileDown:self Status:YES Fileinfo:localpath];
        }
//        OSSGetObjectResult * getResult = task.result;
//        NSLog(@"download result: %@", getResult.downloadedData);
    } else {
        NSLog(@"download object failed, error: %@" ,task.error);
        if ([self.delegate respondsToSelector:@selector(OssFileDown:Status:Fileinfo:)]) {
            [self.delegate OssFileDown:self Status:NO Fileinfo:localpath];
        }
    }
        return nil;
    }];
}
@end
