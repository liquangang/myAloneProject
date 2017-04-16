//
//  ISCutPreViewController.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/29.
//  Copyright © 2015年 Crab movier. All rights reserved.
//
/** 影片概览页面*/
#import "ISCutPreViewController.h"
#import "SoapOperation.h"
#import "GlobalVars.h"
#import "ISStyleDetailCell.h"
// 选择素材界面
#import "ISCutProViewController.h"
// 选择风格界面
#import "ISCutProStylNewViewController.h"
#import "ISCutProStyleViewController.h"
// 订单和素材控制类
#import "MC_OrderAndMaterialCtrl.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+WebCache.h"
// 进度条
#import "ISProgressView.h"
#import "MovierTranslation.h"
#import "ISPlaceholderTextView.h"
//引导界面
#import "leadPage.h"
#import "MBProgressHUD.h"
//音乐选择页面
#import "MusicClipsTNewViewC.h"
#import "APPUserPrefs.h"
//传输类
#import "MovierTranslation.h"
#import "MyVideoViewController.h"
#import "CustomeClass.h"
#import "SubtitleViewController.h"
#import "AFNetWorkManager.h"

// 清空订单列表的通知
#define ISNewOrderCreateNotification @"ISNewOrderCreateNotification"
// 影片详情返回制作首页, 使用通知传递参数
#define ISStyleDetailBacktoCutProParams         @"ISStyleDetailBacktoCutProParams"
#define ISStyleDetailBacktoCutProNotification   @"ISStyleDetailBacktoCutProNotification"
//返回根目录
#define ISGoToMainPage              @"Let's go home"

@interface ISCutPreViewController () <UITextViewDelegate>
/**  顶部的图片 */
@property (weak, nonatomic) IBOutlet UIImageView *titleView;
/**  标题 */
@property (weak, nonatomic) IBOutlet ISPlaceholderTextView *titleField;
/**  是否正在编辑标题 */
@property (assign, nonatomic) BOOL isEditingTitle;

/**  视图的统一高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconWidth;

/**  影片素材 */
@property (weak, nonatomic) IBOutlet UIView *filmView;
@property (weak, nonatomic) IBOutlet UIImageView *filmImageView;
@property (weak, nonatomic) IBOutlet UILabel *filmLabel;

/**  风格 */
@property (weak, nonatomic) IBOutlet UIView *styleView;
@property (weak, nonatomic) IBOutlet UIImageView *styleImageView;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;

/**  音乐 */
@property (weak, nonatomic) IBOutlet UIView *musicView;
@property (weak, nonatomic) IBOutlet UIImageView *musicImageView;
@property (weak, nonatomic) IBOutlet UILabel *musicLabel;

/**  字幕 */
@property (weak, nonatomic) IBOutlet UIView *fontView;
@property (weak, nonatomic) IBOutlet UIImageView *fontImageView;
@property (weak, nonatomic) IBOutlet UILabel *fontLabel;

/**  保存到草稿箱 */
@property (weak, nonatomic) IBOutlet UIButton *draftButton;
/**  制作按钮 */
@property (weak, nonatomic) IBOutlet UIButton *makeButton;
/**  是否公开按钮 */
@property (weak, nonatomic) IBOutlet UIButton *publicButton;
/**  是否正在制作影片 */
@property (assign, nonatomic) BOOL isMakingFilm;
/**  是否已经制作过影片 */
@property (assign, nonatomic)  BOOL hasMade;
/**  是否公开 */
- (IBAction)isPublic:(UIButton *)sender;
/**  保存到草稿箱 */
- (IBAction)saveToDraft:(UIButton *)sender;
/**  制作影片 */
- (IBAction)makeMovie:(UIButton *)sender;

/**  记录上次绘制的进度 */
@property (assign, nonatomic) float lastProgress;

/**  进度条 */
@property (weak, nonatomic) ISProgressView *progressView;

@property(weak,nonatomic)UIView* popdecodeview;
/**  用户 id */
@property (assign, nonatomic) int customID;
/**   正在使用的订单数据 */
@property (strong, nonatomic) NewNSOrderDetail *usingOrder;

@property (strong, nonatomic) MovierDCInterfaceSvc_vpVDCMusicC *recommandMusic;

@property (nonatomic,strong) NSIndexPath *selIndex;
/**   素材是否有声音(即素材是否有视频)*/
@property (nonatomic, assign) BOOL isHaveVoice;
/**   是否保留原声方法*/
- (IBAction)keepVoiceButtonAction:(id)sender;
/**   是否保留原声label*/
@property (weak, nonatomic) IBOutlet UILabel *keepVoiceLabel;
/**   支持的文件格式数组（初步设计为只存储视频格式，用来判断素材中是否有视频文件）*/
@property (nonatomic, strong) NSMutableArray * fileFormatArray;
/**   保留原声按钮*/
@property (weak, nonatomic) IBOutlet UIButton *keepVoiceButton;
/**   保存保留原声按钮当前状态*/
@property (nonatomic, assign) BOOL isSelectKeepVoiceButton;
/**   记录保留原声按钮是否被点击过*/
@property (nonatomic, assign) BOOL isTouchkeepVoiceButton;

/** 是否已经跳转到我的影片部分*/
@property (nonatomic, assign) BOOL isPushToMyVideoVc;
@end

@implementation ISCutPreViewController

#pragma mark - 数组懒加载
- (NSMutableArray *)fileFormatArray{
    if (_fileFormatArray == nil) {
        /*
         支持的所有文件类型
         视频文件：.avi    .mp4   .mov
         图片文件： .GIF"  png  jpg  jpeg  bmp  webp
         */
        _fileFormatArray = [[NSMutableArray alloc] initWithObjects:@"MOV", @"AVI", @"MP4", @"mov", @"avi", @"mp4", nil];
    }
    return _fileFormatArray;
}

- (void) initLeadPage {
    
    NSUserDefaults * userInfoDefault = [NSUserDefaults standardUserDefaults];
    
    NSString *userInfo = @"ISCUPREVIEWCONTROLLER";
    
    if ([userInfoDefault boolForKey:userInfo] == NO) {
        
        //获取引导界面view
        leadPage *xu_leadPage = [[leadPage alloc]initWithName:@"3" ];
        if(xu_leadPage != nil)
        {
            [[UIApplication sharedApplication].keyWindow addSubview:xu_leadPage];
            [userInfoDefault setBool:YES forKey:userInfo];
        }
        
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLeadPage];
    
    [self setupTitleField];
    
    [self setupNavigation];
    
    [self getDefaultStyle];
    
    [self setupViews];
    
    [self setupProgressView];
    
    //确定用户素材有没有视频，然后根据这个结果确定保留视频原声按钮的状态
    [self isHaveVideo];
    
    [self setKeepVoiceButton];
}

//确定用户素材有没有视频，然后根据这个结果确定保留视频原声按钮是否显示
- (void)isHaveVideo{
    self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    
    //获取素材数组
    NSMutableArray * materialArray = [MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.usingOrder.order_id];
    self.isHaveVoice = NO;
    for (NewOrderVideoMaterial * newOrderVideoMatrial in materialArray) {
        
        if (newOrderVideoMatrial.material_type == 2) {
            self.isHaveVoice = YES;
        }else{
            self.isHaveVoice = NO;
        }
        
        if (self.isHaveVoice == YES) {
            //有视频 需要显示保留原声按钮
            self.keepVoiceLabel.hidden = NO;
            self.keepVoiceButton.hidden = NO;
            break;
        }
        else{
            //没视频
            self.keepVoiceButton.hidden = YES;
            self.keepVoiceLabel.hidden = YES;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 监听上传进度
//    [stockForKVO setValue:[NSNumber numberWithFloat:0.01] forKey:@"upratio"];
    [stockForKVO addObserver:self forKeyPath:@"upratio" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    // 素材上传成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadFileSucceed) name:@"orderfinish" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadFileSucceed) name:ISMaterialUploadSucceedNotification object:nil];
    
    // 风格改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeStyle:) name:ISStyleDetailBacktoCutProNotification object:nil];
    
    // 监听键盘出现和消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)changeStyle:(NSNotification *)noti {
    self.styleDetail = noti.userInfo[ISStyleDetailBacktoCutProParams];
    [self.styleImageView sd_setImageWithURL:[NSURL URLWithString:self.styleDetail.thumbnail]];
    self.styleLabel.text = self.styleDetail.title;
    if (!self.usingOrder) {
        self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    }
    self.usingOrder.nHeaderAndTailID = [self.styleDetail.nID intValue];
    [MC_OrderAndMaterialCtrl UpdateFresh:self.usingOrder];
    [self isHaveVideo];
    [self setKeepVoiceButton];
}

- (void)uploadFileSucceed {
    // 让屏幕所有的事件可以触发
    self.isMakingFilm = NO;
    self.progressView.hidden = YES;
    self.makeButton.userInteractionEnabled = YES;
    self.draftButton.userInteractionEnabled = YES;
    self.publicButton.userInteractionEnabled = YES;
    [self.makeButton setBackgroundColor:ISRGBColor(64, 74, 88)];
    [self.draftButton setBackgroundColor:ISRGBColor(64, 74, 88)];
    [stockForKVO setValue:[NSNumber numberWithFloat:0.01] forKey:@"upratio"];
    
    // 将制作完成的订单的内容清除
    //    [self clearLastOrderInfo];
}

// 将制作完成的订单的内容清除
- (void)clearLastOrderInfo {
    UIImage *image = GRAYICON;
    self.titleView.image = nil;
    self.titleField.text = @"";
    self.filmImageView.image = nil;
    self.filmLabel.text = @"";
    self.styleImageView.image = nil;
    self.styleLabel.text = @"";
    self.musicImageView.image = nil;
    self.musicLabel.text = @"";
    self.fontImageView.image = nil;
    self.fontLabel.text = @"";
    self.publicButton.selected = NO;
    
    self.filmImageView.image = image;
    self.styleImageView.image = image;
    self.musicImageView.image = image;
    self.fontImageView.image = image;
}

- (void)setupTitleField {
    self.titleField.delegate = self;
    self.titleField.textColor = [UIColor whiteColor];
    self.titleField.textAlignment = NSTextAlignmentCenter;
    self.titleField.placeholder = @"点击添加标题(10字)";
    self.titleField.placeholderColor = [UIColor whiteColor];
}

/**  设置导航信息 */
- (void)setupNavigation {
    // 标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"影片概览";
    label.font = ISFont_17;
    CGSize labelSize = [label.text sizeWithWidth:MAXFLOAT font:ISFont_17];
    label.textColor = ISRGBColor(255, 255, 255);
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.titleView = label;
    
    // 左侧按钮
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSString *leftBarTitle = @"返回首页";
    [leftBarButton setTitle:leftBarTitle forState:UIControlStateNormal];
    leftBarButton.titleLabel.font = ISFont_16;
    CGSize rightBarSize = [leftBarTitle sizeWithWidth:MAXFLOAT font:ISFont_16];
    leftBarButton.frame = CGRectMake(0, 0, rightBarSize.width, rightBarSize.height);
    [leftBarButton addTarget:self action:@selector(leftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
}

/**  回到首页 */
- (void)leftBarButtonClick:(UIButton *)button {
    [self saveFilmName];
    
    if (self.isMakingFilm == YES) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableDictionary *info = [NSMutableDictionary dictionary];
            info[@"makeFilm"] = @"YES";
            [[NSNotificationCenter defaultCenter] postNotificationName:ISNewOrderCreateNotification object:nil userInfo:info];
        });
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.titleField endEditing:YES];
}

#pragma mark --- UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.titleField.placeholder = @"点击添加标题(10字)";
    }
    
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:
                                 @"~!@#$%^&*()_+`{}|:<>?-=[]\\;',./~！@#￥%……&*（）——+·{}|：“《》？-=【】、；‘，。、"];
    
    NSString * content = textView.text;
    
    content = [[content componentsSeparatedByCharactersInSet: doNotWant] componentsJoinedByString: @""];
    textView.text = content;
    
    NSRange textRange = [textView selectedRange];
    [textView setText:[self disable_emoji:[textView text]]];
    [textView setSelectedRange:textRange];
    
    if (content.length > 10) {
        content = [content substringToIndex:10];
        [UIWindow showMessage:@"标题长度超过10字符" withTime:2.0];
    }else{
        // 保存影片名
        NewNSOrderDetail *freshorder = [MC_OrderAndMaterialCtrl GetFreshOrder:self.customID];
        freshorder.szVideoName = content;
        [MC_OrderAndMaterialCtrl UpdateFresh:freshorder];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.isMakingFilm == YES)  return;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.titleField.placeholder = @"";
    return YES;
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder]; return NO;
    }
    return YES;
}


// 键盘显示时, 可以点击
- (void)keyboardShow:(NSNotification *)noti {
    self.isEditingTitle = YES;
}
- (void)keyboardHide:(NSNotification *)noti {
    self.isEditingTitle = NO;
}

- (void)getDefaultStyle {
    __weak typeof(self) vc = self;
    
    // 从网络获得数据, 显示到 imageView 上
    if (self.isFromDraftBox == YES) {
        self.styleDetail.nID = @(self.orderid);
    }
    
    [[SoapOperation Singleton] WS_GetDefaultInfoUseStyle:nil StyleID:self.styleDetail.nID Success:^(MovierDCInterfaceSvc_vpVDCMusicC *music, MovierDCInterfaceSvc_vpVDCSubtitleC *subTitle) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.musicLabel.text = music.szName;
            self.recommandMusic = music;
            
            if (!vc.usingOrder) {
                
                //  重新编辑后, 保存音乐信息
                self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
            }
            
            vc.usingOrder.nMusicID = [music.nID intValue];
            [MC_OrderAndMaterialCtrl UpdateFresh:vc.usingOrder];
            
            if (music.szUrl) {
                [self.musicImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@thumbail.jpg", self.recommandMusic.szUrl]] placeholderImage:GRAYICON options:SDWebImageRetryFailed | SDWebImageRefreshCached];
            }
            
            if ([music.szName isEqualToString:@"无音乐"]) {
                self.musicImageView.image = [UIImage imageNamed:@"无音乐icon"];
            }
            
            if (subTitle.szThumbnail) {
                [self.fontImageView sd_setImageWithURL:[NSURL URLWithString:subTitle.szThumbnail] placeholderImage:GRAYICON];
            }
            
            vc.usingOrder.nSubtitleID = [subTitle.nID intValue];
            vc.usingOrder.szCustomerSubtitle = subTitle.szRecommend;
            [MC_OrderAndMaterialCtrl UpdateFresh:self.usingOrder];
        });
    } Fail:^(NSError *error) {
        NSLog(@"------%s------%@", __func__, error);
    }];
}

- (void)setupProgressView {
    // 1. 添加进度条
    ISProgressView *progressView = [ISProgressView progressView];
    progressView.hidden = YES;
    [progressView  showInView:self.view];
    self.progressView = progressView;
}

//设置保留原声按钮的状态（选中还是不选中）
- (void)setKeepVoiceButton{
    if(self.keepVoiceLabel.hidden == NO){
        if ([self.styleDetail.nHeaderAndTailStyle intValue] == 0) {
            //推荐有原声（选中）
            [self.keepVoiceButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
            self.isSelectKeepVoiceButton = YES;
        }
        else{
            //推荐没有原声（未选中）
            [self.keepVoiceButton setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
            self.isSelectKeepVoiceButton = NO;
        }
    }
}

- (void)setupViews {
    // 获得本地素材
    [self getMaterial];
    
    // 取出占位图
    UIImage *image = GRAYICON;
    self.viewHeight.constant = 72.0 / 667 * (ISScreen_Height - ISNavigationHeight - ISTabBarHeight);
    self.iconWidth.constant = 56.0 / 667 * (ISScreen_Height - ISNavigationHeight - ISTabBarHeight);
    
    // 影片
    self.filmImageView.layer.cornerRadius = self.iconWidth.constant * 0.5;
    self.filmImageView.clipsToBounds = YES;
    self.filmImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.filmImageView.image = DEFAULTVIDEOTHUMAIL;
    UITapGestureRecognizer *filmTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(filmClick:)];
    [self.filmView addGestureRecognizer:filmTap];
    
    // 风格
    self.styleImageView.layer.cornerRadius = self.iconWidth.constant * 0.5;
    self.styleImageView.clipsToBounds = YES;
    self.styleLabel.text = self.styleDetail.title;
    self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    if (self.isFromDraftBox == YES) {
        self.styleDetail.nID = @(self.orderid);
        self.usingOrder.nHeaderAndTailID = self.orderid;
    }else{
        self.usingOrder.nHeaderAndTailID = [self.styleDetail.nID intValue];
    }
    [MC_OrderAndMaterialCtrl UpdateFresh:self.usingOrder];
    [self.styleImageView sd_setImageWithURL:[NSURL URLWithString:self.styleDetail.thumbnail] placeholderImage:GRAYICON];
    self.styleImageView.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *styleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(styleClick:)];
    [self.styleView addGestureRecognizer:styleTap];
    
    // 音乐nShareType
    self.musicImageView.layer.cornerRadius = self.iconWidth.constant * 0.5;
    self.musicImageView.clipsToBounds = YES;
    [self.musicImageView sd_setImageWithURL:[NSURL URLWithString:self.recommandMusic.szUrl] placeholderImage:GRAYICON];
    self.musicImageView.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *musicTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(musicClick:)];
    [self.musicView addGestureRecognizer:musicTap];
    
    // 字幕
    self.fontImageView.layer.cornerRadius = self.iconWidth.constant * 0.5;
    self.fontImageView.clipsToBounds = YES;
    self.fontImageView.image = image;
    self.fontImageView.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *fontTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fontClick:)];
    [self.fontView addGestureRecognizer:fontTap];
    if (!self.usingOrder) {  //  重新编辑后, 保存音乐信息
        self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    }
    
    //公开状态
    if (!self.usingOrder) {  //  重新编辑后, 保存音乐信息
        self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    }
    
    if (self.usingOrder.nShareType == 0) {
        self.publicButton.selected = YES;
    }
    else{//公开1
        self.publicButton.selected = NO;
    }
}

/**  获得本地素材 */
- (void)getMaterial {
    // 获得素材
    int customID = [[UserEntity sharedSingleton].customerId intValue];
    self.customID = customID;
    NewNSOrderDetail *freshOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:customID];
    
    NSMutableArray *array = [MC_OrderAndMaterialCtrl GetMaterial:customID Orderid:freshOrder.order_id];
    self.filmLabel.text = [NSString stringWithFormat:@"已选%zd段", array.count];
    BOOL hasPhoto = NO;
    NSInteger index = 0;
    for (NSInteger i = 0; i < array.count; i ++) {  // 看是否有图片素材
        NewOrderVideoMaterial *materil = array[i];
        if (materil.material_type == 1) {   // material_type  1: 照片, 2: 视频
            index = i;
            hasPhoto = YES;
            break;
        }
    }
    
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    if (hasPhoto == YES) {  // 有图片
        NSURL *url = [NSURL URLWithString:[array[index] material_assetsURL]];
        [lib assetForURL:url resultBlock:^(ALAsset *asset) {
            UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
            self.titleView.image = image;
            self.titleView.contentMode = UIViewContentModeScaleAspectFill;
            self.filmImageView.image = image;
        } failureBlock:^(NSError *error) {
            NSLog(@"-----%s------%@", __func__, error);
        }];
    } else {    // 没有图片
        NSURL *url = [NSURL URLWithString:[array[0] material_assetsURL]];
        [lib assetForURL:url resultBlock:^(ALAsset *asset) {
            UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
            self.titleView.image = image;
            self.titleView.contentMode = UIViewContentModeScaleAspectFill;
            self.filmImageView.image = image;
        } failureBlock:^(NSError *error) {
            NSLog(@"-----%s------%@", __func__, error);
        }];
    }
}

/**  查看和更改  素材 */
- (void)filmClick:(UITapGestureRecognizer *)tap {
    if (self.isMakingFilm || self.isEditingTitle)  return;
    // 键盘退出编辑
    [self.titleField endEditing:YES];
    self.hasMade = NO;
    // 创建新的cutpro 界面
    ISCutProViewController *cut = [[UIStoryboard storyboardWithName:@"Preview" bundle:nil] instantiateViewControllerWithIdentifier:@"ISCutProRechoose_ID"];
    cut.isTransFromPreview = YES;
    cut.next2Preview=NO;
    cut.isNeedUpdateKeepVoiceButton = YES;
    [cut updateKeepVoiceStateWithBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self isHaveVideo];
            // 获得素材
            int customID = [[UserEntity sharedSingleton].customerId intValue];
            self.customID = customID;
            NewNSOrderDetail *freshOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:customID];
            
            NSMutableArray *array = [MC_OrderAndMaterialCtrl GetMaterial:customID Orderid:freshOrder.order_id];
            self.filmLabel.text = [NSString stringWithFormat:@"已选%zd段", array.count];
        });
    }];
    [self.navigationController pushViewController:cut animated:YES];
}

/**  查看和更改  风格信息 */
- (void)styleClick:(UITapGestureRecognizer *)tap {
    if (self.isMakingFilm || self.isEditingTitle)  return;
    // 键盘退出编辑
    [self.titleField endEditing:YES];
    
    //新页面
    ISCutProStylNewViewController * style = [ISCutProStylNewViewController new];
    WEAKSELF2
    [style setUpdateStyleBlock:^(ISStyleDetail *styleDetail) {
        weakSelf.styleDetail = styleDetail;
        
        [CustomeClass mainQueue:^{
            weakSelf.styleLabel.text = weakSelf.styleDetail.title;
            
            if (!weakSelf.usingOrder) {
                weakSelf.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
            }
            
            weakSelf.usingOrder.nHeaderAndTailID = [weakSelf.styleDetail.nID intValue];
            [MC_OrderAndMaterialCtrl UpdateFresh:weakSelf.usingOrder];
            [weakSelf.styleImageView sd_setImageWithURL:[NSURL URLWithString:weakSelf.styleDetail.thumbnail] placeholderImage:GRAYICON];
        }];
    }];
    
    [self.navigationController pushViewController:style animated:YES];
}

/**  查看和更改  音乐信息 */
- (void)musicClick:(UITapGestureRecognizer *)tap {
    if (self.isMakingFilm || self.isEditingTitle)  return;
    // 键盘退出编辑
    [self.titleField endEditing:YES];
    
    MusicClipsTNewViewC *musicVc = [[MusicClipsTNewViewC alloc] init];
    musicVc.recommadMusic = self.recommandMusic;
    __weak typeof(self) vc = self;
    [musicVc getMusic:^(id music,NSIndexPath *seleteIndex, NSString * objName) {
        if(seleteIndex){
            self.musicImageView.image = [UIImage imageNamed:@"无音乐icon"];
            self.musicLabel.text = @"无音乐";
            self.selIndex = seleteIndex;
            if (!vc.usingOrder) {  //  重新编辑后, 保存音乐信息
                self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:self.customID];
            }
            vc.usingOrder.nMusicID = 90;
            [MC_OrderAndMaterialCtrl UpdateFresh:vc.usingOrder];
        }
        if ([objName isEqualToString:@"MovierDCInterfaceSvc_vpVDCMusicC"] && music != nil) {
            MovierDCInterfaceSvc_vpVDCMusicC * myMusic = music;
            NSString *name = myMusic.szName;
            if (name.length > 16) {
                name = [name substringToIndex:16];
                name = [NSString stringWithFormat:@"%@...", name];
            }
            self.musicLabel.text = name;
            [self.musicImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@thumbail.jpg", myMusic.szUrl]] placeholderImage:GRAYICON options:SDWebImageRetryFailed | SDWebImageRefreshCached];
            if ([myMusic.szName isEqualToString:@"无音乐"]) {
                self.musicImageView.image = [UIImage imageNamed:@"无音乐icon"];
            }
            if (!vc.usingOrder) {  //  重新编辑后, 保存音乐信息
                self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:self.customID];
            }
            vc.usingOrder.nMusicID = [myMusic.nID intValue];
            [MC_OrderAndMaterialCtrl UpdateFresh:vc.usingOrder];
            self.selIndex = seleteIndex;
        }
        else if([objName isEqualToString:@"MovierDCInterfaceSvc_vpVDCMusicEx"] && music != nil){
            MovierDCInterfaceSvc_vpVDCMusicEx * myMusic = music;
            NSString *name = myMusic.szName;
            if (name.length > 16) {
                name = [name substringToIndex:16];
                name = [NSString stringWithFormat:@"%@...", name];
            }
            self.musicLabel.text = name;
            [self.musicImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@thumbail.jpg", myMusic.szUrl]] placeholderImage:GRAYICON options:SDWebImageRetryFailed | SDWebImageRefreshCached];
            if (!vc.usingOrder) {  //  重新编辑后, 保存音乐信息
                self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:self.customID];
            }
            vc.usingOrder.nMusicID = [myMusic.nID intValue];
            [MC_OrderAndMaterialCtrl UpdateFresh:vc.usingOrder];
            self.selIndex = seleteIndex;
        }
        
    }];
    [self.navigationController pushViewController:musicVc animated:YES];
}

/**  查看和更改  字幕信息 */
- (void)fontClick:(UITapGestureRecognizer *)tap {
    WEAKSELF2
    if (self.isMakingFilm || self.isEditingTitle){
        return;
    }
    
    [self.titleField endEditing:YES];
    
    SubtitleViewController *subtitleVc = [SubtitleViewController new];
    [subtitleVc setGetSubtitleBlock:^(MovierDCInterfaceSvc_vpVDCSubtitleC *subtitleModel) {
        
        if (subtitleModel.szThumbnail) {
            MAINQUEUEUPDATEUI({
                [weakSelf.fontImageView sd_setImageWithURL:[NSURL URLWithString:subtitleModel.szThumbnail] placeholderImage:[UIImage imageNamed:@"grayIcon"]];
            })
        }
        
        NSString *name = subtitleModel.szRecommend;
        
        if (name.length > 12) {
            name = [name substringToIndex:12];
            name = [NSString stringWithFormat:@"%@...", name];
        }
        
        weakSelf.fontLabel.text = name;
        
        if (!weakSelf.usingOrder) {
            weakSelf.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:weakSelf.customID];

        }
        
        weakSelf.usingOrder.nSubtitleID = [subtitleModel.nID intValue];
        weakSelf.usingOrder.szCustomerSubtitle = subtitleModel.szRecommend;
        [MC_OrderAndMaterialCtrl UpdateFresh:weakSelf.usingOrder];
    }];
    [self.navigationController pushViewController:subtitleVc animated:YES];
    
    //    // 键盘退出编辑
    //    [self.titleField endEditing:YES];
    //
    //    SubtitleViewC *sub = [[SubtitleViewC alloc] init];
    //
    //    __weak typeof(self) vc = self;
    //    [sub getSubTitle:^(MovierDCInterfaceSvc_vpVDCSubtitleC *subTitle) {
    //
    //        if (subTitle.szThumbnail) {
    //            MAINQUEUEUPDATEUI({
    //                [vc.fontImageView sd_setImageWithURL:[NSURL URLWithString:subTitle.szThumbnail]];
    //            })
    //        }
    //
    //        NSString *name = subTitle.szRecommend;
    //        if (name.length > 12) {
    //            name = [name substringToIndex:12];
    //            name = [NSString stringWithFormat:@"%@...", name];
    //        }
    //        vc.fontLabel.text = name;
    //
    //
    //        if (!vc.usingOrder) {
    //
    //            //  重新编辑后, 保存字幕信息
    //            self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:self.customID];
    //            vc.usingOrder.nSubtitleID = [subTitle.nID intValue];
    //            vc.usingOrder.szCustomerSubtitle = subTitle.szRecommend;
    //            [MC_OrderAndMaterialCtrl UpdateFresh:self.usingOrder];
    //        }else{
    //            vc.usingOrder.nSubtitleID = [subTitle.nID intValue];
    //            vc.usingOrder.szCustomerSubtitle = subTitle.szRecommend;
    //            [MC_OrderAndMaterialCtrl UpdateFresh:self.usingOrder];
    //        }
    //    }];
    //
    //    [self.navigationController pushViewController:sub animated:YES];
}

/**  保存到草稿箱 */
- (IBAction)saveToDraft:(UIButton *)sender {
    if (self.isMakingFilm || self.isEditingTitle)  return;
    
    //已经保存，未保存；
    [self saveFilmName];
    
    // 1. 先把上次的订单保存为草稿订单
    NewNSOrderDetail *currentOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:self.customID];
    [MC_OrderAndMaterialCtrl ChangeOrderStatus:currentOrder.order_id Status:DRAFTORDER];
    
    // 2. 创建空订单
    [MC_OrderAndMaterialCtrl AddFreshOrder:self.customID];
    
    // 3. 获取到空订单, 直接更新订单
    NewNSOrderDetail *newOrder  = [MC_OrderAndMaterialCtrl GetFreshOrder:self.customID];
    newOrder.nVideoLength       = currentOrder.nVideoLength;
    newOrder.nHeaderAndTailID   = currentOrder.nHeaderAndTailID;
    newOrder.nFilterID          = currentOrder.nFilterID;
    newOrder.nMusicID           = currentOrder.nMusicID;
    newOrder.nMusicStart        = currentOrder.nMusicStart;
    newOrder.nMusicEnd          = currentOrder.nMusicEnd;
    newOrder.nSubtitleID        = currentOrder.nSubtitleID;
    newOrder.szCustomerSubtitle = currentOrder.szCustomerSubtitle;
    newOrder.szVideoName        = currentOrder.szVideoName;
    newOrder.nShareType         = currentOrder.nShareType;
    newOrder.stMaterialArr      = currentOrder.stMaterialArr;
    newOrder.stLabelForVideo    = currentOrder.stLabelForVideo;
    newOrder.strVideoURL        = currentOrder.strVideoURL;
    newOrder.strVideoThumbnail  = currentOrder.strVideoThumbnail;
    self.usingOrder             = newOrder;
    [MC_OrderAndMaterialCtrl UpdateFresh:newOrder];
    
    // 5. 提示素材保存到草稿成功
    [UIAlertView alertViewshowMessage:@"导演，影片已保存，您可前往个人页面“草稿箱”中继续制作哦。" cancleButton:nil confirmButton:@"确定"];
}

/**  压缩所有视频及图片 */
- (void)decodeFile {
    
    //弹出遮罩
    UIView *popview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    popview.backgroundColor = [UIColor blackColor];
    popview.alpha = 0.5;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:popview animated:YES];
    hud.labelText = @"文件压缩中...";
    [self.view addSubview:popview];
    [self.view bringSubviewToFront:popview];
    
    [self.view setNeedsDisplay];
    //后台压缩视频或者图片
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        ;
        
        NewNSOrderDetail *noworder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
        NSMutableArray *array = [MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:noworder.order_id];
        for (NewOrderVideoMaterial *obj in array) {
            __block NSURL *uploadURL;
            ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
            dispatch_async(queue, ^{
                [lib assetForURL:[NSURL URLWithString:obj.material_assetsURL] resultBlock:^(ALAsset *asset){
                    //临时文件检查;
                    NSFileManager *fileManager = [NSFileManager defaultManager];
                    NSError *error;
                    NSString *cachesdirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                    //此处未使用
                    //                    NSString *filename = asset.defaultRepresentation.filename;
                    NSString *path1 = [cachesdirectory stringByAppendingPathComponent:asset.defaultRepresentation.filename];
                    uploadURL = [NSURL fileURLWithPath:[cachesdirectory stringByAppendingPathComponent:asset.defaultRepresentation.filename]];
                    NSLog(@"%@",[uploadURL absoluteString]);
                    
                    if ([fileManager removeItemAtPath:path1 error:&error] != YES)
                        NSLog(@"Unable to delete file: %@", [error localizedDescription]);
                    NSData *uploadingData;
                    if([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]){
                        //图片处理
                        //此处未使用
                        //                        CGSize imagecg = asset.defaultRepresentation.dimensions;
                        uploadingData = UIImageJPEGRepresentation([UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage], 1.0);
                        //                        NSLog(@"pic size = %ld",uploadingData.length);
                        //                        uploadingData = UIImageJPEGRepresentation([UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage], 0.8);
                        //                        NSLog(@"pic size = %ld",uploadingData.length);
                        //                        uploadingData = UIImageJPEGRepresentation([UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage], 0.5);
                        //                        NSLog(@"pic size = %ld",uploadingData.length);
                        //                        uploadingData = UIImageJPEGRepresentation([UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage], 0.2);
                        //                        NSLog(@"pic size = %ld",uploadingData.length);
                        //                        uploadingData = UIImageJPEGRepresentation([UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage], 0.0);
                        //                        NSLog(@"pic size = %ld",uploadingData.length);
                        [uploadingData writeToURL:uploadURL atomically:YES];
                        dispatch_semaphore_signal(sema);
                    }else{
                        ALAssetRepresentation *representation = [asset defaultRepresentation];
                        //                    视频压缩
                        NSURL *movieURL = representation.url;
                        CGSize cg = representation.dimensions;
                        if(cg.width>720.0||cg.height>720.0)
                        {
                            //压缩
                            AVAsset *asset      = [AVURLAsset URLAssetWithURL:movieURL options:nil];
                            AVAssetExportSession *session =
                            [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPreset960x540];
                            
                            session.outputFileType  = AVFileTypeMPEG4;
                            session.outputURL       = uploadURL;
                            [session exportAsynchronouslyWithCompletionHandler:^{
                                NSLog(@"session.process = %f",session.progress);
                                if (session.status == AVAssetExportSessionStatusCompleted)
                                {
                                    NSLog(@"output Video URL %@",uploadURL);
                                    dispatch_semaphore_signal(sema);
                                }else{
                                    NSLog(@"Error msg = %@",session.error);
                                    dispatch_semaphore_signal(sema);
                                }
                            }];
                        }else
                            dispatch_semaphore_signal(sema);
                    }
                    
                } failureBlock:^(NSError *error) {
                    dispatch_semaphore_signal(sema);
                }];
            });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            ;
            [popview removeFromSuperview];
            [self suborder];
        });
    });
    
    //更新数据库   ///暂时不用数据库
    
    //遮罩消失
    //    [popview removeFromSuperview];    
}

/**  保存影片名 */
- (void)saveFilmName {
    NewNSOrderDetail *noworder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    noworder.szVideoName = self.titleField.text;
    [MC_OrderAndMaterialCtrl UpdateFresh:noworder];
}

/**  制作影片 */
- (IBAction)makeMovie:(UIButton *)sender {
    
    if (!self.usingOrder) {
        self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:self.customID];
    }
   
    if ([AFNetWorkManager shareInstance].netStatus == AFNetworkReachabilityStatusUnknown || [AFNetWorkManager shareInstance].netStatus == AFNetworkReachabilityStatusNotReachable) {
        ALERT(@"网络好像断开了！");
        return;
    }
    
    if (![APPUserPrefs Singleton].wwanable && [[MovierTranslation Singleton].netType isEqualToString:@"移动网络"]) {
        ALERT(@"您未打开移动网络上传的开关");
        return;
    }
    
    int allMaterialTimeLength = 0;
    NSMutableArray *array = [MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.usingOrder.order_id];
    for (NewOrderVideoMaterial* item in array) {
        allMaterialTimeLength+=item.material_playduration;
    }

    if (allMaterialTimeLength < 15.0) {
        ALERT(@"为保证影片效果，请选择至少15秒视频或5张照片!");
        return;
    }
    
    if (self.isSelectKeepVoiceButton == YES && self.keepVoiceLabel.hidden == NO) {
        [APPUserPrefs Singleton].isKeepVoice = YES;
    }
    else{
        [APPUserPrefs Singleton].isKeepVoice = NO;
    }
    
    if (self.usingOrder.order_st >= 3 || self.hasMade == YES) {
        ALERT(@"请重新添加素材");
        return;
    }
    
    if (!self.titleField.hasText) {
        ALERT(@"导演，为影片赐个名吧！");
        return;
    }
    
    if (self.titleField.text.length > 10) {
        ALERT(@"标题不能超过10个字符");
        return;
    }
    
    // 点击按钮后, 1. 添加进度条  2. 将界面上可以点击的 view 事件全部禁止, 只有返回首页可以点击
    self.makeButton.userInteractionEnabled = NO;
    self.draftButton.userInteractionEnabled = NO;
    self.publicButton.userInteractionEnabled = NO;
    [self.makeButton setBackgroundColor:ISARGBColor(64, 74, 88, 0.5)];
    [self.draftButton setBackgroundColor:ISARGBColor(64, 74, 88, 0.5)];
    self.isMakingFilm = YES;    // 2. 设置正在制作影片的状态
    self.hasMade = YES;
    self.progressView.hidden = NO;
    [self saveFilmName];    //保存影片名
    [self decodeFile];  //压缩视频
    [CustomeClass deleteFileWithFileName:[NSString stringWithFormat:@"%@/Documents/orderThumail", NSHomeDirectory()]];
}

- (void)pushToMyVideoVc{
    
    //跳转我的影片页面
    if (self.isPushToMyVideoVc) {
        return;
    }
    MyVideoViewController * myVideoVc = [MyVideoViewController new];
    [self.navigationController pushViewController:myVideoVc animated:YES];
    self.isPushToMyVideoVc = YES;
}

-(void)suborder{
    
    // 1. 先把上次的订单保存
    NewNSOrderDetail *currentOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:self.customID];
    [MC_OrderAndMaterialCtrl CommitOrder:self.customID];
    
    // 2. 创建空订单
    [MC_OrderAndMaterialCtrl AddFreshOrder:self.customID];
    
    // 3. 获取到空订单, 直接更新订单
    NewNSOrderDetail *newOrder  = [MC_OrderAndMaterialCtrl GetFreshOrder:self.customID];
    newOrder.nHeaderAndTailID   = currentOrder.nHeaderAndTailID;
    newOrder.nFilterID          = currentOrder.nFilterID;
    newOrder.nMusicID           = currentOrder.nMusicID;
    newOrder.nMusicStart        = currentOrder.nMusicStart;
    newOrder.nMusicEnd          = currentOrder.nMusicEnd;
    newOrder.nSubtitleID        = currentOrder.nSubtitleID;
    newOrder.szCustomerSubtitle = currentOrder.szCustomerSubtitle;
    newOrder.szVideoName        = currentOrder.szVideoName;
    newOrder.nShareType         = currentOrder.nShareType;
    newOrder.stLabelForVideo    = currentOrder.stLabelForVideo;
    newOrder.strVideoURL        = currentOrder.strVideoURL;
    newOrder.strVideoThumbnail  = currentOrder.strVideoThumbnail;
    self.usingOrder             = newOrder;
    [MC_OrderAndMaterialCtrl UpdateFresh:newOrder];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    // 从 cutpro 中复制的----监听上传进度
    if([keyPath isEqualToString:@"upratio"]) {
        NSString *fratio = [NSString stringWithFormat:@"%@",[stockForKVO valueForKey:@"upratio"]];
        float f = [fratio floatValue];
        
        if (f - self.lastProgress > 0.01) {
            
            
            self.progressView.hidden = NO;
            //             需要绘制时 发送通知
            NSMutableDictionary *info = [NSMutableDictionary dictionary];
            info[@"finishProgress"] = [NSNumber numberWithFloat:f];
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                self.progressView.progress = f;
                
                //                [weakSelf pushToMyVideoVc];
            });
            // 更新上次  传递绘制时  的进度
            self.lastProgress = f;
        }
    }
}

/**  是否公开 */
- (IBAction)isPublic:(UIButton *)sender {
    if (self.isMakingFilm)  return;
    
    if (self.usingOrder) {
        
        //  重新编辑后, 保存是否公开信息
        self.usingOrder.nShareType = sender.selected;
        [MC_OrderAndMaterialCtrl UpdateFresh:self.usingOrder];
    }else{
        int customID = [[UserEntity sharedSingleton].customerId intValue];
        self.usingOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:customID];
        self.usingOrder.nShareType = sender.selected;
        [MC_OrderAndMaterialCtrl UpdateFresh:self.usingOrder];
    }
    
    sender.selected = !sender.selected;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [stockForKVO removeObserver:self forKeyPath:@"upratio"];
}

- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [stockForKVO removeObserver:self forKeyPath:@"upratio"];
//}
- (IBAction)keepVoiceButtonAction:(id)sender {
    UIButton * btn = (id)sender;
    
    if (self.isSelectKeepVoiceButton == NO) {
        self.isSelectKeepVoiceButton = YES;
        //使用原声
        [btn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateNormal];
    }
    else{
        self.isSelectKeepVoiceButton = NO;
        //不使用原声
        [btn setImage:[UIImage imageNamed:@"select"] forState:UIControlStateNormal];
    }
}
@end
