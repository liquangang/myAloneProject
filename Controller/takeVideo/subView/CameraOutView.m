//
//  CameraOutView.m
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CameraOutView.h"
#import <AVFoundation/AVFoundation.h>
#import "CustomeClass.h"
#import "XMNPhotoManager.h"

@interface CameraOutView()<AVCaptureFileOutputRecordingDelegate>
//负责输入和输出设置之间的数据传递
@property (strong, nonatomic) AVCaptureSession *captureSession;
//负责从AVCaptureDevice获得视频输入数据
@property (strong, nonatomic) AVCaptureDeviceInput *captureDeviceInput;
//获得声音输入数据
@property (nonatomic, strong) AVCaptureDeviceInput *audioCaptureDeviceInput;
//视频输出流
@property (strong, nonatomic) AVCaptureMovieFileOutput *captureMovieFileOutput;
//相机拍摄预览图层
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
//视频保存本地地址
@property (nonatomic, copy) NSString *videoLocalURL;
//拍摄时长
@property (nonatomic, assign) NSInteger timeLength;
@end

@implementation CameraOutView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //接收计时器的通知
        REGISTEREDNOTI(setPropmtLabelText:, timerIntervalMethod);
    }
    return self;
}

#pragma mark - AVCaptureFileOutputRecordingDelegate

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

#pragma mark - 功能模块

/**
 *  计时器通知
 */
- (void)setPropmtLabelText:(NSNotification *)noti{
    self.timeLength++;
}

/**
 *  保存视频到沙盒
 */
- (void)saveVideoToSandBox{
    WEAKSELF2
    //保存沙盒中的视频到相册
    [[XMNPhotoManager sharedManager] saveVideoWithLocalUrl:self.videoLocalURL Complete:^(NSString *assetUrl) {
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
            NSString * localURL = [[NSString alloc] initWithFormat:@"%@/%@", kCachesPath, fileName];
            [weakSelf saveThumailAndShowWithLocalUrl:localURL AssetUrl:assetUrl];
        }
    }];
}

/**
 *  保存缩略图并展示在table上
 */
- (void)saveThumailAndShowWithLocalUrl:(NSString *)localUrl AssetUrl:(NSString *)assetUrl{
    
    //生成缩略图
    UIImage * videoThumailImage = [CustomeClass getThumbnailImageWithUrl:self.videoLocalURL];
    WEAKSELF2
    if (videoThumailImage) {
        MAINQUEUEUPDATEUI({
            
            //保存对应数据到最近视频数组中
            TempVideoOBj * tempVideoObj = [TempVideoOBj new];
            tempVideoObj.videoUrl = weakSelf.videoLocalURL;
            tempVideoObj.videoThumailImage = videoThumailImage;
            tempVideoObj.videoLength = weakSelf.timeLength;
            tempVideoObj.localUrl = localUrl;
            tempVideoObj.assUrl = assetUrl;
            tempVideoObj.createTime = [CustomeClass getCurrentTimeWithFormatter:@"YYYY/MM/dd-hh:mm:ss"];
            weakSelf.saveFinishBlock(tempVideoObj);
        })
    }else{
        [self saveThumailAndShowWithLocalUrl:localUrl AssetUrl:assetUrl];
    }
}

/**
 *  开始保存拍摄数据（即开始拍摄）
 */
- (void)startSaveVideoWithPath:(NSString *)videoSavePath{
    
    //判断是否在录制,如果在录制，就停止，并设置按钮title
    if ([self.captureMovieFileOutput isRecording]) {
        [self.captureMovieFileOutput stopRecording];
        return;
    }
    
    self.timeLength = 0;
    self.videoLocalURL = videoSavePath;
    NSURL *videoSaveURL = [NSURL fileURLWithPath:videoSavePath];
    
    //开始录制,并设置控制器为录制的代理
    [self.captureMovieFileOutput startRecordingToOutputFileURL:videoSaveURL
                                             recordingDelegate:self];
}

/**
 *  停止保存拍摄数据，暂停拍摄
 */
- (void)stopSaveVideo{
    //判断是否在录制,如果在录制，就停止，并设置按钮title
    if ([self.captureMovieFileOutput isRecording]) {
        [self.captureMovieFileOutput stopRecording];
    }
}

/**
 *  开始展示拍摄画面
 */
- (void)startShowCameraImage{
    [self.captureSession startRunning];
}

/**
 *  结束拍摄画面展示
 */
- (void)stopShowCameraImage{
    [self.captureSession stopRunning];
}

/**
 *  切换镜头
 */
- (void)changeCamera{
    NSArray *inputs = self.captureSession.inputs;
    for (AVCaptureDeviceInput *input in inputs ) {
        AVCaptureDevice *device = input.device;
        if ( [device hasMediaType:AVMediaTypeVideo] ) {
            AVCaptureDevicePosition position = device.position;
            AVCaptureDevice *newCamera = nil;
            AVCaptureDeviceInput *newInput = nil;
            
            if (position ==AVCaptureDevicePositionFront)
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            else
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            // beginConfiguration ensures that pending changes are not applied immediately
            [self.captureSession beginConfiguration];
            
            [self.captureSession removeInput:input];
            newInput ? [self.captureSession addInput:newInput] : nil;
            
            // Changes take effect once the outermost commitConfiguration is invoked.
            [self.captureSession commitConfiguration];
            break;
        }
    }
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
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
 *  获得音频输入设备
 */
- (AVCaptureDevice *)getVoiceInputDevice{
    
    //添加一个音频输入设备
    AVCaptureDevice *audioCaptureDevice = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio] firstObject];
    return audioCaptureDevice;
}

/**
 *  打开闪光灯
 */
-(void)turnOnLed{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOn];
        [device unlockForConfiguration];
    }   
}

/**
 *  关闭闪光灯
 */
-(void)turnOffLed{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        [device setTorchMode: AVCaptureTorchModeOff];
        [device unlockForConfiguration];
    }   
}

#pragma mark - 懒加载
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
        
        //使用这个初始化layer
        [self.layer addSublayer:self.captureVideoPreviewLayer];
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

@end
