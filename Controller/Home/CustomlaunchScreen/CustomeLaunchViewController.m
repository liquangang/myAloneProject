//
//  CustomeLaunchViewController.m
//  M-Cut
//
//  Created by apple on 16/11/14.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CustomeLaunchViewController.h"
#import "ISConst.h"
#import <UIImageView+WebCache.h>
#import "MovierUtils.h"
#import "SoapOperation.h"
#import "GuidePlayView.h"
#import "CustomeClass.h"
#import "AFNetWorkManager.h"

static NSString *const launchImageFile = @"launchImage";

@interface CustomeLaunchViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) UIView * launchView;
@property (nonatomic, strong) UIImageView *iconImage;
@end

@implementation CustomeLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadLaunchImage];
}

#pragma mark - 功能模块

/**
 *  启动页
 */
- (void)loadLaunchImage{
    WEAKSELF2
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController *launch = [[UIStoryboard storyboardWithName:@"Launch Screen" bundle:nil] instantiateInitialViewController];
    [mainWindow addSubview:self.launchView = launch.view];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:newUser]) {
        GuidePlayView *guideView = [[GuidePlayView alloc] initWithFrame:self.launchView.bounds];
        [self.launchView addSubview:guideView];
        [guideView setStartBlock:^{
            [weakSelf removeLaunch];
        }];
    }else{
        
        //展示活动信息
        UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height - 64)];
        iconImage.contentMode = UIViewContentModeScaleToFill;
        iconImage.clipsToBounds = YES;
        [self.launchView addSubview:self.iconImage = iconImage];
        
        //icon
        UIImageView *bottomIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, ISScreen_Height - 64, ISScreen_Width - 110, 64)];
        [self.launchView addSubview:bottomIconImageView];
        bottomIconImageView.contentMode = UIViewContentModeLeft;
        bottomIconImageView.image = [UIImage imageNamed:@"launchScreenBottomImage"];
        
        //跳过button
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(ISScreen_Width - 80,
                                                                      ISScreen_Height - 64,
                                                                      60,
                                                                      64)];
        [button setTitle:@"跳过" forState:UIControlStateNormal];
        [button setTitleColor:ISRGBColor(64, 74, 88) forState:UIControlStateNormal];
        button.titleLabel.font = ISFont_16;
        [button addTarget:self
                   action:@selector(removeLaunch)
         forControlEvents:UIControlEventTouchUpInside];
        [launch.view addSubview:button];
        
        [[SoapOperation Singleton] WS_GetLaunchPage:@(4) Success:^(MovierDCInterfaceSvc_StringArr *launchinfos) {
            MAINQUEUEUPDATEUI({
                
                if (launchinfos.item.count > 0) {
                    weakSelf.iconImage.image = [weakSelf getLaunchImageWithURL:launchinfos.item[0]];
                    [weakSelf performSelector:@selector(removeLaunch) withObject:nil afterDelay:3.0];
                }
            })
        } Fail:^(NSError *error) {
            [CustomeClass mainQueue:^{
                [weakSelf performSelector:@selector(removeLaunch) withObject:nil afterDelay:3.0];
                NSLog(@"%@", error);
            }];
            
        }];
    }
}


- (void)removeLaunch{
    static BOOL isCheck = NO;
    
    if (!isCheck) {
        isCheck = YES;
        
        WEAKSELF2
        MAINQUEUEUPDATEUI({
            [UIView animateWithDuration:0.8f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                weakSelf.launchView.alpha = 0.0f;
                weakSelf.launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0f, 2.0f, 1.0f);
            } completion:^(BOOL finished) {
                [weakSelf.launchView removeFromSuperview];
                weakSelf.launchView = nil;
                [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
                weakSelf.view.userInteractionEnabled = YES;
            }];
        })
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:newUser]) {
            [CustomeClass afterRunWithTimer:0.8 AfterBlock:^{
                
                [CustomeClass backgroundAsyncQueue:^{
                    [weakSelf versionUpdateWithAppleServer];
                }];
            }];
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:newUser];
    }
}

- (UIImage *)getLaunchImageWithURL:(NSString *)launchImageURL{
    
    //获取文件路径
    NSString *imageName = [launchImageURL lastPathComponent];
    NSString *imageFilePath = [CustomeClass createFileAtSandboxWithName:launchImageFile];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", imageFilePath, imageName];
    
    //判断是否存在
    BOOL isHave = [[NSFileManager defaultManager] fileExistsAtPath:imagePath];
    
    if (isHave) {
        
        //存在就使用
        return [CustomeClass getImageWithImageFile:imagePath];
    }else{
        
        //不存在就先删除文件夹
        [CustomeClass deleteFileWithPath:imageFilePath];
        
        //创建文件夹
        [CustomeClass createFileAtSandboxWithName:launchImageFile];
        
        //下载设置图片
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:launchImageURL]];
        UIImage *image = [UIImage imageWithData:imageData];
        
        //保存图片
        [CustomeClass saveImageWithPath:imagePath ImageData:image];
        
        //如果文件夹不存在就创建文件夹
        return image;
    }
}

- (void)versionUpdateWithAppleServer{
    //2先获取当前工程项目版本号
    NSString *currentVersion = [CustomeClass getAppVersion];
    
    //3从网络获取appStore版本号
    NSURL *appStoreURl = [NSURL URLWithString:appStoreInfoURL];
    NSURLRequest *appStoreInfoRequest = [NSURLRequest requestWithURL:appStoreURl];
    NSData *response = [NSURLConnection sendSynchronousRequest:appStoreInfoRequest
                                             returningResponse:nil
                                                         error:nil];
    
    if (response == nil) {
        [CustomeClass showMessage:@"网络好像断开了" ShowTime:3];
        return;
    }
    
    NSError *error;
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response
                                                               options:NSJSONReadingMutableLeaves
                                                                 error:&error];
    if (error) {
        DEBUGLOG(error)
        return;
    }
    
    NSArray *array = appInfoDic[@"results"];
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    
    //打印版本号
    NSLog(@"\n当前版本号:%@\n商店版本号:%@", currentVersion, appStoreVersion);
    
    //4当前版本号小于商店版本号,就更新
    if([currentVersion floatValue] < [appStoreVersion floatValue]){
        NSLog(@"版本号比商店小，需要更新！");
        [self showAlertWithMessage:dic[@"releaseNotes"]];
    }else if ([currentVersion floatValue] == [appStoreVersion floatValue]){
        NSLog(@"版本号跟商店版本号一样，记得发布前修改哦！");
    }else{
        NSLog(@"版本号比商店版本号大，不需要更新！");
    }
}

/**
 *  提示框
 */
- (void)showAlertWithMessage:(NSString *)message{
    WEAKSELF2
    [CustomeClass mainQueue:^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:weakSelf cancelButtonTitle:@"去更新" otherButtonTitles:@"去你的", nil];
        [alertView show];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:APPSTOREURL];
    }
}

@end
