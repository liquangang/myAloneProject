//
//  MovierOssTranslation.m
//  bacHTTP
//
//  Created by Crab00 on 15/7/21.
//  Copyright (c) 2015年 Crab00. All rights reserved.
//

#import "MovierTranslation.h"
#import "Reachability.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MovierUtils.h"
//#import "MBProgressHUD+MJ.h"
#import <AVFoundation/AVFoundation.h>
#import "VideoDBOperation.h"
#import "UserEntity.h"
#import "APPUserPrefs.h"

@class OSSResumableUploadRequest;
@implementation MovierTranslation

//传输以单例存在
+ (MovierTranslation *)Singleton
{
    static MovierTranslation *Singleton;
    
    @synchronized(self)
    {
        if (!Singleton)
        {
            Singleton = [[MovierTranslation alloc] init];
            Singleton.multPut = [OSSInitMultipartUploadRequest new];
            Singleton.resumableUpload = [OSSResumableUploadRequest new];
            [Singleton NetListen];
        }
        return Singleton;
    }
}

-(void)initOSSwithpara:(NSString*)ossPrefix where2down:(NSString*)downPath Bucket:(NSString*)ossbucket secretKey:(NSString*)sk accessKey:(NSString*)ak HostId:(NSString*)host
{
    ossPath = ossPrefix;
    DownloadPath = downPath;
    strBucket = ossbucket;
    strThubnailBucket = @"movier-image";
    HostId = [NSString stringWithFormat:@"http://%@",host];
    if (client==nil)
    {
        id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:ak secretKey:sk];
        
        OSSClientConfiguration * conf = [OSSClientConfiguration new];
        conf.maxRetryCount = 3;
        conf.enableBackgroundTransmitService = YES; // 是否开启后台传输服务，目前，开启后，只对上传任务有效
        conf.timeoutIntervalForRequest = 15;
        conf.timeoutIntervalForResource = 24 * 60 * 60;
        
        client = [[OSSClient alloc] initWithEndpoint:HostId credentialProvider:credential clientConfiguration:conf];
        
        //        [self initOSSService:host secretKey:sk Bucket:ossbucket accessKey:ak ];
    }
    [self initfilequeue];
}

-(void)initfilequeue
{
    lockfilequeue = false;//打开文件列表锁
    _uptotalsize = 0;
    
    upLock = [[NSLock alloc]init];
    _upProcess =  [NSMutableArray arrayWithCapacity:1];

}

-(void)enable3GTranslation:(BOOL)enable
{
    bEnable34G = enable;
}

-(void)NetListen
{
    //    DLog(@"开启 www.apple.com 的网络检测");
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    //    NSLog(@"-- current status: %@", reach.currentReachabilityString);
    // start the notifier which will cause the reachability object to retain itself!
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [reach startNotifier];
}


- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
//        NSLog(@"网络不可用");
        self.netType = @"网络不可用";
        [self cancelTranslate];
        return;
    }
//    NSLog(@"网络可用");
    if (reach.isReachableViaWiFi) {
//        NSLog(@"当前通过wifi连接");
        self.netType = @"wifi";
//        [self reTranslateData];
    } else {
//        NSLog(@"wifi未开启，不能用");
        if (reach.isReachableViaWWAN) {
//            NSLog(@"当前通过2g or 3g连接");
            self.netType = @"移动网络";
            if ([APPUserPrefs Singleton].wwanable) {
//                NSLog(@"2 3 4 G 传输");
            }else {
//                NSLog(@"2g or 3g网络未使用");
                [self cancelTranslate];
            }
        }
    }
    
}

-(void)addUpFile:(NSString*)filefullpath
{
    if (self.uploadarray==nil) {
        self.uploadarray = [NSMutableArray arrayWithCapacity:1];
    }
    [self.uploadarray addObject:filefullpath];
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
//    NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:filefullpath error:nil];
    
    ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
//    __weak MovierTranslation *mtself = self;
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_async(queue, ^{
        [lib assetForURL:[NSURL URLWithString:filefullpath] resultBlock:^(ALAsset *asset){
            _put.uploadingData = UIImageJPEGRepresentation([UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage], 1.0);
//            NSLog(@"%lld",asset.defaultRepresentation.size);
            _upProcess = [self resizeFileScale:_upProcess newmember:asset.defaultRepresentation.size oldtotalsize:_uptotalsize];
            _uptotalsize += asset.defaultRepresentation.size;
            if ([_upProcess count]!= [self.uploadarray count]) {
                NSLog(@"LoadStatus error, upFile num not equal upProcess num ");
            }
            dispatch_semaphore_signal(sema);
        } failureBlock:^(NSError *error) {
            dispatch_semaphore_signal(sema);
        }];
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

-(void)addDownFile:(NSString*)filename{
    
}

-(BOOL)TranslateData
{
    [self TranslateData:0 down:0];
    return true;
}

-(BOOL)TranslateData:(int)upIndex down:(int)downIndex
{
    _busyNow = true;
    //    lockfilequeue = true;//不允许增删文件队列
    NSInteger upNum = [self.uploadarray count];
    NSInteger downNum = [self.downloadarray count];
    if (upNum>upIndex) {
//        [self StartUpload:self.uploadarray atIndex:upIndex];
        [self StartMUpload:self.uploadarray atIndex:upIndex];
        
    }
    if (downNum>downIndex) {
        [self StartDownload:self.downloadarray atIndex:downIndex];
    }
    
    return true;
}

-(BOOL)reTranslateData
{
    [self pauseTranslate];
    NSInteger upNum = [self.uploadarray count];
    NSInteger downNum = [self.downloadarray count];
    if (upNum>_nowupindex) {
        NSLog(@"up file cancled!");
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
//            [self StartUpload:self.uploadarray atIndex:_nowupindex];
            [self StartMUpload:self.uploadarray atIndex:_nowupindex];
        });
        
    }
    if (downNum>nowdownindex) {
        
        NSLog(@"down file cancled!");
        dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(time, dispatch_get_main_queue(), ^{
            [self StartDownload:self.downloadarray atIndex:nowdownindex];
        });
        
        
    }
    return true;
}

-(BOOL)cancelTranslate
{
//    [_putTask waitUntilFinished];
    [_resumableUpload cancel];
    [_put cancel];
    //    [self.file2Up cancel];
    //    [self.file2Down cancel];
    [self cleanArray];
    
    return true;
}

-(void)cleanArray
{
    [self cleanupArray];
    [self cleandownArray];
}
-(void)cleanupArray
{
    [self.uploadarray removeAllObjects];
    [self.uploadstatus removeAllObjects];
    [_upProcess removeAllObjects];
    _uptotalsize = 0;
}

-(void)cleandownArray
{
    [self.downloadarray removeAllObjects];
    [self.downloadarray removeAllObjects];
}

-(BOOL)pauseTranslate
{
    //    [self.file2Up cancel];
    //    [self.file2Down cancel];
    return  false;
}

-(void)nextupFile
{
    if (_nowupindex>=[self.uploadarray count]-1) {
        //        NSLog(@"all file upload!");
        [self cleanupArray];
    }else{
//        [self StartUpload:self.uploadarray atIndex:_nowupindex+1];
        [self StartMUpload:self.uploadarray atIndex:_nowupindex+1];
    }
    
    return;
}

-(void)nextdownFile
{
    if (nowdownindex>=[self.downloadarray count]-1) {
        //        NSLog(@"all file download!");
        [self cleandownArray];
    }else{
        [self StartDownload:self.downloadarray atIndex:nowdownindex+1];
    }
    return;
}


/**
 @Param:array  传输比例数组重计算
 *
 *
 *
 */
-(NSMutableArray*)resizeFileScale:(NSMutableArray*)array newmember:(unsigned long long)filesize oldtotalsize:(unsigned long long)allsize
{
    if ([array count] == 0) {
        array = [NSMutableArray arrayWithCapacity:1];
        [array addObject:[NSNumber numberWithFloat:1.0]];
    }else
    {
        for (int i = 0 ; i <[array count]; i++) {
            NSNumber* filescale = (NSNumber*)[array objectAtIndex:i];
            [array replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:filescale.floatValue*allsize/(filesize+allsize)]];
        }
        float abc = filesize / (float)(filesize+allsize);
        
        [array addObject:[NSNumber numberWithFloat:abc]];
        
    }
    return array;
}


-(void)changeOssPrefix:(NSString*)newPrefix
{
    if (client==nil) {
        NSLog(@"client has not init!");
        return;
    }
    ossPath = newPrefix;
}


-(void) StartMUpload:(NSMutableArray*)filepatharray atIndex:(unsigned long)index
{
    if (index >= [filepatharray count]) {  //列表传输完成
        return;
    }
    
    NSString* filepath = [filepatharray objectAtIndex:index];
    __block NSURL *uploadURL;
    _multPut.bucketName = strBucket;
    ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_async(queue, ^{
        [lib assetForURL:[NSURL URLWithString:filepath] resultBlock:^(ALAsset *asset){
            //临时文件检查;
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *cachesdirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *path1 = [cachesdirectory stringByAppendingPathComponent:asset.defaultRepresentation.filename];
            uploadURL = [NSURL fileURLWithPath:[cachesdirectory stringByAppendingPathComponent:asset.defaultRepresentation.filename]];
            NSLog(@"%@",[uploadURL absoluteString]);
            NSLog(@"decode file size = %llu",[[fileManager attributesOfItemAtPath:path1 error:nil] fileSize]);
            if ([fileManager fileExistsAtPath:path1]==YES) {
                NSData *uploadingData;
                if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]){
                    uploadingData = UIImageJPEGRepresentation([UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage], 1.0);
//                    [uploadingD0ata writeToURL:uploadURL atomically:YES];
                }else{
                    ALAssetRepresentation *representation = [asset defaultRepresentation];
                    // create a buffer to hold image data
                    uint8_t *buffer = (Byte*)malloc(representation.size);
                    NSUInteger length = [representation getBytes:buffer fromOffset: 0.0  length:representation.size error:nil];
                    NSData *adata;
                    if (length != 0)  {
                        // buffer -> NSData object; free buffer afterwards
                        adata = [[NSData alloc] initWithBytesNoCopy:buffer length:representation.size freeWhenDone:YES];
                    }
                    NSLog(@"date size = %lu",(unsigned long)length);
//                    [adata writeToURL:uploadURL atomically:YES];
                    //                multput.uploadingData = adata;
                    
                }
            }else{
                NSData *uploadingData;
                if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]){
                    uploadingData = UIImageJPEGRepresentation([UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage], 1.0);
                    [uploadingData writeToURL:uploadURL atomically:YES];
                }else{
                    ALAssetRepresentation *representation = [asset defaultRepresentation];
                    // create a buffer to hold image data
                    uint8_t *buffer = (Byte*)malloc(representation.size);
                    NSUInteger length = [representation getBytes:buffer fromOffset: 0.0  length:representation.size error:nil];
                    NSData *adata;
                    if (length != 0)  {
                        // buffer -> NSData object; free buffer afterwards
                        adata = [[NSData alloc] initWithBytesNoCopy:buffer length:representation.size freeWhenDone:YES];
                    }
                    NSLog(@"date size = %lu",(unsigned long)length);
                    [adata writeToURL:uploadURL atomically:YES];
                    //                multput.uploadingData = adata;
                }
            }
            _multPut.objectKey = [NSString stringWithFormat:@"%@/%@",ossPath,asset.defaultRepresentation.filename];
            dispatch_semaphore_signal(sema);
            
        } failureBlock:^(NSError *error) {
            dispatch_semaphore_signal(sema);
        }];
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    switch([MovierTranslation isExistenceNetwork]) { // arbin 15/09/17 修改
        case ReachableViaWiFi:
            break;
        case NotReachable:
            [self.updowndelegate upFileFailed:_multPut.objectKey];
            return;
        case ReachableViaWWAN:
            if (![APPUserPrefs Singleton].wwanable) {
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [MBProgressHUD showError:@"可以打开3G/4G开关"];
                });
                [self.updowndelegate upFileFailed:_multPut.objectKey];
                return;
            }else
                break;
    }
    
    __block NSString * uploadId = nil;
    NewOrderVideoMaterial *material = [[VideoDBOperation Singleton] DB_SearchMaterail:[[UserEntity sharedSingleton].customerId intValue] Asserturl:filepath];
    if ([material.multUpID isEqualToString:@""]||!material.multUpID) {
        OSSTask * task = [client multipartUploadInit:_multPut];
        [[task continueWithBlock:^id(OSSTask *tasksss) {
            if (!tasksss.error) {
                OSSInitMultipartUploadResult * result = tasksss.result;
                uploadId = result.uploadId;
            } else {
                NSLog(@"init uploadid failed, error: %@", tasksss.error);
            }
            return nil;
        }] waitUntilFinished];
        NSLog(@"uploadID = %@",uploadId);
        material.multUpID = uploadId;
        [[VideoDBOperation Singleton] DB_UpdateMaterial:material Owner:[[UserEntity sharedSingleton].customerId intValue]];
    }else
        uploadId = material.multUpID;
    
    _resumableUpload.bucketName = strBucket;
    _resumableUpload.objectKey = _multPut.objectKey;
    _resumableUpload.uploadId = uploadId;
    __weak MovierTranslation *mtself = self;
    _resumableUpload.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
//        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);
        [mtself setUpProgress:(float)totalByteSent/totalBytesExpectedToSend animated:YES atIndex:index];
    };
    _resumableUpload.uploadingFileURL = uploadURL;
    _putTask = [client resumableUpload:_resumableUpload];
    [_putTask continueWithBlock:^id(OSSTask *task) {
        if (task.error) {
            NSLog(@"error: %@", task.error);
            if ([task.error.domain isEqualToString:OSSClientErrorDomain] && task.error.code == OSSClientErrorCodeCannotResumeUpload) {
                // 该任务无法续传，需要获取新的uploadId重新上传
                OSSTask * task1 = [client multipartUploadInit:_multPut];
                [[task1 continueWithBlock:^id(OSSTask *tasksss) {
                    if (!tasksss.error) {
                        OSSInitMultipartUploadResult * result = tasksss.result;
                        uploadId = result.uploadId;
                    } else {
                        NSLog(@"init uploadid failed, error: %@", tasksss.error);
                    }
                    return nil;
                }] waitUntilFinished];
                NSLog(@"uploadID = %@",uploadId);
                material.multUpID = uploadId;
                [[VideoDBOperation Singleton] DB_UpdateMaterial:material Owner:[[UserEntity sharedSingleton].customerId intValue]];
                [self.updowndelegate upFileFailed:_multPut.objectKey];
            }else if([task.error.domain isEqualToString:OSSClientErrorDomain] && task.error.code == OSSClientErrorCodeTaskCancelled){
                _resumableUpload = [OSSResumableUploadRequest new];
                [self.updowndelegate upFileFailed:_multPut.objectKey];
            }
        } else {
            if ([self checkFileStatus:_multPut.objectKey]==FILEEXIST) {
                NSLog(@"upload object success!");
                [self.updowndelegate upFileSucess:_multPut.objectKey LocalPath:filepath];
                if (index < [filepatharray count]) {
                    //                [self StartUpload:self.uploadarray atIndex:index+1];
                }else{
                    lockfilequeue = false;//逻辑漏洞，上传下载都完成才能打开
                    NSLog(@"All files had upload ------in function StartMUpload");
                    _busyNow = false;
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"orderfinish" object:nil];
                }
            }else {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"transfercancel" object:nil];
                NSLog(@"upload object has been cancel ");
            }
        }
        return nil;
    }];
    self.nowupindex = index;
}

-(void)ossUpThumbnail:(NSString*)object localFile:(NSString*)filepath{
    _thumbnailput = [OSSPutObjectRequest new];
    // required fields
    _thumbnailput.bucketName = strThubnailBucket;
    _thumbnailput.objectKey = object;
    _thumbnailput.uploadingFileURL = [NSURL fileURLWithPath:filepath];
    
    // optional fields
    _thumbnailput.uploadProgress = ^(int64_t bytesSent, int64_t totalByteSent, int64_t totalBytesExpectedToSend) {
        //thumbnail up progress;
    };
    _thumbnailput.contentType = @"";
    _thumbnailput.contentMd5 = @"";
    _thumbnailput.contentEncoding = @"";
    _thumbnailput.contentDisposition = @"";
    _thumbnailTask = [client putObject:_thumbnailput];
    
    [_thumbnailTask continueWithBlock:^id(OSSTask *task) {
        if (!task.error) {
            NSLog(@"upload thumbnail %@ success!",object);
            [self checkFileStatus:object];
        } else {
            NSLog(@"upload object failed, error: %@" , task.error);
//            [self.updowndelegate upFileFailed:object];
        }
        return nil;
    }];
}

-(void) StartDownload:(NSMutableArray*)filearray atIndex:(unsigned long)index
{
    return;
}

- (void)setdownProgress:(float)progress animated:(BOOL)animated atIndex:(unsigned long)index
{
    Upprogress = progress;
    float totaldownratio = [self TotalProgress:progress ratioArray:_downProcess atIndex:index];
    NSLog(@"down %lu file: %f",nowdownindex,totaldownratio);
    [self.updowndelegate upFileProgress:totaldownratio];
}

- (void)setUpProgress:(float)progress animated:(BOOL)animated atIndex:(unsigned long)index
{
    Upprogress = progress;
    float totalupratio = [self TotalProgress:progress ratioArray:_upProcess atIndex:index];
    NSLog(@"up %lu file: %f",_nowupindex,totalupratio);
    [self.updowndelegate upFileProgress:totalupratio];
}

- (float)TotalProgress:(float)progress
            ratioArray:(NSMutableArray*)array
               atIndex:(unsigned long)index
{
    if (index>[array count]) {
        NSLog(@"LoadStatus logic error!");
        return 0;
    }
    float totalprocess = 0 ;
    for (int i = 0 ; i< index; i++) {
        NSNumber* temp = (NSNumber*)[array objectAtIndex:i];
        totalprocess += temp.floatValue;
    }
    NSNumber* ratio = (NSNumber*)[array objectAtIndex:index];
    totalprocess += progress*ratio.floatValue;
    return totalprocess;
}

+ (NetworkStatus)isExistenceNetwork
{
    Reachability *reachability = [Reachability reachabilityWithHostname:@"www.baidu.com"];  // 测试服务器状态
    return  [reachability currentReachabilityStatus];
}

-(FILESTATUS)checkFileStatus:(NSString*)ossobject{
    OSSHeadObjectRequest * head = [OSSHeadObjectRequest new];
    head.bucketName = strBucket;
    head.objectKey = ossobject;
    __block FILESTATUS ret;
    
    NSError * error = nil;
    BOOL isExist = [client doesObjectExistInBucket:strBucket objectKey:ossobject error:&error];
    if (!error) {
        if(isExist) {
            NSLog(@"File exists.");
            ret =FILEEXIST;
        } else {
            NSLog(@"File not exists.");
            ret =FILENOTEXIST;
        }
    } else {
        NSLog(@"Error!,%@",[error localizedDescription]);
    }
    return ret;
}



@end
