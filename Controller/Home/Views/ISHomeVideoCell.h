//
//  ISHomeVideoCell.h
//  INSHOW
//
//  Created by 李亚飞 on 15/11/13.
//  Copyright © 2015年 李亚飞. All rights reserved.
//

#import <UIKit/UIKit.h>

// cell 之间的间距
#define ISHomeCellMargin 4
// cell 显示的列数
#define ISHomeCellColumn 2
// cell 的宽度
#define ISHomeCellWidth (ISScreen_Width - ISHomeCellMargin * (ISHomeCellColumn + 1)) * 0.5
// cell 的宽高比
#define ISHomeCellRatio (457 / 363.0)
// 顶部视图的高度
#define ISHomeTopViewRatio (372.0 / 740.0)
#define ISHomeTopViewRatioWhenSearchBarHidden (288.0 / 740.0)
#define ISHomeTopViewHeight ((ISScreen_Width - 2 * ISHomeCellMargin) * ISHomeTopViewRatio)
#define ISHomeTopViewHeightWhenSearchBarHidden ((ISScreen_Width - 2 * ISHomeCellMargin) * ISHomeTopViewRatioWhenSearchBarHidden)
@class VideoInformationObject, Video;

@interface ISHomeVideoCell : UICollectionViewCell
/**  视频数据模型 */
@property (strong, nonatomic) VideoInformationObject *video;

/**  更新视频的播放数 */
- (void)updateWithVideo:(Video *)video;

- (void)setVideo:(VideoInformationObject *)video;
@end
