//
//  MC_Labels.h
//  M-Cut
//
//  Created by Crab00 on 15/11/27.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoLabelEx : NSObject {
    /* elements */
    NSNumber * nLabelID;
    NSString * szLabelName;
    NSNumber * nParentID;
    NSString * szThumbnail;
    NSNumber * nType;
    /* attributes */
}
@end

@interface MC_LabelsCtrl : NSObject


+(void)RefreshLabels:(NSMutableArray*)labels; //MovierDCInterfaceSvc_VDCVideoLabelEx  Array
+(void)GetChildLabe:(NSNumber*)parentsID;
+(NSDictionary*)GetLabelInfo:(NSNumber*)labelid;
+(void)DeleteChildLabel:(NSNumber*)parentsID;

@end
