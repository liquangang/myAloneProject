//
//  MC_OrderAndMaterialCtrl.m
//  M-Cut
//
//  Created by Crab00 on 15/11/3.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "MC_OrderAndMaterialCtrl.h"


@implementation MC_OrderAndMaterialCtrl


-(void)GetLastUncommitOrder{
    NewNSOrderDetail *last = [[VideoDBOperation Singleton] SearchLastOrder];
    if (last==nil) {
        return;
    }
    if (last.order_st == READYCOMMITORDER) {
        ;
    }else if (last.order_st == COMMITEDORDER){
        ;
    }else{
        ;
    }
}

//-(void)GetUncommitOrder:(int)orderid{
//    NewNSOrderDetail *last = [[VideoDBOperation Singleton] SearchLastOrder];
//}
+(NSArray*)GetCommitOrder:(int)Userid;{
    NSArray* ret;
    ret = [[NSArray alloc] initWithArray:[[VideoDBOperation Singleton] SearchOrder:Userid withStatus:COMMITEDORDER]];
    return ret;
}

+(NSArray*)GetReadyOrder:(int)Userid{
    NSArray* ret;
    ret = [[NSArray alloc] initWithArray:[[VideoDBOperation Singleton] SearchOrder:Userid withStatus:READYCOMMITORDER]];
    return ret;
}
-(NSArray*)GetUncommitOrder:(int)Userid{
    NSArray* ret;
    ret = [[NSArray alloc] initWithArray:[[VideoDBOperation Singleton] SearchOrder:Userid withStatus:DRAFTORDER]];
    return ret;
}
+(NewNSOrderDetail*)GetTranferOrder:(int)Userid{
    NSArray* ret;
    ret = [[NSArray alloc] initWithArray:[[VideoDBOperation Singleton] SearchOrder:Userid withStatus:NOWTRANSFER]];
    if ([ret count]>0) {
        return (NewNSOrderDetail*)[ret objectAtIndex:0];
    }else
        return nil;
}

+(NSArray*)GetTranferOrders:(int)Userid{
    NSArray* ret;
    ret = [[NSArray alloc] initWithArray:[[VideoDBOperation Singleton] SearchOrder:Userid withStatus:NOWTRANSFER]];
    return ret;
}

-(void)UpdateOssId:(int)Userid Orderid:(int)orderid OSSId:(int)ossid{
    NewNSOrderDetail * it = [[VideoDBOperation Singleton] SearchOrder:orderid];
    [[VideoDBOperation Singleton]UpdateOrder:it.order_id ownerCreateTime:it.createTime Owner:it.customer OrderLength:it.nVideoLength HeadTail:it.nHeaderAndTailID Filter:it.nFilterID Music:it.nMusicID SubTitle:it.nSubtitleID CustomSubtitle:it.szCustomerSubtitle OrderVideoName:it.szVideoName ShareSet:it.nShareType OrderStatus:it.order_st OSSID:ossid];
}

+(void)ChangeOrderStatus:(int)orderid Status:(ORDERSTATUS)setStatus{
    NewNSOrderDetail *oldOrder = [[VideoDBOperation Singleton] SearchOrder:orderid];
    [[VideoDBOperation Singleton] UpdateOrder:oldOrder.order_id ownerCreateTime:oldOrder.createTime Owner:oldOrder.customer OrderLength:oldOrder.nVideoLength HeadTail:oldOrder.nHeaderAndTailID Filter:oldOrder.nHeaderAndTailID Music:oldOrder.nMusicID SubTitle:oldOrder.nSubtitleID CustomSubtitle:oldOrder.szCustomerSubtitle OrderVideoName:oldOrder.szVideoName ShareSet:oldOrder.nShareType OrderStatus:setStatus OSSID:oldOrder.oss_orderid];
}
-(void)ChangeOSSOrderStatus:(int)orderid Status:(int)setStatus{
    NewNSOrderDetail *oldOrder = [[VideoDBOperation Singleton] SearchOSSOrder:orderid];
    if (oldOrder!=nil) {
        [[VideoDBOperation Singleton] UpdateOrder:oldOrder.order_id ownerCreateTime:oldOrder.createTime Owner:oldOrder.customer OrderLength:oldOrder.nVideoLength HeadTail:oldOrder.nHeaderAndTailID Filter:oldOrder.nHeaderAndTailID Music:oldOrder.nMusicID SubTitle:oldOrder.nSubtitleID CustomSubtitle:oldOrder.szCustomerSubtitle OrderVideoName:oldOrder.szVideoName ShareSet:oldOrder.nShareType OrderStatus:setStatus OSSID:oldOrder.oss_orderid];
    }
    
    {//待删除 arbin 2015-11-10
        NewNSOrderDetail *Order = [[VideoDBOperation Singleton] SearchOrder:orderid];
        if (Order!=nil)
        [[VideoDBOperation Singleton] UpdateOrder:Order.order_id ownerCreateTime:Order.createTime Owner:Order.customer OrderLength:Order.nVideoLength HeadTail:Order.nHeaderAndTailID Filter:Order.nHeaderAndTailID Music:Order.nMusicID SubTitle:Order.nSubtitleID CustomSubtitle:Order.szCustomerSubtitle OrderVideoName:Order.szVideoName ShareSet:Order.nShareType OrderStatus:setStatus OSSID:Order.oss_orderid];
    }
}

-(void)AddOrderWithLogin:(NewNSOrderDetail*)in{
    NewNSOrderDetail* exist = [[VideoDBOperation Singleton] SearchOSSOrder:in.oss_orderid];
    if(exist)
        return;
    [[VideoDBOperation Singleton] AddCommitOrder:in.order_id Createtime:in.createTime Owner:in.customer OrderLength:in.nVideoLength HeadTail:in.nHeaderAndTailID Filter:in.nFilterID Music:in.nMusicID SubTitle:in.nSubtitleID CustomSubtitle:in.szCustomerSubtitle OrderVideoName:in.szVideoName ShareSet:in.nShareType OSSID:in.oss_orderid];
}

+(void)Fresh2Uncommit:(int)Userid{
    NSMutableArray *result = [[VideoDBOperation Singleton] SearchAllFreshOrder:Userid];
    if ([result count]>1) {
        NSLog(@"Fresh Order error!");
    }
    for (NewNSOrderDetail *item in result) {
        [[VideoDBOperation Singleton] UpdateOrder:item.order_id ownerCreateTime:item.createTime Owner:item.customer OrderLength:item.nVideoLength HeadTail:item.nHeaderAndTailID Filter:item.nFilterID Music:item.nMusicID SubTitle:item.nSubtitleID CustomSubtitle:item.szCustomerSubtitle OrderVideoName:item.szVideoName ShareSet:item.nShareType OrderStatus:DRAFTORDER OSSID:item.oss_orderid];
    }
}

+(void)AddFreshOrder:(int)Userid{
    [[VideoDBOperation Singleton] AddOrder:[MC_OrderAndMaterialCtrl FormatCreateTime] Owner:Userid OrderLength:0 HeadTail:0 Filter:0 Music:0 SubTitle:0 CustomSubtitle:@"" OrderVideoName:@"" ShareSet:0 OSSID:0];
}
+ (NewNSOrderDetail *)GetFreshOrder:(int)Userid{
    if (Userid == 0) {
        return nil;
    }
    NSMutableArray *fresh = [[VideoDBOperation Singleton] SearchAllFreshOrder:Userid];
    if ([fresh count]==1) {
        return [fresh objectAtIndex:0];
    } else if([fresh count]>1){
        NSLog(@"Userid:%d has more than one fresh order!",Userid);
        return [fresh objectAtIndex:0];
    }else
        return nil;
//    return [fresh objectAtIndex:0];
}

+ (NewNSOrderDetail*)GetDraftOrder:(int)Userid Index:(int)index{
    NSMutableArray *drafts = [[VideoDBOperation Singleton] SearchOrder:Userid withStatus:DRAFTORDER];
    if (index > [drafts count]) {
        return nil;
    }
    NewNSOrderDetail *wantorder = [drafts objectAtIndex:index];
    return wantorder;
}
+ (void)UpdateFresh:(NewNSOrderDetail*)in{
    [[VideoDBOperation Singleton] UpdateOrder:in.order_id ownerCreateTime:in.createTime Owner:in.customer OrderLength:in.nVideoLength HeadTail:in.nHeaderAndTailID Filter:in.nFilterID Music:in.nMusicID SubTitle:in.nSubtitleID CustomSubtitle:in.szCustomerSubtitle OrderVideoName:in.szVideoName ShareSet:in.nShareType OrderStatus:in.order_st OSSID:in.oss_orderid OrderType:in.orderType];
}

+ (void)updateFollowVideoIdWithOrder:(NewNSOrderDetail *)orderDetail{
    [[VideoDBOperation Singleton] UpdateOrder:orderDetail.order_id FollowVideoId:orderDetail.followVideoId];
}

+ (void)CommitOrder:(int)Userid{
    NewNSOrderDetail *fresh = [MC_OrderAndMaterialCtrl GetFreshOrder:Userid];
    [[VideoDBOperation Singleton] UpdateOrder:fresh.order_id ownerCreateTime:fresh.createTime Owner:fresh.customer OrderLength:fresh.nVideoLength HeadTail:fresh.nHeaderAndTailID Filter:fresh.nFilterID Music:fresh.nMusicID SubTitle:fresh.nSubtitleID CustomSubtitle:fresh.szCustomerSubtitle OrderVideoName:fresh.szVideoName ShareSet:fresh.nShareType OrderStatus:READYCOMMITORDER OSSID:fresh.oss_orderid];
}
+ (void)DeleteDraftOrder:(int)Userid Order:(int)orderid{
    NewNSOrderDetail *order = [[VideoDBOperation Singleton] SearchOrder:(int)orderid];
    if (order.customer == Userid&&order.order_st == DRAFTORDER) {
        [MC_OrderAndMaterialCtrl DeleteMaterialsInOrder:Userid Orderid:orderid];
        [[VideoDBOperation Singleton] DeleteOrder:orderid];
    }else{
        NSLog(@"Customer had no right delete draft or DraftBox null");
    }
}

+ (void)DeleteOrder:(int)orderid{
    NewNSOrderDetail *order = [[VideoDBOperation Singleton] SearchOrder:(int)orderid];
    [MC_OrderAndMaterialCtrl DeleteMaterialsInOrder:order.customer Orderid:orderid];
    [[VideoDBOperation Singleton] DeleteOrder:orderid];    
}

+(NSString*)FormatCreateTime{
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
    return [NSString stringWithFormat:@"%04d/%02d/%02d-%02d:%02d:%02d",y,m,d,hour,min,sec];
}

+ (void)MC_AddMaterial:(int)Userid Material:(NewOrderVideoMaterial*)in Orderid:(int)orderid{
    //检索素材是否存在
    NewOrderVideoMaterial *insertitem = [[VideoDBOperation Singleton] DB_SearchMaterail:Userid Asserturl:in.material_assetsURL];
    
    //素材id为0即素材表中不存在这个素材信息
    if(insertitem.nOrderVideoMaterialID == 0)
    {
        [[VideoDBOperation Singleton] DB_AddMaterial:in Owner:Userid];
        insertitem = [[VideoDBOperation Singleton] DB_SearchMaterail:Userid Asserturl:in.material_assetsURL];
    }
    [[VideoDBOperation Singleton] DB_AddMaterialwithOrder:insertitem Order:orderid];
    return;
}

//order by id 的数组
+(NSMutableArray*)GetMaterial:(int)Userid Orderid:(int)orderid{
    NSArray *materials = [[VideoDBOperation Singleton] DB_SearchMaterails:orderid];
    return [[VideoDBOperation Singleton] DB_SearchOrderMaterial:materials];
}
+(NSMutableArray*)GetWSMaterial:(int)Userid Orderid:(int)orderid{
    NSMutableArray* ret = [[NSMutableArray alloc]init];
    NSMutableArray *materials = [MC_OrderAndMaterialCtrl GetMaterial:Userid Orderid:orderid];
    int index = 1;
    for (NewOrderVideoMaterial* it in materials) {
        MovierDCInterfaceSvc_VDCOrderVideoMaterial *item = [[MovierDCInterfaceSvc_VDCOrderVideoMaterial alloc]init];
        item.nOrderVideoMaterialID = @(index);
        item.szUrl = it.material_ossURL;
        item.nIndex = @(index);
        [ret addObject:item];
        index++;
    }
    return  ret;
}
+(BOOL)FindMaterial:(int)Userid Orderid:(int)orderid URL:(NSString*)localpath URLType:(SEARCHTYPE)addresstype{
    NewOrderVideoMaterial *result;
    if (addresstype == USEASSERTS) {
        result = [[VideoDBOperation Singleton] DB_SearchMaterail:Userid Asserturl:localpath];
    }else if(addresstype == USELOCALPATH){
        result = [[VideoDBOperation Singleton] DB_SearchMaterail:Userid LocalURL:localpath];
    }
    if (result.nOrderVideoMaterialID != 0) {
        return TRUE;
    }
    return FALSE;
}

+(float)DeleteMaterialInOrder:(int)Userid Orderid:(int)orderid Index:(int)index{
    float ret = 0.0;
    NSMutableArray* results = [MC_OrderAndMaterialCtrl GetMaterial:Userid Orderid:orderid];
    if (index>=[results count]) {
    }else{
        NewOrderVideoMaterial *deleteitem = [results objectAtIndex:index];
        ret = deleteitem.material_playduration;
//        [[VideoDBOperation Singleton] DB_DeleteMaterial:deleteitem.nOrderVideoMaterialID];
        [[VideoDBOperation Singleton] DB_DeleteMaterialINOrder:deleteitem.nOrderVideoMaterialID];
    }
    return ret;
}

+(BOOL)DeleteMaterialsInOrder:(int)Userid Orderid:(int)orderid{   //返回删除素材的时长
    NSMutableArray* results = [MC_OrderAndMaterialCtrl GetMaterial:Userid Orderid:orderid];
    for (NewOrderVideoMaterial *object in results) {
        [[VideoDBOperation Singleton] DB_DeleteMaterialINOrder:object.nOrderVideoMaterialID];
    }
    return TRUE;
}
-(void)MaterialHasUpload:(NSString*)localpath OSSPath:(NSString*)osspath AddressType:(SEARCHTYPE)addresstype Owner:(int)ownerid{
    NewOrderVideoMaterial *info ;
    if (addresstype == USELOCALPATH) {
        info = [[VideoDBOperation Singleton] DB_SearchMaterail:ownerid LocalURL:localpath];
//        info.material_ossURL = osspath;
//        [[VideoDBOperation Singleton] DB_UpdateMaterial:info Owner:ownerid];
    }else{
        info = [[VideoDBOperation Singleton] DB_SearchMaterail:ownerid Asserturl:localpath];

    }
    
    info.material_ossURL = osspath;
    [[VideoDBOperation Singleton] DB_UpdateMaterial:info Owner:ownerid];

}

/** 更新素材映射表, 在草稿箱保存草稿时使用--(将上个订单的订单素材映射到下一个订单中) */
+(void)updateMaterial:(NSMutableArray *)materials orderId:(int)orderId {
    // 遍历 materials , 得到素材 id
    for (NewOrderVideoMaterial *item in materials) {
        [[VideoDBOperation Singleton] DB_AddMaterialwithOrder:item Order:orderId];
    }
}

+(NSArray*)QueryAllMyOrder:(int)Userid{
    NSMutableArray* ret = [[NSMutableArray alloc] init];
//    ret = [[NSMutableArray alloc] initWithArray:[[VideoDBOperation Singleton] SearchOrder:Userid withStatus:COMMITEDORDER]];
    [ret addObjectsFromArray:[[VideoDBOperation Singleton] SearchOrder:Userid withStatus:NOWTRANSFER]];//上传中的订单
    [ret addObjectsFromArray:[[VideoDBOperation Singleton] SearchOrder:Userid withStatus:READYCOMMITORDER]];//编辑完成准备提交的订单
    [ret addObjectsFromArray:[[VideoDBOperation Singleton] SearchOrder:Userid withStatus:COMMITEDORDER]];//已经提交完成的订单
    return ret;
}
@end
