//
//  XMNBottomToolBar.m
//  XMNPhotoPickerFrameworkExample
//
//  Created by XMFraker on 16/1/29.
//  Copyright © 2016年 XMFraker. All rights reserved.
//

#import "XMNBottomBar.h"
#import "XMNAssetModel.h"
#import "XMNPhotoManager.h"
#import "UIView+Animations.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "UserEntity.h"
#import "SelectMaterialArray.h"
#import "App_vpVDCOrderForCreate.h"

@interface XMNBottomBar ()

@property (weak, nonatomic) IBOutlet UIButton *previewButton;
@property (weak, nonatomic) IBOutlet UIView *originView;
@property (weak, nonatomic) IBOutlet UIImageView *originStateImageView;
@property (weak, nonatomic) IBOutlet UILabel *originSizeLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (weak, nonatomic) IBOutlet UIImageView *numberImageView;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLengthLabel;
@property (weak, nonatomic) IBOutlet UIView *timeView;

@property (nonatomic, assign) BOOL selectOriginEnable;
@end

@implementation XMNBottomBar
@synthesize barType = _barType;
@synthesize selectOriginEnable = _selectOriginEnable;
@synthesize totalSize = _totalSize;

#pragma mark - Life Cycle

- (instancetype)initWithBarType:(XMNBottomBarType)barType {
    XMNBottomBar *bottomBar = [[[NSBundle mainBundle] loadNibNamed:@"XMNBottomBar" owner:nil options:nil] firstObject];
    bottomBar ? [bottomBar _setupWithType:barType] : nil;
    return bottomBar;
}

- (void)setTakePhotoButtonHidden:(BOOL)isShow{
    self.cameraBtn.hidden = isShow;
}

- (void)setTimeViewHidden:(BOOL)isHidden{
    self.timeView.hidden = isHidden;
}

- (void)setConfirmButton{
    self.confirmButton.enabled = NO;
    self.numberLabel.text = @"0";
    self.numberLabel.hidden = YES;
    self.numberImageView.hidden = YES;
}

#pragma mark - Methods

- (void)updateBottomBarWithAssets:(NSArray *)assets{
    
//    _totalSize = .0f;
//    
    if (!assets || assets.count == 0) {
        self.originStateImageView.highlighted = NO;
        self.originSizeLabel.textColor = [UIColor lightGrayColor];
        self.originSizeLabel.text = @"原图";
    }else {
        self.originStateImageView.highlighted = self.selectOriginEnable;
    }
//
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(unsigned long)assets.count];
//
    self.numberImageView.hidden = self.numberLabel.hidden = assets.count <= 0;
    self.confirmButton.enabled = assets.count >= 1;
//
    self.previewButton.enabled = assets.count >= 1;
    self.originView.userInteractionEnabled = assets.count >= 1;
//
//    [UIView animationWithLayer:self.numberImageView.layer type:XMNAnimationTypeSmaller];
    
//    __weak typeof(*&self) wSelf = self;
//    [assets enumerateObjectsUsingBlock:^(XMNAssetModel  * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [[XMNPhotoManager sharedManager] getAssetSizeWithAsset:obj.asset completionBlock:^(CGFloat size) {
//            __weak typeof(*&self) self = wSelf;
//            _totalSize += size;
//            if (idx == assets.count - 1) {
//                [self _updateSizeLabel];
//                *stop = YES;
//            }
//        }];
//    }];
    
    [self setTimeWithAssets:assets];
}

/** yes超出180 no没超出180*/
- (void)setTimeWithAssets:(NSArray *)assets{
////    NSMutableArray *materialTimeLengthArray = [NSMutableArray new];
//    NSInteger timeLength = 0;
//    for (XMNAssetModel *assModel in SINGLETON(SelectMaterialArray).selectArray) {
//        if (assModel.type == 0 || assModel.type == XMNAssetTypeLivePhoto) {
////            [materialTimeLengthArray addObject:@"0:03"];
//            timeLength += 3;
//        }else{
////            [materialTimeLengthArray addObject:assModel.timeLength];
//            timeLength += [assModel.timeLength integerValue];
//        }
//    }
    
    NSInteger timeLength = 0;
    for (id tempModel in SINGLETON(SelectMaterialArray).selectArray) {
        if ([tempModel isKindOfClass:[NewOrderVideoMaterial class]]) {
            NewOrderVideoMaterial *tempObj = (NewOrderVideoMaterial *)tempModel;
            timeLength += tempObj.material_playduration;
        }else{
            XMNAssetModel *tempobj = (XMNAssetModel *)tempModel;
            NSString *timeStr = tempobj.timeLength;
            NSArray *tempArray = [timeStr componentsSeparatedByString:@":"];
            timeLength += [tempArray[0] integerValue] + [tempArray[1] integerValue];
            if ([tempArray[0] integerValue] == 0 && [tempArray[1] integerValue] == 0) {
                timeLength += 3;
            }
        }
    }
    
    self.timeLengthLabel.text = [NSString stringWithFormat:@"%lds", (long)timeLength];
    
//    //设置时长
//    int time0 = 0;
//    int time1 = 0;
//    int time2 = 0;
//    for (NSString * timeLength in materialTimeLengthArray) {
//        time1 += [[timeLength componentsSeparatedByString:@":"][0] intValue];
//        time2 += [[timeLength componentsSeparatedByString:@":"][1] intValue];
//        
//        time1 = time2 / 60 + time1;
//        if (time2 / 60 > 0) {
//            time2 = time2%60;
//        }
//        
//        time0 = time1 / 60;
//        if (time1 / 60 > 0) {
//            time1 = time1 % 60;
//        }
//    }
//    if (time0 > 0) {
//        self.timeLengthLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", time0, time1, time2];
//    }else{
//        self.timeLengthLabel.text = [NSString stringWithFormat:@"%02d:%02d", time1, time2];
//    }
//    
//    if (time0 == 0 && time1 == 0 && time2 == 0) {
//        self.timeView.hidden = YES;
//    }else{
//        self.timeView.hidden = NO;
//    }
//
//    if (time1 * 60 + time2 > 180) {
//        
//#pragma mark - 超过180s
//        //超过180s
//    }
}

- (void)setConfirmButtonHidden:(BOOL)hidden{
    self.numberLabel.hidden = hidden;
    self.numberImageView.hidden = hidden;
    self.confirmButton.hidden = hidden;
}

- (void)_setupWithType:(XMNBottomBarType)barType {
    _barType = barType;
    _selectOriginEnable = YES;
    
    self.lineView.hidden = barType == XMNPreviewBottomBar;
    self.backgroundColor = barType == XMNPreviewBottomBar ? [UIColor colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:.7f] : [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0 alpha:1.0f];
    self.lineView.backgroundColor = [UIColor colorWithRed:223/255.0f green:223/255.0f blue:223/255.0f alpha:1.f];
    
    //config previewButton
    self.previewButton.hidden = barType == XMNPreviewBottomBar;
    self.previewButton.hidden = YES;
    self.previewButton.enabled = NO;
    [self.previewButton setTitle:@"预览" forState:UIControlStateNormal];
    [self.previewButton setTitle:@"预览" forState:UIControlStateDisabled];
    [self.previewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.previewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    //config originView
    self.originView.hidden = YES;
    self.originView.userInteractionEnabled = NO;
    self.originView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *originViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_handleOriginViewTap)];
    [self.originView addGestureRecognizer:originViewTap];
    
    self.originStateImageView.highlighted = NO;
    [self.originStateImageView setImage:[UIImage imageNamed:@"bottom_bar_origin_normal"]];
    [self.originStateImageView setHighlightedImage:[UIImage imageNamed:@"bottom_bar_origin_selected"]];
    
    self.originSizeLabel.text = @"原图";
    self.originSizeLabel.textColor = [UIColor lightGrayColor];
    
    //config number
    self.numberImageView.hidden = self.numberLabel.hidden = YES;
    self.numberImageView.image = [UIImage imageNamed:@"bottom_bar_number_background"];
    self.numberLabel.textColor = [UIColor whiteColor];
    
    //config confirmButton
    self.confirmButton.enabled = NO;
    [self.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmButton setTitle:@"确定" forState:UIControlStateDisabled];
    [self.confirmButton setTitleColor:[UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:1.0f] forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:.5f] forState:UIControlStateDisabled];
    [self.confirmButton addTarget:self action:@selector(_handleConfirmAction) forControlEvents:UIControlEventTouchUpInside];
    
    //config camreaButton
    [self.cameraBtn addTarget:self action:@selector(handleTakePhotoButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleTakePhotoButtonAction{
    self.takePhotoBlock ? self.takePhotoBlock() : nil;
}

- (void)_handleConfirmAction {
    self.confirmBlock ? self.confirmBlock() : nil;
}

- (void)_handleOriginViewTap {
    self.selectOriginEnable = !self.selectOriginEnable;
    self.originStateImageView.highlighted = self.selectOriginEnable;
    [self _updateSizeLabel];
}

- (void)_updateSizeLabel {
    if (self.selectOriginEnable) {
        self.originSizeLabel.text = [NSString stringWithFormat:@"原图 (%@)",[self _bytesStringFromDataLength:self.totalSize]];
        self.originSizeLabel.textColor = self.barType == XMNCollectionBottomBar ? [UIColor blackColor] : [UIColor whiteColor];
    }else {
        self.originSizeLabel.text = @"原图";
        self.originSizeLabel.textColor = [UIColor lightGrayColor];
    }
}

#pragma mark - Getters

- (NSString *)_bytesStringFromDataLength:(CGFloat)dataLength {
    NSString *bytes;
    if (dataLength >= 0.1 * (1024 * 1024)) {
        bytes = [NSString stringWithFormat:@"%0.1fM",dataLength/1024/1024.0];
    } else if (dataLength >= 1024) {
        bytes = [NSString stringWithFormat:@"%0.0fK",dataLength/1024.0];
    } else if (dataLength == .0f){
        bytes = @"";
    }else {
        bytes = [NSString stringWithFormat:@"%zdB",dataLength];
    }
    return bytes;
}


@end
