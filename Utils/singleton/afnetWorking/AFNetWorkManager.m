//
//  AFNetWorkManager.m
//  M-Cut
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AFNetWorkManager.h"
#import "SoapOperation.h"
#import "CustomeClass.h"

#define postURL [NSString stringWithFormat:@"http://%@/index.php/Home/FileAccess/newfile", serverIP]
#define deleteURL [NSString stringWithFormat:@"http://%@/index.php/Home/FileAccess/rmfiles", serverIP]
#define recycleURL [NSString stringWithFormat:@"http://%@/index.php/Home/FileAccess/getdumpboxrecord", serverIP]
#define addFileURL [NSString stringWithFormat:@"http://%@/index.php/Home/FileAccess/mkdir", serverIP]
#define searchURL [NSString stringWithFormat:@"http://%@/index.php/Home/FileAccess/listfiles", serverIP]

static NSString *const defaultAuthrisecode = @"fe9b7b0661086767639dc3d96fd0afb4";   //测试专用
static NSString *const defaultSessionid = @"1480592385";        //测试专用

@interface AFNetWorkManager()
@property (nonatomic, copy) NSString *useId;
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *authrisecodeKey;
@property (nonatomic, copy) NSString *rootDir;
@end

@implementation AFNetWorkManager

#pragma mark - interface

/**
 *  实现单例
 */
static AFNetWorkManager *instance;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        [instance startAFNetworkStatus];
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

/**
 *  监听网络状态
 */
- (void)startAFNetworkStatus{
    WEAKSELF2
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager startMonitoring];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        weakSelf.netStatus = status;
        
        [CustomeClass mainQueue:^{
           POSTNOTI(networkStatus, @{networkStatusDes:@(status)});
        }];
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                NSLog(@"未知网络状态");
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                NSLog(@"无网络");
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NSLog(@"蜂窝数据网");
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NSLog(@"WiFi网络");
            }
                break;
                
            default:
                break;
        }
    }] ;
}

/**
 *  新增文件申请
 */
- (void)addNewFileWithFileName:(NSString *)fileName
                      FileType:(NSString *)fileType
                          Etag:(NSString *)etag
                    CreateTime:(NSString *)createTime
                   ContentSize:(NSString *)contentSize
                      FilePath:(NSString *)filePath
                      Latitude:(NSString *)latitude
                    Longtitude:(NSString *)longtitude
            HorizontalAccuracy:(NSString *)horizontalAccuracy
                    LabelArray:(NSArray *)labelsArray
                      Progress:(void(^)(NSProgress *progress))progressBlock
                       Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock
                          Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock{
    
    NSDictionary *parametersDic = @{       @"primary_info":@{
                                                   @"name":fileName,
                                                   @"type":fileType,
                                                   @"etag":etag,
                                                   @"createtime":createTime,
                                                   @"contentsize":contentSize
                                                   },
                                           @"user_info":@{
                                                   @"userid":self.useId,
                                                   @"sessionid":self.sessionId,
                                                   @"authorizecode":self.authrisecodeKey
                                                   },
                                           @"userdir":filePath,
                                           @"location": @{
                                                   @"latitude":latitude,
                                                   @"longitude":longtitude,
                                                   @"horizontalAccuracy":horizontalAccuracy
                                                   }
                                           };
    
    [self POST:postURL parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *responseDic = [[NSMutableDictionary alloc] initWithDictionary:[CustomeClass jsonDataToDicWithJsonData:responseObject]];
        
        NSDictionary *callbackDic = @{
                                      @"primary_info": @{
                                              @"name": fileName,
                                              @"type": fileType,
                                              @"etag": etag,
                                              @"createtime": createTime,
                                              @"contentsize": contentSize
                                              },
                                      @"user_info": @{
                                              @"userid": self.useId,
                                              @"sessionid": self.sessionId,
                                              @"authorizecode": self.authrisecodeKey
                                              },
                                      @"userdir": filePath,
                                      @"oss": @{
                                              @"filename": responseDic[@"url"][@"filename"],
                                              @"prefix": responseDic[@"url"][@"prefix"]
                                              },
                                      @"location": @{
                                              @"latitude": latitude,
                                              @"longitude": longtitude,
                                              @"horizontalAccuracy": horizontalAccuracy
                                              },
                                      @"labels": labelsArray
                                      };
        NSString *tempStr1 = [[CustomeClass dictionaryToJson:callbackDic] stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        [responseDic setObject:tempStr1 forKey:@"customeProperty"];
        successBlock(task, responseDic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(task, error);
    }];
    
    /*
     {
     error =     {
     code = 0;
     message = "Thanks!";
     };
     "oss_ak" =     {
     "access_key" = "STS.DALYBDKZ1XktyrRtE2Ehnivce";
     "access_secret_key" = DDuHWSJauZ78aZceKKN7XoAMSUMsJty2MqgCRGrrgTt2;
     "access_token" = "CAISlQJ1q6Ft5B2yfSjIpYL5EvjwpoUQ76mfe1TjkEVnSedChrPIhzz2IH1Jf3VoAu8dtf41nGBU5/kelqJ4T55IQ1Dza8J148y+WJsNncmT1fau5Jko1beXewHKeSOZsebWZ+LmNqS/Ht6md1HDkAJq3LL+bk/Mdle5MJqP+/EFA9MMRVv6F3kkYu1bPQx/ssQXGGLMPPK2SH7Qj3HXEVBjt3gb6wZ24r/txdaHuFiMzg+46JdM+turcsL8Ppc3YsYkC43o5oEsKPqdihw3wgNR6aJ7gJZD/Tr6pdyHCzFTmU7bbrGIqoYwd1QjPPBqR/8b8OKPnPl5q/HVkJ/s1xFOMOdaXiLSXom8x9HeH+ekJl/yxQgdnPmnGoABSn7i2gj9PIrJaB/WkEesNun1yp9NoaIZhH8FXw4a1olBvUbbt+cIxInkIDWCQ1bZt8ukRxDcvTouIes5XpDR3xIQp6TOWaXAlEBqp3AqBA/JvU110ubiUz5sVZFEj5552XtYdDaSAXmGVATYkGt9zUR0MDnH9woUEsrcXjO8VIY=";
     expiration = "2017-01-04T08:32:59Z";
     };
     url =     {
     filename = "IMG_5988.JPG";
     prefix = "userfile/492df7bcce54c0252685394014cf9dce/170104/";
     };
     }
     */
}

/**
 *  搜索文件及其内容
 */
- (void)searchUserFile:(NSString *)filePath
            LabelArray:(NSArray *)labelArray
              Progress:(void(^)(NSProgress *progress))progressBlock
               Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock
                  Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock{
    
    NSDictionary *parametersDic = @{    @"user_info": @{
                                                @"userid":self.useId,
                                                @"sessionid":self.sessionId,
                                                @"authorizecode":self.authrisecodeKey
                                                        },
                                        @"searchdir":filePath,
                                        @"labels":labelArray
                                        };
    
    [self POST:searchURL parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task, [CustomeClass jsonDataToDicWithJsonData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(task, error);
    }];
    
    /*
     {
     "user_info":{
     "userid":"9849",
     "sessionid":"1480592385",
     "authrisecode":"fe9b7b0661086767639dc3d96fd0afb4"
     },
     "searchdir":"",
     "labels":[]
     }
     {
     "oss_ak":{
     "access_key":"STS.K3A1oP8uhyfXf5Hbpkbhz1zJS",
     "access_secret_key":"EyRosajkmdQAVriUi5vK4f8FPf8VQQNS3S3TMBWbjS4n",
     "expiration":"2016-12-13T11:41:02Z",
     "access_token":"CAESlgMIARKAAa2htT0WHVMxkmS8TJ5W3HVZNCgfE8H5Uro9tYldSjFq\/wvpsKwwXVtyLsTOfNASK0X84PQtFzEiJ0l6fDBNDDZkhJl41E9M9W9iCRUTOXXD11Geh1oiXYviWNeqdw7\/geGf\/FIAh7MZ9Ra29TuJnR+A010EDnhKSacohRPGFZmVGh1TVFMuSzNBMW9QOHVoeWZYZjVIYnBrYmh6MXpKUyISMzU1MzQwMzczMzIyMDg0OTc0KgtjbGllbnRfbmFtZTDwyPG\/jys6BlJzYU1ENUJaCgExGlUKBUFsbG93Eh8KDEFjdGlvbkVxdWFscxIGQWN0aW9uGgcKBW9zczoqEisKDlJlc291cmNlRXF1YWxzEghSZXNvdXJjZRoPCg1hY3M6b3NzOio6KjoqShAxNTcyODIwOTYzNjkzMDI1UgUyNjg0MloPQXNzdW1lZFJvbGVVc2VyYABqEjM1NTM0MDM3MzMyMjA4NDk3NHIbYWxpeXVub3NzdG9rZW5nZW5lcmF0b3Jyb2xleOGj2NaOz+UC"
     },
     "url":{
     "filename":10001,
     "prefix":"userfile\/\/\/161213\/"
     },
     "error":""
     }
     */
    
    /*
     返回的数据
     Printing description of responseObject:
     {
     error =     {
     code = 0;
     message = "Thanks!";
     };
     ret =     (
     {
     childfilecount = 0;
     createtime = "<null>";
     dirname = "\U54c8\U54c8\U54c8\U54c8";
     dirprefix = "/";
     thumbnail = "http://movier-vdctest.oss-cn-beijing.aliyuncs.com/userfile/";
     type = folder;
     }
     );
     }
     */
}

/**
 *  上传oss
 */
- (void)uploadWithFileName:(NSString *)fileName
                  FileType:(NSString *)fileType
                      Etag:(NSString *)etag
                CreateTime:(NSString *)createTime
               Contentsize:(NSString *)contentSize
               OssFileName:(NSString *)ossFileName
                    Prefix:(NSString *)prefix
                  Latitude:(NSString *)latitude
                 Longitude:(NSString *)longitude
        HorizontalAccuracy:(NSString *)horizontalAccuracy
                LabelArray:(NSArray *)labelArray
                  Progress:(void(^)(NSProgress *progress))progressBlock
                   Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock
                      Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock{
    NSDictionary *parametersDic = @{
                                    @"primary_info":@{
                                        @"name":fileName,
                                        @"type":fileType,
                                        @"etag":etag,
                                        @"createtime":createTime,
                                        @"contentsize":contentSize
                                    },
                                    @"user_info":@{
                                        @"userid":self.useId,
                                        @"sessionid":self.sessionId,
                                        @"authorizecode":self.authrisecodeKey
                                    },
                                    @"userdir":self.rootDir,
                                    @"oss":@{
                                        @"filename":ossFileName,
                                        @"prefix":prefix
                                    },
                                    @"location":@{
                                        @"latitude":latitude,
                                        @"longitude":longitude,
                                        @"horizontalAccuracy":horizontalAccuracy
                                    },
                                    @"labels":labelArray
                                    };
    
    [self POST:postURL parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task, [CustomeClass jsonDataToDicWithJsonData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(task, error);
    }];
}

/**
 *  删除文件
 */
- (void)deleteFileWithFilePath:(NSString *)filePath
                   DeleteArray:(NSArray *)deleteArray
                      Progress:(void(^)(NSProgress *progress))progressBlock
                       Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock
                          Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock{
    NSDictionary *parametersDic = @{@"user_info":@{
                                        @"userid":self.useId,
                                        @"sessionid":self.sessionId,
                                        @"authorizecode":self.authrisecodeKey
                                    },
                                    @"filedir":filePath,
                                    @"files":deleteArray
                                    };
    
    [self POST:deleteURL parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task, [CustomeClass jsonDataToDicWithJsonData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(task, error);
    }];
}

/**
 *  回收站查询
 */
- (void)searchRecycleWithStart:(NSString *)startStr
                           End:(NSString *)endStr MostDistant:(NSString *)mostDistant
                      Progress:(void(^)(NSProgress *progress))progressBlock
                       Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock
                          Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock{
    NSDictionary *parametersDic = @{@"user_info": @{
                                        @"userid":self.useId,
                                        @"sessionid":self.sessionId,
                                        @"authorizecode":self.authrisecodeKey
                                    },
                                    @"start":startStr,
                                    @"end":endStr,
                                    @"most_distant":mostDistant
                                    };
    
    [self POST:recycleURL parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task, [CustomeClass jsonDataToDicWithJsonData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(task, error);
    }];
}

/**
 *  增加文件夹
 */
- (void)addFileWithFileName:(NSString *)fileName
                     Prefix:(NSString *)prefix
                   Progress:(void(^)(NSProgress *progress))progressBlock
                    Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock
                       Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock{
    NSDictionary *parametersDic = @{@"user_info":@{
                                            @"userid":self.useId,
                                            @"sessionid":self.sessionId,
                                            @"authorizecode":self.authrisecodeKey
                                    },
                                    @"dir":@{
                                        @"name":fileName,
                                        @"prefix":prefix
                                    }
                                    };
    
    [self POST:addFileURL parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task, [CustomeClass jsonDataToDicWithJsonData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(task, error);
    }];
}

/**
 *  变更文件属性（标签操作）
 */
- (void)updateLabelWithFilePath:(NSString *)filePath
                      FileArray:(NSArray *)fileArray Progress:(void(^)(NSProgress *progress))progressBlock
                        Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock
                           Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock{
    NSDictionary *parametersDic = @{@"user_info":@{
                                        @"userid":self.useId,
                                        @"sessionid":self.sessionId,
                                        @"authorizecode":self.authrisecodeKey
                                    },
                                    @"filedir":filePath,
                                    @"files":fileArray
                                    };
    
    [self POST:addFileURL parameters:parametersDic progress:^(NSProgress * _Nonnull uploadProgress) {
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(task, [CustomeClass jsonDataToDicWithJsonData:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(task, error);
    }];
}

#pragma mark - 懒加载

- (NSString *)useId{
    return [[SoapOperation Singleton].WS_Session.nCustomerID stringValue];
}

- (NSString *)sessionId{
    return [[SoapOperation Singleton].WS_Session.nSessionID stringValue];
}

- (NSString *)authrisecodeKey{
    return [SoapOperation Singleton].WS_Session.szKey;
}

- (NSString *)rootDir{
    return [SoapOperation Singleton].WS_Session.szRootDir;
}

@end
