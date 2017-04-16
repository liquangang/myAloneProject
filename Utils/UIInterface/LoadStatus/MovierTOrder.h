//
//  MovierTOrder.h
//  M-Cut
//
//  Created by Crab00 on 15/7/30.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovierTranslation.h"


@interface OrderFiles : NSObject
@property(nonatomic,strong)NSString *orderid;
@property(nonatomic,strong)NSMutableArray *upfiles;
@property(nonatomic,strong)NSMutableArray *downfiles;


-(BOOL)addUpfile:(NSString*)file;
-(BOOL)addDownfile:(NSString*)file;
-(BOOL)removelastupfile;
-(BOOL)removelastdownfile;


@end


@interface MovierTOrder : NSObject<MCutTransDelegate>
{
    NSString *accessKey;                                            //oss ak
    NSString *secretKey;                                            //oss sk
    NSString *strBucket;                                            //oss bucket
    NSString *strHost;                                               //oss host @“”
    NSString *ossPath;                                              //oss 上传文件夹
    NSString *DownloadPath;                                         //本地文件夹路径（下载）
    
    
    NSString *nowTid;                                                 //现在传输文件标示
    
    BOOL nowWwanStatus;
}
@property(nonatomic,strong)NSMutableArray *Orders;
@property(nonatomic,strong)MovierTranslation *task;


+(MovierTOrder*)Singleton;
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
-(void)initoss:(NSString*)ossPrefix where2down:(NSString*)downPath
        Bucket:(NSString*)ossbucket secretKey:(NSString*)sk
     accessKey:(NSString*)ak HostId:(NSString*)host;
-(NSString*)CreateOrder;
-(void)AddOrderFile:(NSString*)orderid upfile:(NSString*)upfile downfile:(NSString*)downloadfile;
-(void)AddUpFile2Order:(NSString*)orderid filename:(NSString*)file ;
-(void)AddDownFile2Order:(NSString*)orderid filename:(NSString*)file;
//-(void)DelUpFile:(NSString*)orderid filename:(NSString*)file;
//-(void)DelDownFile:(NSString*)orderid filename:(NSString*)file;
-(BOOL)StartOrder:(NSString*)orderid WWANable:(BOOL)Use34;
//-(BOOL)CancelOrder:(NSString*)orderid;//暂时不支持
-(OrderFiles*)GetlastOrder;
-(void)removeselfobserver;

@end
