


//
//  TakeVideoViewController.m
//  M-Cut
//
//  Created by liquangang on 16/9/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TakeVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CameraView.h"
#import "XMNPhotoManager.h"
#import <CoreLocation/CoreLocation.h>
#import "CustomeClass.h"
#import "SoapOperation.h"
#import "App_vpVDCOrderForCreate.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "UserEntity.h"
#import <CoreLocation/CoreLocation.h>
#import "VideoPreviewViewController.h"
#import "TempVideoOBj.h"
#import "locationManager.h"

@interface TakeVideoViewController ()<AVCaptureFileOutputRecordingDelegate>
//负责输入和输出设置之间的数据传递                  
@property (strong, nonatomic) AVCaptureSession *captureSession;

//负责从AVCaptureDevice获得视频输入数据
@property (strong, nonatomic) AVCaptureDeviceInput *captureDeviceInput;

//获得声音输入数据
@property (nonatomic, strong) AVCaptureDeviceInput * audioCaptureDeviceInput;

//视频输出流
@property (strong, nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;

//相机拍摄预览图层
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;

//相机控制部分view
@property (nonatomic, strong) CameraView * cameraControllView;

//时长显示label
@property (nonatomic, strong) UILabel * timeLabel;

//时长
@property (nonatomic, assign) NSInteger timeLength;

//计时器
@property (nonatomic, strong) NSTimer * videoTimeer;

//定位控制对象
//@property (nonatomic, strong) CLLocationManager * locationManager;

//服务器返回的ar信息数组
@property (nonatomic, strong) NSMutableArray * arMuArray;

//拍摄的视频个数
@property (nonatomic, assign) NSUInteger videoNum;
@end

@implementation TakeVideoViewController

- (void)dealloc{
    
    //删除视频缓存文件
    [CustomeClass deleteFileWithPath:[CustomeClass createFileAtSandboxWithName:@"tempVideo"]];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DEBUGSUCCESSLOG(@"dealloc")
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册跳转预览视频界面的通知
    REGISTEREDNOTI(pushToPreviewVdieoVc:, PUSHTOPREVIEWVIDEOVC);
    
    //注册获得地理信息的通知
//    REGISTEREDNOTI(getLocationInfo:, getLocationInfo);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    [self.captureSession startRunning];
    
    //禁止侧滑
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];
    [self.captureSession stopRunning];
//    [self.locationManager stopUpdatingLocation];
    
    [[locationManager shareInstance] stopGetLocationInfo];
    
    //打开侧滑
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark -AVCaptureFileOutputRecordingDelegate

/**
 *  录制完成
 */
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput
        didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL
        fromConnections:(NSArray *)connections
        error:(NSError *)error
{
    [self saveVideoToSandBox];
}

//#pragma mark - CLLocationManagerDelegate
//
//- (void)locationManager:(CLLocationManager *)manager
//     didUpdateLocations:(NSArray<CLLocation *> *)locations{
//    CLLocation * location = [locations lastObject];
//    CLLocationCoordinate2D locationCoorinate = location.coordinate;
//    [self showARPropertyWithLocationCoorinate:locationCoorinate];
//}

#pragma mark - 功能模块

/**
 *  获得地理信息的通知
 */
- (void)getLocationInfo:(NSNotification *)noti{
    CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake([noti.userInfo[locationLatitudeInfo] doubleValue], [noti.userInfo[locationLongitudeInfo] doubleValue]);
    [self showARPropertyWithLocationCoorinate:locationCoordinate];
}

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
 *  开始请求地理信息
 */
- (void)startGetLocation{
    [self.arMuArray removeAllObjects];
//    [[locationManager shareInstance] startGetLocationInfo];
    
//    //判断定位功能是否可用
//    if ([CLLocationManager locationServicesEnabled] &&
//        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized ||
//         [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
//            [self.arMuArray removeAllObjects];
//            [self.locationManager startUpdatingLocation];
//        }else{
//            [CustomeClass showMessage:@"定位功能不可用" ShowTime:3];
//        }
}

/**
 *  显示相关的ar元素
 */
- (void)showARPropertyWithLocationCoorinate:(CLLocationCoordinate2D)locationCoorinate{
    
    //如果已经有ar了，就不在使用
    if (self.arMuArray.count > 0) {
        return;
    }
    
    //test 此时使用的是测试经纬度
    WEAKSELF2
    
    //116.332289，39.978503
    [[SoapOperation Singleton] getARWhenTakeVideoWithType:self.isFollowOrder ? 3 : 4 Longitude:116.332289 Latitude:39.978503 Radius:100 Success:^(NSMutableDictionary *serverDataDictionary) {
//        [weakSelf.locationManager stopUpdatingLocation];
        [[locationManager shareInstance] stopGetLocationInfo];
        
        //在区域内
        DEBUGSUCCESSLOG(@"在规定区域内")
        
        //临时保存所有的ar信息
        [weakSelf.arMuArray addObject:serverDataDictionary];
        
        //发送通知让相关view显示ar元素
        MAINQUEUEUPDATEUI({
            POSTNOTI(CAMERAVIEWSHOWARPORPERY, @{ARINFODICTIONARY:serverDataDictionary});
        })
    } Fail:^(NSError *error) {
//        [weakSelf.locationManager stopUpdatingLocation];
        DEBUGLOG(error)
        if (error.code == 51) {
            DEBUGSUCCESSLOG(@"不在规定区域内")
        }
    }];
}

/**
 *  取得指定位置的摄像头
 *
 *  @param position 摄像头位置
 *
 *  @return 摄像头设备
 */
-(AVCaptureDevice *)getCameraDeviceWithPosition:(AVCaptureDevicePosition )position{
    NSArray *cameras= [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

/**
 *  拍照按钮方法
 */
- (void)takeVideo{
    
    //判断是否在录制,如果在录制，就停止，并设置按钮title
    if ([self.captureMovieFileOutput isRecording]) {
        [self.captureMovieFileOutput stopRecording];
        
        //暂停
        [self.videoTimeer setFireDate:[NSDate distantFuture]];
        [CustomeClass hudShowWithView:self.view Tag:12345678];
        return;
    }
    
    //开始
    self.timeLength = 0;
    [self.videoTimeer setFireDate:[NSDate distantPast]];
    
    //开始启动定位展示ar内容
    [self startGetLocation];
    
    //开始录制视频
    //转为视频保存的url
    self.videoNum = self.videoNum + 1;
    NSString * videoPath = [NSString stringWithFormat:@"%@/materialVideo%ld.mp4", [CustomeClass createFileAtSandboxWithName:@"tempVideo"],
                                                                                  (unsigned long)self.videoNum];
    NSURL *url = [NSURL fileURLWithPath:videoPath];
    
    //开始录制,并设置控制器为录制的代理
    [self.captureMovieFileOutput startRecordingToOutputFileURL:url
                                             recordingDelegate:self];
}

/**
 *  保存缩略图并展示在table上
 */
- (void)saveThumailAndShowWithLocalUrl:(NSString *)localUrl AssetUrl:(NSString *)assetUrl{
    
    //生成缩略图
    NSString * videoPath = [NSString stringWithFormat:@"%@/materialVideo%ld.mp4", [CustomeClass createFileAtSandboxWithName:@"tempVideo"],
                                                                                  (unsigned long)self.videoNum];
    UIImage * videoThumailImage = [CustomeClass getThumbnailImageWithUrl:videoPath];
    WEAKSELF2
    if (videoThumailImage) {
        MAINQUEUEUPDATEUI({
            
            //保存对应数据到最近视频数组中
            TempVideoOBj * tempVideoObj = [TempVideoOBj new];
            tempVideoObj.videoUrl = videoPath;
            tempVideoObj.videoThumailImage = videoThumailImage;
            tempVideoObj.videoLength = weakSelf.timeLength;
            tempVideoObj.localUrl = localUrl;
            tempVideoObj.assUrl = assetUrl;
            tempVideoObj.createTime = [CustomeClass getCurrentTimeWithFormatter:@"YYYY/MM/dd-hh:mm:ss"];
            
            //如果此时ar信息数组中有元素，就保存到该对象中
            if (weakSelf.arMuArray.count > 0) {
                NSDictionary *arInfo = weakSelf.arMuArray[0][@"ARInfoDictionary"];
                tempVideoObj.arid =arInfo[@"arid"];
            }
            
            //使用通知将视频添加到videoTable上
            POSTNOTI(SHOWVIDEOATVIDEOTABLE, @{SHOWVIDEOTHUMAILIMAGE:tempVideoObj});
            [CustomeClass hudHiddenWithView:weakSelf.view Tag:12345678];
        })
    }else{
        [self saveThumailAndShowWithLocalUrl:localUrl AssetUrl:assetUrl];
    }
}

/**
 *  使用视频按钮方法
 */
- (void)useVideo{
    NSArray * videoInfoArray = self.cameraControllView.videoShowView.dataMuArray;
    for (TempVideoOBj * tempVideoObj in videoInfoArray) {
        
        //先判断是否超出规定范围
        if (self.materialNum + 1 > 20) {
            [CustomeClass showMessage:@"素材数量超过限制" ShowTime:3];
            return;
        }
        
        if (self.currentTimeLength + tempVideoObj.videoLength > 180) {
            [CustomeClass showMessage:@"素材时长超过180s" ShowTime:3];
            return;
        }
        
        NewOrderVideoMaterial * addItem = [NewOrderVideoMaterial new];
        addItem.createTime = tempVideoObj.createTime;
        addItem.order_id = [self.currentOrderId intValue];
        addItem.material_type = 2;
        addItem.material_playduration = tempVideoObj.videoLength;
        addItem.material_index = 0;
        addItem.material_localURL = tempVideoObj.localUrl;
        addItem.material_ossURL = @"";
        addItem.material_stream = tempVideoObj.videoThumailImage;
        addItem.material_assetsURL = tempVideoObj.assUrl;
        addItem.arId = tempVideoObj.arid;
        [MC_OrderAndMaterialCtrl MC_AddMaterial:[CURRENTUSERID intValue]
                                       Material:addItem
                                        Orderid:[self.currentOrderId intValue]];
    }
    
    //传回视频
    self.addVideoMaterail(videoInfoArray);
    
    //返回上个页面
    [self popLastVc];
}

/**
 *  保存视频到沙盒
 */
- (void)saveVideoToSandBox{
    NSString * videoPath = [NSString stringWithFormat:@"%@/materialVideo%ld.mp4", [CustomeClass createFileAtSandboxWithName:@"tempVideo"],
                                                                                 (unsigned long)self.videoNum];
    
    WEAKSELF2
    //保存沙盒中的视频到相册
    [[XMNPhotoManager sharedManager] saveVideoWithLocalUrl:videoPath
                                                  Complete:^(NSString *assetUrl) {
                                                      if (assetUrl) {
                                                          NSURL *url = [NSURL URLWithString:assetUrl];
                                                          PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[url]
                                                                                                                   options:nil];
                                                          PHAsset *asset = fetchResult.firstObject;
                                                          PHAssetResource *assetResource = [[PHAssetResource assetResourcesForAsset:asset] firstObject];
                                                          
                                                          //获得本地url
                                                          NSString * fileName = assetResource.originalFilename;
                                                          NSString * kCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                                                                                        NSUserDomainMask,
                                                                                                                        YES) objectAtIndex:0];
                                                          NSString * videoPath = [[NSString alloc] initWithFormat:@"%@/%@", kCachesPath, fileName];
                                                          [weakSelf saveThumailAndShowWithLocalUrl:videoPath
                                                                                          AssetUrl:assetUrl];
                                                      }
                                                  }];
}

/**
 *  计时器方法
 */
- (void)function:(NSTimer *)videoTimer{
    self.timeLength++;
    self.timeLabel.text = [NSString stringWithFormat:@"%ld:%ld", (long)self.timeLength / 60, (long)self.timeLength % 60];
}

/**
 *  释放定时器
 */
- (void)deallocTimer{
    if (self.videoTimeer) {
        [self.videoTimeer invalidate];
        self.videoTimeer = nil;
    }
}

/**
 *  dealloc地理位置控制对象
 */
- (void)deallocLocationManager{
//    if (self.locationManager) {
//        [self.locationManager stopUpdatingLocation];
//        self.locationManager.delegate = nil;
//        self.locationManager = nil;
//    }
}

/**
 *  返回上个页面（必须使用这个方法返回上个界面，否则控制器无法dealloc）
 */
- (void)popLastVc{
//    [self deallocLocationManager];
    [self deallocTimer];
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  获得音频输入设备
 */
- (AVCaptureDevice *)getVoiceInputDevice{
    
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    return audioCaptureDevice;
}

#pragma mark - 懒加载

/**
 *  定位控制对象
 */
//- (CLLocationManager *)locationManager{
//    if (!_locationManager) {
//        _locationManager = [CLLocationManager new];
//        _locationManager.delegate = self;
//        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//        [_locationManager requestAlwaysAuthorization];
//    }
//    return _locationManager;
//}

/**
 *  相机控制view
 */
- (CameraView *)cameraControllView{
    if (!_cameraControllView) {
        _cameraControllView = [[CameraView alloc] initWithFrame:CGRectMake(0,
                                                                           0,
                                                                           ISScreen_Width,
                                                                           ISScreen_Height)];
        WEAKSELF2
        
        //取消按钮执行的代码
        [_cameraControllView setCancleBlock:^{
            [weakSelf popLastVc];
        }];
        
        //拍摄按钮执行的方法
        [_cameraControllView setTakeVideoBlock:^(UILabel * takePropmtLabel,
                                                 UIButton * takeVideoButton){
            //如果点击开始录制的话就开始保存，点击暂停的化就暂停保存
            [weakSelf takeVideo];
            weakSelf.timeLabel = takePropmtLabel;
        }];
        
        //使用视频方法
        [_cameraControllView setUseVideoBlock:^(){
            [weakSelf useVideo];
        }];
    }
    return _cameraControllView;
}

/**
 *  计时器
 */
- (NSTimer *)videoTimeer{
    if (!_videoTimeer) {
        _videoTimeer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(function:)
                                                      userInfo:nil
                                                       repeats:YES];
    }
    return _videoTimeer;
}

/**
 *  懒加载视频预览层，用于实时展示摄像头状态
 */
- (AVCaptureVideoPreviewLayer *)captureVideoPreviewLayer{
    if (!_captureVideoPreviewLayer) {
        _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]
                                     initWithSession:self.captureSession];
        _captureVideoPreviewLayer.frame = CGRectMake(0,
                                                     0,
                                                     ISScreen_Width,
                                                     ISScreen_Height + 64);
    
        _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _captureVideoPreviewLayer;
}

/**
 *  初始化回话（用于输入和输出之间的设置传递）
 */
- (AVCaptureSession *)captureSession{
    if (!_captureSession) {
        _captureSession = [AVCaptureSession new];
        if ([_captureSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
            [_captureSession setSessionPreset:AVCaptureSessionPreset1280x720];
        }
        if ([_captureSession canAddInput:self.captureDeviceInput]) {
            [_captureSession addInput:self.captureDeviceInput];
            [_captureSession addInput:self.audioCaptureDeviceInput];
            AVCaptureConnection * captureConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
            if ([captureConnection isVideoStabilizationSupported]) {
                captureConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
            }
        }
        if ([_captureSession canAddOutput:self.captureMovieFileOutput]) {
            [_captureSession addOutput:self.captureMovieFileOutput];
        }
        [self.view.layer addSublayer:self.captureVideoPreviewLayer];
        [self.view addSubview:self.cameraControllView];
        [self.view bringSubviewToFront:self.cameraControllView];
    }
    return _captureSession;
}

/**
 *  初始化获得视频输入数据对象
 */
- (AVCaptureDeviceInput *)captureDeviceInput{
    if (!_captureDeviceInput) {
        NSError *error=nil;
        
        //根据输入设备初始化设备输入对象，用于获得输入数据
        _captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self getCameraDeviceWithPosition:AVCaptureDevicePositionBack]
                                                                     error:&error];
        if (error) {
            NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
            return nil;
        }
    }
    return _captureDeviceInput;
}

/**
 *  初始化获得音频输入对象
 */
- (AVCaptureDeviceInput *)audioCaptureDeviceInput{
    if (!_audioCaptureDeviceInput) {
        NSError * error = nil;
        _audioCaptureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self getVoiceInputDevice]
                                                                          error:&error];
        if (error) {
            NSLog(@"取得设备输入对象时出错，错误原因：%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioCaptureDeviceInput;
}

/**
 *  初始化数据输出对象
 */
- (AVCaptureMovieFileOutput *)captureMovieFileOutput{
    if (!_captureMovieFileOutput) {
        _captureMovieFileOutput = [AVCaptureMovieFileOutput new];
    }
    return _captureMovieFileOutput;
}

/**
 *  初始化ar信息数组
 */
- (NSMutableArray *)arMuArray{
    if (!_arMuArray) {
        _arMuArray = [NSMutableArray new];
    }
    return _arMuArray;
}
@end
