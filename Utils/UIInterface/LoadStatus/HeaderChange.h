//
//  HeaderChange.h
//  M-Cut
//
//  Created by Crab00 on 15/12/5.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AliyunOSSiOS/OSSService.h>

@interface HeaderChange : NSObject


@property(nonatomic,retain)OSSClient *client;

+(HeaderChange*)Singleton;

/**
 *@brief: 上传文件
 *
 */
-(NSString*)UploadUserHeader:(NSString*)Filename EXt:(NSString*)ext Yourdata:(NSData*)data;

/** 上传背景图片*/
- (NSString *)UploadBackgroundImageWithFilename:(NSString *)fileName Ext:(NSString *)ext Data:(NSData *)imageData;

/**
 *  上传图文分享的图片
 */
- (NSString *)UploadTuwenImageWithFilename:(NSString *)fileName
                                       Ext:(NSString *)ext
                                      Data:(NSData *)imageData
                                  Complete:(void(^)())completeBlock;
@end
