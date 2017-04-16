//
//  TuwenOBJ.m
//  M-Cut
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "TuwenOBJ.h"
#import "CustomeClass.h"

@implementation TuwenOBJ

/*
 + (PrivateMesObj *)getPrivateMesObjWithDBResult:(FMResultSet *)result{
 PrivateMesObj * priMesObj = [PrivateMesObj new];
 priMesObj.mesStartId = [result stringForColumn:FRIENDMESSTARTUSER];
 priMesObj.mesEndId = [result stringForColumn:FRIENDMESENDUSERID];
 priMesObj.startUserNickName = [result stringForColumn:FRIENDSTARTUSERNICKNAME];
 priMesObj.readStatus = [result stringForColumn:FRIENDMESREADSTATUS];
 priMesObj.mesContent = [result stringForColumn:FRIENDMESCONTENT];
 priMesObj.startUserIconUrl = [result stringForColumn:FRIENDHEADIMAGEURL];
 priMesObj.time = [result stringForColumn:FRIENDMESSTARTTIME];
 return priMesObj;
 }
 */
+ (TuwenOBJ *)getTuwenOBjWithResult:(FMResultSet *)result{
    TuwenOBJ * tuwenObj = [TuwenOBJ new];
    /*
     //是什么类型的cell
     @property (nonatomic, assign) CellType cellType;
     //cell上面的内容
     @property (nonatomic, copy) NSString * cellContent;
     //cell的高度
     @property (nonatomic, assign) CGFloat cellHeight;
     //cell的图片
     @property (nonatomic, strong) UIImage * cellImage;
     //是否显示播放按钮
     @property (nonatomic, assign) BOOL isHiddenPlayButton;
     //图片的url地址
     @property (nonatomic, copy) NSString * cellImageUrl;
     //视频的url地址
     @property (nonatomic, copy) NSString * cellVideoUrl;
     */
    tuwenObj.cellType = (CellType)[[result stringForColumn:shareSourceType] integerValue];
    tuwenObj.cellContent = [CustomeClass strToAttriWithStr:[result stringForColumn:shareContent]];
    tuwenObj.cellHeight = [[result stringForColumn:shareCellHeight] floatValue];
    tuwenObj.cellImageUrl = [result stringForColumn:shareImageUrl];
    tuwenObj.isHiddenPlayButton = [[result stringForColumn:shareIsShowPlayButtonImage] boolValue];
    tuwenObj.cellVideoUrl = [result stringForColumn:shareVideoUrl];
    return tuwenObj;
}
@end
