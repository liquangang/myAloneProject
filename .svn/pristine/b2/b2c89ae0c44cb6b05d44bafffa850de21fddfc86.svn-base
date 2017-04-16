//
//  App_vpVDCOrderForCreate.m
//  M-Cut
//
//  Created by zhangxiaotian on 15/4/18.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "App_vpVDCOrderForCreate.h"

@implementation NewOrderVideoMaterial
-(id)init
{
    self=[super init];
    self.nOrderVideoMaterialID = 0;
    self.szUrl = @"";
    self.nIndex = 0;
    return self;
}
@end

@implementation NewOrderLabelForVideo
-(id)init
{
    self=[super init];
    self.nLabelForVideo = 0;
    self.size = 0;
    return self;
}
@end


@implementation NewNSOrderDetail
@synthesize szCustomerSubtitle;
@synthesize szVideoName;
@synthesize stMaterialArr;
@synthesize stLabelForVideo;

-(id)init
{
    self=[super init];
    self.createTime = @"";
    self.nVideoLength = 0;
    self.nHeaderAndTailID = 0;
    self.nFilterID = 0;
    self.nMusicID = 0;
    self.nMusicStart = 0;
    self.nMusicEnd = 0;
    self.nSubtitleID = 0;
    self.szCustomerSubtitle = @"";
    self.szVideoName = @"";
    self.nShareType = 0;
    self.stMaterialArr = [[NSMutableArray alloc] init];
    self.stLabelForVideo = [[NSMutableArray alloc] init];
    return self;
}

@end


@implementation NewUserOrderList

@synthesize newcutlist;

+ (NewUserOrderList *)Singleton
{
    static NewUserOrderList *Singleton;
    @synchronized(self)
    {
        if (!Singleton)
            Singleton = [[NewUserOrderList alloc] init];
        
        return Singleton;
    }
}

-(id) init
{
    self = [super init];
    self.newcutlist = [[NSMutableArray alloc] init];
    return self;
}

@end

