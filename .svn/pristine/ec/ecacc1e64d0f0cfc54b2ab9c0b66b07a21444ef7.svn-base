//
//  OssFileDown.h
//  M-Cut
//
//  Created by Crab00 on 16/1/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>
@class OssFileDown;
@protocol OssFileDownDelegate <NSObject>
@optional
/**  当前下载百分比 */
- (void)OssFileDown:(OssFileDown *)pointdownself Process:(float)download;
/**  下载完成/下载失败 */
- (void)OssFileDown:(OssFileDown *)pointdownself Status:(BOOL)downsuccess Fileinfo:(NSString*)filepath;
@end

@interface OssFileDown : NSObject
@property(nonatomic,retain)OSSClient *client;

+(OssFileDown*)Singleton;
/**
 *@brief: 下载文件
 *
 */
-(void)SimpleDown:(NSString*)ossURL EXt:(NSString*)ext LocalFile:(NSString*)localpath;

/** 下载首页的背景视频*/
- (void)downloadHomepageBackground:(NSString *)ossURL Ext:(NSString *)ext LocalFile:(NSString *)localpath;
/**  代理 */
@property (weak, nonatomic)  id<OssFileDownDelegate> delegate;

@end
