//
//  VideoDetailViewController.h
//  M-Cut
//
//  Created by apple on 16/9/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HaveLoginAndRegisterWindowViewController.h"
#import "HaveShareViewController.h"

@interface VideoDetailViewController : HaveShareViewController
@property (nonatomic, strong) NSMutableDictionary *videoInfo;
@property (nonatomic, assign) BOOL isFormTuwenVc;

/**
 *  跳转影片详情页
 */
+ (void)pushVideoDetailWithVideoInfo:(NSMutableDictionary *)videoInfo Nav:(UINavigationController *)pushNav VideoInfoBlock:(void(^)(NSMutableDictionary *videoInfoDic))videoInfoBlock;
@end
