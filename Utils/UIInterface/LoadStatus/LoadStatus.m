//
//  LoadStatus.m
//  bacHTTP
//
//  Created by Crab00 on 15/6/30.
//  Copyright (c) 2015年 Crab00. All rights reserved.
//

#import "LoadStatus.h"

@implementation LoadStatus
@synthesize updowndelegate;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)initOSSwithpara:(NSString*)ossPrefix where2down:(NSString*)downPath Bucket:(NSString*)ossbucket secretKey:(NSString*)sk accessKey:(NSString*)ak HostId:(NSString*)host
{
    ossPath = ossPrefix;
    DownloadPath = downPath;
    if (client==nil) {
        [self initOSSService:host secretKey:sk Bucket:ossbucket accessKey:ak ];
        
    }
    [self initfilequeue];
}

-(void)initfilequeue
{
    lockfilequeue = false;//打开文件列表锁
    uptotalsize = 0;
    downtotalsize = 0;
    upProcess =  [NSMutableArray arrayWithCapacity:1];
    downProcess =[NSMutableArray arrayWithCapacity:1];
}

//Bucket secretKey accessKey HostId 必须赋值
- (void)initOSSService:(NSString*)host secretKey:(NSString*)sk Bucket:(NSString*)ossbucket accessKey:(NSString*)ak
{
    // 明文设置secret的方式建议只在测试时使用，更多鉴权模式请参考后面的`OSSClient`章节
    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:ak secretKey:sk];
    OSSClientConfiguration * conf = [OSSClientConfiguration new];
    conf.maxRetryCount = 3;
    conf.enableBackgroundTransmitService = NO;
    conf.timeoutIntervalForRequest = 15;
    conf.timeoutIntervalForResource = 24 * 60 * 60;    
    client = [[OSSClient alloc] initWithEndpoint:host credentialProvider:credential clientConfiguration:conf];
    
//    ossService = [ALBBOSSServiceProvider getService];
//    [ossService setGlobalDefaultBucketAcl:PUBLIC_READ_WRITE];
//    [ossService setGlobalDefaultBucketHostId:host];
//    [ossService setAuthenticationType:ORIGIN_AKSK];
//    [ossService setGenerateToken:^(NSString *method, NSString *md5, NSString *type, NSString *date, NSString *xoss, NSString *resource){
//        NSString *signature = nil;
//        NSString *content = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@%@", method, md5, type, date, xoss, resource];
//        signature = [OSSTool calBase64Sha1WithData:content withKey:sk];
//        signature = [NSString stringWithFormat:@"OSS %@:%@", ak, signature];
//        NSLog(@"here signature:%@", signature);
//        return signature;
//    }];
//    bucket = [ossService getBucket:ossbucket];
}

-(BOOL)TranslateData
{
    lockfilequeue = true;
    NSInteger upNum = [self.uploadarray count];
    NSInteger downNum = [self.downloadarray count];
    if (upNum>0) {
        [self StartUpload:self.uploadarray atIndex:0];
    }
    if (downNum>0) {
        [self StartDownload:self.downloadarray atIndex:0];
    }
    return true;
}

-(void) StartUpload:(NSMutableArray*)filepatharray atIndex:(unsigned long)index
{
    NSString* filepath = [filepatharray objectAtIndex:index];
    NSString *type = [filepath pathExtension];
    NSString *filename = [filepath lastPathComponent];
    filename = [NSString stringWithFormat:@"%@/%@",ossPath,filename];
    OSSFile *testFile = [ossService getOSSFileWithBucket:bucket key:filename];
    [testFile setPath:filepath withContentType:type];
    [testFile resumableUploadWithCallback:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            [updowndelegate upFileSucess:filename];
            NSLog(@"%@ has upload",filename);
            if (index < [filepatharray count]) {
                [self StartUpload:self.uploadarray atIndex:index+1];
            }else{
                lockfilequeue = false;//逻辑漏洞，上传下载都完成才能打开
                NSLog(@"All files had upload");
            }
        } else {
            NSLog(@"error Info_testFileParts Upload:%@", [error userInfo]);
            [updowndelegate upFileFailed:filename];
            [self StartUpload:self.uploadarray atIndex:index];
        }
    } withProgressCallback:^(float progress) {
        //        NSLog(@"current up %@ :%f", filename ,progress);
//        [self setupProgress:progress animated:true];
        [self setupTotalProgress:progress animated:true atIndex:(unsigned long)index];
    }];
}

-(void) StartDownload:(NSMutableArray*)filearray atIndex:(unsigned long)index
{
    //    NSError *error = nil;
    NSString* filename = [filearray objectAtIndex:index];
    NSString* downloadfile = [NSString stringWithFormat:@"%@/%@",DownloadPath,filename];
    filename = [NSString stringWithFormat:@"%@/%@",ossPath,filename];
    OSSFile *testFile = [ossService getOSSFileWithBucket:bucket key:filename];
    [testFile downloadTo:downloadfile withDownloadCallback:^(BOOL isSuccess, NSError *error) {
        if (isSuccess) {
            NSLog(@"there is no error");
            [updowndelegate downFileSucess:filename];
            if (index < [filearray count]) {
                [self StartDownload:self.downloadarray atIndex:index+1];
            }else{
                lockfilequeue = false;//逻辑漏洞，上传下载都完成才能打开
                NSLog(@"All files had download");
            }
        } else {
            NSLog(@"error Info_testDataDownloadWithProgress:%@", [error userInfo]);
            [updowndelegate downFileFailed:filename];
            [self StartDownload:self.downloadarray atIndex:index];
        }
    } withProgressCallback:^(float progress) {
        //        NSLog(@"current %@ download %f", filename,progress);
        //        [self setdownProgress:progress animated:true];
        [self setdownTotalProgress:progress animated:true atIndex:(unsigned long)index];
    }];
    return;
}

-(void)addUploadFile:(NSString*)filepath
{
    if (lockfilequeue) {
        return;//文件锁
    }
    if (self.uploadarray==nil) {
        self.uploadarray = [NSMutableArray arrayWithCapacity:1];
    }
    [self.uploadarray addObject:filepath];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:filepath error:nil];
    upProcess = [self resizeFileScale:upProcess newmember:fileAttributeDic.fileSize oldtotalsize:uptotalsize];
    uptotalsize += fileAttributeDic.fileSize;
    if ([upProcess count]!= [self.uploadarray count]) {
        NSLog(@"LoadStatus error, upFile num not equal upProcess num ");
    }
    
}
-(void)addDownloadFile:(NSString*)filename
{
    if (lockfilequeue) {
        return;//文件锁
    }
    if (self.downloadarray == nil) {
        self.downloadarray = [NSMutableArray arrayWithCapacity:1];
    }
    [self.downloadarray addObject:filename];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:filename error:nil];
    downProcess = [self resizeFileScale:downProcess newmember:fileAttributeDic.fileSize oldtotalsize:downtotalsize];
    downtotalsize += fileAttributeDic.fileSize;
    if ([downProcess count]!= [self.downloadarray count]) {
        NSLog(@"LoadStatus error, downFile num not equal downProcess num ");
    }
    //    NSLog(@"download file count = %lu",(unsigned long)[self.downloadarray count]);
}

-(BOOL)cancelUp
{
    [self.uploadarray removeAllObjects];
    return false;
}
-(BOOL)cancelDown
{
    [self.downloadarray removeAllObjects];
    return true;
}

- (void)setupProgress:(float)progress
             animated:(BOOL)animated
{
    self.progressTintColor = [UIColor colorWithRed:244.f/255.f green:92.f/255.f blue:67.f/255.f alpha:1.f];
//    [super setProgress:progress animated:animated];
    Upprogress = progress;
    [updowndelegate upFileProgress:progress];
}

- (void)setupTotalProgress:(float)progress
                  animated:(BOOL)animated atIndex:(unsigned long)index
{
    Upprogress = progress;
    float allup = [self TotalProgress:progress ratioArray:upProcess animated:animated atIndex:index];
    NSLog(@"total up process = %f",allup);
    [updowndelegate upFileProgress:allup];
}

- (void)setdownTotalProgress:(float)progress
                    animated:(BOOL)animated atIndex:(unsigned long)index
{
    Downprogress = progress;
    float alldown = [self TotalProgress:progress ratioArray:downProcess animated:animated atIndex:index];
    NSLog(@"total down process = %f",alldown);
    [updowndelegate downFileProgress:alldown];
}

- (float)TotalProgress:(float)progress ratioArray:(NSMutableArray*)array
              animated:(BOOL)animated atIndex:(unsigned long)index
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

- (void)setdownProgress:(float)progress
               animated:(BOOL)animated
{
    Downprogress = progress;
    self.progressTintColor = [UIColor colorWithRed:235.f/255.f green:51.f/255.f blue:73.f/255.f alpha:1.f];
    [super setProgress:progress animated:animated];
    [updowndelegate downFileProgress:progress];
}

-(void)changeOssPrefix:(NSString*)newPrefix
{
    if (bucket==nil) {
        NSLog(@"bucket has not init!");
        return;
    }
    ossPath = newPrefix;
}

/*
 *@Param:array  传输比例数组
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



@end
