//
//  ARViewControl.m
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ARViewControl.h"
#import <CoreMotion/CoreMotion.h>
#import "CustomeClass.h"
#import <UIImage+GIF.h>
#import "SoapOperation.h"
#import <CoreLocation/CoreLocation.h>
#import "locationManager.h"
#import "MotionManager.h"

@interface ARViewControl()
//设备移动数据管理对象
@property (nonatomic, strong) CMMotionManager *motionManager;
//初始的姿态结构体
@property (nonatomic, strong) CMAttitude *firstARAttitude;
//初始的ar元素的frame
@property (nonatomic, assign) CGRect firstARFrame;
//arlogid
@property (nonatomic, copy) NSString *arLogId;
@property (nonatomic, strong) ARRewardView *arRewardView;
@end

@implementation ARViewControl

/*
    开始定位就会触发这部分的操作
 */

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //注册获得传感器信息通知
        REGISTEREDNOTI(getMotionData:, getMotionDeviceData);
        
        //注册获得地理信息的通知
        REGISTEREDNOTI(getLocationInfo:, getLocationInfo);
        
        //注册停止获得位置的通知
        REGISTEREDNOTI(stopGetLocation:, stopGetLocationInfo);
    }
    return self;
}

#pragma mark - 功能模块

/**
 *  停止获得地理位置
 */
- (void)stopGetLocation:(NSNotification *)noti{
    [[MotionManager shareInstance] stopGetDeviceMotionData];
    [self hiddenAR];
}

/**
 *  展示ar
 */
- (void)showAR{
    self.arRewardView.arPropertyImage.hidden = NO;
}

/**
 *  隐藏ar
 */
- (void)hiddenAR{
    self.arRewardView.arPropertyImage.hidden = YES;
}

/**
 *  获得地理信息的通知
 */
- (void)getLocationInfo:(NSNotification *)noti{
    CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake([noti.userInfo[locationLatitudeInfo] doubleValue], [noti.userInfo[locationLongitudeInfo] doubleValue]);
    [self showARPropertyWithLocationCoorinate:locationCoordinate];
}

/**
 *  获得传感器信息通知
 */
- (void)getMotionData:(NSNotification *)noti{
    [self setARWithMotion:noti.userInfo[motionDeviceData]];
}

/**
 *  根据位置判断是否有ar可以显示
 */
- (void)showARPropertyWithLocationCoorinate:(CLLocationCoordinate2D)locationCoorinate{
    
    //test 此时使用的是测试经纬度
    WEAKSELF2
    
    //116.332289，39.978503
    [[SoapOperation Singleton] getARWhenTakeVideoWithType:3 Longitude:116.332289 Latitude:39.978503 Radius:100 Success:^(NSMutableDictionary *serverDataDictionary) {
        [[locationManager shareInstance] stopGetLocationInfo];
        
        //在区域内
        DEBUGSUCCESSLOG(@"在规定区域内")
        
        [weakSelf setARPropertyWithARRewardView:weakSelf.arRewardView
                                         ARInfo:serverDataDictionary];
    
    } Fail:^(NSError *error) {
        DEBUGLOG(error)
        if (error.code == 51) {
            DEBUGSUCCESSLOG(@"不在规定区域内")
        }
    }];
}

/**
 *  获得arrewardview
 */
- (ARRewardView *)getARRewardViewWithFrame:(CGRect)arRewardViewFrame{
    ARRewardView *arRewardView = [[ARRewardView alloc] initWithFrame:arRewardViewFrame];
    self.arRewardView = arRewardView;
    return arRewardView;
}

/**
 *  ar元素交互
 */
- (void)touchARPropertyWithARRewardView:(ARRewardView *)arRewardView{
    [arRewardView setArPropertyBlock:^{
        
        //下载宝箱的信息，设置宝箱显示
    }];
}

/**
 *  根据后台数据设置ar元素
 */
- (void)setARPropertyWithARRewardView:(ARRewardView *)arRewardView
                               ARInfo:(NSDictionary *)arInfo{
    /*
     返回的ar内容 --- {
     ARInfoDictionary =     {
     arid = 1;
     arlogid = 249;
     arname = "AR\U5b9d\U7bb1";
     arurl = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/HomePageVideo/Box.gif";
     };
     }
     */
    
    [CustomeClass backgroundQueue:^{
        UIImage *arImage;
        
        //本地地址
        //存储所有gif的文件夹
        [CustomeClass createFileAtSandboxWithName:arPropertyGIFFileName];
        //存储当前需要的gif的文件夹
        NSString *imageDataFileNameStr = [NSString stringWithFormat:@"%@/%@", arPropertyGIFFileName, arInfo[@"arid"]];
        //如果不存在就创建
        NSString *imageFile = [CustomeClass createFileAtSandboxWithName:imageDataFileNameStr];

        NSURL *imageDataURL = [NSURL fileURLWithPath:imageFile];
        NSData *imageData = [NSData dataWithContentsOfURL:imageDataURL];
        UIImage *tempImage = [UIImage sd_animatedGIFWithData:imageData];
        
        if (tempImage) {
            arImage = tempImage;
        }else{
            NSURL *arURL = [NSURL URLWithString:STRTOUTF8(arInfo[@"arurl"])];
            NSData *arGIFData = [NSData dataWithContentsOfURL:arURL];
            arImage = [UIImage sd_animatedGIFWithData:arGIFData];
            
            //保存图片
            [arGIFData writeToFile:imageFile atomically:YES];
        }
        
        [CustomeClass mainQueue:^{
            arRewardView.arPropertyImage.image = arImage;
            arRewardView.arPropertyImage.hidden = NO;
            
            //开始获得传感器信息展示ar效果
            [[MotionManager shareInstance] startGetDeviceMotionData];
        }];
    }];
}

/**
 *  ar根据传感器数据产生动的效果
 */
- (void)setARWithMotion:(CMDeviceMotion *)motion{
    double rotation = atan2(motion.gravity.x, motion.gravity.y) - M_PI;
    self.arRewardView.arPropertyImage.transform = CGAffineTransformMakeRotation(rotation);
    
    if (!self.firstARFrame.size.height) {
        self.firstARFrame = self.arRewardView.arPropertyImage.frame;
    }
    
    if (!self.firstARAttitude) {
        self.firstARAttitude = [CMAttitude new];
        self.firstARAttitude = motion.attitude;
    }
    
    CGRect newFrame = self.firstARFrame;
    double changeX = (motion.attitude.roll - self.firstARAttitude.roll) * 100.0f * ISScreen_Width / 70.0;
    double changeY = tan(motion.attitude.pitch - self.firstARAttitude.pitch) * 800.0f;
    newFrame.origin.x += changeX;
    newFrame.origin.y += changeY;
    self.arRewardView.arPropertyImage.frame = newFrame;
}
@end
