//
//  ISChooseSourceView.h
//  M-Cut
//
//  Created by 李亚飞 on 15/11/24.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ISChooseSourceViewDelegate <NSObject>

@optional
/**  拍摄视频 */
- (void)takeVideo;
/**  选择照片 */
- (void)choosePhoto;
/**  取消操作 */
- (void)cancle;
@end
@interface ISChooseSourceView : UIView

@property (weak, nonatomic) id<ISChooseSourceViewDelegate> delegate;

+ (instancetype)chooseSourceView;
- (void)show;
- (void)dismiss;
@end
