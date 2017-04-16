//
//  UploadImageManager.h
//  M-Cut
//
//  Created by apple on 16/12/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadImageManager : NSObject
INSTANCEMETHOD

@property (nonatomic, strong) NSMutableArray *uploadMuArray;

- (void)startUploadImage;
@end
