#import "TelephoneViewController.h"
#import "APPUserPrefs.h"
#import "ValidateFuc.h"
#import "UpDateSql.h"
#import "UserEntity.h"

@implementation TelephoneViewController

@synthesize tfTelephone,tfPassword,tfVertifyCode;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    times = 0;
    [self setviewborder:self.imViewUp];
    
    //标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"手机注册";
    label.font = ISFont_17;
    label.textColor = [UIColor whiteColor];
    CGSize labelSize = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.titleView = label;
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 返回按钮点击方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initUI{
    self.registerButton.backgroundColor = [UIColor redColor];
    [self.registerButton setTitle:@"完成" forState:UIControlStateNormal];
    self.SMS_button.backgroundColor = [UIColor redColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.tabBarController.tabBar.hidden = NO;
}

-(void)setviewborder:(UIView*)myview
{
    myview.layer.masksToBounds = YES;
    myview.layer.cornerRadius = 5;
    myview.layer.borderWidth = 1;
    myview.layer.borderColor = [[UIColor grayColor] CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)outDone:(id)sender{
    [sender resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)getVertifyCode:(id)sender
{
    if(![ValidateFuc validateMobile:(tfTelephone.text)]){
        //之前判断号码是否准确的正则表达式
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示:", nil)
                                                      message:[NSString stringWithFormat:@"%@号码格式错误",tfTelephone.text]
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                            otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    smslefttime = 60;
    _timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sms_count) userInfo:nil repeats:YES];
    [_SMS_button setEnabled:FALSE];
//                            [_SMS_button setTitle:[NSString stringWithFormat:@"剩余时间(%02ld)",(long)smslefttime] forState:UIControlStateDisabled];
    [[SoapOperation Singleton] WS_CheckTelphone:tfTelephone.text Success:^(NSNumber *ret,NSNumber *count) {
        if ([count compare:@(3)]==NSOrderedDescending){
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示:", nil)
                                                          message:[NSString stringWithFormat:@"%@号码24小时内仅允许请求三次",tfTelephone.text]
                                                         delegate:self
                                                cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                otherButtonTitles:nil, nil];
            [alert show];
            smslefttime = -1;
            return ;
        }
        if ([ret isEqualToNumber:@(20)]==YES) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示:", nil)
                                                              message:[NSString stringWithFormat:@"%@号码已经注册,请直接登录!",tfTelephone.text]
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                    otherButtonTitles:nil, nil];
                [alert show];
                smslefttime = -1;
            });
        }else{//手机号存在
//            [[SoapOperation Singleton] WS_SMSNumberGet:tfTelephone.text
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:tfTelephone.text zone:@"86" customIdentifier:nil result:^(NSError *error)
             {
                 if (!error){
                     NSLog(@"block 获取验证码成功");
                 }
                 else{
                     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                                     message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"getVerificationCode"]]
                                                                    delegate:self
                                                           cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                           otherButtonTitles:nil, nil];
                     [alert show];
                     
                 }
                 
             }];
        }
    } Fail:^(NSError *error) {
        ;
    }];
}

-(void)sms_count{
    smslefttime--;
    if (smslefttime>0) {
        [_SMS_button setTitle:[NSString stringWithFormat:@"剩余%02ld秒",(long)smslefttime] forState:UIControlStateDisabled];
    }else{
        [_SMS_button setTitle:@"发送验证码" forState:UIControlStateDisabled];
        [_SMS_button setEnabled:YES];
        [_timer1 invalidate];
    }
//    [_SMS_button setTitle:[NSString stringWithFormat:@"剩余时间(%02ld)",(long)smslefttime] forState:UIControlStateDisabled];
}

- (IBAction)registers:(id)sender{
    [self submit];
}

-(void)submit
{
    [self.view endEditing:YES];
    if(tfVertifyCode.text.length!=4)
    {
        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil)
                                                      message:NSLocalizedString(@"验证码格式不正确。", nil)
                                                     delegate:self
                                            cancelButtonTitle:@"确定"
                                            otherButtonTitles:nil, nil];
        [alert show];
    }else{
        [SMSSDK commitVerificationCode:tfVertifyCode.text phoneNumber:tfTelephone.text zone:@"86" result:^(NSError *error) {

            if (!error)
            {
                NSLog(@"验证成功");
                NSString* str=[NSString stringWithFormat:NSLocalizedString(@"验证成功", nil)];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"验证成功", nil)
                                                              message:str
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                    otherButtonTitles:nil, nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [alert show];
                    _alert3=alert;
                });

            }else if(0==state){
                NSLog(@"验证失败");
                NSString* str=[NSString stringWithFormat:NSLocalizedString(@"验证失败", nil)];
                UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"验证失败", nil)
                                                              message:str
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                    otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}

-(void)CannotGetSMS
{
    NSString* str=[NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"不能连接到SMS", nil) ,tfTelephone.text];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"请确认手机号", nil) message:str delegate:self cancelButtonTitle:NSLocalizedString(@"确定", nil) otherButtonTitles:nil, nil];
    _alert1=alert;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==_alert1)
    {
        if (1==buttonIndex)
        {
            NSLog(@"重发验证码");
            [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:tfTelephone.text zone:@"86" customIdentifier:nil result:^(NSError *error)
             {
                 if (!error)
                 {
                     NSLog(@"block 获取验证码成功");
                 }
                 else if(0==state)
                 {
                     NSLog(@"block 获取验证码失败");
                     UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"codesenderrtitle", nil)
                                                                     message:[NSString stringWithFormat:@"%@",[error.userInfo objectForKey:@"getVerificationCode"]]
                                                                    delegate:self
                                                           cancelButtonTitle:NSLocalizedString(@"sure", nil)
                                                           otherButtonTitles:nil, nil];
                     [alert show];
                 }
             }];
        }
    }else if (alertView==_alert2) {
        if (0==buttonIndex)
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [_timer2 invalidate];
                [_timer1 invalidate];
            }];
        }
    }else if (alertView==_alert3)
    {
        
        [[SoapOperation Singleton] WS_Register:@"" withPassword:tfPassword.text withPhoneNum:tfTelephone.text Success:^(NSNumber *registerret) {
            NSString *message = @"注册成功！";
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showMessage:message];
            });
            [[UserEntity sharedSingleton] Applogin:tfTelephone.text appPwd:tfPassword.text LoginType:LoginTypePhone];
//            [[NSNotificationCenter defaultCenter] addObserver:self.navigationController.tabBarController  selector:@selector(MovierLogin:)
//                                                         name:@"AutoLogin"
//                                                       object:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:YES];
                
                [CustomeClass mainQueue:^{
                    POSTNOTI(HIDDENLOGINANDREGISTERWINDOW, nil);
                }];
            });
//            [[SoapOperation Singleton]WS_Login:tfTelephone.text Password:tfPassword.text withVersion:[UpDateSql getAPPVersion] Encrypt:FALSE Success:^(MovierDCInterfaceSvc_VDCSession *ws_session) {
//                //用户信息保存
//            } Fail:^(NSNumber *LoginStatus, NSError *error) {
//                NSLog(@"自动登录失败！");
//            }];
            
//            ret = [[APPUserPrefs Singleton] login:tfTelephone.text userPassword:tfPassword.text isEncrypt:false];
//            if (ret == NOW_LOGIN) {
//                [self performSegueWithIdentifier:@"registertotabview" sender:self];
//            }else{
//                UIAlertView *alert = [[UIAlertView alloc]
//                                      initWithTitle:@"MessageBox"
//                                      message:@"登陆失败，请重新登陆！"
//                                      delegate:nil
//                                      cancelButtonTitle:@"OK"
//                                      otherButtonTitles:nil];
//                [alert show];
//            }

        } Fail:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"MessageBox"
                                  message:@"登陆失败，请重新登陆！"
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                [alert show];
            });

        }];
//        int ret = -1;
//        ret = [APPUserPrefs registersByTelephone:@"" UserPassword:tfPassword.text UserTelephone:tfTelephone.text];
//        if (ret == 0) {
//            NSString *message = @"注册成功！";
//            [self showMessage:message];
//            int ret = -1;
//            ret = [[APPUserPrefs Singleton] login:tfTelephone.text userPassword:tfPassword.text isEncrypt:false];
//            if (ret == NOW_LOGIN) {
//                [self performSegueWithIdentifier:@"registertotabview" sender:self];
//            }else{
//                UIAlertView *alert = [[UIAlertView alloc]
//                                      initWithTitle:@"MessageBox"
//                                      message:@"登陆失败，请重新登陆！"
//                                      delegate:nil
//                                      cancelButtonTitle:@"OK"
//                                      otherButtonTitles:nil];
//                [alert show];
//            }
//        }else{
//            NSString *message = @"注册失败！";
//            [self showMessage:message];
//        }
//        tfVertifyCode.text = @"";
//        [_timer2 invalidate];
//        [_timer1 invalidate];
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
    [UIView animateWithDuration:10 animations:^{
        showview.alpha = 0;
    } completion:^(BOOL finished) {
        [showview removeFromSuperview];
    }];
}

@end