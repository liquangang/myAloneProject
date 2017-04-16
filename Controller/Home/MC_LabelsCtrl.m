//
//  MC_Labels.m
//  M-Cut
//
//  Created by Crab00 on 15/11/27.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "MC_LabelsCtrl.h"
#import "VideoDBOperation.h"
#import "MovierDCInterfaceSvc.h"

@implementation MC_LabelsCtrl

+(void)RefreshLabels:(NSMutableArray*)labels{
    for (MovierDCInterfaceSvc_VDCVideoLabelEx *object in labels) {
        if ([[VideoDBOperation Singleton] DB_GetLabelInfo:object.nLabelID]==nil) {
            [[VideoDBOperation Singleton] DB_AddLabel:object.szLabelName labelId:object.nLabelID Parent:object.nParentID Thumbnail:object.szThumbnail Type:object.nType];
        }else{
            [[VideoDBOperation Singleton] DB_ModifyLabel:object.szLabelName labelId:object.nLabelID Parent:object.nParentID Thumbnail:object.szThumbnail Type:object.nType];
        }
    }
}
+(void)DeleteChildLabel:(NSNumber*)parentsID{
//    NSMutableArray* allchilds = [[VideoDBOperation Singleton] DB_GetLabels:parentsID];
//    for (NSDictionary *Item  in allchilds) {
//        [[VideoDBOperation Singleton] DB_DeleteLabel:@([[Item objectForKey:@"labelid"] intValue])];
//    }
}

+(void)GetChildLabe:(NSNumber*)parentsID{
    [[VideoDBOperation Singleton] DB_GetLabels:parentsID];
}

+(NSDictionary*)GetLabelInfo:(NSNumber*)labelid{
    return  [[VideoDBOperation Singleton] DB_GetLabelInfo:labelid];
}

@end
