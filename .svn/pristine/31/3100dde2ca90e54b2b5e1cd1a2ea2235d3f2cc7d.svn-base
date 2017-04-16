//
//  AddViewController.m
//  M-Cut
//
//  Created by Crab shell on 12/21/14.
//  Copyright (c) 2014 Crab movier. All rights reserved.
//

#import "CutProViewController.h"
#import "CloudFilesTableViewController.h"
#import "UIViewExt.h"
#import "LocalMaterialsViewController.h"
#import "CutProCollectionViewCell.h"
#import "APPUserPrefs.h"
#import "DraftboxTableViewController.h"
#import "MC_OrderAndMaterialCtrl.h"

#define Main_Screen_Height [[UIScreen mainScreen] bounds].size.height //主屏幕的高度
#define Main_Screen_Width  [[UIScreen mainScreen] bounds].size.width  //主屏幕的宽度
#define KVideoUrlPath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"VideoURL"]

#define USERFILMMIN         15.0
#define USERFILMMAX         180.0

#define UserFirstUse        @"UserFirstUse"
int k = -1;


@implementation CutProViewController
{
    CGFloat cellWidth;
    CGFloat cellHeight;
    CGFloat margin;
    IBOutlet UICollectionView *cutProCollectionView;
    NewAndDraftboxView *NewAndDraftboxView1;
}

@synthesize locationDate,newsNSOrderDetail;
@synthesize objects = _objects;
@synthesize selectedobjs = _selectedobjs;
@synthesize bucketName = _bucketName;
@synthesize cloudId = _cloudId;
@synthesize cloudKey = _cloudKey;
@synthesize endPoint = _endPoint;
@synthesize objectsURL = _objectsURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"创建";
    
    [self loadInit];
}

/**  初始化操作 */
- (void)loadInit {
    UserMaterialNum = 0;
//    [stockForKVO setValue:@"0.01" forKey:@"upratio"];
//    [stockForKVO addObserver:self forKeyPath:@"upratio" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    if (![UserEntity sharedSingleton].customerId || [[UserEntity sharedSingleton].customerId isEqualToString:@""]) {
        self.makeSureButton.enabled = NO;
        self.cloudButton.enabled = NO;
    }else{
        self.makeSureButton.enabled = YES;
        self.cloudButton.enabled = YES;
    }
    [self resetSliderBar];
    
    orderCurrent = 0;
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigation_stateBar_background"]];
    self.sumcount = 20;
    _isTrigger = NO;
    _bl = NO;
    _cancelButton.hidden = NO;
    [_cancelButton setTitle:@"" forState:UIControlStateNormal];
    [_cancelButton setFrame:CGRectMake(16,7,30,30)];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
    _isVideo=YES;
    self.newsNSOrderDetail = [[NewNSOrderDetail alloc] init];
    self.imageOrigArray = [[NSMutableArray alloc] init];
    self.deleteMaterialArray = [[NSMutableArray alloc] init];
    
    // 加载占位图片
    [self resetImageArray];
    
    k = 0;
    [self initWithSelect];
    _customWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, SCREEN_HEIGHT)];
    _customWindow.windowLevel= UIWindowLevelAlert;
    _customWindow.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroud_shadow"]];
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
    [self resumeLastOrder];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.tabBarController.tabBar.hidden = FALSE;//push hide bar 会在tabbar切换的时候隐藏，所以需要重新显示tabbar
}

-(void)newCreateOrder
{
    [self resetSliderBar];
    UserMaterialNum = 0;
    _customWindow.hidden = YES;
    NewNSOrderDetail *newNSOrderDetail1 = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
    [self setRecommandsize:newNSOrderDetail1.nVideoLength Reduce:0.0];
    [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBChange:newNSOrderDetail1];
    [[NewUserOrderList Singleton].newcutlist removeAllObjects];
    [self.imageOrigArray removeAllObjects];
    
    // 加载占位图片
    [self resetImageArray];
    
    orderCurrent = 0;
    int ret = [self judgeStatus];
    if (ret == 0) {	        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        int y = (int)[dateComponent year];
        int m = (int)[dateComponent month];
        int d = (int)[dateComponent day];
        int hour = (int)[dateComponent hour];
        int min = (int)[dateComponent minute];
        int sec = (int)[dateComponent second];
        NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
        newNSOrderDetail.createTime = [NSString stringWithFormat:@"%d/%d/%d-%d:%d:%d",y,m,d,hour,min,sec];
        newNSOrderDetail.customer = 0;
        newNSOrderDetail.nVideoLength = 60;
        newNSOrderDetail.nMusicStart = 0;
        newNSOrderDetail.nMusicEnd = 60;
        newNSOrderDetail.order_id = [[NSString stringWithFormat:@"%d%d%d%d%d",m,d,hour,min,sec] intValue];
        [[NewUserOrderList Singleton].newcutlist addObject:newNSOrderDetail];
        [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBInsert:newNSOrderDetail];
    }else if(ret == 1){
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
        NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
        int y = (int)[dateComponent year];
        int m = (int)[dateComponent month];
        int d = (int)[dateComponent day];
        int hour = (int)[dateComponent hour];
        int min = (int)[dateComponent minute];
        int sec = (int)[dateComponent second];
        NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
        newNSOrderDetail.createTime = [NSString stringWithFormat:@"%d/%d/%d-%d:%d:%d",y,m,d,hour,min,sec];
        newNSOrderDetail.customer = [[UserEntity sharedSingleton].customerId intValue];
        newNSOrderDetail.nVideoLength = 60;
        newNSOrderDetail.nMusicStart = 0;
        newNSOrderDetail.nMusicEnd = 60;
        newNSOrderDetail.order_id = [[NSString stringWithFormat:@"%d%d%d%d%d",m,d,hour,min,sec] intValue];
        [[NewUserOrderList Singleton].newcutlist addObject:newNSOrderDetail];
        [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBInsert:newNSOrderDetail];
    }
    [self newOrder];//暂时2015-11-04 谢斌
    [cutProCollectionView reloadData];
}

-(void)newOrder //arbin 2015/11/03 新增
{
//    [self resetSliderBar];
    _customWindow.hidden = YES; //隐藏左上弹出窗口
    //将Fresh订单转换成草稿状态（Uncommit状态）
    [MC_OrderAndMaterialCtrl Fresh2Uncommit:[[UserEntity sharedSingleton].customerId intValue]];
    //重置界面内cell
    [self resetImageArray];
    //新建一条Fresh订单
    [MC_OrderAndMaterialCtrl AddFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    self.newsNSOrderDetail = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
//    [cutProCollectionView reloadData];
}

-(void)resetImageArray
{
    [self.imageOrigArray removeAllObjects];
    for (int i = 0; i < 20; i++) {
        [self.imageOrigArray addObject:[UIImage imageNamed:@"cutpro_image"]];
    }
    UserMaterialNum = 0;
    //缺少重绘
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

- (void)custermlogin
{
//    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSMutableArray *array = [[APPUserPrefs Singleton] APP_OrderDetail_Custerm0_CacheInformationDBSearch];
    int counts = (int)[array count];
    if ([array count]) {
        for (int i = 0; i < counts; i++) {
//            NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
            NewNSOrderDetail *newNSOrderDetail = [array objectAtIndex:i];
            newNSOrderDetail.customer = [[UserEntity sharedSingleton].customerId intValue];
            [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBChange:newNSOrderDetail];
        }
    }
}

-(void)initWithSelect
{
    int ret = [self judgeStatus];
    [[NewUserOrderList Singleton].newcutlist removeAllObjects];
    if (ret == 0) {
//        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableArray *array = [[APPUserPrefs Singleton] APP_OrderDetail_Custerm0_CacheInformationDBSearch];
        if ([array count]) {
//            NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
            NewNSOrderDetail *newNSOrderDetail = [array objectAtIndex:0];
            [[NewUserOrderList Singleton].newcutlist addObject:newNSOrderDetail];
        }else{
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
            int y = (int)[dateComponent year];
            int m = (int)[dateComponent month];
            int d = (int)[dateComponent day];
            int hour = (int)[dateComponent hour];
            int min = (int)[dateComponent minute];
            int sec = (int)[dateComponent second];
            NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
            newNSOrderDetail.createTime = [NSString stringWithFormat:@"%d/%d/%d-%d:%d:%d",y,m,d,hour,min,sec];
            newNSOrderDetail.customer = 0;
            newNSOrderDetail.nVideoLength = 60;
            newNSOrderDetail.nMusicStart = 0;
            newNSOrderDetail.nMusicEnd = 60;
            newNSOrderDetail.order_id = [[NSString stringWithFormat:@"%d%d%d%d%d",m,d,hour,min,sec] intValue];
            [[NewUserOrderList Singleton].newcutlist addObject:newNSOrderDetail];
            [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBInsert:newNSOrderDetail];
        }
    }else if(ret == 1){
//`        [self custermlogin];
//        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSMutableArray *array = [[APPUserPrefs Singleton] APP_OrderDetail_Custerm1_CacheInformationDBSearch:[[UserEntity sharedSingleton].customerId intValue]];
        if ([array count]) {
//            NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
            NewNSOrderDetail *newNSOrderDetail = [array objectAtIndex:0];
            [[NewUserOrderList Singleton].newcutlist addObject:newNSOrderDetail];
        }else{
            NSDate *now = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSUInteger unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
            NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
            int y = (int)[dateComponent year];
            int m = (int)[dateComponent month];
            int d = (int)[dateComponent day];
            int hour = (int)[dateComponent hour];
            int min = (int)[dateComponent minute];
            int sec = (int)[dateComponent second];
            NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
            newNSOrderDetail.createTime = [NSString stringWithFormat:@"%d/%d/%d-%d:%d:%d",y,m,d,hour,min,sec];
            newNSOrderDetail.customer = [[UserEntity sharedSingleton].customerId intValue];
            newNSOrderDetail.nVideoLength = 60;
            newNSOrderDetail.nMusicStart = 0;
            newNSOrderDetail.nMusicEnd = 60;
            newNSOrderDetail.order_id = [[NSString stringWithFormat:@"%d%d%d%d%d",m,d,hour,min,sec] intValue];
            [[NewUserOrderList Singleton].newcutlist addObject:newNSOrderDetail];
            [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBInsert:newNSOrderDetail];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.imageOrigArray removeAllObjects];
    UserMaterialNum = 0;
    for (int i = 0; i < 20; i++) {
        [self.imageOrigArray addObject:[UIImage imageNamed:@"cutpro_image"]];
    }
    if (![[NewUserOrderList Singleton].newcutlist count]) {
        [self initWithSelect];
    }
    NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
    NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
    newOrderVideoMaterial.order_id = newNSOrderDetail.order_id;
//    NSMutableArray *array = [[APPUserPrefs Singleton] APP_MaterialArrCacheInformationDBSearch:newOrderVideoMaterial];
    NSMutableArray *array = [MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id];
    int a = (int)[array count];
    orderCurrent = a;
    if (a > 0)
    {
        for (int i = 0; i < a;i++) {
            NewOrderVideoMaterial *newOrderVideoMaterial = [array objectAtIndex:i];
            if (orderCurrent <= 20) {
                if (![newOrderVideoMaterial.material_assetsURL isEqualToString:@""]) {
                    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
                    NSURL *asseturl = [NSURL URLWithString:newOrderVideoMaterial.material_assetsURL];
                    [library assetForURL:asseturl resultBlock:^(ALAsset *asset) {
                        if (!asset){
                        }else{
                            UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
                            [self.imageOrigArray replaceObjectAtIndex:i withObject:image];
                            UserMaterialNum++;
                        }
                        [cutProCollectionView reloadData];
                    } failureBlock:^(NSError *error) {
                        
                    }];
                    continue;
                }else{//这种情况在什么时候会发生呢？arbin疑问？arbin回答，数据库曾经存储过blob数据（image）
                    [self.imageOrigArray replaceObjectAtIndex:i withObject:newOrderVideoMaterial.material_stream];
                    UserMaterialNum++;
                }

            }
        }
    }
    [cutProCollectionView reloadData];
    self.navigationController.tabBarController.tabBar.hidden = FALSE;//push hide bar 会在tabbar切换的时候隐藏，所以需要重新显示tabbar
    
    [self refreshSliderBarFrame];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)longPressRecognizerAction:(id)sender {
    _cancelButton.hidden = NO;
    [_cancelButton setTitle:@"删除" forState:UIControlStateNormal];
    [_cancelButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _isTrigger = YES;
    _bl = YES;
    _makeSureButton.hidden = YES;
    [cutProCollectionView reloadData];
}

- (IBAction)cancelButtonAction:(id)sender {
    if (_bl) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"确定删除吗?" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [myAlertView show];
    }else{
        [_customWindow makeKeyAndVisible];
    }
}

-(void)newCreate
{
    UIView *aView = [self.view viewWithTag:100];
    [aView removeFromSuperview];
}

-(void)oldCreate
{
    UIView *aView = [self.view viewWithTag:100];
    [aView removeFromSuperview];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSArray *_reSortArray= [[NSArray alloc] init];
    switch (buttonIndex) {
        case 0:
            _makeSureButton.hidden = NO;
            _cancelButton.hidden = NO;
            _isTrigger = NO;
            //self.deleteMaterialArray 排序
            _reSortArray = [self.deleteMaterialArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                NSComparisonResult result = [obj1 compare:obj2];
//                return result == NSOrderedDescending; // 升序
                return result == NSOrderedAscending;  // 降序
            }];
            //删除数据
            for (int i = 0; i<[_reSortArray count]; i++) {
                float reducetime = [MC_OrderAndMaterialCtrl DeleteMaterialInOrder:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id Index:[[_reSortArray objectAtIndex:i] intValue]];
                [self.imageOrigArray removeObjectAtIndex:[[_reSortArray objectAtIndex:i] intValue]];
                [self.imageOrigArray addObject:[UIImage imageNamed:@"cutpro_image"]];
                UserMaterialNum--;
                [self setRecommandsize:0.0 Reduce:reducetime];
            }
//            int sum = (int)[self.deleteMaterialArray count];
//            for (int i = sum - 1; i >= 0; i--) {
//                int tmp = [[self.deleteMaterialArray objectAtIndex:0] intValue];
//                k = 0;
//                for (int j = 1; j < sum; j++) {
//                    if (tmp < [[self.deleteMaterialArray objectAtIndex:j] intValue])
//                    {
//                        tmp = [[self.deleteMaterialArray objectAtIndex:j] intValue];
//                        k = j;
//                    }
//                }
//                NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
//                NewOrderVideoMaterial *in = [[NewOrderVideoMaterial alloc]init];
//                in.order_id = newNSOrderDetail.order_id;
//                NewOrderVideoMaterial *dbret = [[APPUserPrefs Singleton] APP_MaterialCacheInformationDBSearch:in useindex:tmp];
//                
//                [[APPUserPrefs Singleton] APP_MaterialCacheInformationDBDelete:newNSOrderDetail.order_id Material_Index:tmp];
//                [self setRecommandsize:0.0 Reduce:dbret.material_playduration];
//                [self.imageOrigArray removeObjectAtIndex:tmp];
//                [self.imageOrigArray addObject:[UIImage imageNamed:@"cutpro_image"]];
//                NSString *stringInt = [NSString stringWithFormat:@"%d",tmp];
//                [self.deleteMaterialArray removeObject:stringInt];
//                orderCurrent--;
//                sum = sum - 1;
//            }
            [self.deleteMaterialArray removeAllObjects];
            [_cancelButton setBackgroundImage:[UIImage imageNamed:@"star"] forState:UIControlStateNormal];
            [_cancelButton setTitle:@"" forState:UIControlStateNormal];
            _bl = NO;
            [cutProCollectionView reloadData];
            break;
        case 1:
            break;
        default:
            break;
    }
}

- (IBAction)takeMedia:(UIButton *)sender
{
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}

- (IBAction)selectionLocalMaterialButton:(id)sender
{
    NSLog(@"sender %@",sender);
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    picker.maximumNumberOfSelectionMedia = 10;
    [self presentViewController:picker animated:YES completion:^{
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
//        NSLog(@"imagepicker time = %f",USERFILMMAX - self.recommondvalue);
        
        self.imagePicker.allowsEditing = YES;
        self.imagePicker.sourceType = sourceType;
        if (self.imagePicker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            _imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            _imagePicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;
            if (self.isVideo)
            {
                _imagePicker.mediaTypes=@[(NSString *)kUTTypeMovie];
                _imagePicker.videoQuality=UIImagePickerControllerQualityType640x480;
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
//        UIAlertView *alert =
//        [[UIAlertView alloc] initWithTitle:@"Error accessing media"
//                                   message:@"Unsupported media source."
//                                  delegate:nil
//                         cancelButtonTitle:@"Drat!"
//                         otherButtonTitles:nil];
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSDate * date = [NSDate date];
        NSString *strTime =[NSString stringWithFormat:@"%ld",(long)date.timeIntervalSinceReferenceDate];
        NSString *fileName = [[NSString alloc] initWithFormat: @"%@.png",strTime];
        NSString *KCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *videoPath = [[NSString alloc] initWithFormat: @"%@/%@",KCachesPath,fileName];
        [data writeToFile:videoPath atomically:YES];
        UIImage *image;
        image=[info objectForKey:UIImagePickerControllerOriginalImage];
        if (orderCurrent <= 20) {
            NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
//            NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
            NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
            newOrderVideoMaterial.createTime = newNSOrderDetail.createTime;
            newNSOrderDetail = [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBSearch:newNSOrderDetail];
            newOrderVideoMaterial.order_id = newNSOrderDetail.order_id;
            newOrderVideoMaterial.file_st = 0;
            newOrderVideoMaterial.material_type = 1;
            newOrderVideoMaterial.material_index = orderCurrent;
            newOrderVideoMaterial.material_localURL = videoPath;
            newOrderVideoMaterial.material_ossURL = @"";
            newOrderVideoMaterial.material_stream = image;
            newOrderVideoMaterial.material_assetsURL = @"";
            [[APPUserPrefs Singleton] APP_MaterialCacheInformationDBInsert:newOrderVideoMaterial];
            orderCurrent++;
        }
        [cutProCollectionView reloadData];
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];
        AVURLAsset *avUrl = [AVURLAsset assetWithURL:url];
        CMTime time = [avUrl duration];
        //        NSLog(@"seconds is equal = %lld ",time.value/time.timescale);
        NSData *data = [NSData dataWithContentsOfURL:url];
        MPMoviePlayerController *mp = [[MPMoviePlayerController alloc] initWithContentURL:url];
        mp.shouldAutoplay = NO;
        UIImage *thumbnail = [mp thumbnailImageAtTime:0.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        NSDate * date = [NSDate date];
        NSString *strTime =[NSString stringWithFormat:@"%ld",(long)date.timeIntervalSinceReferenceDate];
        NSString *fileName = [[NSString alloc] initWithFormat: @"%@.mov",strTime];
        NSString *KCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *videoPath = [[NSString alloc] initWithFormat: @"%@/%@",KCachesPath,fileName];
        [data writeToFile:videoPath atomically:YES];
        if (orderCurrent <= 20) {
            NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
//            NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
//            NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
//            newOrderVideoMaterial.createTime = newNSOrderDetail.createTime;
//            newNSOrderDetail = [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBSearch:newNSOrderDetail];
//            newOrderVideoMaterial.order_id = newNSOrderDetail.order_id;
//            newOrderVideoMaterial.file_st = 0;
//            newOrderVideoMaterial.material_type = 1;
//            newOrderVideoMaterial.material_index = orderCurrent;
//            newOrderVideoMaterial.material_localURL = fileName;
//            newOrderVideoMaterial.material_ossURL = @"";
//            newOrderVideoMaterial.material_stream = thumbnail;
//            newOrderVideoMaterial.material_assetsURL = @"";
//            newOrderVideoMaterial.material_playduration = time.value/time.timescale;
//            [self setRecommandsize:newOrderVideoMaterial.material_playduration Reduce:0.0];
//            [[APPUserPrefs Singleton] APP_MaterialCacheInformationDBInsert:newOrderVideoMaterial];
            NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
            //创建ALAssetsLibrary对象并将视频保存到媒体库
            ALAssetsLibrary* assetsLibrary = [[ALAssetsLibrary alloc] init];
            [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL completionBlock:^(NSURL *assetURL, NSError *error) {
                if (!error) {
                    NSLog(@"captured video saved with no error.");
                    NewOrderVideoMaterial *additem = [[NewOrderVideoMaterial alloc] init];
                    additem.createTime = self.newsNSOrderDetail.createTime;
                    additem.order_id = self.newsNSOrderDetail.order_id;
                    additem.file_st = 0;
                    additem.material_type = 1;
                    additem.material_index = 0;
                    additem.material_localURL = videoPath;
                    additem.material_ossURL = @"";
                    additem.material_stream = thumbnail;
                    additem.material_assetsURL = [assetURL absoluteString];
                    additem.material_playduration = time.value/time.timescale;
                    
                    [MC_OrderAndMaterialCtrl MC_AddMaterial:[[UserEntity sharedSingleton].customerId intValue] Material:additem Orderid:self.newsNSOrderDetail.order_id];
                    [self setRecommandsize:additem.material_playduration Reduce:0.0];
                    
                    self.newsNSOrderDetail.nVideoLength = _recommondvalue;
                    [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
                    [cutProCollectionView reloadData];
                    
                }else
                {
                    NSLog(@"error occured while saving the video:%@", error);
                }
            }];
            orderCurrent++;
        }
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}


-(void)newMaaterial:(NewOrderVideoMaterial*)in{
    in.order_id = self.newsNSOrderDetail.order_id;
    //数据入库
    //cell image 数组替换
    [self.imageOrigArray addObject:nil];
}

- (void)buttonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CutProIdentifier= @"CutProIdentifier";
    CutProCollectionViewCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:CutProIdentifier forIndexPath:indexPath];
    collectionCell.imageView.image = [self.imageOrigArray objectAtIndex:indexPath.row];
    if (_isTrigger&&UserMaterialNum>indexPath.item) {
        collectionCell.unSelectedButton.hidden = NO;
    } else {
        collectionCell.unSelectedButton.hidden = YES;
    }
    if (collectionCell.unSelectedButton.selected) {
        collectionCell.unSelectedButton.selected = !collectionCell.unSelectedButton.selected;
    }
    collectionCell.indexLabel.layer.cornerRadius = 10;
    collectionCell.indexLabel.clipsToBounds = YES;
    collectionCell.indexLabel.text = [NSString stringWithFormat:@"%ld", indexPath.item + 1];
    return collectionCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cellWidth = (self.collectionView.width - 36)/3;
    cellHeight = cellWidth - 30;
    return CGSizeMake(cellWidth, cellHeight);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CutProCollectionViewCell *cell = (CutProCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (_isTrigger) {
        cell.unSelectedButton.selected = !cell.unSelectedButton.selected;
        [cell.unSelectedButton setImage:[UIImage imageNamed:@"check_h"] forState:UIControlStateSelected];
        NSString *string = [NSString stringWithFormat:@"%02d",(int)indexPath.row];
        if (cell.unSelectedButton.selected) {
            [self.deleteMaterialArray addObject:string];
        }else{
            [self.deleteMaterialArray removeObject:string];
        }
    }
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark --- UzysAssetsPickerControllerDelegate
- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if (assets.count+orderCurrent>20) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示:"
                              message:@"素材数量太多！"
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    for (int i = 0; i<assets.count; i++) {
        [self AddMaterial:assets[i]];
        k++;
    }
}

-(void)AddMaterial:(ALAsset*)al
{
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
    additem.material_type = 1;
    additem.material_index = 0;
    additem.material_localURL = videoPath;
    additem.material_ossURL = @"";
    additem.material_stream = image;
    additem.material_assetsURL = [imageURL absoluteString];
    if([[al valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
        additem.material_playduration = 3.0;
    else
        additem.material_playduration = [[al valueForProperty:ALAssetPropertyDuration] floatValue];
    BOOL exist = [MC_OrderAndMaterialCtrl FindMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id URL:additem.material_assetsURL URLType:USELOCALPATH];
    if (exist) {
        return;
    }
    
    [MC_OrderAndMaterialCtrl MC_AddMaterial:[[UserEntity sharedSingleton].customerId intValue] Material:additem Orderid:self.newsNSOrderDetail.order_id];
    [self setRecommandsize:additem.material_playduration Reduce:0.0];
    
    self.newsNSOrderDetail.nVideoLength = _recommondvalue;
    [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
    
    return;
    /*
    NSString *filename = al.defaultRepresentation.filename;
    UIImage *image = [UIImage imageWithCGImage:al.thumbnail];
    NSURL *imageURL = al.defaultRepresentation.url;
    NSString *KCachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *videoPath = [[NSString alloc] initWithFormat: @"%@/%@",KCachesPath,filename];
    [self videoWithUrl:imageURL withFileName:videoPath];
    if (orderCurrent <= 20) {
        NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
        NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
        newOrderVideoMaterial.createTime = newNSOrderDetail.createTime;
        newNSOrderDetail = [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBSearch:newNSOrderDetail];
        newOrderVideoMaterial.order_id = newNSOrderDetail.order_id;
        newOrderVideoMaterial.file_st = 0;
        newOrderVideoMaterial.material_type = 1;
        newOrderVideoMaterial.material_index = orderCurrent;
        newOrderVideoMaterial.material_localURL = filename;
        newOrderVideoMaterial.material_ossURL = @"";
        newOrderVideoMaterial.material_stream = image;
        newOrderVideoMaterial.material_assetsURL = [imageURL absoluteString];
        if([[al valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto])
            newOrderVideoMaterial.material_playduration = 3.0;
        else
            newOrderVideoMaterial.material_playduration = [[al valueForProperty:ALAssetPropertyDuration] floatValue];
        NewOrderVideoMaterial *newOrderVideoMaterial1 = [[NewOrderVideoMaterial alloc] init];
        NewNSOrderDetail *newNSOrderDetail1 = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
        newOrderVideoMaterial1.order_id = newNSOrderDetail1.order_id;
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSMutableArray *array = [[APPUserPrefs Singleton] APP_MaterialArrCacheInformationDBSearch:newOrderVideoMaterial1];
            int a = (int)[array count];
            int j = 0;
            for (int i = 0 ; i < a; i++) {
                NewOrderVideoMaterial *newOrderVideoMaterial2 = [array objectAtIndex:i];
                if ([newOrderVideoMaterial2.material_assetsURL isEqualToString:newOrderVideoMaterial.material_assetsURL]) {
                    break;
                }
                j = i+1;
            }
            if (j == a) {
                orderCurrent++;
                newOrderVideoMaterial.material_index = orderCurrent;
                [self setRecommandsize:newOrderVideoMaterial.material_playduration Reduce:0.0];
                [[APPUserPrefs Singleton] APP_MaterialCacheInformationDBInsert:newOrderVideoMaterial];
                [cutProCollectionView reloadData];
            }
        });
    }
    return;*/
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

-(void)jumpview
{
    _customWindow.hidden = YES;
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DraftboxTableViewController *draview=[storyBoard instantiateViewControllerWithIdentifier:@"DraftboxTable"];
    [self.navigationController  pushViewController:draview animated:YES];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"upratio"])
    {
        NSString *fratio = [NSString stringWithFormat:@"%@",[stockForKVO valueForKey:@"upratio"]];
        float f = [fratio floatValue];
        
        if (f - self.lastProgress > 0.02) {
            // 需要绘制时 发送通知
            NSMutableDictionary *info = [NSMutableDictionary dictionary];
            info[@"finishProgress"] = [NSNumber numberWithFloat:f];
            [[NSNotificationCenter defaultCenter] postNotificationName:UploadFileProgressChange object:nil userInfo:info];
            
            dispatch_async(dispatch_get_main_queue(), ^(void){
                [self.navigationController setSGProgressPercentage:f*100 andTintColor:[UIColor colorWithRed:235.f/255.f green:51.f/255.f blue:73.f/255.f alpha:1.f]];
            });
            // 更新上次  传递绘制时  的进度
            self.lastProgress = f;
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (IBAction)sliderbutton:(id)sender {
//    UISlider *slider = (UISlider *)sender;
//    NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
//    bool valuechange = false;//监测订单值是否变化
//    if (slider.value<0.3) {
//        _sliderbutton.value=0;
//        if(newNSOrderDetail.nVideoLength != 30)
//            valuechange = true;
//        newNSOrderDetail.nVideoLength = 30;
//        newNSOrderDetail.nMusicStart = 0;
//        newNSOrderDetail.nMusicEnd = 30;
//    }else if(slider.value>0.6){
//        _sliderbutton.value=1.0;
//        if(newNSOrderDetail.nVideoLength != 90)
//            valuechange = true;
//        newNSOrderDetail.nVideoLength = 90;
//        newNSOrderDetail.nMusicStart = 0;
//        newNSOrderDetail.nMusicEnd = 90;
//    }else{
//        _sliderbutton.value=0.5;
//        if(newNSOrderDetail.nVideoLength != 60)
//            valuechange = true;
//        newNSOrderDetail.nVideoLength = 60;
//        newNSOrderDetail.nMusicStart = 0;
//        newNSOrderDetail.nMusicEnd = 60;
//    }
//    if (valuechange) {
//        [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBChange:newNSOrderDetail];
//        [[NewUserOrderList Singleton].newcutlist replaceObjectAtIndex:0 withObject:newNSOrderDetail];
//    }
//}

-(void)setRecommandsize:(float)addvalue Reduce:(float)minusvalue{
    _recommondvalue += addvalue;
    _recommondvalue -= minusvalue;
    if (_recommondvalue>=15) {
        [self refreshSliderBarFrame];
        _sliderbutton.maximumValue = _recommondvalue;
        _sliderbutton.value = _recommondvalue;
    }else{
        _sliderbutton.maximumValue = USERFILMMIN;
        _sliderbutton.value = USERFILMMIN;
        self.sliderWidthC.constant = 4;
        [_labelRecommand setText:@"素材过少， 请添加素材"];
    }
//    NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
//    newNSOrderDetail.nVideoLength = _recommondvalue;
//    newNSOrderDetail.nMusicStart = 0;
//    newNSOrderDetail.nMusicEnd = _recommondvalue;
//    //虚拟机cpu太快，需要注掉
//    [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBChange:newNSOrderDetail];
//    [[NewUserOrderList Singleton].newcutlist replaceObjectAtIndex:0 withObject:newNSOrderDetail];

    NSLog(@"recommond = %lf",_recommondvalue);

}

-(void)refreshSliderBarFrame{
    if(_recommondvalue<15)
        return;
    [UIView animateWithDuration:0.3 animations:^{
//        NSLog(@"ratio = %lf",(_recommondvalue-15.0)/75.0);
//        [_sliderbutton setFrame:newrc];
        self.sliderWidthC.constant = Main_Screen_Width*(_recommondvalue-15.0)/75.0;
        [_labelRecommand setText:[NSString stringWithFormat:@"大约%0.1lf秒",_recommondvalue]];
    }];
    return;
}

-(void)resetSliderBar{
    _recommondvalue = 0;
    _sliderbutton.maximumValue=USERFILMMIN;
    _sliderbutton.minimumValue=USERFILMMIN;
    _sliderbutton.value=USERFILMMIN;
    [_labelRecommand setText:@"请添加用户素材"];
}

- (IBAction)changeLength:(id)sender {
    UISlider *slider = (UISlider*)sender;
    NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
    newNSOrderDetail.nVideoLength = slider.value;
    newNSOrderDetail.nMusicStart = 0;
    newNSOrderDetail.nMusicEnd = slider.value;
    NSLog(@"now value = %lf",slider.value);
    //虚拟机cpu太快，需要注掉
    [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBChange:newNSOrderDetail];
    [[NewUserOrderList Singleton].newcutlist replaceObjectAtIndex:0 withObject:newNSOrderDetail];
//    [UIView animateWithDuration:0.3 animations:^{
//        [_labelRecommand setText:[NSString stringWithFormat:@"大约%0.1lf秒",slider.value]];
//    }];
    [_labelRecommand setText:[NSString stringWithFormat:@"大约%0.1lf秒",slider.value]];
    
    ///启用新的数据内容
    self.newsNSOrderDetail.nVideoLength = slider.value;//
    self.newsNSOrderDetail.nMusicStart = 0;
    self.newsNSOrderDetail.nMusicEnd = slider.value;
    
    [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
}

-(void)resumeLastOrder{
    //viewdidappear 里面的代码谁要是能看懂帮我移植过来吧。累2015年10月24日下午
    /*
    [self resetSliderBar];
    NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
    NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
    newOrderVideoMaterial.order_id = newNSOrderDetail.order_id;
    NSMutableArray *array = [[APPUserPrefs Singleton] APP_MaterialArrCacheInformationDBSearch:newOrderVideoMaterial];
    if ([array count] > 0)
    {
        for (int i = 0; i < [array count];i++) {
            NewOrderVideoMaterial *item = [array objectAtIndex:i];
            [self setRecommandsize:item.material_playduration Reduce:0.0];
        }
    }*/
    //替换使用新的数据2015-11-04
    
    [self resetSliderBar];
    self.newsNSOrderDetail = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    if (self.newsNSOrderDetail == nil) {
        [MC_OrderAndMaterialCtrl AddFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
        self.newsNSOrderDetail =[MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    }else{
#pragma 待补充素材数据
#warning need fill material
        NSMutableArray *array = [MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:self.newsNSOrderDetail.order_id];
        for (NewOrderVideoMaterial* item in array) {
            [self setRecommandsize:item.material_playduration Reduce:0.0];
        }
        self.newsNSOrderDetail.nVideoLength = _recommondvalue;
        [MC_OrderAndMaterialCtrl UpdateFresh:self.newsNSOrderDetail];
    }
    

}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    if (_recommondvalue<15) {
        [self showAlert:@"为保证影片效果，请选择至少15秒视频或5张照片。"];
        return NO;
    }else
        return YES;
}

- (void)showAlert:(NSString*)msg
{
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:3.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    [promptAlert show];
}
- (void)timerFireMethod:(NSTimer*)theTimer
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:YES];
    promptAlert = NULL;
}

#pragma mvOverSlider delegate
-(void)SliderRightOver{
    [self showAlert:@"想制作更长的影片吗？请继续添加素材吧。"];
}

@end
