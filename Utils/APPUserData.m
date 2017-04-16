//
//  APPUserData.m
//  M-Cut
//
//  Created by apple on 16/6/28.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "APPUserData.h"

//如果没有生成过，就生成一次
#define GETFIRSTOBJ if (![[NSUserDefaults standardUserDefaults] objectForKey:appUserDataObjStr]) {[APPUserData getFirstUserData];}
#define GETDEFAULTOBJ [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:appUserDataObjStr]];
//保存操作
#define SAVEOPERATION(SAVEOBJ) [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:SAVEOBJ] forKey:appUserDataObjStr];

static NSString * appUserDataObjStr = @"APPUSERSETINFO";
static NSString * appUserDataMobileDataStatus = @"isOpenMobileData";

@implementation APPUserData
- (void)encodeWithCoder:(NSCoder *)aCoder{
    //添加所有属性，后需添加时在这添加
    [aCoder encodeObject:@(self.isOpenMobileData) forKey:appUserDataMobileDataStatus];
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        //初始化所有属性，后需添加时在这添加
        self.isOpenMobileData = [[aDecoder decodeObjectForKey:appUserDataMobileDataStatus] boolValue];
    }
    return self;
}

/** 如果不存在，就初始化一下*/
+ (void)getFirstUserData{
    APPUserData * myUserData = [APPUserData new];
    //初始化该属性，因为默认是打开的
    myUserData.isOpenMobileData = YES;
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:myUserData] forKey:appUserDataObjStr];
}

//读操作(获得用户设置的流量条件下是否允许传输数据)
+ (BOOL)getUserSetInfo{
    //如果不存在，就将所有的属性设置一个默认值
    if (![[NSUserDefaults standardUserDefaults] objectForKey:appUserDataObjStr]) {
        [APPUserData getFirstUserData];
    }
    APPUserData * myUserData = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:appUserDataObjStr]];
    return myUserData.isOpenMobileData;
}

//写操作(将用户选择的设置内容进行持久化)
+ (void)writeUserInfoWithMobileStatus:(BOOL)isOpen{
    APPUserData * myUserData = [APPUserData new];
    myUserData.isOpenMobileData = isOpen;
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:myUserData] forKey:appUserDataObjStr];
}
@end
