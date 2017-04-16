//
//  MakeVideoViewController.m
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MakeVideoViewController.h"
#import "CameraOutView.h"
#import "CameraView.h"
#import "locationManager.h"
#import "CustomeClass.h"
#import "TempVideoOBj.h"
#import "App_vpVDCOrderForCreate.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "UserEntity.h"
#import "VideoPreviewViewController.h"
#import "TimerManager.h"
#import "SelectMaterialArray.h"
#import "XMNPhotoPickerController.h"

@interface MakeVideoViewController ()
//展示拍摄画面的view
@property (nonatomic, strong) CameraOutView *cameraOutView;
//控制view
@property (nonatomic, strong) CameraView *cameraControllView;
//视频个数
@property (nonatomic, assign) NSInteger *videoNum;
//视频沙盒文件夹
@property (nonatomic, copy) NSString *videoFile;
//当前文件
@property (nonatomic, copy) NSString *currentVideoURL;
@end

@implementation MakeVideoViewController

- (void)dealloc{
    
    //删除视频缓存文件
    [CustomeClass deleteFileWithPath:[CustomeClass createFileAtSandboxWithName:@"tempVideo"]];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [SINGLETON(TimerManager) stop];
    DEBUGSUCCESSLOG(@"dealloc")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册跳转预览视频界面的通知
    REGISTEREDNOTI(pushToPreviewVdieoVc:, PUSHTOPREVIEWVIDEOVC);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    [self.cameraOutView startShowCameraImage];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];
    [self.cameraOutView stopShowCameraImage];
    [[locationManager shareInstance] stopGetLocationInfo];
}

#pragma mark - 功能模块

/**
 *  跳转视频预览界面
 */
- (void)pushToPreviewVdieoVc:(NSNotification *)noti{
    VideoPreviewViewController * videoPreviewVc = [VideoPreviewViewController new];
    videoPreviewVc.videoDataMuArray = noti.userInfo[PREVIEWVIDEOARRAY];
    videoPreviewVc.showIndex = noti.userInfo[PREVIEWVIDEOINDEX];
    [self.navigationController pushViewController:videoPreviewVc animated:YES];
}

/**
 *  拍摄按钮
 */
- (void)makeVideoButtonAction:(UIButton *)makeVideoButton{
    if (makeVideoButton.selected) {
        
        //开始拍摄操作
        //保存视频
        self.videoNum++;
        self.currentVideoURL = [NSString stringWithFormat:@"%@/materialVideo%ld.mp4", self.videoFile, (unsigned long)self.videoNum];
        [self.cameraOutView startSaveVideoWithPath:self.currentVideoURL];
        
        //开始地理定位展示ar
//        [[locationManager shareInstance] startGetLocationInfo];
//        [self.cameraControllView testNewYearFu];
    }else{
        
        //暂停操作
        //停止保存视频
        [self.cameraOutView stopSaveVideo];
        
        //停止定位
//        [[locationManager shareInstance] stopGetLocationInfo];
        
        //保存视频缓冲
        [CustomeClass hudShowWithView:self.view Tag:12345678];
    }
}

/**
 *  使用视频
 */
- (void)useVideo{
    
    //传回视频
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        POSTNOTI(useTakeVideo, @{takeVideoArray:weakSelf.cameraControllView.videoShowView.dataMuArray});
        
        //返回上个页面
        [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
    })
}

/**
 *  保存tempVideoObj
 */
- (void)saveVideoObjWithVideoObj:(TempVideoOBj *)tempVideoObj{

    WEAKSELF2
    MAINQUEUEUPDATEUI({
        
        //如果此时ar信息数组中有元素，就保存到该对象中
        if (weakSelf.cameraControllView.rewardArray.count > 0) {
            
            /*
             Printing description of serverDataDictionary:
             {
             arawardlogid = 2627;
             desc = "";
             flag = 0;
             index = 0;
             name = "8000\U5143\U865a\U62df\U7535\U5668";
             type = 3;
             url = "http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/HomePageVideo/card_have_all.gif";
             }
             */
            NSDictionary *rewardInfo = weakSelf.cameraControllView.rewardArray[0];
            tempVideoObj.arid = rewardInfo[@"arawardlogid"];
            tempVideoObj.rewardType = [rewardInfo[@"type"] integerValue];
        }
        
        //使用通知将视频添加到videoTable上
        POSTNOTI(SHOWVIDEOATVIDEOTABLE, @{SHOWVIDEOTHUMAILIMAGE:tempVideoObj});
        
        [CustomeClass hudHiddenWithView:weakSelf.view Tag:12345678];
    })
}

/**
 *  跳转选择照片界面
 */
- (void)getAlbumAuthorizationStatus{
    SHOWHUD
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        WEAKSELF2
        if (status == PHAuthorizationStatusAuthorized) {
            
            // TODO:...
            [weakSelf pushToSelectMaterial];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * alertStr = [NSString stringWithFormat:@"请在%@的\"设置-隐私-照片\"选项中，\r允许映像访问你的手机相册。",[UIDevice currentDevice].model];
                ALERT(alertStr)
                return;
            });
        }
    }];
}


- (void)pushToSelectMaterial{
    
    //获得所有的选择的素材的assurl
    [SINGLETON(SelectMaterialArray) removeAllMaterial];
    [self initPickAndPush];
}

- (void)initPickAndPush{
    WEAKSELF2
    XMNPhotoPickerController *picker = [[XMNPhotoPickerController alloc] initWithMaxCount:20 delegate:nil];
    
    //    选择照片后回调
    [picker setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<XMNAssetModel *> * _Nullable assets) {
        [CustomeClass HUDShow];
        [weakSelf dismissViewControllerAnimated:YES completion:^{

        }];
    }];
    
    //    点击取消
    __weak typeof(picker) weakPicker = picker;
    [picker setDidCancelPickingBlock:^{
        [weakPicker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    [self presentViewController:picker animated:YES completion:^{
        [CustomeClass HUDHidden];
    }];
}


#pragma mark - 懒加载

- (CameraView *)cameraControllView{
    if (!_cameraControllView) {
        _cameraControllView = [[CameraView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           ISScreen_Width,
                                                                           ISScreen_Height)];
        [_cameraControllView addViewWithNeedAddControlView:YES];
        _cameraControllView.isShowARAnimation = YES;
        _cameraControllView.propmtStr = @"请使用本段带有奖品信息的视频制作影片，成功后即可获得该奖品";
        
        WEAKSELF2
        [_cameraControllView setCancleBlock:^{
            MAINQUEUEUPDATEUI({
                [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            })
        }];
        
        [_cameraControllView setUseVideoBlock:^{
            [weakSelf useVideo];
        }];
        
        [_cameraControllView setTakeVideoBlock:^(UILabel *timeLabel, UIButton *makeButton) {
            [weakSelf makeVideoButtonAction:makeButton];
        }];
        
        [_cameraControllView setChangeCameraBlock:^{
            [weakSelf.cameraOutView changeCamera];
        }];
        
        [_cameraControllView setLedControlBlock:^(BOOL isSelect) {
            if (isSelect) {

                [weakSelf.cameraOutView turnOnLed];
            }else{
                [weakSelf.cameraOutView turnOffLed];
            }
        }];
        
        [_cameraControllView setOpenAlbumBlock:^{
//            [weakSelf getAlbumAuthorizationStatus];
            MAINQUEUEUPDATEUI({
                [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
            })
        }];
    }
    return _cameraControllView;
}

- (CameraOutView *)cameraOutView{
    if (!_cameraOutView) {
        WEAKSELF2
        _cameraOutView = [[CameraOutView alloc] initWithFrame:CGRectMake(0,
                                                                         0,
                                                                         ISScreen_Width,
                                                                         ISScreen_Height)];
        
        [_cameraOutView setSaveFinishBlock:^(TempVideoOBj *tempVideoObj) {
            [weakSelf saveVideoObjWithVideoObj:tempVideoObj];
        }];
        
        [self.view addSubview:_cameraOutView];
        [self.view addSubview:self.cameraControllView];
        [self.view bringSubviewToFront:self.cameraControllView];
    }
    return _cameraOutView;
}

- (NSString *)videoFile{
    if (!_videoFile) {
        _videoFile = [CustomeClass createFileAtSandboxWithName:@"tempVideo"];
    }
    return _videoFile;
}

@end
