//
//  MakeVideoHomePageViewController.m
//  M-Cut
//
//  Created by liquangang on 2017/1/17.
//  Copyright © 2017年 Crab movier. All rights reserved.
//

#import "MakeVideoHomePageViewController.h"
#import "MakeVideoHomePageView.h"
#import "MakeVideoNavigationControllerViewController.h"
#import "XMNPhotoPickerController.h"
#import "SelectMaterialArray.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "MaterialSelectViewController.h"

@interface MakeVideoHomePageViewController ()
@property (nonatomic, strong) MakeVideoHomePageView *makeVideoHomePageView;
@end

@implementation MakeVideoHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //禁止侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //打开侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

#pragma mark - interface

- (void)setUI{
    [self.view addSubview:self.makeVideoHomePageView];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)takeVideo{
    [self getAuthorizeStatus];
}

- (void)selectImage{
    [self getAlbumAuthorizationStatus];
}

- (void)togetherMake{
    
}

/**
 *  跳转拍摄界面
 */
- (void)pushToTakeVideoVc{
    MakeVideoNavigationControllerViewController *takeVideoVc = [MakeVideoNavigationControllerViewController new];
    takeVideoVc.hidesBottomBarWhenPushed = YES;
    
    [self presentViewController:takeVideoVc animated:YES completion:^{
        HIDDENHUD
    }];
}

/**  获得授权状态 */
- (void)getAuthorizeStatus{
    SHOWHUD
    WEAKSELF2
    
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(status == AVAuthorizationStatusAuthorized){
            
            //用户已经授权
            [weakSelf pushToTakeVideoVc];
        }
        else if (status == AVAuthorizationStatusDenied){
            
            //否认
            SHOWALERT(@"未获得相机的使用权限")
            return;
        }
        else if (status == AVAuthorizationStatusRestricted){
            
            //受限制
        }
        else if (status == AVAuthorizationStatusNotDetermined){
            
            //不确定
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    [weakSelf pushToTakeVideoVc];
                }
                else{
                    SHOWALERT(@"未获得相机的使用权限")
                }
            }];
        }
    }, {})
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
    
    //旧得素材选择界面
//    //获得所有的选择的素材的assurl
//    [SINGLETON(SelectMaterialArray) removeAllMaterial];
//    
//    [self initPickAndPush];
    
    MaterialSelectViewController *materialSelectVc = [MaterialSelectViewController new];
    UINavigationController *tempNav = [[UINavigationController alloc] initWithRootViewController:materialSelectVc];
    [self presentViewController:tempNav animated:YES completion:^{
       HIDDENHUD
    }];
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
    [picker setDidCancelPickingBlock:^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    [self presentViewController:picker animated:YES completion:^{
        HIDDENHUD
    }];
}

#pragma mark - getter

- (MakeVideoHomePageView *)makeVideoHomePageView{
    if (!_makeVideoHomePageView) {
        _makeVideoHomePageView = [[MakeVideoHomePageView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height - 49)];
        WEAKSELF2
        
        [_makeVideoHomePageView setTakeVideoButtonActionBlock:^{
            [weakSelf takeVideo];
        }];
        
        [_makeVideoHomePageView setSelectImageButtonActionBlock:^{
            [weakSelf selectImage];
        }];
        
        [_makeVideoHomePageView setTogetherButtonActionBlock:^{
            [weakSelf togetherMake];
        }];
    }
    return _makeVideoHomePageView;
}

@end
