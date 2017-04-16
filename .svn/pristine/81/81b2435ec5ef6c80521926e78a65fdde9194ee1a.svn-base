//
//  LoadStatus.h
//  bacHTTP
//
//  Created by Crab00 on 15/6/30.
//  Copyright (c) 2015年 Crab00. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AliyunOSSiOS/OSSService.h>

@protocol UpandDownDelegate <NSObject>

@optional
-(void)uparrayhasfinish;
-(void)downarrayhasfinish;
-(void)upFileSucess:(NSString*)filename;
-(void)upFileFailed:(NSString*)filename;
-(void)downFileSucess:(NSString*)filename;
-(void)downFileFailed:(NSString*)filename;
-(void)downFileProgress:(float)progress;
-(void)upFileProgress:(float)progress;

@end

@interface LoadStatus : UIProgressView
{
    id<UpandDownDelegate> updowndelegate;
//    OSSBucket *bucket;
    NSString *accessKey;
    NSString *secretKey;
    NSString *Bucket;
    NSString *HostId;
    NSString *ossPath;
    NSString *DownloadPath;//文件夹
//    id<ALBBOSSServiceProtocol> ossService;
    OSSClient *client;
    float Upprogress;//单个文件进度
    float Downprogress;//单个文件进度
    BOOL lockfilequeue;//锁定传输队列
    NSMutableArray *upProcess;//上传文件大小比例
    NSMutableArray *downProcess;//下载文件大小比例
    unsigned long long uptotalsize;//总上传文件大小
    unsigned long long downtotalsize;//总下载文件大小
}

@property(nonatomic,strong)NSMutableArray* downloadarray;
@property(nonatomic,strong)NSMutableArray* uploadarray;
@property(nonatomic,strong)NSMutableArray* downloadstatus;
@property(nonatomic,strong)NSMutableArray* uploadstatus;
@property(nonatomic,retain) id<UpandDownDelegate> updowndelegate;


-(void)addUploadFile:(NSString*)filepath;
-(void)addDownloadFile:(NSString*)filename;
/*
 *@param:ossPrefix oss上传的文件夹
 *@param:downPath  本地文件夹路径
 *@param:ossbucket ossbucket路径
 *@param:sk         oss secretkey
 *@param:ak         oss acces
 skey
 *@param:host       oss服务器地址
 *
 *@return nil
 */
-(void)initOSSwithpara:(NSString*)ossPrefix where2down:(NSString*)downPath Bucket:(NSString*)ossbucket secretKey:(NSString*)sk accessKey:(NSString*)ak HostId:(NSString*)host;
-(BOOL)TranslateData;
-(BOOL)cancelUp;
-(BOOL)cancelDown;
- (void)setdownProgress:(float)progress
               animated:(BOOL)animated;
- (void)setupProgress:(float)progress
             animated:(BOOL)animated;
-(void)changeOssPrefix:(NSString*)newPrefix;

@end
