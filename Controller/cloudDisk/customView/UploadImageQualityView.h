//
//  UploadImageQualityView.h
//  M-Cut
//
//  Created by apple on 16/12/22.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageQualityType){
    normalImage,
    highDefinitionImage,
    originalImage
};

@interface UploadImageQualityView : UIView
@property (nonatomic, copy) void(^selectQualityBlock)(ImageQualityType qualityType);    //用户选中的照片上传质量
@property (nonatomic, copy) void(^nextStepBlock)(ImageQualityType qualityType);     //下一步block
@property (nonatomic, copy) void(^showSelectTableBlock)(BOOL isHidden);    //显示selecttableblock
@property (nonatomic, strong) UILabel *nextLabel;       //显示选中照片的个数和下一步三个字的label
@end
