//
//  AFNetWorkManager.h
//  M-Cut
//
//  Created by apple on 16/12/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface AFNetWorkManager : AFHTTPSessionManager

+ (instancetype)shareInstance;

/**
 *  获取当前网络状态
 */
@property (nonatomic, assign) AFNetworkReachabilityStatus netStatus;

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
                          Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock;

/**
 *  搜索文件及其内容
 */
- (void)searchUserFile:(NSString *)filePath LabelArray:(NSArray *)labelArray Progress:(void(^)(NSProgress *progress))progressBlock Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock;

/**
 *  上传oss
 */
- (void)uploadWithFileName:(NSString *)fileName FileType:(NSString *)fileType Etag:(NSString *)etag CreateTime:(NSString *)createTime Contentsize:(NSString *)contentSize OssFileName:(NSString *)ossFileName Prefix:(NSString *)prefix Latitude:(NSString *)latitude Longitude:(NSString *)longitude HorizontalAccuracy:(NSString *)horizontalAccuracy LabelArray:(NSArray *)labelArray Progress:(void(^)(NSProgress *progress))progressBlock Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock;

/**
 *  删除文件
 */
- (void)deleteFileWithFilePath:(NSString *)filePath DeleteArray:(NSArray *)deleteArray Progress:(void(^)(NSProgress *progress))progressBlock Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock;

/**
 *  回收站查询
 */
- (void)searchRecycleWithStart:(NSString *)startStr End:(NSString *)endStr MostDistant:(NSString *)mostDistant Progress:(void(^)(NSProgress *progress))progressBlock Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock;

/**
 *  增加文件夹
 */
- (void)addFileWithFileName:(NSString *)fileName Prefix:(NSString *)prefix Progress:(void(^)(NSProgress *progress))progressBlock Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock;

/**
 *  变更文件属性（标签操作）
 */
- (void)updateLabelWithFilePath:(NSString *)filePath FileArray:(NSArray *)fileArray Progress:(void(^)(NSProgress *progress))progressBlock Success:(void(^)(NSURLSessionDataTask *task, id responseObject))successBlock Fail:(void(^)(NSURLSessionDataTask *task, NSError *error))failBlock;
@end
