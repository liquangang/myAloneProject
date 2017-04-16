//
//  MovierTOrder.m
//  M-Cut
//
//  Created by Crab00 on 15/7/30.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "MovierTOrder.h"
#import "MovierUtils.h"

@implementation MovierTOrder

//订单以单例存在
+ (MovierTOrder *)Singleton
{
    static MovierTOrder *Singleton;
    
    @synchronized(self)
    {
        if (!Singleton)
        {
            Singleton = [[MovierTOrder alloc] init];
        }
        return Singleton;
    }
}

-(void)initoss:(NSString*)ossPrefix where2down:(NSString*)downPath
        Bucket:(NSString*)ossbucket secretKey:(NSString*)sk
     accessKey:(NSString*)ak HostId:(NSString*)host
{
    accessKey = ak;
    secretKey = sk;
    strHost = host;
    strBucket = ossbucket;
    ossPath = ossPrefix;
    DownloadPath = downPath;
    self.task = [MovierTranslation Singleton];
    if (!self.task.busyNow) {
        [self.task initOSSwithpara:ossPath where2down:DownloadPath Bucket:strBucket secretKey:secretKey accessKey:accessKey HostId:strHost];
        self.task.updowndelegate = self;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextTOrder:) name:@"orderfinish" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TCancel:) name:@"transfercancel" object:nil];
    
    nowWwanStatus = TRUE;
    
    return;
}

-(void)removeselfobserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(NSString*)CreateOrder{
    int x = arc4random() % 100;
    NSString *strOrderid =[NSString stringWithFormat:@"%@%2d",[MovierUtils stringFromDate:[NSDate date]],x];
    strOrderid = [strOrderid stringByReplacingOccurrencesOfString:@":" withString:@""];
    strOrderid = [strOrderid stringByReplacingOccurrencesOfString:@" " withString:@""];
    strOrderid = [strOrderid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    OrderFiles* neworder = [[OrderFiles alloc]init];
    neworder.orderid = strOrderid;
    neworder.upfiles  = [[NSMutableArray alloc] initWithCapacity:1];
    neworder.downfiles  = [[NSMutableArray alloc] initWithCapacity:1];
    if (!self.Orders) {
        self.Orders = [[NSMutableArray alloc] initWithCapacity:1];
    }
    [self.Orders addObject:neworder];
    

//    self.task.updowndelegate = self;

    return strOrderid;
}



-(void)AddUpFile2Order:(NSString*)orderid filename:(NSString*)file
{
    [[self findOrder:orderid] addUpfile:file];
    return;
}

-(void)AddDownFile2Order:(NSString*)orderid filename:(NSString*)file
{
    [[self findOrder:orderid] addDownfile:file];
    return;
}

-(void)AddOrderFile:(NSString*)orderid upfile:(NSString*)upfile downfile:(NSString*)downloadfile
{
    [self AddUpFile2Order:orderid filename:upfile];
    [self AddDownFile2Order:orderid filename:downloadfile];
    return;
}


-(BOOL)StartOrder:(NSString*)orderid WWANable:(BOOL)Use34
{
    if (_task.busyNow) {
        return true;
    }
    [self.task enable3GTranslation:Use34];
    
    nowWwanStatus = Use34;
    OrderFiles *myorder = [self findOrder:orderid];

    if (myorder !=nil) {
//        NSLog(@"HaHa StartT \"%@\"",orderid);
        [self.task cleanupArray];
        for (NSString* upfile in myorder.upfiles ){
            [self.task addUpFile:upfile];
        }
        for (NSString* downfile in myorder.downfiles) {
            [self.task addDownFile:downfile];
        }
        [self.task TranslateData];
        nowTid = orderid;//标示现在上传的Order
        return true;
    }

    return false;
}

-(void)nextTOrder:(NSNotification*) notification
{
    NSLog(@"orderfinesh post one orderfinsh");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"oneorderfinish" object:nil];
    NSEnumerator *enumerator = [self.Orders objectEnumerator];
    OrderFiles *obj = nil;
    while(obj = [enumerator nextObject]){
        if ([obj.orderid isEqualToString:nowTid]) {
            break;
        }
    }
    obj = [enumerator nextObject];
    if (obj!=nil) {
        [self StartOrder:obj.orderid WWANable:nowWwanStatus];
    }else
        _task.busyNow = false;
    return;
}

-(void)TCancel:(NSNotification*) notification{
    _task.busyNow = false;
    NSLog(@"receive cancel notification");
}

-(OrderFiles*)findOrder:(NSString*)orderid
{
    for (OrderFiles* order in self.Orders){
        if ([order.orderid isEqualToString:orderid]) {
            return order;
        }
    }
    return nil;
}

-(OrderFiles*)GetlastOrder
{
    NSInteger ordersize = [self.Orders count];
    
//    [self.Orders objectAtIndex:ordersize-1];
    
    return (OrderFiles*)[self.Orders objectAtIndex:ordersize-1];
}

-(void)upFileSucess:(NSString *)filename
{
    [self.task nextupFile];
}

-(void)upFileFailed:(NSString *)filename
{
    [self.task reTranslateData];
}

-(void)downFileSucess:(NSString *)filename
{
    //    NSLog(@"%@ had down load!",filename);
}

-(void)upFileProgress:(float)progress
{
    NSLog(@"%f has upload!",progress);
//    float max = self.uploadProgressView.progress;
//    if (max<progress) {
//        [self.uploadProgressView setProgress:progress];
//    }
    
}


@end

@implementation OrderFiles
-(BOOL)addUpfile:(NSString*)file
{
    [self.upfiles addObject:file];
    return true;
}
-(BOOL)addDownfile:(NSString*)file
{
    [self.downfiles addObject:file];
    return true;
}
-(BOOL)removelastupfile
{
    [self.upfiles removeLastObject];
    return false;
}
-(BOOL)removelastdownfile
{
    [self.downfiles removeLastObject];
    return false;
}

@end
