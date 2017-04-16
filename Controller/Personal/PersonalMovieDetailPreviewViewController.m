//
//  PersonalMovieDetailPreviewViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/4/19.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "PersonalMovieDetailPreviewViewController.h"
#import "ShareViewController.h"
#import "UMSocial.h"

@implementation PersonalMovieDetailPreviewViewController

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"HomeVCPushCollectionIdentifier_segue"]) {
    } else if([identifier isEqualToString:@"MyfavouriteIndentifier_segue"]){
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
    self.ownerAcatarButton.layer.masksToBounds = YES;
    self.ownerAcatarButton.layer.cornerRadius = 29;
    [self.ownerAcatarButton setBackgroundImage:[[APPUserPrefs Singleton]APP_getImg:[Video Singleton].ownerAcatar ImageView:self.ownerAcatarButton.imageView ImageName:@"head"] forState:UIControlStateNormal];
    self.videoThumbnailUrlImage.image = [[APPUserPrefs Singleton]APP_getImg:[Video Singleton].videoThumbnailUrl ImageView:self.videoThumbnailUrlImage ImageName:@"huan"];
    self.videoNameLabel.text = [Video Singleton].videoName;
    self.ownerNameLabel.text = [Video Singleton].ownerName;
    self.videoCreateTimeLabel.text = [Video Singleton].videoCreateTime;
    self.videoNumberOfPraiseLabel.text = [Video Singleton].videoNumberOfPraise;
//    self.videoNumberOfShareLabel.text = [Video Singleton].videoNumberOfShare;
    
    int num = [[APPUserPrefs Singleton] APP_getShareNumByVideoID:[[Video Singleton].videoID intValue]];
    self.videoNumberOfShareLabel.text = [NSString stringWithFormat:@"%d", num];
    
    PersonalInformationSet *personalInformationSet = [[PersonalInformationSet alloc] init];
    personalInformationSet = [APPUserPrefs APP_getcustomerinfoex];
    self.personalizedSignatureLabel.text = personalInformationSet.userCelebratedDictum;
    int videoShare = [[Video Singleton].videoShare intValue];
    if (videoShare == 1) {
        [self.changVideoShare setBackgroundImage:[UIImage imageNamed:@"public"] forState:UIControlStateNormal];
    }else{
        [self.changVideoShare setBackgroundImage:[UIImage imageNamed:@"public-1"] forState:UIControlStateNormal];
    }
    self.player = [[NGMoviePlayer alloc] init];
    self.player.autostartWhenReady = YES;
    self.player.delegate = self;
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.view.bounds.size.width-10,(self.view.bounds.size.width-10)/720*408)];
    self.containerView.backgroundColor = [UIColor darkTextColor];
    [self.player addToSuperview:self.containerView withFrame:self.containerView.bounds];
    [self.view addSubview:self.containerView];
    NSLog(@"Play URL = %@",[Video Singleton].videoReferenceUrl);
    [self.player setURL:[NSURL URLWithString:[Video Singleton].videoReferenceUrl] title:[Video Singleton].videoName];
}

- (IBAction)transportButtonAction:(id)sender {
//    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Backup" bundle:nil];
//    ShareViewController *sharVC =[secondStoryBoard instantiateViewControllerWithIdentifier:@"ShareVCStoryboardID"];
//    [self.navigationController pushViewController:sharVC animated:YES];

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
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:@"55f9088b67e58e3dbd000488"
//                                      shareText:showmes
//                                     shareImage:self.videoThumbnailUrlImage.image
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,nil]
//                                       delegate:self];
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
    int number = [[Video Singleton].videoID intValue];
    int ret = -1;
    ret = [APPUserPrefs APP_praisevideobyid:number];
    if (ret == 0) {
        int tmp = [[Video Singleton].videoNumberOfPraise intValue] + 1;
        [Video Singleton].videoNumberOfPraise = [NSString stringWithFormat:@"%d",tmp];
        self.videoNumberOfPraiseLabel.text = [NSString stringWithFormat:@"%d",tmp];
    }
}

- (IBAction)actSheet:(id)sender
{
    int videoShare = [[Video Singleton].videoShare intValue];// 0 视频未公开   1 视频已公开
    [self InitActionSheet:videoShare];
    [_actionSheet showInView:self.view];

}

-(void)InitActionSheet:(int)open{
    if (open == 0 ) {
        _actionSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"公开",@"下载", @"删除", nil];
    }else{
        _actionSheet = [[UIActionSheet alloc]
                       initWithTitle:nil
                       delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"未公开",@"下载", @"删除", nil];
    }
    
}

- (IBAction)clickSave:(id)sender
{
    int number = [[Video Singleton].videoID intValue];
    int ret = -1;
    ret = [[APPUserPrefs Singleton] APP_markfavoritebyid:number Status:YES];
    if (ret == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MessageBox" message:@"" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)delateVideo:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MessageBox" message:@"是否确定删除视频？" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES",nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }else{
        int number = [[Video Singleton].videoID intValue];
        int ret = -1;
        ret = [[APPUserPrefs Singleton] APP_delateprivatepersonvideo:number];
        if (ret == 0) {
            VideoInformationObject *videoInformationObject = [[VideoInformationObject alloc] init];
            videoInformationObject = [Video Singleton];
            [[APPUserPrefs Singleton] APP_PrivatePageVideoCacheInformationDBDelete:videoInformationObject];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MessageBox" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
}

- (IBAction)updateVideoStatus:(id)sender
{
    int number = [[Video Singleton].videoID intValue];
    int videoShare = [[Video Singleton].videoShare intValue];
    [self InitActionSheet:videoShare];
    BOOL videoStatu;
    if (videoShare == 1) {
        videoStatu = NO;
        [self.changVideoShare setBackgroundImage:[UIImage imageNamed:@"public-1"] forState:UIControlStateNormal];
    }else{
        videoStatu = YES;
        [self.changVideoShare setBackgroundImage:[UIImage imageNamed:@"public"] forState:UIControlStateNormal];
    }
    int ret = -1;
    ret = [[APPUserPrefs Singleton] APP_updatevideostatus:number VideoStatus:videoStatu];
    if (ret == 0) {
        if (videoStatu) {
            [Video Singleton].videoShare = @"1";
            VideoInformationObject *videoInformationObject = [[VideoInformationObject alloc] init];
            videoInformationObject.videoID = [Video Singleton].videoID;
            videoInformationObject.videoName = [Video Singleton].videoName;
            videoInformationObject.ownerID = [Video Singleton].ownerID;
            videoInformationObject.ownerName = [Video Singleton].ownerName;
            videoInformationObject.ownerAcatar = [Video Singleton].ownerAcatar;
            videoInformationObject.videoLabelName = [Video Singleton].videoLabelName;
            videoInformationObject.videoCreateTime = [Video Singleton].videoCreateTime;
            videoInformationObject.videoThumbnailUrl = [Video Singleton].videoThumbnailUrl;
            videoInformationObject.videoReferenceUrl = [Video Singleton].videoReferenceUrl ;
            videoInformationObject.videoNumberOfPraise = [Video Singleton].videoNumberOfPraise;
            videoInformationObject.videoNumberOfShare = [Video Singleton].videoNumberOfShare;
            videoInformationObject.videoNumberOfFavorite = [Video Singleton].videoNumberOfFavorite;
            videoInformationObject.videoCollectStatus = [Video Singleton].videoCollectStatus;
            videoInformationObject.videoShare = [Video Singleton].videoShare;
            [[APPUserPrefs Singleton] APP_insertvideofromhome:videoInformationObject];
        }else{
            [Video Singleton].videoShare = @"0";
            [[APPUserPrefs Singleton] APP_deletevideofromhome:[[Video Singleton].videoID intValue]];
        }
    }
}


#pragma mark -- UIActionSheetDelegate --
//根据被点击按钮的索引处理点击事件
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *text = [actionSheet buttonTitleAtIndex:buttonIndex];
    if (buttonIndex == 0 ) {//公开或者非公开
        [self updateVideoStatus:self.changVideoShare];
    }else if([text compare:@"删除"] == NSOrderedSame){
        [self delateVideo:self.videoCollectStatusButton];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"MessageBox" message:@"暂不支持下载？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];
        [alert show];

    }
//    NSLog(@"clickedButtonAtIndex:%d",buttonIndex);
}
//A

@end
