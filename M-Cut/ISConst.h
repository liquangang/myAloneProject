//
//  ISConst.h
//  INSHOW
//
//  Created by 李亚飞 on 15/11/12.
//  Copyright © 2015年 李亚飞. All rights reserved.
//
//  定义项目中使用的常量

#import <UIKit/UIKit.h>

#pragma mark - app的各种key

static NSString *const serverIP = @"59.110.5.216";  //测试服务器ip
//static NSString *const serverIP = @"182.92.236.181";  //正式服务器ip
//static NSString *const serverIP = @"10.0.0.159";  //中贺虚拟机服务器ip

#define APPSTOREURL [NSURL URLWithString:appStoreURLStr]

static NSString *const appStoreInfoURL = @"https://itunes.apple.com/cn/lookup?id=1013565760";
static NSString *const appID = @"1013565760";
static NSString *const appStoreURLStr = @"https://itunes.apple.com/cn/app/ying-xiang/id1013565760?mt=8";
static NSString *const umAPPKey = @"55f9088b67e58e3dbd000488";
static NSString *const wxAPPKey = @"wxaf98baf2b5b8590b";
static NSString *const wxSecret = @"66f662fe399ba00da5e286d2eafe302c";
static NSString *const inshowURLStr = @"http://www.movier.cc";
static NSString *const wxDes = @"InShian Product";
static NSString *const sinaAPPKey = @"1065048023";
static NSString *const sinaBackURLStr = @"http://sns.whalecloud.com/sina2/callback";
static NSString *const qqAPPId = @"1104735856";
static NSString *const qqAPPKey = @"Z8HMchORzgwyKzCD";
static NSString *const qqURLStr = @"http://www.umeng.com/social";
static NSString *const smAPPId = @"88aefdbb59b8";
static NSString *const smSecretId = @"18f4a9f71679b009c3087ea06335a357";
static NSString *const buglyAPPId = @"900011027";

#define SHAREAPPKEY @"55f9088b67e58e3dbd000488"

//测试阶段，写死这两个数据
/*
 ID：zGVpCiAsMnFfAJpg
 Secret：7nfKkKFs5MZUj9ktXUGrLMJQD1XDPu
 
 accessKey
 secretKey
 */
#define ACCESSKEY @"zGVpCiAsMnFfAJpg"
#define SECRETKEY @"27ab30165d6852e32bda183d13f07fcb"

extern const CGFloat ISNavigationHeight;
extern const CGFloat ISTabBarHeight;

#define GAODEKEY @"c29ab49ddbe6be27182118f65257dd7d"

//个推
//正式版
//com.movier.MCut
static NSString *const gtAPPId = @"wzTtqDCWDq8AmavVTIScP2";
static NSString *const gtAPPKey = @"NVQg7i5Xs7A2XrHDC1cGY5";
static NSString *const gtAPPSecret = @"7u3tL9oyoJ7qrAeKfBqhS6";

//测试版
//com.movier.InShow
static NSString *const gtTestAPPId = @"CiLjaS8OnD7e32vm5UutE";
static NSString *const gtTestAPPKey = @"DXRiwux8CJ7LVbwKnThyI3";
static NSString *const gtTestAPPSecret = @"saSfvGB04i7oZDZ5Hdn2h5";

#pragma mark - 通知key

//通知
#define ISMaterialUploadSucceedNotification @"ISMaterialUploadSucceedNotification"

//从我的页面跳转到消息通知界面的通知
#define PUSHTOMESSAGEVC         @"pushToMessageVc"

//从我的界面跳转到好友界面的通知
#define PUSHTOFRIENDVC          @"pushToFriendVc"

//消息通知跳转的通知
#define PUSHTOMESSAGE           @"pushToMessage"

//跳转到我的主页（消息通知部分）
#define PUSHTOVIDEO             @"pushToMyVideo"
#define PUSHTOVIDEOVC           @"pushToMyVideoVc"

//好友界面跳转的通知
#define PUSHTOFRIEND            @"pushToFriend"

//修改消息通知一栏数字的通知
#define UPDATEMESNUM            @"updateMesNum"

//修改我的影片一栏数字的通知
#define UPDATENEWVIDEONUM       @"updateNewVideoNum"

//修改好友栏数字的通知
#define UPDATEFRIENDMESNUM      @"updateFriendMesNum"

//tabbarlabel的更新通知
#define UPDATETABBARLABELTEXT   @"updateTabbarLabel"

//根据badgenum的变化更新各个界面的提示数字
#define UPDATEPROPMTLABELTEXT   @"updatePropmtLabelText"

//私信消息的通知
#define PRIVATEMESNOTI          @"privateMesNoti"

//新影片生成的通知
#define NEWVIDEOBORN            @"newVideoBorn"

//app进入前台的通知
#define APPFOREGROUND @"Foreground"

//app进入后台的通知
#define APPBACKGROUND @"Background"

//选择素材时拍照完成的通知
#define RELOADPHOTOTARRAY @"reloadPhotoArray"

//素材选择的通知
#define REMOVESELECTIMAGE @"removeSelectImage"

//移除的对象key
#define REMOVEIAMGEKEY @"removeImageKey"

//更新选中的素材数组
#define UPDATESELECTIMAGEARRAY @"updateSelectImageArray"

//更新的key
#define UPDATESELECTARRAYKEY @"updateSelectArray"

//如果素材时长超过180，就发出这个通知
#define TIMEMORENOTI @"timeMoreNoti"

//通知主页跳转到具体页面
#define PUSHTOVIDEOLABELDETAILVC @"pushToVideoLabelDetailVc"

//跳转到搜索页面
#define PUSHTOSEARCHVC @"pushToSearchVc"

//视频应该使用竖屏播放
#define PORTRAIT @"portrait"

//视频从竖屏恢复原来
#define RESTROE @"restore"

//竖屏全屏方式
#define PORTRAITFULLSCREEN @"portraitFullScreen"

//点击banner图片通知
#define CLICKBANNERIMAGE @"clickBannerImage"
#define BANNERIMAGEINFO @"bannerImageInfo"

//影片详情页输入框开始输入
#define VIDEOINPUTVIEWBEGININPUT @"videoInputViewBeginInput"
#define VIDEOINPUTVIEWENDINPUT @"videoInputViewEndInput"

//隐藏登录注册window
#define HIDDENLOGINANDREGISTERWINDOW @"hiddenLoginAndRegisterWindow"

//拍摄视频界面跳转预览视频界面
#define PUSHTOPREVIEWVIDEOVC @"pushTopreviewVideoVc"

//要预览的视频的位置
#define PREVIEWVIDEOINDEX @"previewVideoIndex"

//要预览的视频数组
#define PREVIEWVIDEOARRAY @"previewVideoArray"

//要预览的本地url
#define PREVIEWLOCALURL @"previewLocalUrl"

//把保存完成的视频放到videoTable上
#define SHOWVIDEOATVIDEOTABLE @"showVideoAtVideoTable"

//保存完成的视频的缩略图
#define SHOWVIDEOTHUMAILIMAGE @"showVideoThumailImage"

//相机控制view显示ar元素
#define CAMERAVIEWSHOWARPORPERY @"cameraViewShowAr"

//后台返回的ar信息数组
#define ARINFOARRAY @"ArInfoArray"
#define ARINFODICTIONARY @"ARInfoDictionary"

static NSString *const getLocationInfo = @"getLoactionInfo";
static NSString *const locationLatitudeInfo = @"locationLatitudeInfo";
static NSString *const locationLongitudeInfo = @"locationLongitudeInfo";

//停止获得位置的通知
static NSString *const stopGetLocationInfo = @"stopGetLocationInfo";

//计时器每个周期的方法
static NSString *const timerIntervalMethod = @"timerIntervalMethod";

//拍摄视频完成
static NSString *const useTakeVideo = @"useTakeVideo";
static NSString *const takeVideoArray = @"takeVideoArray";

//移除选中的素材
static NSString *const removeSelectMaterial = @"removeSelectMaterial";
static NSString *const removeMaterial = @"removeMaterial";

static NSString *const networkStatus = @"networkStatus";    //网络状态
static NSString *const networkStatusDes = @"networkStatusDes";  //网络状态描述
static NSString *const orderInfoUploadSuccess = @"orderInfoUploadSuccess";  //订单信息上传成功
static NSString *const orderUploadSuccessId = @"orderUploadSuccessId";  //订单上传成功的id

//云资单个资源上传成功
static NSString *const cloudImageUploadSuccess = @"cloudImageUploadSuccess";

//上传进度通知
static NSString *const uploadProgress = @"uploadProgress";

//用户产生了更换或者登出等操作
static NSString *const userUpdate = @"userUpdate";

#pragma mark - 各种沙盒文件夹的名称

//首页图片文件夹名称
static NSString *const homeImageFileName = @"homeImage";

//ar元素文件夹
static NSString *const arPropertyGIFFileName = @"arGIF";

//ar奖品文件夹
static NSString *const arRewardFileName = @"arReward";

//ar奖品gif文件夹
static NSString *const arRewardGIFFileName = @"arRewardGIF";
static NSString *const uploadImageFileName = @"uploadImageFile";    //云资上传临时文件夹

#define HOMEPAGEFILE @"homeData"
#define HOMEPAGEDATAKEY @"homeDataKey"

//轮播获奖信息plist文件名称
static NSString *const arRewardInfo = @"arRewardInfo";

#pragma mark - 代码段

#define SHOWHUD [APPDELEGATE showHUD];      //展示hud
#define HIDDENHUD [APPDELEGATE hiddenHUD];      //隐藏hud

//灰色icon
#define GRAYICON [UIImage imageNamed:@"grayIcon"]

//默认icon
#define DEFAULTICON [UIImage imageNamed:@"grayIcon"]

//支持横屏
#define CANNOTSCALE AppDelegate * appDelegate = APPDELEGATE;[appDelegate setCanNotAllowRotation];

//不支持横屏
#define CANSCALE AppDelegate * appDelegate = APPDELEGATE;[appDelegate setCanAllowRotation];

//屏幕宽度
#define ISScreen_Width [UIScreen mainScreen].bounds.size.width

//屏幕高度
#define ISScreen_Height [UIScreen mainScreen].bounds.size.height

//NavBar高度
#define NavigationBar_HEIGHT 44

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark - 颜色相关

/**  RGB 颜色 */
#define ISRGBColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

/**
 *  argb颜色(带透明度)
 */
#define ISARGBColor(r, g, b, a) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:(a)]

/**  背景颜色 */
#define ISBackgroundColor ISRGBColor(220, 220, 220)

/**   字体颜色 */
#define ISFontColor ISRGBColor(64, 74, 88)

/** 常用的红色*/
#define ISRedColor ISRGBColor(255, 78, 77)

/** 常用的字体灰色*/
#define ISGrayColor ISRGBColor(179, 183, 188)

//404a58
#define ISLIKEGRAYCOLOR ISRGBColor(64, 74, 88)

//999999
#define ISGRAYCOLOR2 ISRGBColor(153, 153, 153)

//c0c3c7
#define ISGRAYCOLOR3 ISRGBColor(192, 195, 199)

//217, 217, 217
#define ISGRAYCOLOR4 ISRGBColor(217, 217, 217)

//65, 74, 89
#define ISGRAYCOLOR5 ISRGBColor(65, 74, 89)

//908b88 144, 139, 136
#define IS908B88 ISRGBColor(144, 139, 136)

//cecece 206, 206, 206
#define IScecece ISRGBColor(206, 206, 206)

//8d8986 141, 137, 134
#define IS8d8986 ISRGBColor(141, 137, 134)

//b3b7bc 179, 183, 188
#define ISB3B7BC ISRGBColor(179, 183, 188)

//67, 67, 67 #434343
#define IS434343 ISRGBColor(67, 67, 67)

//0, 4, 31 00041f
#define IS00041f ISRGBColor(0, 4, 31)

//f2f2f2 242, 242, 242
#define ISf2f2f2 ISRGBColor(242, 242, 242)

//e6e6e6 230, 230, 230
#define ISe6e6e6 ISRGBColor(230, 230, 230)

//2e2e3a 46,46,58
#define IS2e2e3a ISRGBColor(46,46,58)

//65656d 101,101,109
#define IS65656d ISRGBColor(101,101,109)

//使用方法     UIColorFromRGB(0xf54140);（注意带0x）
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//使用方法     ColorFromRGB(0xf54140, 1.0);（注意带0x）
#define ColorFromRGB(rgbValue, ALPHA) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:ALPHA]

/**  测试使用 随机色 */
#define ISTestRandomColor [UIColor colorWithRed:(arc4random() % 255 / 255.0) green:(arc4random() % 255 / 255.0) blue:(arc4random() % 255 / 255.0) alpha:1.0]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#pragma mark - 字体相关

/**  10号字体 */
#define ISFont_10 [UIFont systemFontOfSize:10]

/**  12号字体 */
#define ISFont_12 [UIFont systemFontOfSize:12]

/**  13号字体 */
#define ISFont_13 [UIFont systemFontOfSize:13]

/**  13号字体 */
#define ISFont_14 [UIFont systemFontOfSize:14]

/**  15号字体 */
#define ISFont_15 [UIFont systemFontOfSize:15]

/**  16号字体 */
#define ISFont_16 [UIFont systemFontOfSize:16]

/**  17号字体 */
#define ISFont_17 [UIFont systemFontOfSize:17]

//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]

#pragma mark - 获取手机型号系统版本、语言、屏幕分辨率、真机或者模拟器、

/**  iPhone4  */
#define iPhone4         CGSizeEqualToSize(CGSizeMake(640, 960), [UIScreen mainScreen].currentMode.size)
/**  iPhone5_5S_5C  */
#define iPhone5_5S_5C   CGSizeEqualToSize(CGSizeMake(640, 1136), [UIScreen mainScreen].currentMode.size)
/**  iPhone6_6S  */
#define iPhone6_6S      CGSizeEqualToSize(CGSizeMake(750, 1334), [UIScreen mainScreen].currentMode.size)
/**  iPhone6_6SPlus  */
#define iPhone6_6SPlus  CGSizeEqualToSize(CGSizeMake(1125, 2001), [UIScreen mainScreen].currentMode.size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [UIScreen mainScreen].currentMode.size) || CGSizeEqualToSize(CGSizeMake(1080, 1920), [UIScreen mainScreen].currentMode.size) 

#ifndef M_Cut_Config_h
#define M_Cut_Config_h

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//2.ios7系统判断：
#define IsIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)
#define IsIOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] >=6.0 ? YES : NO)

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否ifhone 5、ifhone 6,是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPads (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334),[[UIScreen mainScreen] currentMode].size) : NO)

//判断是真机还是模拟器
#if TARGET_OS_IPHONE

//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR

//iPhone Simulator
#endif

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]

//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

//1.首次启动判断：
#define First_Launched @"firstLaunch"

#endif

//懒加载数组
#define LAZYINITARRAY(arrayName)     if (!arrayName) {arrayName = [NSArray new];}return arrayName;

//懒加载可变数组
#define LAZYINITMUARRAY(muArrayName)     if (!muArrayName) {muArrayName = [NSMutableArray new];}return muArrayName;

/**
 *  创建单例
 */
#define CREATESINGLETON(singletonClassName) \
static singletonClassName *instance;\
+ (instancetype)shareInstance{\
    static dispatch_once_t onceToken;\
        dispatch_once(&onceToken, ^{\
        instance = [[singletonClassName alloc] init] ;\
    }) ;\
    return instance;\
}\
+ (id)allocWithZone:(struct _NSZone *)zone{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        instance = [super allocWithZone:zone] ;\
    }) ;\
    return instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
    return instance;\
}

/**
 *  开放接口
 */
#define INSTANCEMETHOD + (instancetype)shareInstance;

/**
 *  调用该接口
 */
#define SINGLETON(singletonName) [singletonName shareInstance]

#pragma mark - navigationbar

//返回按钮
#define NAVIGATIONBACKBARBUTTONITEM UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];leftButton.frame = CGRectMake(0, 0, 20, 20);[leftButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];[leftButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

//返回按钮的方法
#define NAVIGATIONBACKITEMMETHOD - (void)backButtonAction:(UIButton *)backBtn{[self.navigationController popViewControllerAnimated:YES];}

//标题
#define NAVIGATIONBARTITLEVIEW(titleString)     UILabel *label = [[UILabel alloc] init];label.text = titleString;label.font = ISFont_17;label.textColor = [UIColor whiteColor];CGSize labelSize = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);self.navigationItem.titleView = label;

//右侧按钮（文字版）
#define NAVIGATIONBARRIGHTBARBUTTONITEM(BarButtonItemTitle)     UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];rightButton.frame = CGRectMake(0, 0, 88, 30);rightButton.titleLabel.textAlignment = NSTextAlignmentRight;[rightButton setTitle:BarButtonItemTitle forState:UIControlStateNormal];rightButton.titleLabel.font = ISFont_15;[rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];[rightButton addTarget:self action:@selector(rightBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];

//右侧按钮（图片版）
#define NAVIGATIONBARRIGHTBARBUTTONITEMWITHIMAGE(IMAGENAME)     UIButton * rightNavItem = [UIButton new];rightNavItem.frame = CGRectMake(0, 0, 20, 20);[rightNavItem setImage:[UIImage imageNamed:IMAGENAME] forState:UIControlStateNormal];[rightNavItem addTarget:self action:@selector(rightBarItemAction) forControlEvents:UIControlEventTouchUpInside];self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightNavItem];

//左侧按钮（文字）
#define NAVIGATIONBARLEFTBARBUTTONITEM(BarButtonItemTitle)     UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];\
leftButton.frame = CGRectMake(0, 0, 88, 30);\
leftButton.titleLabel.textAlignment = NSTextAlignmentLeft;\
[leftButton setTitle:BarButtonItemTitle forState:UIControlStateNormal];\
leftButton.titleLabel.font = ISFont_15;\
[leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];\
[leftButton addTarget:self action:@selector(leftBarButtonItemAction:) forControlEvents:UIControlEventTouchUpInside];\
self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];\

//左侧按钮（图片版）
#define NAVIGATIONBARLEFTBARBUTTONITEMWITHIMAGE(IMAGENAME)     UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];\
leftButton.frame = CGRectMake(0, 0, 20, 20);\
[leftButton setImage:[UIImage imageNamed:IMAGENAME] forState:UIControlStateNormal];\
[leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];\
self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];\
self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;\

//弹出提示框
#define ALERT(alertStr) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:alertStr delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];[alert show];

//3s消失的提示框
#define SHOWALERT(ALERTSTRING) [CustomeClass showAlert:ALERTSTRING];

//添加手势
#define ADDTAPGESTURE(SUPERVIEW, TAPMETHODNAME) SUPERVIEW.userInteractionEnabled = YES;[SUPERVIEW addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TAPMETHODNAME:)]];

//声明属性
#define CUSTOMEPORPERTY(PROPER) @property (nonatomic, copy) NSString * PROPER;

//获得appdelegate
#define APPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]

//默认cell
#define DEFAULTCELL UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];if(!cell){cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellid"];}return cell;

//移除所有子视图
#define REMOVEALLSUBVIEWS(THISVIEW) [THISVIEW.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)]

//如果第一次下载后台数据失败，如果有网络就重新下载（使用递归方式下载）如果没有网络就提示没有网络，并终止下载
#define RELOADSERVERDATA(YOUCODE) DEBUGLOG(error) if ([[CustomeClass currentInterentStatus] isEqualToString:@"网络不可用"]) { [CustomeClass showMessage:@"您的网络不可用" ShowTime:3]; }else{ NSString *printStr = [NSString stringWithFormat:@"网络好像有问题，正在重试！(%ld)", (long)error.code]; [CustomeClass showMessage:printStr ShowTime:1.5]; YOUCODE}

//隐藏注册部分window
#define HIDDENLOGINANDREGISTERWINDOWNOTI  POSTNOTI(HIDDENLOGINANDREGISTERWINDOW, nil);

//发出通知
#define POSTNOTI(NOTINAME, USERINFO) [[NSNotificationCenter defaultCenter] postNotification:[[NSNotification alloc] initWithName:NOTINAME object:nil userInfo:USERINFO]]

//当前登录用户的id
#define CURRENTUSERID [UserEntity sharedSingleton].customerId

//当前登录用户的昵称
#define CURRENTUSERNICKNAME [UserEntity sharedSingleton].szNickname

//当前登录用户的头像url
#define CURRENTUSERICONURL [UserEntity sharedSingleton].szAcatar

//打印error宏
#define DEBUGLOG(NEEDPRINTFCONTENT) NSLog(@"\n当前类和函数：%s\n当前行：%d\n>>>ERROR --- %@\n\n\n", __func__, __LINE__, NEEDPRINTFCONTENT);

//打印接口调用成功信息宏
#define DEBUGSUCCESSLOG(NEEDPRINTFCONTENT) NSLog(@"\n当前类和函数：%s\n当前行：%d\n>>>SUCCESSINFO --- %@\n\n\n", __func__, __LINE__, NEEDPRINTFCONTENT);

//弱引用宏1.0
#define WEAKSELF(WEAKSELFNAME) __weak typeof(self) WEAKSELFNAME = self

//弱引用宏2.0
#define WEAKSELF2 __weak typeof(self) weakSelf = self;


//主线程刷新ui
#define MAINQUEUEUPDATEUI(UPDATECODE) dispatch_async(dispatch_get_main_queue(), ^{UPDATECODE});

//默认线程中处理数据，主线程ui操作
#define DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI(DEFAULTQUEUEANALYSISCODE, MAINQUEUECODE) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{DEFAULTQUEUEANALYSISCODE dispatch_async(dispatch_get_main_queue(), ^{MAINQUEUECODE});});

//在组线程中进行操作，主线程刷新ui
#define GROUPQUEUEANALYSISMAINQUEUEUPDATEUI(GROUPQUEUECODE, MAINQUEUECODE) dispatch_group_async(dispatch_group_create(), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{GROUPQUEUECODE dispatch_get_main_queue(), ^{MAINQUEUECODE});});

//组线程
#define GROUPCREATE dispatch_group_create()
#define GROUPQUEUE dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

//主线程
#define MAINQUEUE dispatch_get_main_queue()

//根据tag获得控件
#define GETVIEWWITHTAG(VIEWNAME, CUSTOMENAME, TAG) VIEWNAME * CUSTOMENAME = (VIEWNAME *)[self.view viewWithTag:TAG];

//注册通知
#define REGISTEREDNOTI(NOTIMETHOD, NOTINAME) [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(NOTIMETHOD) name:NOTINAME object:nil]

//普通数据懒加载
#define LAZYLOADINGARRAY(LAZYMETHOD, ARRAYNAME) - (NSMutableArray *)ARRAYNAME{if (!ARRAYNAME) {ARRAYNAME = [NSMutableArray new];}return ARRAYNAME;}

//默认头像
#define DEFAULTHEADIMAGE [UIImage imageNamed:@"设置头像-0"]

//默认视频图片
#define DEFAULTVIDEOTHUMAIL [UIImage imageNamed:@"defaultVideoImage"]

//使用xib初始化cell
#define XIBCELL(LOADNIBNAME) [[[NSBundle mainBundle] loadNibNamed:LOADNIBNAME owner:nil options:nil] lastObject];

//table背景图
#define BACKPROPMTVIEW(CONDITIONS, BACKVIEWTAG, PROPMTCONTENT, YOURTABLENAME) if (CONDITIONS) {UIView * tableBackView = [[UIView alloc] initWithFrame:self.view.bounds];self.YOURTABLENAME.backgroundView = tableBackView;tableBackView.tag = BACKVIEWTAG;UILabel * tableBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ISScreen_Height / 2 - 64, ISScreen_Width, 66)];[tableBackView addSubview:tableBackLabel];tableBackLabel.text = PROPMTCONTENT;tableBackLabel.textColor = [UIColor grayColor];tableBackLabel.font = [UIFont fontWithName:@"Helvetica" size:18.f];tableBackLabel.textAlignment = NSTextAlignmentCenter;tableBackLabel.numberOfLines = 0;tableBackView.hidden = NO;self.YOURTABLENAME.separatorStyle = UITableViewCellSeparatorStyleNone;}else{UIView * myView = (id)[self.view viewWithTag:BACKVIEWTAG];myView.hidden = YES;[myView removeFromSuperview];myView = nil;}

//汉字转utf-8
#define STRTOUTF8(NEEDCONVERSIONSTR) [NEEDCONVERSIONSTR stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]

//dealloc
#define DEALLOCMETHOD \
- (void)dealloc{\
    NSLog(@"dealloc");\
}\

/**
 *  打印相关
 */
#if DEBUG
#define NSLog(format, ...) do {                                             \
fprintf(stderr, "-------\n");                                             \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-------\n\n");                                               \
} while (0)
#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)
#else
#define NSLog(FORMAT, ...) nil
#define NSLogRect(rect) nil
#define NSLogSize(size) nil
#define NSLogPoint(point) nil
#endif

//增加监听，当键盘出现或改变时收出消息
#define REGISTERSHOWKEYBOARDNOTI [[NSNotificationCenter defaultCenter] addObserver:self\
                                                                          selector:@selector(keyboardWillShow:)\
                                                                              name:UIKeyboardWillShowNotification\
                                                                            object:nil];\

//增加监听，当键退出时收出消息
#define REGISTERHIDDENKEYBOARDNOTI [[NSNotificationCenter defaultCenter] addObserver:self\
                                                                            selector:@selector(keyboardWillHidden:)\
                                                                                name:UIKeyboardWillHideNotification\
                                                                              object:nil];\

//注册网络监听
#define REGISTERNETWORKMONITOR REGISTEREDNOTI(networkUpdate:, networkStatus);

//注册用户信息下载完成
#define REGISTERUSERINFOUPDATEFINISH REGISTEREDNOTI(updateUserInfo:, @"updateUserInfo");

//https
//- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace{
//    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];\
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
//{
//    static CFArrayRef certs;
//    if (!certs) {
//        NSData *certData =[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"IntermediateCA" ofType:@"cer"]];
//        SecCertificateRef rootcert =SecCertificateCreateWithData(kCFAllocatorDefault,CFBridgingRetain(certData));
//        const void *array[1] = { rootcert };
//        certs = CFArrayCreate(NULL, array, 1, &kCFTypeArrayCallBacks);
//        CFRelease(rootcert);
//    }
//    SecTrustRef trust = [[challenge protectionSpace] serverTrust];
//    int err;
//    SecTrustResultType trustResult = 0;
//    err = SecTrustSetAnchorCertificates(trust, certs);
//    if (err == noErr) {
//        err = SecTrustEvaluate(trust,&trustResult);
//    }
//    CFRelease(trust);
//    BOOL trusted = (err == noErr) && ((trustResult == kSecTrustResultProceed)||(trustResult == kSecTrustResultConfirm) || (trustResult == kSecTrustResultUnspecified));
//    
//    if (trusted) {
//        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
//    }else{
//        [challenge.sender cancelAuthenticationChallenge:challenge];
//    }
//    
//    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
//    
//    if ([challenge previousFailureCount] == 0) {
//        NSURLCredential *newCredential;
//        newCredential=[NSURLCredential credentialWithUser:self.binding.authUsername
//                                                 password:self.binding.authPassword
//                                              persistence:NSURLCredentialPersistenceForSession];
//        [[challenge sender] useCredential:newCredential
//               forAuthenticationChallenge:challenge];
//    } else {
//        [[challenge sender] cancelAuthenticationChallenge:challenge];
//        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"Authentication Error" forKey:NSLocalizedDescriptionKey];
//        NSError *authError = [NSError errorWithDomain:@"Connection Authentication" code:0 userInfo:userInfo];
//        [self connection:connection didFailWithError:authError];
//    }
//}

//- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
//{
//    static CFArrayRef certs;
//    if (!certs) {
//        NSData*certData =[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"srca" ofType:@"cer"]];
//        SecCertificateRef rootcert =SecCertificateCreateWithData(kCFAllocatorDefault,CFBridgingRetain(certData));
//        const void *array[1] = { rootcert };
//        certs = CFArrayCreate(NULL, array, 1, &kCFTypeArrayCallBacks);
//        CFRelease(rootcert);    // for completeness, really does not matter
//    }
//    
//    SecTrustRef trust = [[challenge protectionSpace] serverTrust];
//    int err;
//    SecTrustResultType trustResult = 0;
//    err = SecTrustSetAnchorCertificates(trust, certs);
//    if (err == noErr) {
//        err = SecTrustEvaluate(trust,&trustResult);
//    }
//    CFRelease(trust);
//    BOOL trusted = (err == noErr) && ((trustResult == kSecTrustResultProceed)||(trustResult == kSecTrustResultConfirm) || (trustResult == kSecTrustResultUnspecified));
//    
//    if (trusted) {
//        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
//    }else{
//        [challenge.sender cancelAuthenticationChallenge:challenge];
//    }
//}
