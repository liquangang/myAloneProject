//
//  HaveShareViewController.m
//  M-Cut
//
//  Created by apple on 16/10/27.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HaveShareViewController.h"
#import "shareView.h"
#import "CustomeClass.h"
#import "TuwenShareViewController.h"

@interface HaveShareViewController ()
//shareView
@property (nonatomic, strong) shareView * shareview;
//三方平台名称
@property (nonatomic, strong) NSArray * shareThirdPartyNameArray;
//三方平台的图片名称
@property (nonatomic, strong) NSArray * shareImageArray;
//三方平台的友盟枚举值
@property (nonatomic, strong) NSArray * shareCodeNameArray;
@end

@implementation HaveShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 *  分享点击方法
 */
- (void)shareTapMethodWithIndex:(NSInteger)index
                            URL:(NSString *)url
                          Title:(NSString *)title
                    UrlResource:(UMSocialUrlResource *)urlResource
                     ShareImage:(UIImage *)shareImage
{
    [self hiddenShareView];
    switch (index) {
        case 0:
        {
            
            //微信好友
            [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
            [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[self.shareCodeNameArray[index]]
                                                               content:title
                                                                 image:shareImage
                                                              location:nil
                                                           urlResource:urlResource
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity *response) {
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    [CustomeClass showMessage:@"分享成功" ShowTime:3];
                                                                }
                                                                
                                                            }];
        }
            break;
        case 1:
        {
            
            //朋友圈
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
            [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[self.shareCodeNameArray[index]]
                                                               content:title
                                                                 image:shareImage
                                                              location:nil
                                                           urlResource:urlResource
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity *response) {
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    [CustomeClass showMessage:@"分享成功" ShowTime:3];
                                                                }
                                                            }];
        }
            break;
        case 2:
        {
            
            //微博
            NSString * content = [NSString stringWithFormat:@"%@%@", title, url];
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[self.shareCodeNameArray[index]]
                                                               content:content
                                                                 image:shareImage
                                                              location:nil
                                                           urlResource:urlResource
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity *response) {
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    [CustomeClass showMessage:@"分享成功" ShowTime:3];
                                                                }
                                                            }];
            
        }
            break;
        case 3:
        {
            
            //QQ
            [UMSocialData defaultData].extConfig.qqData.url = url;
            [UMSocialData defaultData].extConfig.qqData.title = title;
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[self.shareCodeNameArray[index]]
                                                               content:title
                                                                 image:shareImage
                                                              location:nil
                                                           urlResource:urlResource
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity *response) {
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    [CustomeClass showMessage:@"分享成功" ShowTime:3];
                                                                }
                                                            }];
        }
            break;
        case 4:
        {
            
            //QQ空间
            [UMSocialData defaultData].extConfig.qzoneData.url = url;
            [UMSocialData defaultData].extConfig.qzoneData.title = title;
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[self.shareCodeNameArray[index]]
                                                               content:title
                                                                 image:shareImage
                                                              location:nil
                                                           urlResource:urlResource
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity *response) {
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    [CustomeClass showMessage:@"分享成功" ShowTime:3];
                                                                }
                                                            }];
        }
            break;
        case 5:
        {
            
            //微信收藏
            [UMSocialData defaultData].extConfig.wechatFavoriteData.url = url;
            [UMSocialData defaultData].extConfig.wechatFavoriteData.title = title;
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[self.shareCodeNameArray[index]]
                                                               content:title
                                                                 image:shareImage
                                                              location:nil
                                                           urlResource:urlResource
                                                   presentedController:self
                                                            completion:^(UMSocialResponseEntity *response) {
                                                                if (response.responseCode == UMSResponseCodeSuccess) {
                                                                    [CustomeClass showMessage:@"收藏成功" ShowTime:3];
                                                                }
                                                            }];
        }
            break;
        case 6:
        {
            
            //复制链接
            UIPasteboard *pastboad = [UIPasteboard generalPasteboard];
            pastboad.string = url;
            [CustomeClass showMessage:@"链接复制成功" ShowTime:3];
        }
            break;
            
        default:
            break;
    }
}

/**
 *  显示分享view
 */
- (void)showShareView{
    [UIView animateWithDuration:0.5 animations:^{
        self.shareview.frame = CGRectMake(0,
                                          0,
                                          ISScreen_Width,
                                          ISScreen_Height - 64);
        [self.view bringSubviewToFront:self.shareview];
    }];
}

/**
 *  隐藏分享view
 */
- (void)hiddenShareView{
    [UIView animateWithDuration:0.5 animations:^{
        self.shareview.frame = CGRectMake(0,
                                          ISScreen_Height,
                                          ISScreen_Width,
                                          ISScreen_Height - 64);
        [self.view bringSubviewToFront:self.shareview];
    }];
}

/**
 *  图文分享
 */
- (void)tuwenShare{
    [self hiddenShareView];
    TuwenShareViewController * tuwenShareVc = [TuwenShareViewController new];
    tuwenShareVc.videoInfoDictionary = self.videoInfoDictionary;
    [self.navigationController pushViewController:tuwenShareVc animated:YES];
}

#pragma mark - 懒加载
- (NSArray *)shareImageArray{
    if (!_shareImageArray) {
        _shareImageArray = @[@"weChatShareImage",
                             @"cricleFriendImage",
                             @"weiboShareImage",
                             @"qqShareImage",
                             @"qZoneShareImage",
                             @"weChatCollectImage",
                             @"copyUrlImage"];
    }
    return _shareImageArray;
}

- (NSArray *)shareThirdPartyNameArray{
    if (!_shareThirdPartyNameArray) {
        _shareThirdPartyNameArray = @[@"微信好友",
                                      @"朋友圈",
                                      @"微博",
                                      @"QQ",
                                      @"QQ空间",
                                      @"微信收藏",
                                      @"复制链接"];
    }
    return _shareThirdPartyNameArray;
}

- (NSArray *)shareCodeNameArray{
    if (!_shareCodeNameArray) {
        _shareCodeNameArray = @[UMShareToWechatSession,
                                UMShareToWechatTimeline,
                                UMShareToSina,
                                UMShareToQQ,
                                UMShareToQzone,
                                UMShareToWechatFavorite];
    }
    return _shareCodeNameArray;
}

- (shareView *)shareview{
    if (!_shareview) {
        _shareview = [[shareView alloc] initWithFrame:CGRectMake(0,
                                                                 ISScreen_Height,
                                                                 ISScreen_Width,
                                                                 ISScreen_Height - 64)
                                           ImageArray:self.shareImageArray
                                            NameArray:self.shareThirdPartyNameArray];
        if (!self.isShowTuwenButton) {
            _shareview = [[shareView alloc] init2WithFrame:CGRectMake(0,
                                                                      ISScreen_Height,
                                                                      ISScreen_Width,
                                                                      ISScreen_Height - 64)
                                                ImageArray:self.shareImageArray
                                                 NameArray:self.shareThirdPartyNameArray];
        }
        [self.view addSubview:_shareview];
        WEAKSELF2
        [_shareview setShareTapBlock:^(NSInteger index) {
            [weakSelf shareTapMethodWithIndex:index
                                          URL:weakSelf.shareUrl
                                        Title:weakSelf.shareTitle
                                  UrlResource:weakSelf.shareUrlResource
                                   ShareImage:weakSelf.shareImage];
        }];
        [_shareview setTuwenShareBlock:^{
            [weakSelf tuwenShare];
        }];
        [_shareview setCancleBlock:^{
            [weakSelf hiddenShareView];
        }];
    }
    return _shareview;
}

- (NSString *)shareUrl{
    if (!_shareUrl) {
        _shareUrl = @"http://www.inshowtv.com/";
    }
    return _shareUrl;
}

- (NSString *)shareTitle{
    if (!_shareTitle) {
        _shareTitle = @"映像让记忆更精彩！";
    }
    return _shareTitle;
}

- (UIImage *)shareImage{
    if (!_shareImage) {
        _shareImage = [UIImage imageNamed:@"inshow-1"];
    }
    return _shareImage;
}

- (UMSocialUrlResource *)shareUrlResource{
    if (!_shareUrlResource) {
        _shareUrlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeVideo
                                                                             url:@"http://www.inshowtv.com/"];
        
    }
    return _shareUrlResource;
}

@end
