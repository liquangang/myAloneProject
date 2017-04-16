//
//  FavouriteMovieDetailPreviewViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/4/19.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "FavouriteMovieDetailPreviewViewController.h"
#import "ShareViewController.h"
#import "LoginViewController.h"
#import "UMSocial.h"

#define First @"带有色情内容或敏感话题"
#define Second @"涉嫌盗用他人作品"
#define Three @"自主描述"
#define Four @"确定举报这段视频吗?"


@implementation FavouriteMovieDetailPreviewViewController

- (void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if ([identifier isEqualToString:@"HomeVCPushCollectionIdentifier_segue"]) {
        
    } else if([identifier isEqualToString:@"MyFavouriteIndentifier_segue"]){
        
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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.ownerAcatarButton.layer.masksToBounds = YES;
    self.ownerAcatarButton.layer.cornerRadius = 29;
    UIImageView *imageView = [[UIImageView alloc] init];
    UIImage *images = [[APPUserPrefs Singleton] APP_getImg:[Video Singleton].ownerAcatar ImageView:imageView ImageName:@"head"];
    UIImage *stretchableButtonImage = [images  stretchableImageWithLeftCapWidth:12  topCapHeight:0];
    [self.ownerAcatarButton setBackgroundImage:stretchableButtonImage forState:UIControlStateNormal];
    self.videoThumbnailUrlImage.image = [[APPUserPrefs Singleton]APP_getImg:[Video Singleton].videoThumbnailUrl ImageView:self.videoThumbnailUrlImage ImageName:@"huan"];
    self.videoNameLabel.text = [Video Singleton].videoName;
    self.ownerNameLabel.text = [Video Singleton].ownerName;
    self.videoCreateTimeLabel.text = [Video Singleton].videoCreateTime;
    self.videoNumberOfPraiseLabel.text = [Video Singleton].videoNumberOfPraise;
    self.videoNumberOfShareLabel.text = [Video Singleton].videoNumberOfShare;
    self.personalizedSignatureLabel.text = [Video Singleton].videoSignature;
    
    
    if ([[APPUserPrefs Singleton] APP_getpraisestatus:[[Video Singleton].videoID intValue]] == 0) {
        [self.praiseButton setBackgroundImage:[UIImage imageNamed:@"press_praise"] forState:UIControlStateNormal];
    }else{
        [self.praiseButton setBackgroundImage:[UIImage imageNamed:@"press_praise_h"] forState:UIControlStateNormal];
    }
}

- (IBAction)collectedButtonClick:(id)sender {

}

- (IBAction)transportButtonAction:(id)sender {
//    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Backup" bundle:nil];
//    ShareViewController *sharVC =[secondStoryBoard instantiateViewControllerWithIdentifier:@"ShareVCStoryboardID"];
//    [self.navigationController pushViewController:sharVC animated:YES];
    NSString *videoUrl = [[NSString alloc] initWithFormat:shareURL,[Video Singleton].videoID];
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeVideo url:videoUrl];
    NSString *showmes;
    if ([self.videoNameLabel.text isEqualToString:@""]) {
        showmes = @"映像让记忆更精彩！";
    }else
        showmes =self.videoNameLabel.text;
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:showmes
                                     shareImage:self.videoThumbnailUrlImage.image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToSina,nil]
                                       delegate:self];
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
}

- (IBAction)clickPraise:(id)sender
{
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
            [[APPUserPrefs Singleton] APP_CollectPageVideoCacheInformationDBChange:videoInformationObject];
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
            [[APPUserPrefs Singleton] APP_CollectPageVideoCacheInformationDBChange:videoInformationObject];
        }
       
    }
}

- (IBAction)clickSave:(id)sender
{
    int number = [[Video Singleton].videoID intValue];
    int ret = -1;
    
    ret = [[APPUserPrefs Singleton] APP_markfavoritebyid:number Status:NO];
    if (ret == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"" delegate:nil cancelButtonTitle:@"已取消收藏！"otherButtonTitles:nil];
        [alert show];
    }
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
    actionsheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:First otherButtonTitles:Second,Three, nil];
    actionsheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionsheet showInView:self.view];
}

- (void)showAlert:(NSString *)msg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示:" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"取消");
    }else{
        if (session._session._nCustomerID) {
            [[APPUserPrefs Singleton] App_userReport:[[Video Singleton].videoID intValue] Category:select PszRemark:@""];
            [[APPUserPrefs Singleton] APP_CollectPageVideoCacheInformationDBDeleteForID:[[Video Singleton].videoID intValue]];
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
