//
//  MovieDetailPreviewViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/2/1.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "MovieDetailPreviewViewController.h"
#import "ShareViewController.h"
#import "LoginViewController.h"
//#import "UMSocial.h"
#import "APPUserPrefs.h"
#import "SoapOperation.h"


#define First @"带有色情内容或敏感话题"
#define Second @"涉嫌盗用他人作品"
#define Three @"自主描述"
#define Four @"确定举报这段视频吗?"

@implementation MovieDetailPreviewViewController

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"HomeVCPushCollectionIdentifier_segue"]){
    }else if([identifier isEqualToString:@"MyFavouriteIndentifier_segue"]){
    }else if([identifier isEqualToString:@"PersonVCPushDeleteIdentifier_segue"]){
    }
}

-(UIImage *)scaleImage:(UIImage *)img ToSize:(CGSize)itemSize{
    UIImage *i;
    // 创建一个bitmap的context,并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(itemSize);
    CGRect imageRect=CGRectMake(0, 0, itemSize.width, itemSize.height);
    // 绘制改变大小的图片
    [img drawInRect:imageRect];
    // 从当前context中创建一个改变大小后的图片
    i=UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return i;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    actionselect = 0;
    select = 0;
    clickedable = 0;
    self.ownerAcatarButton.layer.masksToBounds = YES;
    self.ownerAcatarButton.layer.cornerRadius = 29;
    [self.ownerAcatarButton setBackgroundImage:[[APPUserPrefs Singleton]APP_getImg:[Video Singleton].ownerAcatar ImageView:self.ownerAcatarButton.imageView ImageName:@"head"] forState:UIControlStateNormal];
    
    self.videoThumbnailUrlImage.image = [[APPUserPrefs Singleton]APP_getImg:[Video Singleton].videoThumbnailUrl ImageView:self.videoThumbnailUrlImage ImageName:@"huan"];
    self.videoNameLabel.text = [Video Singleton].videoName;
    self.ownerNameLabel.text = [Video Singleton].ownerName;
    self.videoCreateTimeLabel.text = [Video Singleton].videoCreateTime;
    self.videoNumberOfPraiseLabel.text = [Video Singleton].videoNumberOfPraise;
    
    int num = [[APPUserPrefs Singleton] APP_getShareNumByVideoID:[[Video Singleton].videoID intValue]];
    NSLog(@"-----%d", num);
    
//    self.videoNumberOfShareLabel.text = [Video Singleton].videoNumberOfShare;
    self.videoNumberOfShareLabel.text = [NSString stringWithFormat:@"%d", num];
    self.videoPlayNumLabel.text = [Video Singleton].videoPlayCount;
    if ([UserEntity sharedSingleton].vdcLoginret != 0) {
        [self.praiseButton setBackgroundImage:[UIImage imageNamed:@"press_praise"] forState:UIControlStateNormal];
        [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"Collection_button_h"] forState:UIControlStateNormal];
        
    }else{
        if ([[APPUserPrefs Singleton] APP_getpraisestatus:[[Video Singleton].videoID intValue]] == 0) {
            [self.praiseButton setBackgroundImage:[UIImage imageNamed:@"press_praise"] forState:UIControlStateNormal];
        }else{
            [self.praiseButton setBackgroundImage:[UIImage imageNamed:@"press_praise_h"] forState:UIControlStateNormal];
        }
        if ([[APPUserPrefs Singleton] APP_getfavouritestatus:[[Video Singleton].videoID intValue]] == 0) {
            [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"Collection_button_h"] forState:UIControlStateNormal];
        }else{
            [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"Collection_button"] forState:UIControlStateNormal];
        }
    }
    self.personalizedSignatureLabel.text = [Video Singleton].videoSignature;
    
//    self.player = [[NGMoviePlayer alloc] init];
//    self.player.autostartWhenReady = YES;
////    self.player.dataSource = self;
//    self.player.delegate = self;
    
    self.vkplayer = [[VKVideoPlayer alloc]init];
    self.vkplayer.delegate = self;
    self.vkplayer.forceRotate = YES;
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.view.bounds.size.width-10,(self.view.bounds.size.width-10)/720*408)];
    self.containerView.backgroundColor = [UIColor darkTextColor];
    [self playFrameSet];
//    [self.player addToSuperview:self.containerView withFrame:self.containerView.bounds];
    [self.view addSubview:self.containerView];
//    [self.player setURL:[NSURL URLWithString:[Video Singleton].videoReferenceUrl] title:[Video Singleton].videoName];
    [self playStream:[NSURL URLWithString:[Video Singleton].videoReferenceUrl]];
//    [self.vkplayer setCaptionToTop:[self testCaption:[Video Singleton].videoName]];
    
}

-(void)playFrameSet{
    CGRect frameRect = self.containerView.frame;
//    frameRect.origin.y += NavigationBar_HEIGHT+20;
//    frameRect.size.height = frameRect.size.width*9/16;
    self.player.view.frame = frameRect;
}
- (void)playStream:(NSURL*)url {
    VKVideoPlayerTrack *track = [[VKVideoPlayerTrack alloc] initWithStreamURL:url];
    [self.vkplayer loadVideoWithTrack:track];
}

#pragma mark -- 分享
- (IBAction)transportButtonAction:(id)sender {
//    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
    if ([[APPUserPrefs Singleton] AutoLogin] != NOW_LOGIN ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"请先登录!" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    NSString *videoUrl = [[NSString alloc] initWithFormat:shareURL,[Video Singleton].videoID];
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeVideo url:videoUrl];
    NSString *showmes;
    if ([self.videoNameLabel.text isEqualToString:@""]) {
        showmes = @"映像让记忆更精彩！";
    }else
        showmes =self.videoNameLabel.text;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55f9088b67e58e3dbd000488"
                                      shareText:showmes
                                     shareImage:self.videoThumbnailUrlImage.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,nil]
                                       delegate:self];
}

#pragma mark -- UMSocialUIDelegate
- (void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response {
    if (response.responseCode == UMSResponseCodeSuccess) {      // 分享成功
        int videoID = [[Video Singleton].videoID intValue];
        int ret = [[APPUserPrefs Singleton] APP_increaseShareNumByVideoID:videoID];
        if (ret == -1) {
            NSLog(@"转发失败----%d", ret);
        } else {    // 更新界面显示的转发数量
//            int num = [[APPUserPrefs Singleton] APP_getShareNumByVideoID:[[Video Singleton].videoID intValue]];
            self.videoNumberOfShareLabel.text = [NSString stringWithFormat:@"%d", ret];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
    [self.player setURL:nil];
}

- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didChangeControlStyle:(NGMoviePlayerControlStyle)controlStyle {
    if (controlStyle == NGMoviePlayerControlStyleInline) {
        [self updateToOrientation:UIDeviceOrientationPortrait];
        [self.navigationController setNavigationBarHidden:NO];
    } else {
        [self.navigationController setNavigationBarHidden:YES];
        [self updateToOrientation:UIDeviceOrientationLandscapeLeft];
    }
}

- (void)updateToOrientation:(UIDeviceOrientation)orientation
{
    CGRect bounds = [[ UIScreen mainScreen ] bounds ];
    CGRect videoBounds = [[ UIScreen mainScreen ] bounds ];
    CGAffineTransform t;
    CGFloat r = 0;
    switch (orientation ) {
        case UIDeviceOrientationLandscapeRight:
            r = -(M_PI / 2);
            break;
        case UIDeviceOrientationLandscapeLeft:
            r  = M_PI / 2;
            break;
        default :
            break;
    }
    if( r != 0 ){
        CGSize sz = bounds.size;
        bounds.size.width = sz.height;
        bounds.size.height = sz.width;
        videoBounds = bounds;
        t = CGAffineTransformMakeRotation( r );
        UIApplication *application = [ UIApplication sharedApplication ];
        [UIView animateWithDuration:[ application statusBarOrientationAnimationDuration ] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
            self.containerView.transform = t;
        }completion:^(BOOL finish){
            self.containerView.bounds = videoBounds;
            self.containerView.center = CGPointMake(CGRectGetHeight(bounds)/2, CGRectGetWidth(bounds)/2);
        }];
        [application setStatusBarOrientation:(UIInterfaceOrientation)orientation animated: YES ];
    }else{
        CGSize sz = bounds.size;
        sz.width = bounds.size.width>bounds.size.height?bounds.size.height:bounds.size.width;
        sz.height = bounds.size.width<bounds.size.height?bounds.size.height:bounds.size.width;

        videoBounds.origin.y = 5.0;
        videoBounds.origin.x = 5.0;
        videoBounds.size.width = sz.width-10;
        videoBounds.size.height = (sz.width-10)/720*408;
//            self.wantsFullScreenLayout = NO;
        t = CGAffineTransformMakeRotation( r );
        UIApplication *application = [ UIApplication sharedApplication ];
        [UIView animateWithDuration:[ application statusBarOrientationAnimationDuration ] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
//            self.containerView.bounds
            self.containerView.transform = t;
            self.containerView.frame = videoBounds;
//            self.containerView.center = CGPointMake(CGRectGetWidth(videoBounds)/2+2.5, CGRectGetHeight(videoBounds)/2+2.5);
        }completion:^(BOOL finish){

        }];
        [application setStatusBarOrientation:(UIInterfaceOrientation)orientation animated: YES ];
    }
}

- (IBAction)clickPraise:(id)sender
{
    if ([UserEntity sharedSingleton].vdcLoginret != 0) {
        [self Notloggedin];
    }else{
        if ([[APPUserPrefs Singleton] APP_getpraisestatus:[[Video Singleton].videoID intValue]] == 0) {
            [self.praiseButton setBackgroundImage:[UIImage imageNamed:@"press_praise_h"] forState:UIControlStateNormal];
            int ret = -1;
            ret = [APPUserPrefs APP_praisevideobyid:[[Video Singleton].videoID intValue]];
            if (ret == 0) {
                int tmp = [[Video Singleton].videoNumberOfPraise intValue] + 1;
                [Video Singleton].videoNumberOfPraise = [NSString stringWithFormat:@"%d",tmp];
                self.videoNumberOfPraiseLabel.text = [NSString stringWithFormat:@"%d",tmp];
                VideoInformationObject *videoInformationObject = [[VideoInformationObject alloc] init];
                videoInformationObject = [Video Singleton];
                [[APPUserPrefs Singleton] APP_HomePageVideoCacheInformationDBChange:videoInformationObject];
            }
        }else{
            [self.praiseButton setBackgroundImage:[UIImage imageNamed:@"press_praise"] forState:UIControlStateNormal];
            int ret = -1;
            ret = [APPUserPrefs APP_unpraisevideobyid:[[Video Singleton].videoID intValue]];
            if (ret == 0) {
                int tmp = [[Video Singleton].videoNumberOfPraise intValue] - 1;
                [Video Singleton].videoNumberOfPraise = [NSString stringWithFormat:@"%d",tmp];
                self.videoNumberOfPraiseLabel.text = [NSString stringWithFormat:@"%d",tmp];
                VideoInformationObject *videoInformationObject = [[VideoInformationObject alloc] init];
                videoInformationObject = [Video Singleton];
                [[APPUserPrefs Singleton] APP_HomePageVideoCacheInformationDBChange:videoInformationObject];
            }
        }
    }
}

#pragma mark -- 保存
- (IBAction)clickSave:(id)sender
{
    if ([UserEntity sharedSingleton].vdcLoginret != 0) {
        [self Notloggedin];
    }else{
        if ([[APPUserPrefs Singleton] APP_getfavouritestatus:[[Video Singleton].videoID intValue]] == 0) {
            int ret = -1;
            ret = [[APPUserPrefs Singleton] APP_markfavoritebyid:[[Video Singleton].videoID intValue] Status:YES];
            if (ret == 0) {
                [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"Collection_button"] forState:UIControlStateNormal];
            }
        }else{
            int ret = -1;
            ret = [[APPUserPrefs Singleton] APP_markfavoritebyid:[[Video Singleton].videoID intValue] Status:NO];
            if (ret == 0) {
                [self.collectionButton setBackgroundImage:[UIImage imageNamed:@"Collection_button_h"] forState:UIControlStateNormal];
            }
        }
    }
}


- (void)iphoneButtonClick{
    NSLog(@"---------------iphoneButtonClick---------------");
    LoginViewController *loginVC =[self.storyboard instantiateViewControllerWithIdentifier:@"Login"] ;
    [self.navigationController pushViewController:loginVC animated:YES];
    [self popBackViewAnimation];
    [self performSelector:@selector(windowHidden) withObject:self afterDelay:.2];
}

- (void)processGestureRecongnizer:(UIGestureRecognizer *)gesture
{
    NSLog(@"------------processGestureRecongnizer-----------");
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        [self popBackViewAnimation];
        [self performSelector:@selector(windowHidden) withObject:self afterDelay:0.2];
        
    }
    
}
#pragma mark -- window 隐藏
- (void)windowHidden{
    
    [secondWindow setHidden:YES];
    
}
#pragma mark -- 从下往上弹出动画
-(void)popViewAnimation{
    [UIView beginAnimations:@"popViewAnimation" context:NULL];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [secondWindow makeKeyAndVisible];
    customLoginAlertView.frame = CGRectMake((self.view.width - 240)/2, (self.view.height - 200)/2, 240, 200);
    [UIView commitAnimations];
}
#pragma mark -- 由上往下弹回动画
-(void)popBackViewAnimation{
    [UIView beginAnimations:@"popBackViewAnimation" context:NULL];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    customLoginAlertView.frame = CGRectMake((self.view.width - 240)/2, SCREEN_HEIGHT, 240, 200);
    [UIView commitAnimations];
    
}

-(void)Notloggedin
{

    secondWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    secondWindow.windowLevel= UIWindowLevelAlert;
    secondWindow.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud_shadow"]];
    secondWindow.userInteractionEnabled = YES;
    customLoginAlertView = [[[NSBundle mainBundle]loadNibNamed:@"CustomLoginAlertView" owner:nil options:nil] lastObject];
    [customLoginAlertView.iphoneLoginButtonClick addTarget:self action:@selector(iphoneButtonClick) forControlEvents:UIControlEventTouchUpInside];
    customLoginAlertView.frame = CGRectMake((self.view.width - 240)/2, self.view.height, 240, 200);
    [secondWindow addSubview:customLoginAlertView];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(processGestureRecongnizer:)];
    [tapGesture setNumberOfTouchesRequired:1];
    [tapGesture setNumberOfTapsRequired:1];
    [secondWindow addGestureRecognizer:tapGesture];

    [self popViewAnimation];
}

- (void)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    UIView *showview =  [[UIView alloc]init];
    showview.backgroundColor = [UIColor blackColor];
    showview.frame = CGRectMake(1, 1, 1, 1);
    showview.alpha = 1.0f;
    showview.layer.cornerRadius = 5.0f;
    showview.layer.masksToBounds = YES;
    [window addSubview:showview];
    UILabel *label = [[UILabel alloc]init];
    CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
    label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
    label.text = message;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = 1;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:15];
    [showview addSubview:label];
    showview.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width - 20)/2, SCREEN_HEIGHT - 100, LabelSize.width+20, LabelSize.height+10);
    [UIView animateWithDuration:5.0 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

- (IBAction)showSheet:(id)sender
{
    actionselect = 1;
    actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:nil];
    actionsheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionsheet showInView:self.view];
}

- (void)showSheet2
{
    actionselect = 2;
    actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:First,Second,Three, nil];
    actionsheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionsheet showInView:self.view];
}

- (void)showAlert:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"取消");
    }else{
        NSLog(@"确定");
        if (![UserEntity sharedSingleton].customerId || [[UserEntity sharedSingleton].customerId isEqualToString:@""]){
            [[APPUserPrefs Singleton] App_userReport:[[Video Singleton].videoID intValue] Category:select PszRemark:@""];
            [[APPUserPrefs Singleton] APP_HomePageVideo_PersonCacheInformationDBDelete:[[Video Singleton].videoID intValue]];
            NSString *message = @"举报成功,我们会尽快处理.";
            [self showMessage:message];
        }else{
            NSString *message = @"请登录后在执行举报操作.";
            [self showMessage:message];
        }
        
    }
}

- (void)alertViewCancel:(UIAlertView *)alertView
{
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionselect == 1) {
        switch (buttonIndex) {
            case 0:
                [self showSheet2];
                break;
            case 1:
                break;
            default:
                break;
        }
    }else if (actionselect == 2){
        switch (buttonIndex) {
            case 0:
                [self showAlert:Four];
                select = 1;
                break;
            case 1:
                [self showAlert:Four];
                select = 2;
                break;
            case 2:
                select = 3;
                [self firsttosecond];
                break;
            case 3:
                break;
            default:
                break;
        }
    }
}

- (void)firsttosecond
{
    DescriptionViewController *descriptionViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"descriptionViewController"] ;
    [self.navigationController pushViewController:descriptionViewController animated:true];
}

- (void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    
}




@end
