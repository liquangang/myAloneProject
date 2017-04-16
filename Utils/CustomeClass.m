//
//  CustomeClass.m
//  M-Cut
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "CustomeClass.h"
#import "MovierTranslation.h"
#import <MBProgressHUD.h>
//md5加密使用
#import <CommonCrypto/CommonDigest.h>
#import <AVFoundation/AVFoundation.h>
#import <UIImage+GIF.h>

@implementation AddressBookModel
@end

@implementation CustomeClass
//根据传入的格式获取当前时间
/*
 YYYY（年）/MM（月）/dd（日） hh（时）:mm（分）:ss（秒） SS（毫秒）
 需要用哪个的话就把哪个格式加上去。
 值得注意的是，如果想显示两位数的年份的话，可以用”YY/MM/dd hh:mm:ss SS”，两个Y代表两位数的年份。
 而且大写的M和小写的m代表的意思也不一样。“M”代表月份，“m”代码分钟
 “HH”代表24小时制，“hh”代表12小时制
 （注意：dd也就是日必须用小写，否则会出错）
 */
+ (NSString *)getCurrentTimeWithFormatter:(NSString *)timeFormatter{
    NSDateFormatter * formatter = [NSDateFormatter new];
    [formatter setDateFormat:timeFormatter];
    return [formatter stringFromDate:[NSDate date]];
}

+ (void)showMessage:(NSString *)message ShowTime:(NSInteger)showTime
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *label = [[UILabel alloc]init];
        label.layer.cornerRadius = 6;
        label.layer.masksToBounds = YES;
        CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(290, 9000)];
        label.text = message;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = ColorFromRGB(0x000000, 0.66);
        label.font = [UIFont boldSystemFontOfSize:15];
        label.numberOfLines = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:label];
        label.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width - 20)/2, SCREEN_HEIGHT / 4 * 3, LabelSize.width+20, LabelSize.height+10);
        
        [UIView animateWithDuration:showTime animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    });
}

+ (void)showAlert:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        UILabel *label = [[UILabel alloc]init];
        label.layer.cornerRadius = 6;
        label.layer.masksToBounds = YES;
        CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:36] constrainedToSize:CGSizeMake(290, 9000)];
        label.text = message;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = 1;
        label.backgroundColor = ColorFromRGB(0x000000, 0.66);
        label.font = [UIFont boldSystemFontOfSize:16];
        label.numberOfLines = 0;
        [[UIApplication sharedApplication].keyWindow addSubview:label];
        label.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width)/2, SCREEN_HEIGHT / 4 * 3, LabelSize.width, LabelSize.height);
        
        [UIView animateWithDuration:3 animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    });
}

+ (void)showMessage:(NSString *)message ShowTime:(NSInteger)showTime TextColor:(UIColor *)textColor{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        UIView *showview =  [[UIView alloc]init];
        showview.backgroundColor = [UIColor whiteColor];
        showview.frame = CGRectMake(1, 1, 1, 1);
        showview.alpha = 1.0f;
        showview.layer.cornerRadius = 5.0f;
        showview.layer.masksToBounds = YES;
        [window addSubview:showview];
        
        UILabel *label = [[UILabel alloc]init];
        CGSize LabelSize = [message sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(290, 9000)];
        label.frame = CGRectMake(10, 5, LabelSize.width, LabelSize.height);
        label.text = message;
        label.textColor = textColor;
        label.textAlignment = 1;
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:12];
        [showview addSubview:label];
        showview.frame = CGRectMake((SCREEN_WIDTH - LabelSize.width - 20)/2, SCREEN_HEIGHT / 4 * 3, LabelSize.width+20, LabelSize.height+10);
        [UIView animateWithDuration:showTime animations:^{
            showview.alpha = 0;
        } completion:^(BOOL finished) {
            [showview removeFromSuperview];
        }];
    });
}



//  十进制转二进制
+ (NSString *)toBinarySystemWithDecimalSystem:(NSString *)decimal
{
    int num = [decimal intValue];
    int remainder = 0;      //余数
    int divisor = 0;        //除数
    
    NSString * prepare = @"";
    
    while (true)
    {
        remainder = num%2;
        divisor = num/2;
        num = divisor;
        prepare = [prepare stringByAppendingFormat:@"%d",remainder];
        
        if (divisor == 0)
        {
            break;
        }
    }
    
    NSString * result = @"";
    for (int i = prepare.length - 1; i >= 0; i --)
    {
        result = [result stringByAppendingFormat:@"%@",
                  [prepare substringWithRange:NSMakeRange(i , 1)]];
    }
    
    return result;
}
//  二进制转十进制
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary
{
    int ll = 0 ;
    int  temp = 0 ;
    for (int i = 0; i < binary.length; i ++)
    {
        temp = [[binary substringWithRange:NSMakeRange(i, 1)] intValue];
        temp = temp * powf(2, binary.length - i - 1);
        ll += temp;
    }
    
    NSString * result = [NSString stringWithFormat:@"%d",ll];
    
    return result;
}

/** 返回当前网络状态*/
+ (NSString *)currentInterentStatus{
    if ([[MovierTranslation Singleton].netType isEqualToString:@"网络不可用"]) {
        return @"网络不可用";
    }
    if ([[MovierTranslation Singleton].netType isEqualToString:@"移动网络"]) {
        return @"移动网络";
    }
    if ([[MovierTranslation Singleton].netType isEqualToString:@"wifi"]) {
        return @"wifi";
    }
    return nil;
}

+ (void)hudShowWithView:(UIView *)hudSuperView Tag:(NSInteger)hudTag{
//    MAINQUEUEUPDATEUI({
//        MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:hudSuperView];
//        [hudSuperView addSubview:HUD];
////        HUD.color = [UIColor clearColor];
////        HUD.backgroundColor = ColorFromRGB(0xc5c8cd, 0.66);
////        HUD.activityIndicatorColor = [UIColor lightGrayColor];
//        [HUD show:YES];
//        HUD.tag = hudTag;
//        HUD.mode = MBProgressHUDModeDeterminate;
//    })
    SHOWHUD
}

+ (void)hudHiddenWithView:(UIView *)hudSuperView Tag:(NSInteger)hudTag{
//    MAINQUEUEUPDATEUI({
//        MBProgressHUD * HUD = (MBProgressHUD *)[hudSuperView viewWithTag:hudTag];
//        [HUD show:NO];
//        [HUD removeFromSuperview];
//        HUD = nil;
//    })
    HIDDENHUD
}

+ (void)HUDshow:(UIView *)hudShowView Tag:(NSInteger)hudTag{
//    MAINQUEUEUPDATEUI({
//        MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:hudShowView];
//        [hudShowView addSubview:HUD];
////        HUD.color = [UIColor clearColor];
////        HUD.backgroundColor = ColorFromRGB(0xc5c8cd, 0.66);
////        HUD.activityIndicatorColor = [UIColor lightGrayColor];
//        [HUD show:YES];
//        HUD.tag = hudTag;
//        HUD.mode = MBProgressHUDModeAnnularDeterminate;
//    })
    SHOWHUD
}

+ (void)HUDhidden:(UIView *)hudShowView Tag:(NSInteger)hudTag{
//    MAINQUEUEUPDATEUI({
//        MBProgressHUD * HUD = (MBProgressHUD *)[hudShowView viewWithTag:hudTag];
//        [HUD show:NO];
//        [HUD removeFromSuperview];
//        HUD = nil;
//    })
    HIDDENHUD
}

+ (void)HUDshow:(UIView *)superView{
//    MAINQUEUEUPDATEUI({
//        MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:superView];
//        [superView addSubview:HUD];
////        HUD.color = [UIColor clearColor];
////        HUD.backgroundColor = ColorFromRGB(0xc5c8cd, 0.66);
////        HUD.activityIndicatorColor = [UIColor lightGrayColor];
//        [HUD show:YES];
//        HUD.tag = 1234567890;
//        HUD.mode = MBProgressHUDModeDeterminate;
//    })
    SHOWHUD
}

+ (void)HUDhidden:(UIView *)superView{
//    MAINQUEUEUPDATEUI({
//        MBProgressHUD * HUD = (MBProgressHUD *)[superView viewWithTag:1234567890];
//        [HUD show:NO];
//        [HUD removeFromSuperview];
//        HUD = nil;
//    })
    HIDDENHUD
}

+ (void)HUDShow{
    
//    [CustomeClass mainQueue:^{
//        MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:[UIApplication sharedApplication].keyWindow];
//        [[UIApplication sharedApplication].keyWindow addSubview:HUD];
////        HUD.color = [UIColor clearColor];
////        HUD.backgroundColor = ColorFromRGB(0xc5c8cd, 0.66);
////        HUD.activityIndicatorColor = [UIColor lightGrayColor];
//        [HUD show:YES];
//        HUD.tag = 88888888;
//        HUD.mode = MBProgressHUDModeDeterminate;
//    }];
    SHOWHUD
}

+ (void)HUDHidden{
    
//    [CustomeClass mainQueue:^{
//        MBProgressHUD * HUD = (MBProgressHUD *)[[UIApplication sharedApplication].keyWindow viewWithTag:88888888];
//        [HUD show:NO];
//        [HUD removeFromSuperview];
//        HUD = nil;
//    }];
    HIDDENHUD
}

/** 根据颜色返回图片*/
+ (UIImage *)createImageWithColor:(UIColor *)color Rect:(CGRect)myRect
{
    CGRect rect = CGRectMake(0.0f, 0.0f, ISScreen_Width - 16, 34.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

/** 获取通讯录中的数据*/
+ (void)loadAddressBookDataWithBlock:(RETURNADDRESSBOOKDATA)dataBlock{
    //存放通讯录联系人模型的数组
    NSMutableArray * personArray = [NSMutableArray new];
    __block BOOL readAddressBookPersimmons = NO;
    
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
    
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error){
            [personArray addObjectsFromArray:[CustomeClass getArray]];
            readAddressBookPersimmons = YES;
            dataBlock(@{ADDRESSBOOKDATA:personArray, ADDRESSBOOKPERMISSIONS:@(readAddressBookPersimmons)});
        });
    }
    else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        [personArray addObjectsFromArray:[self getArray]];
        readAddressBookPersimmons = YES;
        dataBlock(@{ADDRESSBOOKDATA:personArray, ADDRESSBOOKPERMISSIONS:@(readAddressBookPersimmons)});
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            //提示用户没有获取通讯录权限
            dataBlock(@{ADDRESSBOOKDATA:personArray, ADDRESSBOOKPERMISSIONS:@(readAddressBookPersimmons)});
        });
    }
}

+ (NSArray *)getArray{
    //保存联系人模型的数组
    NSMutableArray * addressBookTemp = [NSMutableArray new];
    
    //新建一个通讯录类
    ABAddressBookRef addressBooks = ABAddressBookCreate();
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        AddressBookModel *addressBook = [[AddressBookModel alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        addressBook.recordId = (int)ABRecordGetRecordID(person);;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.tel = (__bridge NSString*)value;
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [addressBookTemp addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
    return [addressBookTemp copy];
}

/** 过滤特殊字符*/
+ (NSString *)filterStringWithStr:(NSString *)str{
    return [[str componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:
                                                        @"~!@#$%^&*()_+`{}|:<>?-=[]\\;',./~！@#￥%……&*（）——+·{}|：“《》？-=【】、；‘，。、 "]] componentsJoinedByString: @""];
}

//读取plist文件(以字典的方式存储数据)
+ (NSDictionary *)getPlistfileDataWithFileName:(NSString *)fileName{
    return [NSDictionary dictionaryWithContentsOfFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]]];
}

//写入数据到plist（数据用字典存储）
+ (void)writeToPlistWithFileName:(NSString *)fileName Data:(NSDictionary *)dataDic{
    NSLog(@"保存的下载进度 --- %@", [self getPlistfileDataWithFileName:fileName]);
    [dataDic writeToFile:[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]] atomically:YES];
    NSLog(@"存储之后读取一次 --- %@", [self getPlistfileDataWithFileName:fileName]);
}

//强制旋转屏幕
+ (void)orientationToPortrait:(UIInterfaceOrientation)orientation{
    SEL selector = NSSelectorFromString(@"setOrientation:");
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
    [invocation setSelector:selector];
    [invocation setTarget:[UIDevice currentDevice]];
    int val = orientation;
    [invocation setArgument:&val atIndex:2];//前两个参数已被target和selector占用
    [invocation invoke];
}

/** 获得当前系统版本*/
+ (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}

+ (void)deleteFileWithFileName:(NSString *)fileName{
    NSError * error;
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        [[NSFileManager defaultManager] removeItemAtPath:fileName error:&error];
    }
    
    if (error) {
        DEBUGLOG(error)
    }else{
        DEBUGSUCCESSLOG(@"删除文件夹成功")
    }
}

/** 获得当前app版本号*/
+ (NSString *)getAppVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//对输入的字符串进行MD5加密
+ (NSString *)md5Str:(NSString *)str{
    const char * cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString
            stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],
            result[1],
            result[2],
            result[3],
            result[4],
            result[5],
            result[6],
            result[7],
            result[8],
            result[9],
            result[10],
            result[11],
            result[12],
            result[13],
            result[14],
            result[15]];
}

//保存图片到沙盒
+ (void)saveImageDocuments:(UIImage *)image ImageName:(NSString *)imageNameStr{
    
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.png", [self creatImageFile], imageNameStr]];
    NSLog(@"存之前 --- 这个文件：%@",result?@"存在":@"不存在");
    if (!result) {
        [UIImagePNGRepresentation(image) writeToFile:[NSString stringWithFormat:@"%@/%@.png", [self creatImageFile], imageNameStr] atomically:YES];
        BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithFormat:@"%@/%@.png", [self creatImageFile], imageNameStr]];
        NSLog(@"存之后 --- 这个文件：%@",result?@"存在":@"不存在");
    }
}
// 从沙盒读取图片
+ (UIImage *)getImageWithImageName:(NSString *)imageNameStr{
    // 拿到沙盒路径图片
    UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.png", [self creatImageFile], imageNameStr]];
    return imgFromUrl3 ? imgFromUrl3 : DEFAULTVIDEOTHUMAIL;
}

//删除沙盒中的某一张图片
+ (void)deleteImageWithImageName:(NSString *)imageNameStr{
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

//创建存储缩略图的文件夹
+ (NSString *)creatImageFile{
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

//删除存储缩略图的文件夹
+ (void)deleteFile{
    [[NSFileManager defaultManager] removeItemAtPath:[self creatImageFile] error:nil];
}

//将HTML字符串转化为NSAttributedString富文本字符串
+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString
{
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
}

/**
 *  获得本地视频资源的视频缩略图
 */
+ (UIImage *)getThumbnailImageWithUrl:(NSString *)videoURL

{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return thumb;
}

#pragma mark - 持久化部分

#pragma mark - nsuserdefaults
/**
 *  保存数据(数据以对象存在)
 */
+ (void)saveDataWithObject:(NSDictionary *)object Key:(NSString *)saveKey{
    NSData * saveData = [NSKeyedArchiver archivedDataWithRootObject:object];
    [[NSUserDefaults standardUserDefaults] setObject:saveData forKey:saveKey];
}

/**
 *  从沙盒中读取数据
 */
+ (NSDictionary *)readDataWithKey:(NSString *)readKey{
    NSData * readData = [[NSUserDefaults standardUserDefaults] objectForKey:readKey];
    NSDictionary * readDic = [NSKeyedUnarchiver unarchiveObjectWithData:readData];
    return readDic;
}


#pragma mark - 归档部分

/**
 *  归档写入数据到沙盒
 */
+ (void)writeDataToSandboxWithDic:(NSDictionary *)writeDic
                         FilePath:(NSString *)filePath
                              Key:(NSString *)writeKey
{
    NSMutableData * writeData = [NSMutableData new];
    NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:writeData];
    [archiver encodeObject:writeDic forKey:writeKey];
    [archiver finishEncoding];
    [writeData writeToFile:[NSString stringWithFormat:@"%@.plist", filePath] atomically:YES];
}

/**
 *  解档
 */
+ (NSDictionary *)readDataWithPath:(NSString *)readDataPath
                               Key:(NSString *)readKey
{
    NSDictionary * readDic = [NSDictionary new];
    NSData * readData = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@.plist", readDataPath]];
    if (readData.length > 0) {
        NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:readData];
        readDic = [unarchiver decodeObjectForKey:readKey];
        [unarchiver finishDecoding];
    }
    return readDic;
}

#pragma mark - 用户交互打开关闭

/**
 *  打开用户交互
 */
+ (void)openInteractionEvents{
    MAINQUEUEUPDATEUI({
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    })
}

/**
 *  关闭用户交互
 */
+ (void)closeInteractionEvents{
    MAINQUEUEUPDATEUI({
        if (![[UIApplication sharedApplication] isIgnoringInteractionEvents])
            [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    })
}

#pragma makr - 日志
/**
 *  将日志写入文件
 */
+ (void)writoLogToFile{
    UIDevice *device =[UIDevice currentDevice];
    if (!([[device model] isEqualToString:@"iPad Simulator"] ||
          [[device model]isEqualToString:@"iPhone Simulator"])) {
        [self redirectNSLogToDocumentFolder];
    }
}

//定义日志文件格式和输出位置
+ (void)redirectNSLogToDocumentFolder{
    NSString *fileName =[NSString stringWithFormat:@"%@.log", [self getCurrentTimeWithFormatter:@"yyyy-MM-dd hh:mm:ss"]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *logFilePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+",stderr);
}

#pragma mark - 沙盒图片文件夹操作

/**
 *  创建文件夹 fileName是文件夹得名称，不是完整的路径
 */
+ (NSString *)createFileAtSandboxWithName:(NSString *)fileName{
    NSString *imageDir = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), fileName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:imageDir isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:imageDir
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
    return imageDir;
}

/**
 *  保存图片文件 filePath 是完整的文件路径(包括文件名和后缀名)
 */
+ (BOOL)saveImageWithPath:(NSString *)filePath ImageData:(UIImage *)image{
    BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    NSLog(@"存之前 --- 这个文件：%@",result?@"存在":@"不存在");
    if (!result) {
        [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
        BOOL result = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        NSLog(@"存之后 --- 这个文件：%@",result?@"存在":@"不存在");
        if (result) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return YES;
    }
}

/**
 *  删除文件夹
 */
+ (void)deleteFileWithPath:(NSString *)deleteFilePath{
    [[NSFileManager defaultManager] removeItemAtPath:deleteFilePath error:nil];
}

/**
 *  获取保存的图片
 */
+ (UIImage *)getImageWithImageFile:(NSString *)imagePath{
    
    //拿到沙盒路径图片
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    return image ? image : nil;
}

/**
 *  根据url和沙盒文件路径获得图片
 */
+ (UIImage *)getImageWithFilePath:(NSString *)filePath
                         FileName:(NSString *)fileName
                         FileType:(NSString *)fileType
                         ImageURL:(NSString *)imageURL{
    
    //如果不存在就创建
    NSString *imageFile = [CustomeClass createFileAtSandboxWithName:filePath];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@.%@", imageFile, fileName, fileType];
    UIImage *tempImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
    if (!tempImage) {
        NSData *downloadData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        tempImage = [UIImage imageWithData:downloadData];
        [CustomeClass saveImageWithPath:imagePath ImageData:tempImage];
    }
    return tempImage;
}

+ (UIImage *)getHomeImageWithFilePath:(NSString *)filePath
                             FileName:(NSString *)fileName
                             FileType:(NSString *)fileType
                             ImageURL:(NSString *)imageURL{
    
    //如果不存在就创建
    NSString *imageFile = [CustomeClass createFileAtSandboxWithName:filePath];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@.%@", imageFile, fileName, fileType];
    UIImage *tempImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
    
//    if (!tempImage) {
////        NSData *downloadData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
////        tempImage = [UIImage imageWithData:downloadData];
////        [CustomeClass saveImageWithPath:imagePath ImageData:tempImage];
//        return nil;
//    }
    return tempImage;
}

/**
 *  根据沙盒文件夹名称和图片url来获取图片（如果本地没有就进行保存）
 */
+ (UIImage *)getGIFImageWithPath:(NSString *)filePath
                        FileName:(NSString *)fileName
                        ImageURL:(NSString *)imageURL{
    NSString *imageFile = [CustomeClass createFileAtSandboxWithName:filePath];
    NSString *imagePath = [NSString stringWithFormat:@"%@/%@", imageFile, fileName];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    UIImage *tempImage = [UIImage sd_animatedGIFWithData:imageData];
    
    if (!tempImage) {
        NSData *downloadData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]];
        tempImage = [UIImage sd_animatedGIFWithData:downloadData];
        [downloadData writeToFile:imagePath atomically:YES];
    }
    return tempImage;
}

#pragma mark - 多线程

/**
 *  后台线程
 */
+ (void)backgroundQueue:(void(^)())backgroundQueueBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        backgroundQueueBlock();
    });
}

/**
 *  后台同步多线程
 */
+ (void)backgroundSyncQueue:(void(^)())backgroundQueueBlock{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        backgroundQueueBlock();
    });
}

/**
 *  后台异步多线程
 */
+ (void)backgroundAsyncQueue:(void(^)())backgroundQueueBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        backgroundQueueBlock();
    });
}

/**
 *  主线程
 */
+ (void)mainQueue:(void(^)())mainQueueBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
        mainQueueBlock();
    });
}

/**
 *  主线程中延时执行
 */
+ (void)afterRunWithTimer:(double)seconds AfterBlock:(void(^)())afterBlock{
    //延时执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        afterBlock();
    });
}

#pragma mark - 随机数

/**
 *  随机数
 */
+ (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + (arc4random() % ((to) - (from) + 1)));
}

#pragma mark - 时间显示
/**
 *  显示几分钟前、几小时前等 str格式：yyyy-MM-dd HH:mm:ss.SSS
 */
+ (NSString *)compareCurrentTime:(NSString *)str{
    
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

#pragma mark - 富文本与string

/**
 *  富文本转html字符串
 */
+ (NSString *)attriToStrWithAttri:(NSAttributedString *)attri{
    NSDictionary *tempDic = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,
                              NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]};
    NSData *htmlData = [attri dataFromRange:NSMakeRange(0, attri.length)
                         documentAttributes:tempDic
                                      error:nil];
    return [[NSString alloc] initWithData:htmlData
                                 encoding:NSUTF8StringEncoding];
}

/**
 *  字符串转富文本
 */
+ (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr{
    return [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding]
                                            options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType}
                                 documentAttributes:nil
                                              error:nil];
}

#pragma mark - plist

/**
 *  存储数据
 */
+ (void)saveDataWithArray:(NSArray *)saveArray PlistName:(NSString *)plistNameStr{
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename = [plistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", plistNameStr]];
    
    //写入
    [saveArray writeToFile:filename atomically:YES];
}

/**
 *  读取数据
 */
+ (NSArray *)readDataWithPlistName:(NSString *)plistName{
    
    //获取应用程序沙盒的Documents目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    
    //得到完整的文件名
    NSString *filename = [plistPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", plistName]];
    return [NSArray arrayWithContentsOfFile:filename];
}

#pragma mark - 字典json转换

/*!
 
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}


/**
 *  字典转json格式字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *parameters = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return parameters;
}

/**
 *  json的data类型转字典
 */
+ (NSDictionary *)jsonDataToDicWithJsonData:(NSData *)jsonData{
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@", jsonString);
    NSDictionary *jsonDic = [CustomeClass dictionaryWithJsonString:jsonString];
    return jsonDic;
}

#pragma mark - 键盘相关

/**
 *  获取键盘高度
 */
+ (CGFloat)getKeyboardHeightWithNoti:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    return keyboardRect.size.height;
}

@end
