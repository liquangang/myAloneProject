//
//  CustomeClass.h
//  M-Cut
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>

typedef void(^RETURNADDRESSBOOKDATA)(NSDictionary * dataDic);


#define ADDRESSBOOKPERMISSIONS @"addressBookPermissions"
#define ADDRESSBOOKDATA        @"addressbookdata"

static NSString *const noMoreData = @"没有更多数据了";

@interface AddressBookModel : NSObject
CUSTOMEPORPERTY(name);
@property (nonatomic, assign) int recordId;
CUSTOMEPORPERTY(tel);
CUSTOMEPORPERTY(email);
CUSTOMEPORPERTY(inshowName);
CUSTOMEPORPERTY(iconUrl);
CUSTOMEPORPERTY(userId);
CUSTOMEPORPERTY(friendType);
@end



@interface CustomeClass : NSObject
/**
 *  根据传入的格式获取当前时间
 *  格式例子：yyyy-MM-dd HH：mm：ss
 *  @param timeFormatter 需要的时间格式
 */
+ (NSString *)getCurrentTimeWithFormatter:(NSString *)timeFormatter;

/**
 *  展示提示框
 *  message 展示内容 
 *  showTime 展示时间
 */
+ (void)showMessage:(NSString *)message ShowTime:(NSInteger)showTime;

/**
 *  带颜色设置
 */
+ (void)showMessage:(NSString *)message ShowTime:(NSInteger)showTime TextColor:(UIColor *)textColor;

/**
 *  最简版
 */
+ (void)showAlert:(NSString *)message;

/**
 *  二进制转十进制
 *  binary 需要转的二进制字符串
 *@return   转完的十进制字符串
 */
+ (NSString *)toDecimalSystemWithBinarySystem:(NSString *)binary;

/**
 *  十进制转二进制
 *  binary 需要转的十进制字符串
 *@return   转完的二进制字符串
 */
+ (NSString *)toBinarySystemWithDecimalSystem:(NSString *)decimal;

/**
 *@brief  返回当前网络状态
 *@return   网络状态字符串
 */
+ (NSString *)currentInterentStatus;

/**
 *@brief    showhud
 *@param    hudSuperView hud加载的view
 *@param    hudTag hud的tag
 */
+ (void)hudShowWithView:(UIView *)hudSuperView Tag:(NSInteger)hudTag;

/**
 *@brief    hidden hud
 *@param    hudSuperView hud加载的view
 *@param    hudTag hud的tag
 */
+ (void)hudHiddenWithView:(UIView *)hudSuperView Tag:(NSInteger)hudTag;

/**
 *  不带交互开关
 */
+ (void)HUDshow:(UIView *)hudShowView Tag:(NSInteger)hudTag;

/**
 *  不带交互开关
 */
+ (void)HUDhidden:(UIView *)hudShowView Tag:(NSInteger)hudTag;

/**
 *  不需要设置tag
 */
+ (void)HUDshow:(UIView *)superView;

/**
 *  不需要设置tag
 */
+ (void)HUDhidden:(UIView *)superView;

+ (void)HUDShow;

+ (void)HUDHidden;

/**
 *@brief    获取通讯录中的数据
 *@param    dataBlock 带结果的block
 */
+ (void)loadAddressBookDataWithBlock:(RETURNADDRESSBOOKDATA)dataBlock;

/**
 *@brief    根据颜色返回图片
 *@param    color 需要的图片的颜色
 *@param    color 需要的图片的区域
 *@return   根据颜色生成的图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color Rect:(CGRect)myRect;

/**
 *@brief    过滤特殊字符
 *@param    str 需要过滤的字符串
 *@return   过滤完成的字符串
 */
+ (NSString *)filterStringWithStr:(NSString *)str;

/**
 *@brief    读取plist文件(以字典的方式存储数据)
 *@param    fileName plist文件名
 *@return   读到的数据
 */
+ (NSDictionary *)getPlistfileDataWithFileName:(NSString *)fileName;

/**
 *@brief    写入数据到plist（数据用字典存储）
 *@param    fileName plist文件名
 *@param    dataDic  要保存的数据
 */
+ (void)writeToPlistWithFileName:(NSString *)fileName Data:(NSDictionary *)dataDic;

/**
 *@brief    强制旋转屏幕
 *@param    orientation 要旋转到的方向
 */
+ (void)orientationToPortrait:(UIInterfaceOrientation)orientation;

/**
 *@brief    获得系统版本
 */
+ (float)getIOSVersion;

/**
 *@brief    删除沙盒某个文件夹
 *@param    fileName 要删除的文件夹名
 */
+ (void)deleteFileWithFileName:(NSString *)fileName;

/**
 *@brief    获得当前app版本号
 */
+ (NSString *)getAppVersion;

/*****************************************************************
 函数名称：+ (NSString *)md5Str:(NSString *)str;
 函数描述：获得加密的字符串
 输入参数：str：需要加密的字符串
 输出参数：N/A
 返回值： 加密后的字符串
 *****************************************************************/
+ (NSString *)md5Str:(NSString *)str;

/*****************************************************************
 函数描述：保存图片到沙盒
 输入参数：image：需要保存的图片
         imageNameStr：需要保存的图片的名字
 输出参数：N/A
 返回值： N/A
 *****************************************************************/
+ (void)saveImageDocuments:(UIImage *)image ImageName:(NSString *)imageNameStr;

/**
 *  将HTML字符串转化为NSAttributedString富文本字符串
 */
+ (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString;

/**
 *  获得本地资源的视频缩略图
 */
+ (UIImage *)getThumbnailImageWithUrl:(NSString *)videoURL;

/**
 *  保存数据(数据以对象存在)
 */
+ (void)saveDataWithObject:(id)object Key:(NSString *)saveKey;

/**
 *  从沙盒中读取数据
 */
+ (NSDictionary *)readDataWithKey:(NSString *)readKey;

#pragma mark - 归档

/**
 *  归档写入数据到沙盒
 */
+ (void)writeDataToSandboxWithDic:(NSDictionary *)writeDic
                         FilePath:(NSString *)filePath
                              Key:(NSString *)writeKey;

/**
 *  解档
 */
+ (NSDictionary *)readDataWithPath:(NSString *)readDataPath
                               Key:(NSString *)readKey;


#pragma mark - 用户交互打开关闭

/**
 *  打开用户交互
 */
+ (void)openInteractionEvents;

/**
 *  关闭用户交互
 */
+ (void)closeInteractionEvents;

#pragma makr - 日志
/**
 *  将日志写入文件
 */
+ (void)writoLogToFile;

#pragma mark - 图片操作

/**
 *  创建沙盒文件夹
 */
+ (NSString *)createFileAtSandboxWithName:(NSString *)fileName;

/**
 *  保存图片文件
 */
+ (BOOL)saveImageWithPath:(NSString *)filePath ImageData:(UIImage *)image;

/**
 *  删除文件夹
 */
+ (void)deleteFileWithPath:(NSString *)deleteFilePath;

/**
 *  获取保存的图片
 */
+ (UIImage *)getImageWithImageFile:(NSString *)imagePath;

/**
 *  根据沙盒文件夹名称和图片url来获取图片（如果本地没有就进行保存）filePath:文件夹名称 fileName:文件名 imageURL：网络url(gif图专用)
 */
+ (UIImage *)getGIFImageWithPath:(NSString *)filePath
                        FileName:(NSString *)fileName
                        ImageURL:(NSString *)imageURL;

/**
 *  根据url和沙盒文件路径获得图片 filePath:文件夹名称  fileName：文件名称 fileType:文件类型即后缀名 imageURL：文件网络地址
 */
+ (UIImage *)getImageWithFilePath:(NSString *)filePath
                         FileName:(NSString *)fileName
                         FileType:(NSString *)fileType
                         ImageURL:(NSString *)imageURL;

/**
 *  首页专用
 */
+ (UIImage *)getHomeImageWithFilePath:(NSString *)filePath
                             FileName:(NSString *)fileName
                             FileType:(NSString *)fileType
                             ImageURL:(NSString *)imageURL;


#pragma mark - 多线程

/**
 *  后台线程操作
 */
+ (void)backgroundQueue:(void(^)())backgroundQueueBlock;

/**
 *  主线程操作
 */
+ (void)mainQueue:(void(^)())mainQueueBlock;

/**
 *  主线程中延时执行 seconds时延时的秒数
 */
+ (void)afterRunWithTimer:(double)seconds AfterBlock:(void(^)())afterBlock;

/**
 *  后台同步多线程
 */
+ (void)backgroundSyncQueue:(void(^)())backgroundQueueBlock;

/**
 *  后台异步多线程
 */
+ (void)backgroundAsyncQueue:(void(^)())backgroundQueueBlock;

#pragma mark - 随机数
/**
 *  随机数
 */
+ (int)getRandomNumber:(int)from to:(int)to;

#pragma mark - 时间显示
/**
 *  显示几分钟前、几小时前等 str格式：yyyy-MM-dd HH:mm:ss.SSS
 */
+ (NSString *)compareCurrentTime:(NSString *)str;

#pragma mark - 富文本转string

/**
 *@brief    富文本转string
 *@param    attri 需要转换的富文本
 *@return   转换完成的数据
 */
+ (NSString *)attriToStrWithAttri:(NSAttributedString *)attri;

/**
 *@brief    字符串转富文本
 *@param    htmlStr 需要转换的字符串
 *@return   转换完成的数据
 */
+ (NSAttributedString *)strToAttriWithStr:(NSString *)htmlStr;

#pragma mark - plist

/**
 *@brief    存储数据
 *@param    saveArray 需要保存的数据
 *@param    plistNameStr plist文件名
 */
+ (void)saveDataWithArray:(NSArray *)saveArray PlistName:(NSString *)plistNameStr;

/**
 *@brief    读取数据
 *@param    plistNameStr plist文件名
 *@return   查询出来的数据
 */
+ (NSArray *)readDataWithPlistName:(NSString *)plistName;

#pragma mark - 字典json转换

/*!
 
 * @brief 把格式化的JSON格式的字符串转换成字典
 
 * @param jsonString JSON格式的字符串
 
 * @return 返回字典
 
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


/**
 *  字典转json格式字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 *  json的data类型转字典
 */
+ (NSDictionary *)jsonDataToDicWithJsonData:(NSData *)jsonData;


#pragma mark - 键盘相关

/**
 *  获取键盘高度
 */
+ (CGFloat)getKeyboardHeightWithNoti:(NSNotification *)noti;
@end
