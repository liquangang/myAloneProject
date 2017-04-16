//
//  OSSManager.h
//  M-Cut
//
//  Created by apple on 16/12/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSSManager : NSObject

INSTANCEMETHOD

// 断点续传
- (void)resumableUploadWithFilePath:(NSString *)filePath ObjectKey:(NSString *)objectKey AccessKey:(NSString *)accessKey SecretKey:(NSString *)secretKey Token:(NSString *)token CustomeProperty:(NSString *)customeProperty Complete:(void(^)())completeBlock;
@end
