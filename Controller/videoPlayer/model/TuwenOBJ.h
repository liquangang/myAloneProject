//
//  TuwenOBJ.h
//  M-Cut
//
//  Created by apple on 16/11/1.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "VideoDBOperation.h"

typedef NS_ENUM(NSInteger, CellType){
    imageType,
    textType,
    videoType
};

@interface TuwenOBJ : NSObject
//是什么类型的cell
@property (nonatomic, assign) CellType cellType;
//cell上面的内容
@property (nonatomic, copy) NSAttributedString *cellContent;
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

+ (TuwenOBJ *)getTuwenOBjWithResult:(FMResultSet *)result;
@end
