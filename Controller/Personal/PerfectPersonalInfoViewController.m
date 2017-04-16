//
//  PerfectPersonalInfoViewController.m
//  M-Cut
//
//  Created by 李亚飞 on 15/9/28.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "PerfectPersonalInfoViewController.h"
#import "LogOutPersonViewController.h"
#import "UserEntity.h"
#import "UMSocial.h"
#import "GlobalVars.h"
#import "UIImageView+WebCache.h"
#import "APPUserPrefs.h"
#import "ValidateFuc.h"
#import "UpDateSql.h"
//手机绑定界面
#import "TelephoneBindingViewController.h"
#import "HeaderChange.h"
#import "EditNickNameViewController.h"
#import "EditGenderViewController.h"
#import "DistrictTableViewController.h"


@interface PerfectPersonalInfoViewController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) MovierDCInterfaceSvc_VDCCustomerInfo * myUserInfo;
@end

@implementation PerfectPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setupNav];
    
    // 设置用户信息
    [self getMsgFromWeChat];
    
}

#pragma mark - downloadData
- (void)downloadData{
    [[SoapOperation Singleton] WS_QueryUserInfo:^(MovierDCInterfaceSvc_VDCCustomerInfo *info) {
        self.myUserInfo = info;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.nicknameLabel.text = info.szNickname;
            
            int gender = [info.nGender intValue];
            NSString *name;
            if (gender == 1) {
                name = [NSString stringWithFormat:@"男"];
            } else if (gender == 2 ) {
                name = [NSString stringWithFormat:@"女"];
            } else {
                name = @"";
            }
            self.sexLabel.text = name;
            
            self.locationLabel.text = [NSString stringWithFormat:@"%@-%@", info.szLocationProvince, info.szLocationCity];
            
            NSString *iconUrl = info.szAcatar;
            if ( iconUrl.length ) {
                [self.iconView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:nil];
            }
            [self.tableView reloadData];
        });
    } Fail:^(NSError *error) {
        NSLog(@"完善个人信息界面下载信息失败%@", error);
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isFromLogVc) {
        [self downloadData];
    }
}

- (void)getMsgFromWeChat {
    // 回调微信第三方的信息, 在 info 中保存
    self.nicknameLabel.text = [self.detail[@"nickname"] stringByRemovingPercentEncoding];
    
    int gender = [self.detail[@"sex"] intValue];
    NSString *name;
    if (gender == 1) {
        name = [NSString stringWithFormat:@"男"];
    } else if (gender == 0 ) {
        name = [NSString stringWithFormat:@"女"];
    } else {
        name = @"";
    }
    self.sexLabel.text = name;
    
    self.locationLabel.text = self.detail[@"province"];
    
    NSString *iconUrl = self.detail[@"headimgurl"];
    if ( iconUrl.length ) {
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:nil];
    }
    [self.tableView reloadData];
    [self finish];
}

/**
 *   设置导航条
 */
- (void)setupNav {
    // 设置navigation的背景图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigation_bg"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *titleView = [[UILabel alloc] init];
    titleView.text = @"完善个人信息";
    titleView.textColor = [UIColor whiteColor];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    titleView.size = [titleView.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    self.navigationItem.titleView = titleView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"下一步" forState: UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = CGRectMake(0, 0, 60, 30);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    //取消按钮
    UILabel *label = [[UILabel alloc] init];
    label.text = @"取消";
    label.font = ISFont_17;
    label.textColor = [UIColor whiteColor];
    CGSize labelSize = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleButtonAction:)]];
    label.userInteractionEnabled = YES;
}

#pragma mark - 下一步点击方法
- (void)nextButtonAction{
    TelephoneBindingViewController * telBindingVc = [TelephoneBindingViewController new];
    [self.navigationController pushViewController:telBindingVc animated:YES];
}

#pragma mark - 取消点击方法
- (void)cancleButtonAction:(UITapGestureRecognizer *)tap{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MovierTabBarViewController *main = [storyboard instantiateViewControllerWithIdentifier:@"MainTabView"];
    [self presentViewController:main animated:YES completion:nil];
}


+ (UILabel *)labelWithTitle:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = [UIColor whiteColor];
    CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil].size;
    label.frame = CGRectMake(0, 0, titleSize.width, titleSize.height);
    return label;
}

#pragma mark - tableDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.isFromLogVc = NO;
    if (indexPath.row == 0) {
        //更换头像
        [self updateHeadImage];
    }else if (indexPath.row == 1){
        //更换昵称
        EditNickNameViewController * editNickNameVc = [EditNickNameViewController new];
        editNickNameVc.myUserInfo = self.myUserInfo;
        [self.navigationController pushViewController:editNickNameVc animated:YES];
    }else if (indexPath.row == 2){
        //更换性别
        EditGenderViewController * editGenderVc = [EditGenderViewController new];
        editGenderVc.myUserInfo = self.myUserInfo;
        [self.navigationController pushViewController:editGenderVc animated:YES];
    }else{
        //更换地区
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
        DistrictTableViewController *districtTabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"DistrictTabVCStoryBoardID"];
        districtTabVC.myUserInfo = self.myUserInfo;
        [self.navigationController pushViewController:districtTabVC animated:YES];
    }
}

-(void)updateHeadImage
{
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择"
                                             delegate:self
                                    cancelButtonTitle:@"取消"
                               destructiveButtonTitle:nil
                                    otherButtonTitles:@"拍照",@"从相册选择",nil];
    }
    else {
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择"
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"从相册选择", nil];
    }
    sheet.tag = 255;
    [sheet showInView:self.view];
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //照相
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    // 取消
                    return;
            }
        }
        else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else {
                return;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *imageData = UIImageJPEGRepresentation(image, .4);
    HeaderChange *headerChage = [HeaderChange Singleton];
    NSString *status =[headerChage UploadUserHeader:[NSString stringWithFormat:@"%d", [[UserEntity sharedSingleton].customerId intValue]]
                                                EXt:@"jpg"
                                           Yourdata:imageData];
    
    //修改相关对象的属性
    [UserEntity sharedSingleton].szAcatar = status;
    
    self.myUserInfo.szAcatar = status;
    [[SoapOperation Singleton] WS_SetUserInfo:self.myUserInfo
                                      Success:^(NSNumber *num) {
                                          NSLog(@"上传头像成功");
                                      } Fail:^(NSError *error){
                                          NSLog(@"上传头像失败");
                                      }];
    
}

- (void)finish {
//    if(![ValidateFuc validateMobile:_tfMobilePhone.text]){
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示!" message:@"请输入正确的手机号" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
    
    /*
     NSString *screen_name = [wechatinfo[@"nickname"] length] == 0 ? @"" : wechatinfo[@"nickname"];
     // 头像
     NSString *Profile = [wechatinfo[@"headimgurl"] length] == 0 ? @"" : wechatinfo[@"headimgurl"];
     NSString *Country = [wechatinfo[@"country"] length] == 0 ? @"" : wechatinfo[@"country"];
     NSString *City = [wechatinfo[@"city"] length] == 0 ? @"" : wechatinfo[@"city"];
     NSString *Province = [wechatinfo[@"province"] length] == 0 ? @"" : wechatinfo[@"province"];
     int gender = [wechatinfo[@"sex"] intValue];
     if (gender == 0) {
     gender = 1;
     } else if (gender == 1) {
     gender = 2;
     }
     NSString *unionid = [wechatinfo[@"unionid"] length] == 0 ? @"" : wechatinfo[@"unionid"];*/
    
    MovierDCInterfaceSvc_VDCThirdPartyAccountEx *accountin_ = [[MovierDCInterfaceSvc_VDCThirdPartyAccountEx alloc]init];
    accountin_.szAccount = [self.detail[@"unionid"] stringByRemovingPercentEncoding];
    accountin_.szPwd = @"";
    int gender = [self.info[@"gender"] intValue];
    if (gender == 0) {
        gender = 1;
    } else if (gender == 1) {
        gender = 2;
    }
    accountin_.nGender = @(gender);
    accountin_.szLocationProvince = [self.detail[@"province"] stringByRemovingPercentEncoding];
    accountin_.szLocationCity = [self.detail[@"city"] stringByRemovingPercentEncoding];
    accountin_.szNickName = [self.info[@"screen_name"] stringByRemovingPercentEncoding];
    accountin_.szSignature = @"";
    accountin_.szAcatar = [self.info[@"profile_image_url"] stringByRemovingPercentEncoding];
    accountin_.szTelNum = _tfMobilePhone.text;
    accountin_.szEmail = @"";
    accountin_.nThirdPartyType = @(1);
    [[SoapOperation Singleton] WS_Register:accountin_ Success:^(NSNumber *registerret) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[SoapOperation Singleton] WS_Login:accountin_.szAccount ThirdPartyType:@"1" Token:[self.info[@"access_token"] stringByRemovingPercentEncoding] Openid:accountin_.szAccount APPVersion:[UpDateSql getAPPVersion] SubVersion:[UpDateSql getAPPVersion] Success:^(MovierDCInterfaceSvc_VDCSession *ws_session) {
                [[UserEntity sharedSingleton] Applogin:accountin_.szAccount appPwd:[self.info[@"access_token"] stringByRemovingPercentEncoding] LoginType:LoginTypeWeChat];
            } Fail:^(NSNumber *LoginStatus, NSError *error) {
                ;
            }];
        });
    } Fail:^(NSError *error, NSNumber *ret) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示!" message:@"网络异常，请重试" delegate:nil cancelButtonTitle:@"OK"otherButtonTitles:nil];
            [alert show];
        });
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 4;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
