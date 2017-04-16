//
//  OneButtonProduceViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/19.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "OneButtonProduceViewController.h"
#import "APPUserPrefs.h"
#import "MovierTabBarViewController.h"
#import "MC_OrderAndMaterialCtrl.h"

@interface OneButtonProduceViewController()<UIAlertViewDelegate>
@property (weak, nonatomic) UIView *msgView;
@property (assign, nonatomic) BOOL isTouch;

/**  是否公开 */
@property (weak, nonatomic) IBOutlet UISwitch *isPublic;
/**  是否开启3/4G上传 */
@property (weak, nonatomic) IBOutlet UISwitch *uploadWith34G;
@end

@implementation OneButtonProduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selects = 0;
//    self.aButton.selected = YES;
//    _s34GOn.selected = [APPUserPrefs Singleton].wwanable;
//    [self buttonshow:_s34GOn status:[APPUserPrefs Singleton].wwanable];
    
    self.isPublic.on = YES;
    self.uploadWith34G.on = [APPUserPrefs Singleton].wwanable;

//    [self.aButton setImage:[UIImage imageNamed:@"check_h"] forState:UIControlStateSelected];
//    NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
    NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
    newNSOrderDetail.nShareType = 1;
    [[NewUserOrderList Singleton].newcutlist replaceObjectAtIndex:0 withObject:newNSOrderDetail];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)circleButtonAction:(id)sender {
//    [NSThread detachNewThreadSelector:@selector(submit) toTarget:self withObject:nil];
//    MovierTabBarViewController *tabBar = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainTabView"];
//    tabBar.hasTransferTask = YES;
//    [self presentViewController:tabBar animated:YES completion:nil];
    
    [self submit];
    [self showAlert:@"影片素材正在上传，请保持网络畅通，通过审核后，云端服务器将进行影片制作，几分钟后，您可在“个人页面”进行查看。"];
}

- (void)showAlert:(NSString*)msg
{
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerFireMethod:) userInfo:promptAlert repeats:NO];
//    promptAlert.delegate = self;
    [promptAlert show];
}
//- (void)timerFireMethod:(NSTimer*)theTimer
//{
//    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
//    [promptAlert dismissWithClickedButtonIndex:0 animated:YES];
//    promptAlert = NULL;
//    [self performSegueWithIdentifier:@"creattohome" sender:self];
//}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
        [self performSegueWithIdentifier:@"creattohome" sender:self];
    }
}

- (void)submit{
    
    [MC_OrderAndMaterialCtrl CommitOrder:[[UserEntity sharedSingleton].customerId intValue]];
    
//    NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
//    newNSOrderDetail.order_st = 1;//置为新订单
//    [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBChange:newNSOrderDetail];
//    [[NewUserOrderList Singleton].newcutlist removeAllObjects];
//    QueryLocOrderDetail *queryLocOrderDetail = [[QueryLocOrderDetail alloc] init];
//    queryLocOrderDetail.createTime = newNSOrderDetail.createTime;
//    queryLocOrderDetail.order_id = newNSOrderDetail.order_id;
//    queryLocOrderDetail.order_st = newNSOrderDetail.order_st;
//    queryLocOrderDetail.customer = newNSOrderDetail.customer;
//    [[CircleQueryLocOrderList Singleton].querylist addObject:queryLocOrderDetail];
//    NSLog(@"arbin test----- querylist count = %lu createTime = %@",(unsigned long)[[CircleQueryLocOrderList Singleton].querylist count],queryLocOrderDetail.createTime);
}

// 是否公开
- (IBAction)chooseIsPublic:(UISwitch *)sender {
    // sender.on : 0关闭  1开启
//    if (sender.on) {
//        NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
//        newNSOrderDetail.nShareType = 0;
//        [[NewUserOrderList Singleton].newcutlist replaceObjectAtIndex:0 withObject:newNSOrderDetail];
//    } else {
//        NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
//        newNSOrderDetail.nShareType = 1;
//        [[NewUserOrderList Singleton].newcutlist replaceObjectAtIndex:0 withObject:newNSOrderDetail];
//    }
    
    //arbin 2015-11-09
    NewNSOrderDetail * nowedit = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    if (sender.on) {
        nowedit.nShareType = 0;
    } else {
        nowedit.nShareType = 1;
    }
    [MC_OrderAndMaterialCtrl UpdateFresh:nowedit];
}

// 是否开启3G/4G上传
- (IBAction)isUploadWith34G:(UISwitch *)sender {
    [APPUserPrefs Singleton].wwanable = sender.on;
}

/*      是否开启3G/4G上传  按钮 更换为 UISwitch
-(IBAction)buttonClick:(id)sender
{
    if (self.aButton.selected) {
        self.aButton.selected = !self.aButton.selected;
        [self.aButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
//        NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
        NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
        newNSOrderDetail.nShareType = 0;
        [[NewUserOrderList Singleton].newcutlist replaceObjectAtIndex:0 withObject:newNSOrderDetail];
    }else{
        self.aButton.selected = !self.aButton.selected;
        [self.aButton setImage:[UIImage imageNamed:@"check_h"] forState:UIControlStateSelected];
//        NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
        NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
        newNSOrderDetail.nShareType = 1;
        [[NewUserOrderList Singleton].newcutlist replaceObjectAtIndex:0 withObject:newNSOrderDetail];
    }
}
 */

/*      是否开启3G/4G上传  按钮 更换为 UISwitch
- (IBAction)Set34GStatus:(id)sender {
    UIButton* button = (UIButton*)sender;
    BOOL show = !button.selected;
    [self buttonshow:button status:show];

    [APPUserPrefs Singleton].wwanable = button.selected;
}

-(void)buttonshow:(UIButton*)button status:(BOOL)set{
    UIButton* senderButton = (UIButton*)button;
    senderButton.selected = set;
    if (set==TRUE) {
        [senderButton setImage:[UIImage imageNamed:@"check_h"] forState:UIControlStateSelected];
    }else{
        [senderButton setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
    }
}
*/
@end
