//
//  GlobalVars.h
//  test9
//
//  Created by 彰笑天 on 14/12/26.
//  Copyright (c) 2014年 zhang. All rights reserved.
//

#ifndef test9_GlobalVars_h
#define test9_GlobalVars_h
#import <sqlite3.h>
#import "StockData.h"
#import "FMDatabaseQueue.h"
#import "SoapOperation.h"

//#define OPENENVIROMENT 1
#define TESTENEVIROMENT 2

#ifdef OPENENVIROMENT
#define shareURL @"http://www.inshowtv.com/play/%@"//#define shareURL @"http://www.inshowtv.com/play.php?videoid=%@"//#define shareURL @"http://115.28.154.117/phproot/inshia/inshian.php?videoid=%@"
#define soapURL @"http://182.92.236.181:8080";//开放环境
#endif

#ifdef TESTENEVIROMENT
#define shareURL @"http://www.inshowtv.com/play/%@"//#define shareURL @"http://www.inshowtv.com/play.php?videoid=%@"//#define shareURL @"http://115.28.154.117/phproot/inshia/inshian.php?videoid=%@"
#define soapURL @"http://43.227.252.179:8080";//测试环境    ///2015年10月22日替换 为43.227.252.179  https://xiebin@115.28.154.117/svn/ACS
#endif

#define SOAPTRYTIME        3

#define MSG_ONEORDER_TRANSFER_OK            @"oneorderfinish"
#define MSG_CUSTOMER_BAC_THREAD_ON          @"personalbacTon"
#define MSG_CUSTOMER_BAC_THREAD_OFF         @"personalbacToff"


extern NSString *_szEndPoint;//oss endpoint字段
extern sqlite3 *contactDB;//数据库文件对象
extern NSString *databasePath;//数据库路径
extern int orderStatus;//订单状态
extern int orderCurrent;//当前订单ID
extern int global;//仅仅标示一个状态
extern NSString *namenick;//昵称
extern NSString *szEmails;//邮箱
extern NSString *szPersonalSignature;//个性签名
extern int dissession;//标记选择云端素材时对应的index
extern NSString *state;//州
extern NSString *city;//市
extern NSString *finish;//仅仅标示一个状态
extern NSString *captionedite;//编辑的字符串
extern StockData *stockForKVO;

//登录平台：0.未知。1.PC设备。2.IOS设备。3.Android设备。4.web网页。
enum PLATFORMVER
{
    TYPE_UNKNOWN = 0,
    TYPE_PC = 1,
    TYPE_IOS = 2,
    TYPE_ANDROID = 3,
    TYPE_WEB = 4,
};

#endif
