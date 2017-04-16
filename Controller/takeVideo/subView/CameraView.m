
//
//  CameraView.m
//  M-Cut
//
//  Created by apple on 16/10/9.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CameraView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CustomeClass.h"
#import <UIImage+GIF.h>
#import "locationManager.h"
#import "TimerManager.h"
#import "MotionManager.h"
#import <CoreLocation/CoreLocation.h>
#import "SoapOperation.h"
#import <CoreMotion/CoreMotion.h>
#import "CameraControlView.h"

@interface CameraView()
//取消按钮
@property (nonatomic, strong) UIButton *cancleButton;
//拍照按钮
@property (nonatomic, strong) UIButton *takeVideoButton;
//使用该视频
@property (nonatomic, strong) UIButton *useVideoButton;
//拍摄暂停label
@property (nonatomic, strong) UILabel *takePropmtLabel;
//切换摄像头按钮
@property (nonatomic, strong) UIButton *changeCameraButton;
//闪光灯
@property (nonatomic, strong) UIButton *ledControlButton;
//打开相册
@property (nonatomic, strong) UIButton *openAlbumButton;
//初始的姿态结构体
@property (nonatomic, strong) CMAttitude *firstARAttitude;
//初始的ar元素的frame
@property (nonatomic, assign) CGRect firstARFrame;
@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) CameraControlView *cameraControlView;
@property (nonatomic, assign) BOOL isShowAR;
@property (nonatomic, copy) NSString *arId;
@property (nonatomic, copy) NSString *chestId;
@property (nonatomic, strong) NSDictionary *rewardInfo;
//记录用户是否点击ar
@property (nonatomic, assign) BOOL isTouchAR;
//记录用户是否点击奖品
@property (nonatomic, assign) BOOL isTouchReward;
@end

@implementation CameraView

/**
 *  重写初始化方法
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - 功能模块

/**
 *  ar部分view
 */
- (void)addViewWithNeedAddControlView:(BOOL)isNeedControlView{
    WEAKSELF2
    self.isShowAR = YES;
    self.isTouchReward = NO;
    ARRewardView *arRewardView = [[ARRewardView alloc] initWithFrame:self.bounds];
    [arRewardView setArPropertyBlock:^{
        weakSelf.isTouchAR = YES;
        [weakSelf showChest];
        [CustomeClass afterRunWithTimer:3 AfterBlock:^{
            [weakSelf getChestWithARId:weakSelf.arId];
        }];
    }];
    [arRewardView setChestBlock:^{
        [weakSelf getChestWithARId:weakSelf.arId];
    }];
    [arRewardView setCouponBlock:^{
        weakSelf.isTouchReward = YES;
        [weakSelf hiddenReward];
        [weakSelf showPropmt];
    }];
    [arRewardView setVirtualElectricBlock:^{
        weakSelf.isTouchReward = YES;
        [weakSelf hiddenReward];
        [weakSelf showPropmt];
    }];
    [arRewardView setPropmtBlock:^{
        [weakSelf hiddenPropmt];
    }];
    [self addSubview:arRewardView];
    self.arRewardView = arRewardView;
    
    //接收计时器的通知
    REGISTEREDNOTI(setPropmtLabelText:, timerIntervalMethod);
    
    //注册获得传感器复合信息通知
    REGISTEREDNOTI(getMotionData:, getMotionDeviceData);
    
    //注册获得地理信息的通知
    REGISTEREDNOTI(getLocationInfo:, getLocationInfo);
    
    if (isNeedControlView) {
        [self addControlView];
    }
}

/**
 *  camera控制部分控件在这里添加
 */
- (void)addControlView{
    CameraControlView *cameraView = [[CameraControlView alloc] initWithFrame:self.bounds];
    self.cancleButton = cameraView.cancleButton;
    [self addSubview:self.cancleButton];
    [self.cancleButton addTarget:self
                          action:@selector(cancleButtonAction)
                forControlEvents:UIControlEventTouchUpInside];
    
    self.takePropmtLabel = cameraView.takePropmtLabel;
    [self addSubview:self.takePropmtLabel];
    
    self.takeVideoButton = cameraView.takeVideoButton;
    [self addSubview:self.takeVideoButton];
    [self.takeVideoButton addTarget:self
                             action:@selector(takeVideoButtonAction)
                   forControlEvents:UIControlEventTouchUpInside];
    
    self.useVideoButton = cameraView.useVideoButton;
    [self.useVideoButton addTarget:self
                            action:@selector(useVideoButtonAction)
                  forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.useVideoButton];
    
    self.videoShowView = cameraView.videoShowView;
    WEAKSELF2
    [self.videoShowView setShowUseVideoButton:^{
        weakSelf.useVideoButton.hidden = NO;
        weakSelf.changeCameraButton.hidden = NO;
    }];
    [self addSubview:self.videoShowView];
    
    self.changeCameraButton = cameraView.changeCameraButton;
    [self addSubview:self.changeCameraButton];
    [self.changeCameraButton addTarget:self
                                action:@selector(changeCameraButtonAction:)
                      forControlEvents:UIControlEventTouchUpInside];
    
    self.ledControlButton = cameraView.ledControlButton;
    [self addSubview:self.ledControlButton];
    [self.ledControlButton addTarget:self
                              action:@selector(ledControlButtonAction:)
                    forControlEvents:UIControlEventTouchUpInside];
    
    self.openAlbumButton = cameraView.openAlbumButton;
    [self addSubview:self.openAlbumButton];
    [self.openAlbumButton addTarget:self action:@selector(openAlbumButtonAction:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  获得传感器信息通知
 */
- (void)getMotionData:(NSNotification *)noti{
    [self setARWithMotion:noti.userInfo[motionDeviceData]];
}

/**
 *  获得地理信息的通知
 */
- (void)getLocationInfo:(NSNotification *)noti{
    CLLocationDegrees latitude = [noti.userInfo[locationLatitudeInfo] doubleValue];
    CLLocationDegrees longitude = [noti.userInfo[locationLongitudeInfo] doubleValue];
    CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [self showARPropertyWithLocationCoorinate:locationCoordinate];
}

/**
 *  计时器通知
 */
- (void)setPropmtLabelText:(NSNotification *)noti{
    self.timeLength++;
    self.takePropmtLabel.text = [NSString stringWithFormat:@"%ld:%ld", self.timeLength / 60, self.timeLength % 60];
    if (self.timeLength > 15) {
        [self hiddenAR];
    }
}

/**
 *  根据影片id判断是否有ar
 */
- (void)showARWithVideoId:(NSString *)videoId{
    WEAKSELF2
    [[SoapOperation Singleton] getARWhenWatchVideoWithVideoId:videoId Success:^(NSMutableDictionary *serverDataDictionary) {
        if (weakSelf.isShowAR) {
            weakSelf.isShowAR = NO;
            
            //开始动画效果
            [SINGLETON(MotionManager) stopGetDeviceMotionData];
            [weakSelf setARPropertyWithARInfo:serverDataDictionary];
            weakSelf.arId = serverDataDictionary[@"arlogid"];
        }
    } Fail:^(NSError *error) {
        [weakSelf hiddenARViewAndProperty];
        if (error.code == 57) {
            DEBUGLOG(@"没有ar")
            //关闭定位
            [[locationManager shareInstance] stopGetLocationInfo];
        }else if (error.code == 12){
            [CustomeClass showMessage:@"登录后看片有惊喜！" ShowTime:3];
        } else if (weakSelf.isShowAR){
            RELOADSERVERDATA([weakSelf showARWithVideoId:videoId];);
        }
    }];
}

/**
 *  test
 */
- (void)testNewYearFu{
    
    /*
     RInfoDictionary =     {
     arid = 1;
     arlogid = 249;
     arname = "AR\U5b9d\U7bb1";
     arurl = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/HomePageVideo/Box.gif";
     };
     }
     */
    NSDictionary *serverDataDictionary = @{@"arid":@"1",
                                           @"arlogid":@"249",
                                           @"arname":@"AR",
                                           @"arurl":@"http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/HomePageVideo/Box.gif"};
    WEAKSELF2
    if (weakSelf.isShowAR) {
        weakSelf.isShowAR = NO;
        weakSelf.arId = serverDataDictionary[@"arlogid"];
        [SINGLETON(MotionManager) startGetDeviceMotionData];
        [weakSelf setARPropertyWithARInfo:serverDataDictionary];
    }
}

/**
 *  根据位置判断是否有ar可以显示
 */
- (void)showARPropertyWithLocationCoorinate:(CLLocationCoordinate2D)locationCoorinate{
    
    //test 此时使用的是测试经纬度
    WEAKSELF2
    
    //116.332289，39.978503
    [[SoapOperation Singleton] getARWhenTakeVideoWithType:3 Longitude:locationCoorinate.longitude Latitude:locationCoorinate.latitude Radius:100 Success:^(NSMutableDictionary *serverDataDictionary) {
        
        //关闭定位
        [[locationManager shareInstance] stopGetLocationInfo];
        
        //在区域内
        DEBUGSUCCESSLOG(@"在规定区域内")
        
        if (weakSelf.isShowAR) {
            weakSelf.isShowAR = NO;
            weakSelf.arId = serverDataDictionary[@"arlogid"];
            [SINGLETON(MotionManager) startGetDeviceMotionData];
            [weakSelf setARPropertyWithARInfo:serverDataDictionary];
        }
    } Fail:^(NSError *error) {
        [weakSelf hiddenARViewAndProperty];
        if (error.code == 51) {
            DEBUGSUCCESSLOG(@"不在规定区域内")
        }else if (error.code == 57){
            DEBUGLOG(@"没有ar")
            //关闭定位
            [[locationManager shareInstance] stopGetLocationInfo];
        }else if (weakSelf.isShowAR){
            RELOADSERVERDATA([weakSelf showARPropertyWithLocationCoorinate:locationCoorinate];);
        }
    }];
}

/**
 *  根据arid获取宝箱
 */
- (void)getChestWithARId:(NSString *)arId{
    WEAKSELF2
    [[SoapOperation Singleton] getARChestWithLogId:self.arId Success:^(NSMutableDictionary *serverDataDictionary) {
        weakSelf.chestId = serverDataDictionary[@"chestlogid"];
        [weakSelf openChestWithChestId:weakSelf.chestId];
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf getChestWithARId:arId];);
    }];
}

/**
 *  根据宝箱id获取打开宝箱
 */
- (void)openChestWithChestId:(NSString *)chestId{
    WEAKSELF2
    [[SoapOperation Singleton] openARBoxWithBoxId:chestId Success:^(NSMutableDictionary *serverDataDictionary) {
        
        //展示奖品
        WEAKSELF2
        [weakSelf shwoRewardWithRewardInfo:serverDataDictionary];
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf openChestWithChestId:chestId];);
    }];
}

/**
 *  展示奖品
 */
- (void)shwoRewardWithRewardInfo:(NSDictionary *)rewardInfo{
    [self.rewardArray removeAllObjects];
    [self.rewardArray addObject:rewardInfo];
    WEAKSELF2
    [CustomeClass backgroundQueue:^{
        UIImage *rewardImage;
        NSString *fileName;
        UIImageView *tempImageView;
        
        if ([rewardInfo[@"type"] intValue] == 3) {
            fileName = [NSString stringWithFormat:@"%@%@", rewardInfo[@"name"], rewardInfo[@"index"]];
            tempImageView = weakSelf.arRewardView.virtualElectricImage;
        }else if ([rewardInfo[@"type"] intValue] == 1){
            fileName = rewardInfo[@"name"];
            tempImageView = weakSelf.arRewardView.couponImage;
        }
        
        rewardImage = [CustomeClass getGIFImageWithPath:arRewardFileName
                                               FileName:fileName
                                               ImageURL:rewardInfo[@"url"]];
        
        MAINQUEUEUPDATEUI({
//            tempImageView.image = rewardImage;
            tempImageView.image = [UIImage sd_animatedGIFNamed:@"禄-3"];
            [weakSelf landAnimationWithView:tempImageView];
            [weakSelf hiddenChest];
            [CustomeClass afterRunWithTimer:6 AfterBlock:^{
                if (!weakSelf.isTouchReward) {
                    [weakSelf hiddenReward];
                    [weakSelf showPropmt];
                }
            }];
        })
    }];
}

/**
 *  根据后台数据设置ar元素
 */
- (void)setARPropertyWithARInfo:(NSDictionary *)arInfo{
    WEAKSELF2
    [CustomeClass backgroundQueue:^{
        UIImage *arImage = [CustomeClass getGIFImageWithPath:arPropertyGIFFileName
                                                    FileName:arInfo[@"arid"]
                                                    ImageURL:arInfo[@"arurl"]];
        MAINQUEUEUPDATEUI({
//            weakSelf.arRewardView.arPropertyImage.image = arImage;
            weakSelf.arRewardView.arPropertyImage.image = [UIImage sd_animatedGIFNamed:@"禄-1"];
            [weakSelf showAR];
        })
    }];
}

/**
 *  ar根据传感器数据产生动的效果
 */
- (void)setARWithMotion:(CMDeviceMotion *)motion{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        double rotation = atan2(motion.gravity.x, motion.gravity.y) - M_PI;
        weakSelf.arRewardView.arPropertyImage.transform = CGAffineTransformMakeRotation(rotation);
        //    NSLog(@"gravity x = %f, y = %f z = %f",motion.gravity.x,motion.gravity.y,motion.gravity.z);
        
        if (!weakSelf.firstARFrame.size.height) {
            weakSelf.firstARFrame = weakSelf.arRewardView.arPropertyImage.frame;
        }
        
        if (!weakSelf.firstARAttitude) {
            weakSelf.firstARAttitude = [CMAttitude new];
            weakSelf.firstARAttitude = motion.attitude;
        }
        
        CGRect newFrame = weakSelf.firstARFrame;
        double changeX = (motion.attitude.roll - weakSelf.firstARAttitude.roll) * 100.0f * ISScreen_Width / 70.0;
        double changeY = tan(motion.attitude.pitch - weakSelf.firstARAttitude.pitch) * 800.0f;
        newFrame.origin.x += changeX;
        newFrame.origin.y += changeY;
        weakSelf.arRewardView.arPropertyImage.frame = newFrame;
    })
}

/**
 *  隐藏所有的arview
 */
- (void)hiddenARViewAndProperty{
    MAINQUEUEUPDATEUI({
        WEAKSELF2
        weakSelf.arRewardView.hidden = YES;
        weakSelf.arRewardView.arPropertyImage.hidden = YES;
        weakSelf.arRewardView.chestImage.hidden = YES;
        weakSelf.arRewardView.couponImage.hidden = YES;
        weakSelf.arRewardView.virtualElectricImage.hidden = YES;
        weakSelf.arRewardView.propmtImage.hidden = YES;
    })
}

/**
 *  显示ar
 */
- (void)showAR{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        weakSelf.arRewardView.hidden = NO;
        weakSelf.arRewardView.propmtImage.hidden = YES;
        weakSelf.arRewardView.chestImage.hidden = YES;
        weakSelf.arRewardView.couponImage.hidden = YES;
        weakSelf.arRewardView.virtualElectricImage.hidden = YES;
        weakSelf.arRewardView.couponImage.image = [UIImage new];
        weakSelf.arRewardView.virtualElectricImage.image = [UIImage new];
        weakSelf.arRewardView.chestImage.image = [UIImage new];
        weakSelf.arRewardView.propmtImage.image = [UIImage new];
        weakSelf.arRewardView.arPropertyImage.hidden = NO;
    })
}

/**
 *  隐藏ar
 */
- (void)hiddenAR{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        weakSelf.arRewardView.arPropertyImage.hidden = YES;
        
        if (weakSelf.isShowARAnimation) {
            [[MotionManager shareInstance] stopGetDeviceMotionData];
        }
    })
}

/**
 *  展示宝箱
 */
- (void)showChest{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        [weakSelf hiddenAR];
        weakSelf.arRewardView.chestImage.image = [UIImage sd_animatedGIFNamed:@"禄-2"];
        [weakSelf landAnimationWithView:weakSelf.arRewardView.chestImage];
    })
}

/**
 *  隐藏宝箱
 */
- (void)hiddenChest{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        weakSelf.arRewardView.chestImage.hidden = YES;
    })
}

/**
 *  隐藏奖品
 */
- (void)hiddenReward{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        weakSelf.arRewardView.couponImage.hidden = YES;
        weakSelf.arRewardView.virtualElectricImage.hidden = YES;
        [weakSelf showPropmt];
    })
}

/**
 *  展示提示
 */
- (void)showPropmt{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        weakSelf.arRewardView.propmtImage.image = [UIImage imageNamed:@"propmtImage"];
        CGFloat propmtLabelWidth = CGRectGetWidth(weakSelf.arRewardView.propmtImage.frame) - 52;
        CGFloat propmtLableHeight = CGRectGetHeight(weakSelf.arRewardView.propmtImage.frame) - 100;
        CGRect propmtLabelFrame = CGRectMake(26, 40, propmtLabelWidth, propmtLableHeight);
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:propmtLabelFrame];
        [weakSelf.arRewardView.propmtImage addSubview:titleLabel];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = ISLIKEGRAYCOLOR;
        titleLabel.font = ISFont_13;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = weakSelf.propmtStr;
        [weakSelf landAnimationWithView:weakSelf.arRewardView.propmtImage];
    })
}

/**
 *  隐藏提示
 */
- (void)hiddenPropmt{
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        weakSelf.arRewardView.propmtImage.hidden = YES;
    })
}

/**
 *  隐藏arview
 */
- (void)hiddenARView{
    if (!self.isTouchAR) {
        WEAKSELF2
        MAINQUEUEUPDATEUI({
            weakSelf.arRewardView.hidden = YES;
        })
    }
}

/**
 *  出现动画
 */
- (void)landAnimationWithView:(UIView *)landView{
    [CustomeClass backgroundQueue:^{
        CGFloat superViewWidth = CGRectGetWidth(landView.superview.frame);
        CGFloat superViewHight = CGRectGetHeight(landView.superview.frame);
        CGFloat frameX = superViewWidth / 2 - CGRectGetWidth(landView.frame) / 2;
        CGFloat frameY = superViewHight / 2 - CGRectGetHeight(landView.frame) / 2;
        CGRect currentFrame = CGRectMake(frameX, frameY, CGRectGetWidth(landView.frame), CGRectGetHeight(landView.frame));
        int x = [CustomeClass getRandomNumber:-currentFrame.size.width to:superViewWidth];
        int y = [CustomeClass getRandomNumber:-currentFrame.size.height to:superViewHight];
        
        CGRect upFrame = CGRectMake(x, -currentFrame.size.height, CGRectGetWidth(currentFrame), CGRectGetHeight(currentFrame));
        CGRect downFrame = CGRectMake(x, currentFrame.size.height + superViewHight, CGRectGetWidth(currentFrame), CGRectGetHeight(currentFrame));
        CGRect leftFrame = CGRectMake(-CGRectGetMinX(currentFrame), y, CGRectGetWidth(currentFrame), CGRectGetHeight(currentFrame));
        CGRect rightFrame = CGRectMake(superViewWidth, y, CGRectGetWidth(currentFrame), CGRectGetHeight(currentFrame));
        
        CGRect updateFrame;
        switch ([CustomeClass getRandomNumber:1 to:4]) {
            case 1:
            {
                updateFrame = upFrame;
            }
                break;
            case 2:
            {
                updateFrame = downFrame;
            }
                break;
            case 3:
            {
                updateFrame = leftFrame;
            }
                break;
            case 4:
            {
                updateFrame = rightFrame;
            }
                break;
                
            default:
            {
                updateFrame = CGRectMake(x, y, CGRectGetWidth(currentFrame), CGRectGetHeight(currentFrame));
            }
                break;
        }
        
        landView.frame = updateFrame;
        MAINQUEUEUPDATEUI({
            landView.hidden = NO;
            [UIView animateWithDuration:0.6 animations:^{
                landView.frame = currentFrame;
            }];
        })
    }];
}

#pragma mark - 相机控制部分
/**
 *  取消按钮点击方法
 */
- (void)cancleButtonAction{
    self.cancleBlock();
}

/**
 *  拍照按钮点击方法
 */
- (void)takeVideoButtonAction{
    
    //系统声音
    AudioServicesPlaySystemSound(1117);
    
    //震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    self.takeVideoButton.selected = !self.takeVideoButton.selected;
    
    if (self.takeVideoButton.selected) {
        
        //开始录制
        self.timeLength = 0;
        self.useVideoButton.hidden = YES;
        self.changeCameraButton.hidden = YES;
        [[TimerManager shareInstance] startWithTimeInterval:1];
        
        //清空ar奖品数组
        [self.rewardArray removeAllObjects];
        
        //防止多次获取ar
        self.isShowAR = YES;
        
        //展示ar
        self.arRewardView.hidden = NO;
        
        //默认没有点击ar
        self.isTouchAR = NO;
    }else{
        
        //停止录制
        self.takePropmtLabel.text = @"点击拍摄";
        [[TimerManager shareInstance] stop];
        
        //隐藏ar内容
        self.arRewardView.hidden = YES;
    }
    
    self.takeVideoBlock(self.takePropmtLabel, self.takeVideoButton);
}

/**
 *  使用视频按钮点击方法
 */
- (void)useVideoButtonAction{
    self.useVideoBlock();
}

/**
 *  更换镜头
 */
- (void)changeCameraButtonAction:(UIButton *)btn{
    self.ledControlButton.hidden = !self.ledControlButton.hidden;
    self.changeCameraBlock();
}

/**
 *  闪光灯
 */
- (void)ledControlButtonAction:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.ledControlBlock(btn.selected);
}

/**
 *  打开相册
 */
- (void)openAlbumButtonAction:(UIButton *)btn{
    self.openAlbumBlock();
}

#pragma mark - 懒加载
- (NSMutableArray *)rewardArray{
    if (!_rewardArray) {
        _rewardArray = [NSMutableArray new];
    }
    return _rewardArray;
}
@end
