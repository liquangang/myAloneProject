//
//  PhotoModel.h
//  M-Cut
//
//  Created by apple on 16/12/26.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject
@property (nonatomic, strong) PHAsset *asset;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) CGSize itemSize;
@end
