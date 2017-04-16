//
//  MovierOssTranslation.h
//  bacHTTP
//
//  Created by Crab00 on 15/7/21.
//  Copyright (c) 2015年 Crab00. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>

typedef enum : NSUInteger {
    FILEEXIST    =  0,
    FILENOTEXIST    = 1,
} FILESTATUS;


@protocol MCutTransDelegate <NSObject>

@optional
-(void)uparrayhasfinish;
-(void)downarrayhasfinish;
-(void)upFileSucess:(NSString*)filename LocalPath:(NSString*)localpath;
-(void)upFileFailed:(NSString*)filename;
-(void)downFileSucess:(NSString*)filename;
-(void)downFileFailed:(NSString*)filename;
-(void)downFileProgress:(float)progress;
-(void)upFileProgress:(float)progress;

@end


@interface MovierTranslation : NSObject
{
//    OSSBucket *bucket;                                              //bucket指针 4月版本oss官方sdk
//    id<ALBBOSSServiceProtocol> ossService;                          //oss 服务代理 4月版本oss官方sdk
    OSSClient * client;
    NSString *accessKey;                                            //oss ak
    NSString *secretKey;                                            //oss sk
    NSString *strBucket;                                            //oss bucket
    NSString *strThubnailBucket;
    NSString *HostId;                                               //oss host @“”
    NSString *ossPath;                                              //oss 上传文件夹
    NSString *DownloadPath;                                         //本地文件夹路径（下载）
//    NSMutableArray *upProcess;                                      //上传文件列表大小比例
//    NSMutableArray *downProcess;                                    //下载文件列表大小比例
    float Upprogress;                                               //正在上传文件进度
    float Downprogress;                                             //正在下载文件进度
    BOOL lockfilequeue;                                             //锁定传输队列-》已有文件传输
//    unsigned long long uptotalsize;                                 //总上传文件大小
    unsigned long long downtotalsize;                               //总下载文件大小
//    unsigned long nowupindex;                                       //现在上传文件index
    unsigned long nowdownindex;                                     //现在下载文件index
    BOOL bEnable34G;
    NSLock* upLock;
    
}

@property(nonatomic)unsigned long nowupindex;
//@property(nonatomic)unsigned long long uptotalsize;                                 //总上传文件大小
@property(nonatomic,strong)NSMutableArray *upProcess;                                      //上传文件列表大小比例
@property(nonatomic,strong)NSMutableArray *downProcess;                                    //下载文件列表大小比例
@property(nonatomic)    unsigned long long uptotalsize;                                 //总上传文件大小
@property(nonatomic,strong)NSMutableArray* downloadarray;           //下载队列
@property(nonatomic,strong)NSMutableArray* uploadarray;             //上传队列
@property(nonatomic,strong)NSMutableArray* downloadstatus;          //下载百分比
@property(nonatomic,strong)NSMutableArray* uploadstatus;            //上传百分比
@property(nonatomic,retain) id<MCutTransDelegate> updowndelegate;   //
//@property(nonatomic,strong)OSSData *file2Up; //唯一的上传文件 4月版本oss官方sdk
//@property(nonatomic,strong)OSSFile *file2Up; //唯一的上传文件 4月版本oss官方sdk
//@property(nonatomic,strong)OSSFile *file2Down;//唯一的下载文件 4月版本oss官方sdk
@property(nonatomic,retain)OSSPutObjectRequest * put;
@property(nonatomic,retain)OSSInitMultipartUploadRequest *multPut;
@property(nonatomic)OSSResumableUploadRequest *resumableUpload;
@property(nonatomic,retain)OSSPutObjectRequest * thumbnailput;
@property(nonatomic,retain)OSSTask *putTask;
@property(nonatomic,retain)OSSTask *thumbnailTask;
@property(nonatomic)BOOL busyNow;

/** 当前的网络链接方式*/
@property (nonatomic, copy) NSString * netType;

+(MovierTranslation*)Singleton;


-(void)addUpFile:(NSString*)filefullpath;
-(void)addDownFile:(NSString*)filename;
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
-(void)initOSSwithpara:(NSString*)ossPrefix where2down:(NSString*)downPath
                Bucket:(NSString*)ossbucket secretKey:(NSString*)sk
             accessKey:(NSString*)ak HostId:(NSString*)host;
/*
 *function: 开启传输
 */
-(BOOL)TranslateData;
/*
 *function: 开启传输
 *
 *param:upIndex     从第N个开始上传传输
 *param:downIndex   从第N个开始下载传输
 */
-(BOOL)TranslateData:(int)upIndex down:(int)downIndex;
/*
 *function: 恢复传输
 */
-(BOOL)reTranslateData;
/*
 *function: 中止传输
 */
-(BOOL)cancelTranslate;
/*
 *function: 暂停传输
 */
-(BOOL)pauseTranslate;
/*
 *function:开启下一个上传
 */
-(void)nextupFile;
/*
 *function:开启下一个下载
 */
-(void)nextdownFile;
/*
 *function:开启3、4G传输在任务启动前设置
 *
 *param:开启/停用
 */
-(void)enable3GTranslation:(BOOL)enable3G;


//- (void)setDownProgress:(float)progress animated:(BOOL)animated atIndex:(unsigned long)index;
//- (void)setUpProgress:(float)progress animated:(BOOL)animated atIndex:(unsigned long)index;
-(void)changeOssPrefix:(NSString*)newPrefix;


-(void)cleanupArray;

//+ (NetworkStatus)isExistenceNetwork;

@end
