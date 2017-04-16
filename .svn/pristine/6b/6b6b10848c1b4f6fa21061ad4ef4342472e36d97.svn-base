//
//  ClipseViewC.m
//  M-Cut
//
//  Created by Crab00 on 15/8/14.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "ClipsViewC.h"
#import "FirstClipViewC.h"
#import "MusicClipsTViewC.h"
#import "APPUserPrefs.h"
#import "CommonMacro.h"

// 增加提示的 alertView
#import "MWAlertView.h"
// 是否提示用户还有 “音乐”和“字幕” 没有点击的标记
#define Prompt @"Prompt"

@interface ClipsViewC () <MWAlertViewDelegate>
{
    NSInteger currentindex;
    SCNavTabBarController *navTabBarController;
    
}

/**
 *  记录是否点击了 “音乐” 和 “字幕”, 如果没有点击isPrompt=NO：提示； 点击任何一个isPrompt=YES，不提示
 */
@property (assign, nonatomic) BOOL isPrompt;
@end

@implementation ClipsViewC
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.isPrompt = NO;
    
    currentindex = 0;
    
    [self init_new];
}

- (void)init_new {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[APPUserPrefs Singleton] AutoLogin];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subSCViewChange:) name:@"subViewChange"object:nil];
    
    //    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)init_old {
    FirstClipViewC *firstViewC = [[FirstClipViewC alloc] init];
    MusicClipsTViewC *secondViewC = [[MusicClipsTViewC alloc] init];
    SubtitleViewC *thirdViewC = [[SubtitleViewC alloc] init];
    thirdViewC.parentviewC = self;
    
    if(IS_IPHONE_5){
        firstViewC.title = @"     风格     ";//空格是为了保持文字的长度，需要前后保留大概5
        secondViewC.title = @"     音乐     ";
        thirdViewC.title = @"     字幕     ";
    }else if(IS_IPHONE_6){
        firstViewC.title = @"       风格       ";//空格是为了保持文字的长度，需要前后保留大概7
        secondViewC.title = @"       音乐       ";
        thirdViewC.title = @"       字幕       ";
    }else if(IS_IPHONE_6Plus){
        firstViewC.title = @"         风格         ";//空格是为了保持文字的长度，需要前后保留大概9
        secondViewC.title = @"         音乐         ";
        thirdViewC.title = @"         字幕         ";
    }
    
    //    thirdViewC.view.backgroundColor = [UIColor orangeColor];//测试使用
    
    navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.showContentView = true;
    navTabBarController.subViewControllers = @[firstViewC, secondViewC, thirdViewC];
    [navTabBarController addParentController:self];
    
    navTabBarController.delegate = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[APPUserPrefs Singleton] AutoLogin];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(subSCViewChange:) name:@"subViewChange"object:nil];
    
    //    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.tabBarController.tabBar.hidden = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (IBAction)nextStep:(id)sender {
#pragma mark -----  如果没有点击“音乐”和“字幕”，提示用户
    // 获取沙盒中存放的  Prompt
    BOOL needsPrompt;
    if ([[NSUserDefaults standardUserDefaults] boolForKey:Prompt]) {
        needsPrompt = [[NSUserDefaults standardUserDefaults] boolForKey:Prompt];
    }
    
    if (needsPrompt == NO) {
        if (self.isPrompt == NO) {  // 如果用户没有点击 “音乐” 和 “字幕”， 提示用户
            MWAlertView *alertView = [MWAlertView alertView];
            alertView.delegate = self;
            [alertView show];
        } else {    // 如果用户点击了 “音乐” 或者 “字幕”， 不提示用户
            [self next];
        }
    } else {
        [self next];
    }
}


#pragma mark -- MWAlertViewDelegate 提示用户   信息的代理方法
- (void)alertView:(MWAlertView *)alertView didSelectedChooseButton:(UIButton *)choose {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (choose.selected == NO) {    // 没有选中 "不再提示" 按钮, 将数据保存到沙盒, 点击之后变为 YES
        [defaults setBool:YES forKey:Prompt];
    } else {    // 选中 "不再提示" 按钮
        [defaults setBool:NO forKey:Prompt];
    }
    
    [defaults synchronize];
    
    choose.selected = !choose.selected;
}

- (void)alertView:(MWAlertView *)alertView clickedButtonAtIndex:(NSInteger)index {
    switch (index) {
        case 0:     // 返回选取
            
            break;
            
        case 1:     // 继续制作
            [self next];
            break;
            
        default:
            break;
    }
    [alertView dismiss];
}

#pragma mark -- 对nextStep:进行拦截， 因为要提醒用户
- (void)next {
//    NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
//    NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
//    newOrderVideoMaterial.order_id = newNSOrderDetail.order_id;
//    NSMutableArray *array = [[APPUserPrefs Singleton] APP_MaterialArrCacheInformationDBSearch:newOrderVideoMaterial];
//    if ([array count]<1) {
//        [self showAlert];
//    }els
    [self performSegueWithIdentifier:@"BeforSubmit" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"cliptoedite"])
    {
        CaptionEditeNewViewController * captionEditVc = segue.destinationViewController;
        captionEditVc.delegate = self;
        [captionEditVc setValue:EditSelfSubtitle forKey:@"stringText"];
    }
}

- (void)Editbuttonttouched:(NSString*)context Index:(NSInteger)selectindex
{
    EditSelfSubtitle = context;
//    [self performSegueWithIdentifier:@"cliptoedite" sender:nil];
    SubtitleViewC *subview2 = (SubtitleViewC*)[navTabBarController.subViewControllers objectAtIndex:2];
    [subview2 SetSelectTableCell:selectindex];
}


- (void) subSCViewChange:(NSNotification*)notification
{
    FirstClipViewC *subview0 = [navTabBarController.subViewControllers objectAtIndex:0];
    MusicClipsTViewC *subview1 = [navTabBarController.subViewControllers objectAtIndex:1];
    SubtitleViewC *subview2 = (SubtitleViewC*)[navTabBarController.subViewControllers objectAtIndex:2];
    switch (currentindex) {
        case 0:
            [subview1 StopPlay];
            [subview2 StopPlay];
            break;
            
        case 1:
            [subview0 StopPlay];
            [subview2 StopPlay];
            break;
            
        case 2:
            [subview0 StopPlay];
            [subview1 StopPlay];
            break;
            
        default:
            break;
    }
    
//    id obj = [notification object];//获取到传递的对象
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    UIBarButtonItem *senderItem = sender;
    if (senderItem.tag == 0) {
        NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
        newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
        if ([newNSOrderDetail.stMaterialArr count]<1) {
            [self showAlert];
            segue ;
            return;
        }
    }
//        [self.player setURL:nil];

}
*/
- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:YES];
    promptAlert = NULL;
}


- (void)showAlert
{
    
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"请添加素材!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    
    [promptAlert show];
}

#pragma mark - SCViewChange

- (void)itemShouldShowWithindex:(NSInteger)index
{
#pragma mark -- 设置变量的值， 记录是否需要提示用户
    if (index == 0) {
        self.isPrompt = NO;
    } else {
        self.isPrompt = YES;
    }
    
    if (index!=currentindex) {
                currentindex = index;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"subViewChange" object:nil];

    }
}
#pragma mark -- -TextFieldChangeDelegate
-(void)changeText:(NSString *)text
{
    SubtitleViewC *subview2 = (SubtitleViewC*)[navTabBarController.subViewControllers objectAtIndex:2];
    [subview2 SetCellText:text];
}

@end
