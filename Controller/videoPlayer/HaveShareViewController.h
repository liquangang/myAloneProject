//
//  HaveShareViewController.h
//  M-Cut
//
//  Created by apple on 16/10/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMSocial.h>
#import "HaveLoginAndRegisterWindowViewController.h"

@interface HaveShareViewController : HaveLoginAndRegisterWindowViewController
/*
    调用方法：首先继承该类，然后设置这5个参数，然后调用show方法即可, hidden不需要调用 继承该类既可以实现添加登录模块，也可以添加分享模块
 */
//默认是产品网首页
@property (nonatomic, copy) NSString * shareUrl;
//默认是映像让记忆更精彩！
@property (nonatomic, copy) NSString * shareTitle;
//默认是网页
@property (nonatomic, strong) UMSocialUrlResource * shareUrlResource;
//默认是映像logo
@property (nonatomic, strong) UIImage * shareImage;
//是否需要显示图文分享按钮
@property (nonatomic, assign) BOOL isShowTuwenButton;
//需要显示图文分享时也要设置这个参数(视频的信息字典)
@property (nonatomic, strong) NSDictionary * videoInfoDictionary;

 
/**
 *  显示分享view
 */
- (void)showShareView;

/**
 *  分享点击方法
 */
- (void)shareTapMethodWithIndex:(NSInteger)index
                            URL:(NSString *)url
                          Title:(NSString *)title
                    UrlResource:(UMSocialUrlResource *)urlResource
                     ShareImage:(UIImage *)shareImage;

/**
 *  图文分享
 */
- (void)tuwenShare;
@end
