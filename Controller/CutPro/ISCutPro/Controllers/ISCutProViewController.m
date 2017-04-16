//
//  ISCutProViewController.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/24.
//  Copyright © 2015年 Crab movier. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "ISCutProViewController.h"
#import "MWaterflowLayout.h"
#import "ISCutProCell.h"
#import "ISChooseSourceView.h"
#import "UIViewExt.h"
//#import "LocalMaterialsViewController.h"
#import "APPUserPrefs.h"
#import "DraftboxTableViewController.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "ISCutProStyleViewController.h"
#import "ISCutPreViewController.h"
//#import "CustomLoginAlertView.h"
//#import "LoginViewController.h"
#import "HeaderChange.h"
#import "leadPage.h"
#import "HTKDragAndDropCollectionViewLayout.h"
#import "HTKDraggableCollectionViewCell.h"
#import "longleadPage.h"
#import "ISCutProStylNewViewController.h"
#import "XMNPhotoPickerFramework.h"
#import "MediaUtils.h"
#import "PromptController.h"
#import "XMNPhotoPreviewController.h"
#import "TelephoneViewController.h"
#import "ServiceTermsViewController.h"
#import "UpDateSql.h"
#import "PerfectPersonalInfoViewController.h"
#import "TakeVideoViewController.h"
#import "TempVideoOBj.h"
#import "MakeVideoViewController.h"
#import "MakeVideoNavigationControllerViewController.h"
#import "SelectMaterialArray.h"
#import "OnlyOneView.h"

/** 列数 */
#define CutProColumnsCount 3
/** 列间距 */
#define CutProColumnMargin 2
/** cell 和屏幕的上间距 */
#define CutProTopMargin 1
/** cell 和屏幕的左间距 */
#define CutProLeftMargin 9
/** cell 和屏幕的右间距 */
#define CutProRightmargin CutProLeftMargin
/** cell 的宽度高度比例 */
#define CutProCellRatio (132.0 / 232)
#define USERFILMMIN         15.0
#define USERFILMMAX         180.0
// 影片详情返回制作首页, 使用通知传递参数
#define ISStyleDetailBacktoCutProParams         @"ISStyleDetailBacktoCutProParams"
#define ISStyleDetailBacktoCutProNotification   @"ISStyleDetailBacktoCutProNotification"
// 清空订单列表的通知
#define ISNewOrderCreateNotification            @"ISNewOrderCreateNotification"
//返回根目录
#define ISGoToMainPage                          @"Let's go home"
//隐藏tabbar
#define ISHideTabbar                            @"hide userdefault tabbar"
//相册 cell
static NSString *CutProIdentifier_cell = @"CutProIdentifier_cell";
static NSString *const firstPropmt = @"firstPropmt";

@interface ISCutProViewController () <UICollectionViewDataSource, UICollectionViewDelegate, MWaterflowLayoutDelegate, ISChooseSourceViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, MVOverslider, NewAndDraftboxViewDelegate, ISCutProCellDelegate, UIAlertViewDelegate,HTKDraggableCollectionViewCellDelegate, UMSocialUIDelegate> {
    UIWindow *window;
//    CustomLoginAlertView *customLoginAlertView;
    NewAndDraftboxView *NewAndDraftboxView1;
}

/**  导航右侧按钮 */
@property (weak, nonatomic) UIButton *rightBarButton;
/**  导航左侧按钮 */
@property (weak, nonatomic) UIButton *leftBarButton;
@property (strong, nonatomic) ISCutProCell *currentDeleteCell;
@property (weak, nonatomic) UICollectionView *collectionView;
/**  数据源, 初始化后添加一张默认的图片, 以后往数组的倒数第一个前面插入图片数据------允许最多选择20个素材, images 中最多有21个图片 */
@property (strong, nonatomic) NSMutableArray *images;
/**  点击制作按钮的遮罩 */
@property (weak, nonatomic) UIView *coverView;
/**  存放所有选择素材的路径 */
@property (strong, nonatomic) NSMutableArray *paths;
/**  存放所有素材的时长*/
@property (nonatomic, strong) NSMutableArray * materialTimeLengthArray;
/**  遮罩图片 */
@property (weak, nonatomic) UIImageView *guideView;
/**  制作影片 */
@property (assign, nonatomic) BOOL makeFilm;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) UIWindow * secondWindow;
@property (nonatomic, strong) NSArray * selectMaterialInDbArray;
@property (nonatomic, strong) NSMutableArray * allMaterialMuArray;
@property (nonatomic, copy) NSString * deleteAssUrl;
//是否包含arid
@property (nonatomic, strong) NSMutableArray * isHaveArIdMuArray;
//app内拍摄的视频数组
@property (nonatomic, strong) NSMutableArray * takeVideoArray;
@property (nonatomic, strong) OnlyOneView *propmtView;
@end

@implementation ISCutProViewController

- (NSMutableArray *)takeVideoArray{
    LAZYINITMUARRAY(_takeVideoArray)
}

- (NSMutableArray *)allMaterialMuArray{
    if (!_allMaterialMuArray) {
        _allMaterialMuArray = [NSMutableArray new];
    }
    return _allMaterialMuArray;
}

- (NSArray *)selectMaterialInDbArray{
    _selectMaterialInDbArray = [[MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id] copy];
    return _selectMaterialInDbArray;
}

- (NSMutableArray *)materialTimeLengthArray{
    if (_materialTimeLengthArray == nil) {
        _materialTimeLengthArray = [[NSMutableArray alloc] init];
    }
    return _materialTimeLengthArray;
}

- (NSMutableArray *)isHaveArIdMuArray{
    LAZYINITMUARRAY(_isHaveArIdMuArray)
}

- (NSMutableArray *)images {
    if (!_images) {
        _images = [NSMutableArray array];
        UIImage *image = [UIImage imageNamed:@"add"];
        [_images addObject:image];
    }
    return _images;
}

- (NSMutableArray *)paths {
    if (!_paths) {
        self.paths = [NSMutableArray array];
    }
    return _paths;
}
-(NSMutableArray *)models
{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    
    return _models;
}

- (void)updateKeepVoiceStateWithBlock:(updateKeepVoiceButton)myBlock{
    self.updateKeepVoice = myBlock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册接收拍摄的视频
    REGISTEREDNOTI(addTakeVideo:, useTakeVideo);
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    _SetDurationValue = 0;
    
    // 创建 cellectionView 视图
    [self setupCollectionView];
    
    // 影片预览界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newOrder:) name:ISNewOrderCreateNotification object:nil];
    // 回到根目录
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GoHome:) name:ISGoToMainPage object:nil];
    // 隐藏tabbar
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(Msg_HideTabbar:) name:ISHideTabbar object:nil];
#pragma mark --- 原有内容
    [self loadInit];

    
    //首次进入时显示提示
    [self showFirstPropmt];
}

- (void)showFirstPropmt{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:firstPropmt]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:firstPropmt];
    
        //展示提示框
        self.collectionView.hidden = YES;
        OnlyOneView *propmtView = [[OnlyOneView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height)];
        propmtView.needShowImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:self.propmtView = propmtView];
        [self.view bringSubviewToFront:propmtView];
        [propmtView showOnlyImageWithImage:[UIImage imageNamed:@"addMaterialPropmtImage"]];
        WEAKSELF2
        [propmtView setImageTapBlock:^{
            MAINQUEUEUPDATEUI({
                [weakSelf.propmtView hiddenImage];
                weakSelf.collectionView.hidden = NO;
            })
        }];
    }
}

- (void)next:(UITapGestureRecognizer *)tap {
    [self.guideView removeFromSuperview];
    self.guideView = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadmaterials];
    [self refreshSliderBarFrame];
    
    //禁止侧滑手势
    if (!self.tabBarController.tabBar.hidden) {
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
    [self setupNavigation];
    
    if (self.isTransFromPreview == YES) {
        self.leftBarButton.hidden = NO;
    }
    [self resumeLastOrder];
    if (self.HideTabbar) {
        [self.navigationController.tabBarController.tabBar setHidden:YES];
    }
    
    if (!self.isTransFromPreview) {
        [self.navigationController.tabBarController.tabBar setHidden:NO];
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //打开侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

-(void)loadmaterials{
    [self.materialTimeLengthArray removeAllObjects];
    [self.isHaveArIdMuArray removeAllObjects];
    [self.images removeAllObjects];
    [self.paths removeAllObjects];
    [self.images addObject:[UIImage imageNamed:@"add"]];
    [self.materialTimeLengthArray addObject:@"0"];
    [self.isHaveArIdMuArray addObject:@"0"];
    UserMaterialNum = 0;
    
    self.newsNSOrderDetail = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    NSMutableArray *array = [MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id];
    [self.models addObjectsFromArray:array];
    int a = (int)[array count];
    if (a > 0 && a <= 20)
    {
        for (int i = 0; i < a;i++) {
            NewOrderVideoMaterial *newOrderVideoMaterial = [array objectAtIndex:i];
                if (![newOrderVideoMaterial.material_assetsURL isEqualToString:@""]) {
                    [self.images removeObjectAtIndex:[self.images count]-1];
                    [self.materialTimeLengthArray removeObjectAtIndex:self.materialTimeLengthArray.count - 1];
                    [self.isHaveArIdMuArray removeObjectAtIndex:self.isHaveArIdMuArray.count - 1];
                    if (newOrderVideoMaterial.material_assetsURL.length > 0 && ![newOrderVideoMaterial.material_assetsURL isEqualToString:@"(null)"]) {
                        NSString * imageNameStr = [[newOrderVideoMaterial.material_assetsURL componentsSeparatedByString:@"="][1] componentsSeparatedByString:@"&"][0];
                        [self.images addObject:[self getImageWithImageName:imageNameStr]];
                    }
                   
                    [self.materialTimeLengthArray addObject:@(newOrderVideoMaterial.material_playduration)];
                    [self.isHaveArIdMuArray addObject:newOrderVideoMaterial.arId];
                    UIImage *addimage = [UIImage imageNamed:@"add"];
                    [_images addObject:addimage];
                    [self.materialTimeLengthArray addObject:@"0"];
                    [self.isHaveArIdMuArray addObject:@"0"];
                    newOrderVideoMaterial.material_assetsURL.length > 0 ? [self.paths insertObject:newOrderVideoMaterial.material_assetsURL atIndex:0] : [self.paths insertObject:@"" atIndex:0];
                    UserMaterialNum++;
                }else{//这种情况在什么时候会发生呢？arbin疑问？arbin回答，数据库曾经存储过blob数据（image）
                    //                    [self.images replaceObjectAtIndex:i withObject:newOrderVideoMaterial.material_stream];
                    
                    //  重新设置导航右侧按钮的标题
                    [self resetRightBarButtonTitle];
                    newOrderVideoMaterial.material_stream ? [self.images insertObject:newOrderVideoMaterial.material_stream atIndex:0] : [self.images insertObject:@"" atIndex:0];
                    [self.materialTimeLengthArray insertObject:@(newOrderVideoMaterial.material_playduration) atIndex:0];
                    newOrderVideoMaterial.arId.length > 0 ? [self.isHaveArIdMuArray insertObject:newOrderVideoMaterial.arId atIndex:0] : [self.isHaveArIdMuArray insertObject:@"" atIndex:0];
                    newOrderVideoMaterial.material_assetsURL.length > 0 ? [self.paths insertObject:newOrderVideoMaterial.material_assetsURL atIndex:0] : [self.paths insertObject:@"" atIndex:0];
                    UserMaterialNum++;
                }
        }
        
        MAINQUEUEUPDATEUI({
            [self resetRightBarButtonTitle];
            [self resumeLastOrder];
            [self.collectionView reloadData];
        })
        
    }else{
        [self.collectionView reloadData];
    }
}

-(void)GoHome:(NSNotification *)noti{
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)newOrder:(NSNotification *)noti {
    self.makeFilm = [noti.userInfo[@"makeFilm"] boolValue];
    self.navigationController.tabBarController.selectedIndex = 0;
    [self newOrder];
}

-(void)newOrder //arbin 2015/11/03 新增
{
    [self resetSliderBar];
    
    _customWindow.hidden = YES; //隐藏左上弹出窗口
    //将Fresh订单转换成草稿状态（Uncommit状态）
    //    [MC_OrderAndMaterialCtrl Fresh2Uncommit:[[UserEntity sharedSingleton].customerId intValue]];
    // 更新数据源
    [self.images removeAllObjects];
    [self.materialTimeLengthArray removeAllObjects];
    [self.isHaveArIdMuArray removeAllObjects];
    UIImage *image = [UIImage imageNamed:@"add"];
    [self.images addObject:image];
    [self.materialTimeLengthArray addObject:@"0"];
    [self.isHaveArIdMuArray addObject:@"0"];
    [self.collectionView reloadData];
    
    //新建一条Fresh订单
    //    [MC_OrderAndMaterialCtrl AddFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    self.newsNSOrderDetail = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    self.newsNSOrderDetail.orderType = generalOrder;
    [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
    
    [self resetRightBarButtonTitle];
}


-(void)Msg_HideTabbar:(NSNotification *)noti{
    //    [self hideTabBar:YES];
    self.HideTabbar = YES;
}

- (void) hideTabBar:(BOOL) hidden{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, 480, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, 433, view.frame.size.width, view.frame.size.height)];
            }
        }
        else
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 480)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, 433)];
            }
        }
    }
    [UIView commitAnimations];
    [self.navigationController.tabBarController.tabBar setHidden:hidden];
}

- (void)setupNavigation {
    // 标题
    NAVIGATIONBARTITLEVIEW(@"创建")
    
    // 右侧按钮
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    NSString *rightBarTitle = @"00/20 下一步";
    [rightBarButton setTitle:rightBarTitle forState:UIControlStateNormal];
    rightBarButton.titleLabel.font = ISFont_16;
    rightBarButton.userInteractionEnabled = NO;
    CGSize rightBarSize = [rightBarTitle sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:16], NSFontAttributeName, nil]];
    rightBarButton.frame = CGRectMake(0, 0, rightBarSize.width + 10, rightBarSize.height);
    [rightBarButton addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    self.rightBarButton = rightBarButton;
    
    // 左侧按钮
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    leftBarButton.frame = CGRectMake(0, 0, 20, 20);
    [leftBarButton addTarget:self action:@selector(leftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    self.leftBarButton = leftBarButton;
    leftBarButton.hidden = YES;
}

- (void)leftBarButtonClick:(UIButton *)button {
    if (self.isNeedUpdateKeepVoiceButton == YES) {
        self.updateKeepVoice();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 下一步点击方法
- (void)rightBarButtonClick:(UIButton *)button {
    
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [self showLoginAndRegisterWindow];
        return;
    }
    
    // 如果图片数量少于5张, 提示用户素材数量较少
    if (self.recommondvalue < 15.0) {
        [UIAlertView alertViewTitle:nil message:@"为保证影片效果，请选择至少15秒视频或5张照片。" delegate:nil cancleButton:nil confirmButton:@"确定" isNeedsInput:NO];
        return;
    }
    
    if (self.isNeedUpdateKeepVoiceButton == YES) {
        self.updateKeepVoice();
    }
    
    if(self.next2Preview&&_recommondvalue>=15.0){
        [self nextButtonAction];
    }else if (self.isTransFromPreview&&!self.next2Preview) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        
        //跳转到风格选择页面
        ISCutProStylNewViewController *style = [[ISCutProStylNewViewController alloc] init];//新页面
        style.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:style animated:YES];
    }
}

/** 下一步按钮点击方法*/
- (void)nextButtonAction{
    
    //从选择风格选择界面跳转到影片概览界面
    WEAKSELF2
    MAINQUEUEUPDATEUI({
        UINavigationController *preview = [[UIStoryboard storyboardWithName:@"Preview" bundle:nil] instantiateViewControllerWithIdentifier:@"ISCutPreView_ID"];
        ISCutPreViewController *pre = [preview.childViewControllers firstObject];
        pre.Direct2Main = YES;
        pre.styleDetail = weakSelf.styleDetail;
        [weakSelf presentViewController:preview animated:YES completion:^{
            MAINQUEUEUPDATEUI({
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            })
        }];
    })
}

/**  初始化操作 */
- (void)loadInit {
    UserMaterialNum = 0;
    
    if (![UserEntity sharedSingleton].appUserName || [[UserEntity sharedSingleton].appUserName isEqualToString:@""]) {
        self.makeSureButton.enabled = NO;
        self.cloudButton.enabled = NO;
    }else{
        self.makeSureButton.enabled = YES;
        self.cloudButton.enabled = YES;
    }
    [self resetSliderBar];
    
    orderCurrent = 0;
//    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_stateBar_background"]];
    self.sumcount = 20;
    _isTrigger = NO;
    _bl = NO;
    _cancelButton.hidden = NO;
    [_cancelButton setTitle:@"" forState:UIControlStateNormal];
    [_cancelButton setFrame:CGRectMake(16,7,30,30)];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    _isVideo=YES;
    self.newsNSOrderDetail = [[NewNSOrderDetail alloc] init];
    
    _customWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    _customWindow.windowLevel= UIWindowLevelAlert;
    _customWindow.backgroundColor = [UIColor grayColor];
    _customWindow.userInteractionEnabled = YES;
    NewAndDraftboxView1 = [[[NSBundle mainBundle]loadNibNamed:@"NewAndDraftboxView" owner:nil options:nil] lastObject];
    NewAndDraftboxView1.frame = CGRectMake(10, 60, 150,110);
    NewAndDraftboxView1.layer.cornerRadius = 10;
    NewAndDraftboxView1.layer.masksToBounds = YES;
    UIImage *imag = [UIImage imageNamed:@"home_alertViewbg"];
    NewAndDraftboxView1.backgroundColor = [UIColor colorWithPatternImage:imag];
    [_customWindow addSubview:NewAndDraftboxView1];
    UITapGestureRecognizer *homeTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecongnizer:)];
    [homeTapGesture setNumberOfTouchesRequired:1];
    [homeTapGesture setNumberOfTapsRequired:1];
    [_customWindow addGestureRecognizer:homeTapGesture];
    NewAndDraftboxView1.delegate=self;
    self.sliderbutton.fulldelegate = self;
}

- (void)tapGestureRecongnizer:(UIGestureRecognizer *)gesture{
    if ([gesture isKindOfClass:[UITapGestureRecognizer class]]) {
        _customWindow.hidden = YES;
    }
}

//判断是否有用户登录（arbin理解的）
-(int)judgeStatus
{
    int ret = -1;
    if ([UserEntity sharedSingleton].customerId == 0) {
        ret = 0;
    }else{
        ret = 1;
    }
    return ret;
}

-(void)resumeLastOrder{
    //替换使用新的数据2015-11-04
    [self resetSliderBar];
    self.newsNSOrderDetail = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    if (self.newsNSOrderDetail == nil) {
        [MC_OrderAndMaterialCtrl AddFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
        self.newsNSOrderDetail = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    }else{//程序需要
        NSMutableArray *array = [MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id];
        for (NewOrderVideoMaterial* item in array) {
            [self setRecommandsize:item.material_playduration Reduce:0.0];
        }
        [self refreshUserSetValue:self.newsNSOrderDetail.nVideoLength];//恢复用户需要时长
        //        self.newsNSOrderDetail.nVideoLength = _recommondvalue;
        //        [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
    }
}

- (void)setupCollectionView {
    //    MWaterflowLayout *layout = [[MWaterflowLayout alloc] init];
    //    layout.columnsCount =  CutProColumnsCount;
    //    layout.columnMargin = CutProColumnMargin;
    //    // 设置 cell 的边距
    //    layout.sectionInset = UIEdgeInsetsMake(CutProTopMargin, CutProLeftMargin, CutProColumnMargin, CutProRightmargin);
    //    layout.delegate = self;
    //
    //
    ////    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - (self.columnsCount - 1) * self.columnMargin)/self.columnsCount;
    //  //设置  白色背景
    //    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height - ISTabBarHeight - 55 - ISNavigationHeight) collectionViewLayout:layout];
    //
    //    /**  相册对象 cell */
    //    [collectionView registerNib:[UINib nibWithNibName:@"ISCutProCell" bundle:nil] forCellWithReuseIdentifier:CutProIdentifier_cell];
    //
    //    collectionView.delegate = self;
    //    collectionView.dataSource = self;
    //    collectionView.backgroundColor = ISRGBColor(220, 220, 220);
    //    collectionView.alwaysBounceVertical = YES;
    //
    //    [self.view addSubview:collectionView];
    //    self.collectionView = collectionView;
    
    // losehero
    HTKDragAndDropCollectionViewLayout *flowLayout = [[HTKDragAndDropCollectionViewLayout alloc] init];
    CGFloat itemWidth = (ISScreen_Width - 20 - (CutProColumnsCount - 1) * CutProColumnMargin)/CutProColumnsCount;
    CGFloat height = itemWidth * CutProCellRatio;
    flowLayout.itemSize = CGSizeMake(itemWidth, height);
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.lineSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(CutProTopMargin, CutProLeftMargin, CutProColumnMargin, CutProRightmargin - 5);
    flowLayout.completionBlock = ^(NSUInteger dargIndex,NSUInteger finalIndex){
        UIImage *image = self.images[dargIndex];
        [self.images removeObjectAtIndex:dargIndex];
        [self.materialTimeLengthArray removeObjectAtIndex:dargIndex];
        [self.isHaveArIdMuArray removeObjectAtIndex:dargIndex];
        image ? [self.images insertObject:image atIndex:finalIndex] : nil;
//        [self.images insertObject:image atIndex:finalIndex];
        NewOrderVideoMaterial *newNSOrderDetail = self.models[dargIndex];
        [self.models removeObjectAtIndex:dargIndex];
        newNSOrderDetail ? [self.models insertObject:newNSOrderDetail atIndex:finalIndex] : nil;
//        [self.models insertObject:newNSOrderDetail atIndex:finalIndex];
        [self.materialTimeLengthArray insertObject:@(newNSOrderDetail.material_playduration) atIndex:finalIndex];
        newNSOrderDetail.arId.length > 0 ? [self.isHaveArIdMuArray insertObject:newNSOrderDetail.arId atIndex:finalIndex] : [self.isHaveArIdMuArray insertObject:@"" atIndex:finalIndex];
//        [self.isHaveArIdMuArray insertObject:newNSOrderDetail.arId atIndex:finalIndex];
    };
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, ISScreen_Width, ISScreen_Height - ISTabBarHeight - 59 - ISNavigationHeight) collectionViewLayout:flowLayout];
    
    /**  相册对象 cell */
    [collectionView registerNib:[UINib nibWithNibName:@"ISCutProCell" bundle:nil] forCellWithReuseIdentifier:CutProIdentifier_cell];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    //    collectionView.backgroundColor = ISRGBColor(220, 220, 220);
    collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    collectionView.alwaysBounceVertical = YES;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

#pragma mark ---- MWaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(MWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    return width * CutProCellRatio;
}

#pragma mark ---- UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ISCutProCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CutProIdentifier_cell forIndexPath:indexPath];
    cell.delegate = self;
    if (indexPath.row == self.images.count - 1) {
        cell.draggingDelegate = nil;
    }else
    {
        cell.draggingDelegate = self;
    }
    if (self.materialTimeLengthArray.count > indexPath.item) {
        [cell setContent:self.images[indexPath.item] atIndex:indexPath.item totalCount:self.images.count materialPath:[NSString stringWithFormat:@"%@", self.materialTimeLengthArray[indexPath.item]]];
        if (self.isHaveArIdMuArray.count > indexPath.item) {
            [cell setCouponImageWithArid:self.isHaveArIdMuArray[indexPath.item]];
        }
//        [cell setRewardImageWithArray:[self.takeVideoArray copy]];
        return cell;
    }
    [cell setContent:self.images[indexPath.item] atIndex:indexPath.item totalCount:self.images.count materialPath:nil];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 最多有20个素材, 现在数组中有21个图片
    if (indexPath.item == self.images.count - 1) {
        //未登录时先登录
        if (![UserEntity sharedSingleton].isAppHasLogin) {
            [self showLoginAndRegisterWindow];
            return;
        }
        
        if (self.images.count == 21) {  // 超过20个素材提示用户最多添加20个素材
            [UIAlertView alertViewshowMessage:@"最多添加20个素材!" cancleButton:nil confirmButton:@"确定"];
        } else {
            [self showChooseView];
        }
    }
}

#pragma mark --- ISCutProCellDelegate
- (void)cutproCell:(ISCutProCell *)cutproCell deleteClick:(UIButton *)button {
    self.currentDeleteCell = cutproCell;
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"导演, 确定删除吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertView.tag = 1234;
    [alertView show];
}

#pragma mark --- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0 && alertView.tag == 1234) {
        [self delete];
    }
}

- (void)delete {
    if (self.selectMaterialInDbArray.count == 0) {
        [CustomeClass deleteFileWithFileName:[NSString stringWithFormat:@"%@/Documents/orderThumail", NSHomeDirectory()]];
    }
    
    // 1. 从内存中删除
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:self.currentDeleteCell];
    
    NSLog(@"%ld", (long)indexPath.row);
    
    NSString * materialAssStr = [self.selectMaterialInDbArray[indexPath.item] material_assetsURL];
    
    if (![materialAssStr isEqualToString:@"(null)"] && materialAssStr.length > 0) {
        NSString * imageNameStr = [[materialAssStr componentsSeparatedByString:@"="][1] componentsSeparatedByString:@"&"][0];
        [self deleteImageWithImageName:imageNameStr];
    }
    
    // 移除数据源中的图片
    [self.images removeObjectAtIndex:indexPath.row];
    // 移除所选 asset 对象数组中要删除的对象
    [self.paths removeObjectAtIndex:indexPath.item];
    [self.materialTimeLengthArray removeObjectAtIndex:indexPath.item];
    [self.isHaveArIdMuArray removeObjectAtIndex:indexPath.item];
    [self.collectionView reloadData];
    
    // 2. 从数据库删除
    float reducetime = [MC_OrderAndMaterialCtrl DeleteMaterialInOrder:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id Index:(int)indexPath.item];
    
    // 3. 重新设置时间
    UserMaterialNum--;
    [self setRecommandsize:0.0 Reduce:reducetime];
    self.newsNSOrderDetail.nVideoLength = self.SetDurationValue;
    [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
    
    // 4. 重新设置导航右侧按钮的标题
    [self resetRightBarButtonTitle];
}

- (void)resetRightBarButtonTitle {
    if (self.images.count > 0) {
        self.rightBarButton.userInteractionEnabled = YES;
    } else {
        self.rightBarButton.userInteractionEnabled = NO;
    }
    
    if (self.isTransFromPreview == YES) {
        NSString *title = nil;
        if (self.makeFilm == YES) {
            title = [NSString stringWithFormat:@"00/20 下一步"];
        } else {
            title = [NSString stringWithFormat:@"%02zd/20 完成", self.images.count - 1];
        }
        [self.rightBarButton setTitle:title forState:UIControlStateNormal];
        [self.rightBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        NSString *title = [NSString stringWithFormat:@"%02zd/20下一步", self.images.count - 1];
        [self.rightBarButton setTitle:title forState:UIControlStateNormal];
        [self.rightBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

#pragma mark - 显示选择素材弹框

/**  显示选择素材弹框 */
- (void)showChooseView {
    ISChooseSourceView *view = [ISChooseSourceView chooseSourceView];
    view.delegate = self;
    [view show];
}

#pragma mark ---- ISChooseSourceViewDelegate

/**  拍摄视频 */
- (void)takeVideo {
    [CustomeClass HUDShow];
    WEAKSELF2
    
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(status == AVAuthorizationStatusAuthorized){
            
            //用户已经授权
            [weakSelf pushToTakeVideoVc];
        }
        else if (status == AVAuthorizationStatusDenied){
            
            //否认
            [weakSelf showMessage];
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
                    [weakSelf showMessage];
                }
            }];
        }
    }, {})
}

#pragma mark - 跳转拍摄界面

/**
 *  跳转拍摄界面
 */
- (void)pushToTakeVideoVc{
    MakeVideoNavigationControllerViewController *takeVideoVc = [MakeVideoNavigationControllerViewController new];
    takeVideoVc.hidesBottomBarWhenPushed = YES;
    
    [self presentViewController:takeVideoVc animated:YES completion:^{
        [CustomeClass HUDHidden];
    }];
}

/**
 *  使用视频通知
 */
- (void)addTakeVideo:(NSNotification *)noti{
    [self addTakeVideoWithArray:noti.userInfo[takeVideoArray]];
}

/**
 *  添加拍摄视频到数据库
 */
- (void)addTakeVideoWithArray:(NSArray *)takeVideoArray{
    SHOWHUD
    WEAKSELF2
    for (TempVideoOBj * tempVideoObj in takeVideoArray) {
        NewOrderVideoMaterial * addItem = [NewOrderVideoMaterial new];
        addItem.createTime = tempVideoObj.createTime;
        addItem.order_id = weakSelf.newsNSOrderDetail.order_id;
        addItem.material_type = 2;
        addItem.material_playduration = tempVideoObj.videoLength;
        addItem.material_index = 0;
        addItem.material_localURL = tempVideoObj.localUrl;
        addItem.material_ossURL = @"";
        addItem.material_stream = tempVideoObj.videoThumailImage;
        addItem.material_assetsURL = tempVideoObj.assUrl;
        addItem.arId = tempVideoObj.arid;
        addItem.rewardType = tempVideoObj.rewardType;
        [MC_OrderAndMaterialCtrl MC_AddMaterial:[CURRENTUSERID intValue]
                                       Material:addItem
                                        Orderid:weakSelf.newsNSOrderDetail.order_id];
        
        //添加缩略图到沙盒
        NSString * imageNameStr = [[tempVideoObj.assUrl componentsSeparatedByString:@"="][1] componentsSeparatedByString:@"&"][0];
        [weakSelf saveImageDocuments:tempVideoObj.videoThumailImage
                           ImageName:imageNameStr];
        
        [weakSelf setRecommandsize:tempVideoObj.videoLength Reduce:0.0];
        
        weakSelf.newsNSOrderDetail.nVideoLength = _recommondvalue;
        [MC_OrderAndMaterialCtrl UpdateFresh:weakSelf.newsNSOrderDetail];
    }
    
    [weakSelf.takeVideoArray addObjectsFromArray:takeVideoArray];
    
    MAINQUEUEUPDATEUI({
        HIDDENHUD
        [weakSelf.collectionView reloadData];
    })
}

/** 未允许使用相机权限*/
- (void)showMessage{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:@"请在iphone的“设置-隐私-相机”选项中，允许映像访问你的相机" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert removeFromParentViewController];
    }];
    [alert addAction:alertAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/**  从相册中选择图片 */
#pragma mark - 跳转相册选取图片
- (void)choosePhoto{
    [CustomeClass HUDShow];
    
    //获取授权
    //iOS9以后
    WEAKSELF(weakSelf);
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        
        if ([CustomeClass getIOSVersion] > 9.0f) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                
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
        }else{
            //iOS9以前
            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
            
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if (*stop) {
                    
                    // TODO:...
                    [weakSelf pushToSelectMaterial];
                    return;
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString * alertStr = [NSString stringWithFormat:@"请在%@的\"设置-隐私-照片\"选项中，\r允许映像访问你的手机相册。",[UIDevice currentDevice].model];
                        ALERT(alertStr)
                    });
                }
                *stop = TRUE;//不能省略
                
            } failureBlock:^(NSError *error) {
                
                NSLog(@"failureBlock");
            }];
        }
    }, {})
}

//保存图片
-(void)saveImageDocuments:(UIImage *)image ImageName:(NSString *)imageNameStr{
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.png", [self creatImageFile], imageNameStr]];
    NSLog(@"存之前 --- 这个文件：%@",result?@"存在":@"不存在");
    if (!result) {
        [UIImagePNGRepresentation(image) writeToFile:[NSString stringWithFormat:@"%@/%@.png", [self creatImageFile], imageNameStr] atomically:YES];
        BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.png", [self creatImageFile], imageNameStr]];
        NSLog(@"存之后 --- 这个文件：%@",result?@"存在":@"不存在");
    }
}
// 读取
-(UIImage *)getImageWithImageName:(NSString *)imageNameStr{
    // 拿到沙盒路径图片
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png", [self creatImageFile], imageNameStr]];
    return imgFromUrl3 ? imgFromUrl3 : DEFAULTVIDEOTHUMAIL;
}

- (void)deleteImageWithImageName:(NSString *)imageNameStr{
    NSError * error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.png", [self creatImageFile], imageNameStr]]) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@.png", [self creatImageFile], imageNameStr] error:&error];
    }
    if (error) {
        DEBUGLOG(error)
    }else{
        DEBUGSUCCESSLOG(@"删除成功")
    }
}

- (NSString *)creatImageFile{
    NSString *imageDir = [NSString stringWithFormat:@"%@/Documents/orderThumail", NSHomeDirectory()];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return imageDir;
}

- (void)deleteFile{
    [[NSFileManager defaultManager] removeItemAtPath:[self creatImageFile] error:nil];
}

- (void)pushToSelectMaterial{
    
    //获得所有的选择的素材的assurl
    [SINGLETON(SelectMaterialArray) removeAllMaterial];
    NSMutableArray *selectMuArray = [MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id];
    for (NewOrderVideoMaterial *newOrderVideoMaterial in selectMuArray) {
            
        //在这里使用asset来获取图片
        [SINGLETON(SelectMaterialArray) addMaterial:newOrderVideoMaterial];
    }
    
    [self initPickAndPush];
}

- (void)initPickAndPush{
    WEAKSELF2
    XMNPhotoPickerController *picker = [[XMNPhotoPickerController alloc] initWithMaxCount:20 delegate:nil];
    
    //    选择照片后回调
    [picker setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> * _Nullable images, NSArray<XMNAssetModel *> * _Nullable assets) {
        [CustomeClass HUDShow];
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            MAINQUEUEUPDATEUI({
                for (int i = 0; i<assets.count; i++) {
                    if(![self addMaterial:assets[i]]){
                        [UIWindow showMessage:@"素材时长超过180s" withTime:2.0];
                        break;
                    }
                }
                [CustomeClass HUDHidden];
                [weakSelf loadmaterials];
                [weakSelf refreshSliderBarFrame];
            })
        }];
    }];
    
    //    点击取消
    [picker setDidCancelPickingBlock:^{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    [self presentViewController:picker animated:YES completion:^{
        [CustomeClass HUDHidden];
    }];
}

- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    if (USERFILMMAX-self.recommondvalue<1.0) {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"提示:"
                                   message:@"剩余的拍摄时长太短。"
                                  delegate:nil
                         cancelButtonTitle:@"取消"
                         otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSArray *mediaTypes = [UIImagePickerController
                           availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController
         isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0)
    {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        if (!_imagePicker)
        {
            _imagePicker=[[UIImagePickerController alloc]init];
        }
        self.imagePicker.mediaTypes = mediaTypes;
        self.imagePicker.delegate = self;
        self.imagePicker.videoMaximumDuration = USERFILMMAX - self.recommondvalue;
        
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.sourceType = sourceType;
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            _imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            _imagePicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
            if (self.isVideo)
            {
                _imagePicker.mediaTypes=@[(NSString *)kUTTypeMovie];
                _imagePicker.videoQuality=UIImagePickerControllerQualityTypeIFrame960x540;
                _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;
            }else{
                _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
            }
            [self presentViewController:_imagePicker animated:YES completion:NULL];
        }else if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
        {
            [self presentViewController:_imagePicker animated:YES completion:NULL];
        }
    } else {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"提示:"
                                   message:@"不支持的媒体类型."
                                  delegate:nil
                         cancelButtonTitle:@"取消"
                         otherButtonTitles:nil];
        [alert show];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    //相机回调
//    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
//        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        NSDate * date = [NSDate date];
//        NSString *strTime =[NSString stringWithFormat:@"%ld",(long)date.timeIntervalSinceReferenceDate];
//        NSString *fileName = [[NSString alloc] initWithFormat: @"%@.png",strTime];
//        NSString *KCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        NSString *videoPath = [[NSString alloc] initWithFormat: @"%@/%@",KCachesPath,fileName];
//        [data writeToFile:videoPath atomically:YES];
//        UIImage *image;
//        image=[info objectForKey:UIImagePickerControllerOriginalImage];
//        if (orderCurrent <= 20&&_recommondvalue<=USERFILMMAX-3.0) {
//            NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
//            NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
//            newOrderVideoMaterial.createTime = newNSOrderDetail.createTime;
//            newNSOrderDetail = [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBSearch:newNSOrderDetail];
//            newOrderVideoMaterial.order_id = newNSOrderDetail.order_id;
//            newOrderVideoMaterial.file_st = 0;
//            newOrderVideoMaterial.material_type = 2;
//            newOrderVideoMaterial.material_index = orderCurrent;
//            newOrderVideoMaterial.material_localURL = videoPath;
//            newOrderVideoMaterial.material_ossURL = @"";
//            newOrderVideoMaterial.material_stream = image;
//            newOrderVideoMaterial.material_assetsURL = @"";
//            [[APPUserPrefs Singleton] APP_MaterialCacheInformationDBInsert:newOrderVideoMaterial];
//            orderCurrent++;
//            [self.collectionView reloadData];
//        }else{
//            [UIWindow showMessage:@"素材总长超过" withTime:3.0];//视频长度大于90.0
//        }
//    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
//        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];
//        AVURLAsset *avUrl = [AVURLAsset assetWithURL:url];
//        CMTime time = [avUrl duration];
//        //        NSLog(@"seconds is equal = %lld ",time.value/time.timescale);
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        MPMoviePlayerController *mp = [[MPMoviePlayerController alloc] initWithContentURL:url];
//        mp.shouldAutoplay = NO;
//        UIImage *thumbnail = [mp thumbnailImageAtTime:0.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
//        NSDate * date = [NSDate date];
//        NSString *strTime =[NSString stringWithFormat:@"%ld",(long)date.timeIntervalSinceReferenceDate];
//        NSString *fileName = [[NSString alloc] initWithFormat: @"%@.mov",strTime];
//        NSString *KCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        NSString *videoPath = [[NSString alloc] initWithFormat: @"%@/%@",KCachesPath,fileName];
//        [data writeToFile:videoPath atomically:YES];
//        if (orderCurrent <= 20&&_recommondvalue<=USERFILMMAX-time.value/time.timescale) {
//            NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
//            //创建ALAssetsLibrary对象并将视频保存到媒体库
//            ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];
//            [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL completionBlock:^(NSURL *assetURL, NSError *error) {
//                if (!error) {
//                    NSLog(@"captured video saved with no error.");
//                    NewOrderVideoMaterial *additem = [[NewOrderVideoMaterial alloc] init];
//                    additem.createTime = self.newsNSOrderDetail.createTime;
//                    additem.order_id = self.newsNSOrderDetail.order_id;
//                    additem.file_st = 0;
//                    additem.material_type = 2;
//                    additem.material_index = 0;
//                    additem.material_localURL = videoPath;
//                    additem.material_ossURL = @"";
//                    additem.material_stream = thumbnail;
//                    additem.material_assetsURL = [assetURL absoluteString];
//                    additem.material_playduration = time.value/time.timescale;
//                    
//                    //添加缩略图到沙盒
//                    NSString * imageNameStr = [[additem.material_assetsURL componentsSeparatedByString:@"="][1] componentsSeparatedByString:@"&"][0];
//                    [self saveImageDocuments:thumbnail ImageName:imageNameStr];
//                    
//                    [MC_OrderAndMaterialCtrl MC_AddMaterial:[[UserEntity sharedSingleton].customerId intValue] Material:additem Orderid:self.newsNSOrderDetail.order_id];
//                    [self setRecommandsize:additem.material_playduration Reduce:0.0];
//                    
//                    self.newsNSOrderDetail.nVideoLength = _recommondvalue;
//                    [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
//                    
//                    /*
//                     NSInteger index = self.images.count - 1;
//                     [self.images insertObject:additem.material_stream atIndex:0];
//                     */
//                    [self.collectionView reloadData];
//                    
//                }else
//                {
//                    NSLog(@"error occured while saving the video:%@", error);
//                }
//            }];
//            orderCurrent++;
//        }else{
//            [UIWindow showMessage:@"素材总长超过" withTime:3.0];//视频长度大于180.0
//        }
//    }
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}

//#pragma mark --- UzysAssetsPickerControllerDelegate
//- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
//{
//    //相册回调
//    if (assets.count + orderCurrent>20) {
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"提示:"
//                              message:@"素材数量太多！"
//                              delegate:nil
//                              cancelButtonTitle:@"OK"
//                              otherButtonTitles:nil];
//        [alert show];
//        return;
//    }
//    for (int i = 0; i<assets.count; i++) {
//        if(![self AddMaterial:assets[i]]){
//            [UIWindow showMessage:@"素材时长超过180s" withTime:2.0];
//            break;
//        }
//        //        k++;
//    }
//    //arbintest
//    //    [self arbintest:assets[0]];
//    //    [self performSelector:@selector(addLead) withObject:nil afterDelay:1.0];
//    
//}

-(void)addLead
{
    NSUserDefaults * userInfoDefault = [NSUserDefaults standardUserDefaults];
    NSString *userInfo = @"CutProViewClongLeadPage";
    if ([userInfoDefault boolForKey:userInfo] == NO) {
        //获取引导界面view
        longleadPage *lead = [[longleadPage alloc] initWithFrame:self.view.bounds];
        
        if(lead != nil)
        {
            [[UIApplication sharedApplication].keyWindow addSubview:lead];
            [userInfoDefault setBool:YES forKey:userInfo];
        }
        
        
    }
}

-(void)arbintest:(ALAsset*)al{
    //    ALAssetRepresentation *rep = [al defaultRepresentation];
    //    Byte *buffer = (Byte*)malloc(rep.size);
    //    NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
    //    NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
    //    NSString * url = [[HeaderChange Singleton] UploadUserHeader:[UserEntity sharedSingleton].customerId EXt:@"png" Yourdata:data];
    //    NSLog(@"~~~~~~~~~%@",url);
}

//根据XMNAssetModel添加到数据库
- (BOOL)addMaterial:(XMNAssetModel *)assetModel{
    NSString * fileName = assetModel.filename;
    UIImage * image = [UIImage imageWithCGImage:(__bridge CGImageRef _Nonnull)(assetModel.thumbnail)];
    NSURL * imageUrl = assetModel.fileAssUrl;
    NSString * kCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * videoPath = [[NSString alloc] initWithFormat:@"%@/%@", kCachesPath, fileName];
    [self videoWithUrl:imageUrl withFileName:videoPath];
    
    NewOrderVideoMaterial * additem = [NewOrderVideoMaterial new];
    additem.createTime = self.newsNSOrderDetail.createTime;
    additem.order_id = self.newsNSOrderDetail.order_id;
    if (assetModel.type == XMNAssetTypePhoto || assetModel.type == XMNAssetTypeLivePhoto) {
        //照片
        additem.material_type = 1;
        additem.material_playduration = 3.0;
    }else if (assetModel.type == XMNAssetTypeAudio || assetModel.type == XMNAssetTypeVideo){
        //视频
        additem.material_type = 2;
        NSMutableArray * tempMuArray = [NSMutableArray arrayWithArray:[assetModel.timeLength componentsSeparatedByString:@":"]];
        additem.material_playduration = [tempMuArray[0] intValue] * 60 + [tempMuArray[1] intValue];
    }else{
        //其他
        additem.material_type = 0;
    }
    
    additem.material_index = 0;
    additem.material_localURL = videoPath;
    additem.material_ossURL = @"";
    additem.material_stream = image;
    additem.material_assetsURL = [imageUrl absoluteString];
    
    BOOL exist = [MC_OrderAndMaterialCtrl FindMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id URL:additem.material_assetsURL URLType:USELOCALPATH];
    if (exist) {
        NSLog(@"material alread exist!");
        [[VideoDBOperation Singleton] setARIdWithAssetURL:additem.material_assetsURL];
        [[VideoDBOperation Singleton] setRewardTypeWithAssetURL:additem.material_assetsURL];
        return true;
    }
    
    if (_recommondvalue+additem.material_playduration >USERFILMMAX) {
        return false;
    }
    [MC_OrderAndMaterialCtrl MC_AddMaterial:[[UserEntity sharedSingleton].customerId intValue] Material:additem Orderid:self.newsNSOrderDetail.order_id];
    [self setRecommandsize:additem.material_playduration Reduce:0.0];
    
    self.newsNSOrderDetail.nVideoLength = _recommondvalue;
    [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
    
    //添加缩略图到沙盒
    NSString * imageNameStr = [[additem.material_assetsURL componentsSeparatedByString:@"="][1] componentsSeparatedByString:@"&"][0];
    [self saveImageDocuments:assetModel.thumbnail ImageName:imageNameStr];
    
    return true;
}

- (BOOL)AddMaterial:(ALAsset *)al{
    
    //用到了al的属性有 al.defaultRepresentation.filename  al.thumbnail  al.defaultRepresentation.url [[al valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto] [[al valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]
    //替换到新的数据层 2015-11-04 arbin修改
    NSString *filename = al.defaultRepresentation.filename;
    UIImage *image = [UIImage imageWithCGImage:al.thumbnail];
    NSURL *imageURL = al.defaultRepresentation.url;
    NSString *KCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *videoPath = [[NSString alloc] initWithFormat: @"%@/%@",KCachesPath,filename];
    [self videoWithUrl:imageURL withFileName:videoPath];
    
    NewOrderVideoMaterial *additem = [[NewOrderVideoMaterial alloc] init];
    additem.createTime = self.newsNSOrderDetail.createTime;
    additem.order_id = self.newsNSOrderDetail.order_id;
    additem.file_st = 0;
    
    // 根据 asset 对象是照片和视频, 设置类型
    if ([[al valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {   // 照片:1
        additem.material_type = 1;
    } else if ([[al valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {    // 视频:2
        additem.material_type = 2;
    } else {    // 其他:0
        additem.material_type = 0;
    }
    
    //    additem.szUrl = imageURL;
    additem.material_index = 0;
    additem.material_localURL = videoPath;
    
    //    additem.material_localURL = @"";
    additem.material_ossURL = @"";
    additem.material_stream = image;
    additem.material_assetsURL = [imageURL absoluteString];
    if([[al valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
        additem.material_playduration = 3.0;
    else
        additem.material_playduration = [[al valueForProperty:ALAssetPropertyDuration] floatValue];
    BOOL exist = [MC_OrderAndMaterialCtrl FindMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id URL:additem.material_assetsURL URLType:USELOCALPATH];
    if (exist) {
        NSLog(@"material alread exist!");
        return true;
    }
    if (_recommondvalue+additem.material_playduration >USERFILMMAX) {
        
        //        [UIWindow showMessage:@"素材超长" withTime:3.0];
        return false;
    }
    [MC_OrderAndMaterialCtrl MC_AddMaterial:[[UserEntity sharedSingleton].customerId intValue] Material:additem Orderid:self.newsNSOrderDetail.order_id];
    [self setRecommandsize:additem.material_playduration Reduce:0.0];
    
    self.newsNSOrderDetail.nVideoLength = _recommondvalue;
    [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
    return true;
}

- (void)videoWithUrl:(NSURL *)url withFileName:(NSString *)fileName
{
    ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
    if (url) {
        [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
            ALAssetRepresentation *rep = [asset defaultRepresentation];
            char const *cvideoPath = [fileName UTF8String];
            FILE *file = fopen(cvideoPath, "a+");
            if (file) {
                const int bufferSize = 1024 * 1024;
                Byte *buffer = (Byte*)malloc(bufferSize);
                NSUInteger read = 0, offset = 0, written = 0;
                NSError* err = nil;
                if (rep.size != 0)
                {
                    do {
                        read = [rep getBytes:buffer fromOffset:offset length:bufferSize error:&err];
                        written = fwrite(buffer, sizeof(char), read, file);
                        offset += read;
                    } while (read != 0 && !err);
                }
                free(buffer);
                buffer = NULL;
                fclose(file);
                file = NULL;
            }
        } failureBlock:nil];
    }
}

- (IBAction)changeLength:(id)sender {
    UISlider *slider = (UISlider*)sender;
    [self refreshUserSetValue:slider.value];
    
    ///启用新的数据内容
    //    if(_SetDurationValue>=15.0){
    if(_recommondvalue>=15.0){
        self.newsNSOrderDetail.nVideoLength = slider.value;//
        self.newsNSOrderDetail.nMusicStart = 0;
        self.newsNSOrderDetail.nMusicEnd = slider.value;
        [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
    }
}

-(void)setRecommandsize:(float)addvalue Reduce:(float)minusvalue{
    _recommondvalue += addvalue;
    _recommondvalue -= minusvalue;
    _SetDurationValue += addvalue;
    _SetDurationValue -= minusvalue;
    if(_recommondvalue <0)
        _SetDurationValue = 0.0;
    
    if (_recommondvalue>=15.0) {
        [self refreshSliderBarFrame];
        _sliderbutton.maximumValue = _recommondvalue;
        [_labelRecommand setText:[NSString stringWithFormat:@"大约%0.1lf秒",_sliderbutton.value]];
    }else{
        _sliderbutton.maximumValue = USERFILMMIN;
        self.sliderWidthC.constant = 4;
        [_labelRecommand setText:@"素材过少， 请添加素材"];
    }
}

-(void)resetSliderBar{
    _recommondvalue = 0;
    _SetDurationValue = 0;
    _sliderbutton.maximumValue = USERFILMMIN;
    _sliderbutton.minimumValue=USERFILMMIN;
    _sliderbutton.value=USERFILMMIN;
    [_labelRecommand setText:@"请添加用户素材"];
}

-(void)refreshSliderBarFrame{
    if(_recommondvalue<15.0)
        return;
    [UIView animateWithDuration:0.3 animations:^{
        self.sliderWidthC.constant = (ISScreen_Width-32.0)*(_recommondvalue-15.0)/(USERFILMMAX-USERFILMMIN);
    }];
    return;
}

-(void)refreshUserSetValue:(float)value{
    _sliderbutton.value = value;
    _SetDurationValue = value;
    if(value>=15.0 && self.images.count > 1)
        [_labelRecommand setText:[NSString stringWithFormat:@"大约%0.1lf秒",value]];
    else
        [_labelRecommand setText:@"素材过少， 请添加素材"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that  be recreated.
}

#pragma mvOverSlider delegate
-(void)SliderRightOver{
#pragma mark - 加判断
    if (self.recommondvalue < 180 && self.images.count < 20) {
        [self showAlert:@"想制作更长的影片吗？请继续添加素材吧。"];
    }
}
- (void)showAlert:(NSString*)msg
{
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [promptAlert show];
}
#pragma mark - losehero
#pragma mark - HTKDraggableCollectionViewCellDelegate

- (void)userDidBeginDraggingCell:(UICollectionViewCell *)cell {
    
    HTKDragAndDropCollectionViewLayout *flowLayout = (HTKDragAndDropCollectionViewLayout *)self.collectionView.collectionViewLayout;
    flowLayout.draggedIndexPath = [self.collectionView indexPathForCell:cell];
    flowLayout.draggedCellFrame = cell.frame;
}

- (void)userDidEndDraggingCell:(UICollectionViewCell *)cell {
    HTKDragAndDropCollectionViewLayout *flowLayout = (HTKDragAndDropCollectionViewLayout *)self.collectionView.collectionViewLayout;
    //此处未使用
    //    NSIndexPath *finallIndexPath = flowLayout.finalIndexPath;
    //    NSIndexPath *dragIndexPath = flowLayout.draggedIndexPath;
    [flowLayout resetDragging];
    [self performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
    
}
-(void)reloadData
{
    //    [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBDelete];
    //    for (int i = 0; i < self.images.count + 2; i ++) {
    //        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
    //        [MC_OrderAndMaterialCtrl DeleteMaterialInOrder:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id Index:(int)path.item];
    //    }
    
    //    [self.models enumerateObjectsUsingBlock:^(  NewOrderVideoMaterial *obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        [MC_OrderAndMaterialCtrl MC_AddMaterial:[[UserEntity sharedSingleton].customerId intValue] Material:obj Orderid:self.newsNSOrderDetail.order_id];
    //        [self setRecommandsize:obj.material_playduration Reduce:0.0];
    //        self.newsNSOrderDetail.nVideoLength = _recommondvalue;
    //        [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
    //    }];
    [self.collectionView reloadData];
}
- (void)userDidDragCell:(UICollectionViewCell *)cell withGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
    
    HTKDragAndDropCollectionViewLayout *flowLayout = (HTKDragAndDropCollectionViewLayout *)self.collectionView.collectionViewLayout;
    CGPoint translation = [recognizer translationInView:self.collectionView];
    // Determine our new center
    CGPoint newCenter = CGPointMake(recognizer.view.center.x + translation.x,
                                    recognizer.view.center.y + translation.y);
    // Set center
    flowLayout.draggedCellCenter = newCenter;
    [recognizer setTranslation:CGPointZero inView:self.collectionView];
    
    // swap items if needed
    [flowLayout exchangeItemsIfNeeded];
    
    UICollectionViewCell *draggedCell = [self.collectionView cellForItemAtIndexPath:flowLayout.draggedIndexPath];
    [self scrollIfNeededWhileDraggingCell:draggedCell];;
    
    
}


- (void)scrollIfNeededWhileDraggingCell:(UICollectionViewCell *)cell {
    
    HTKDragAndDropCollectionViewLayout *flowLayout = (HTKDragAndDropCollectionViewLayout *)self.collectionView.collectionViewLayout;
    if (![flowLayout isDraggingCell]) {
        // If we've stopped dragging, exit
        return;
    }
    
    CGPoint cellCenter = flowLayout.draggedCellCenter;
    // Offset we will be adjusting
    CGPoint newOffset = self.collectionView.contentOffset;
    // How far past edge does it need to be before scrolling
    CGFloat buffer = 10;
    
    // Check for scrolling down
    CGFloat bottomY = self.collectionView.contentOffset.y + CGRectGetHeight(self.collectionView.frame);
    if (bottomY < CGRectGetMaxY(cell.frame) - buffer) {
        // We're scrolling down
        newOffset.y += 1;
        
        if (newOffset.y + CGRectGetHeight(self.collectionView.bounds) > self.collectionView.contentSize.height) {
            return; // Stop moving, went too far
        }
        
        // adjust cell's center by 1
        cellCenter.y += 1;
    }
    
    // Check if moving upwards
    CGFloat offsetY = self.collectionView.contentOffset.y;
    if (CGRectGetMinY(cell.frame) + buffer < offsetY) {
        // We're scrolling up
        newOffset.y -= 1;
        
        if (newOffset.y <= 0) {
            return; // Stop moving, went too far
        }
        
        // adjust cell's center by 1
        cellCenter.y -= 1;
    }
    
    // Set new values
    self.collectionView.contentOffset = newOffset;
    flowLayout.draggedCellCenter = cellCenter;
    // Repeat until we went to far.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollIfNeededWhileDraggingCell:cell];
    });
}
@end
