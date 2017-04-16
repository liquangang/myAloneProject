//
//  ISStyleDetailCell.h
//  M-Cut
//
//  Created by 李亚飞 on 15/11/26.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>


#pragma mark ----- ISStyleDetail 数据模型
// 风格数据模型
@interface ISStyleDetail : NSObject
/**  ID     --- nID */
@property (strong, nonatomic) NSNumber *nID;
/**  热度    --- nHotIndex */
//@property (strong, nonatomic) NSNumber *nHotIndex;
/**  头尾样式 --- nHeaderAndTailStyle */
@property (strong, nonatomic) NSNumber *nHeaderAndTailStyle;
/**  风格视频 url --- szReference */
@property (copy, nonatomic) NSString *videoUrl;
/**  模板标题 --- szName */
@property (copy, nonatomic) NSString *title;
/**  查看次数 --- nHotIndex?? */
@property (strong, nonatomic) NSNumber *visitCount;
/**  缩略图   --- szThumbnail */
@property (copy, nonatomic) NSString *thumbnail;
/**  简介    ---- szDesc */
@property (copy, nonatomic) NSString *intro;
/**  应用场景 ---- szFit */
@property (copy, nonatomic) NSString *sence;
/**  创建时间 */
@property (copy, nonatomic) NSString *szCreateTime;

#pragma mark --- 标记变量
/**  模板是否被选中 */
@property (assign, nonatomic)  BOOL isSelected;

@end


#pragma mark ----- ISStyleDetail 尺寸模型
@interface ISStyleDetailFrame : NSObject
@property (strong, nonatomic) ISStyleDetail *styleDetail;

/**  图标 */
@property (assign, nonatomic, readonly) CGRect iconF;
/**  标题 */
@property (assign, nonatomic, readonly) CGRect titleF;
/**  查看次数 */
@property (assign, nonatomic, readonly) CGRect visitF;
/**  选择按钮 */
@property (assign, nonatomic, readonly) CGRect chooseF;
/**  "选择此模板" 文字 */
@property (assign, nonatomic, readonly) CGRect chooseTextF;
/**  缩略图 */
@property (assign, nonatomic, readonly) CGRect thumbF;
/**  播放按钮 */
@property (assign, nonatomic, readonly) CGRect playButtonF;
/**  简介 */
@property (assign, nonatomic, readonly) CGRect introF;
/**  应用场景 */
@property (assign, nonatomic, readonly) CGRect senceF;
/**  分割线 */
@property (assign, nonatomic, readonly) CGRect lineF;
/**  cell 高度 */
@property (assign, nonatomic, readonly) CGFloat cellH;

@end


#pragma mark ----- ISStyleDetailCell
@class ISStyleDetailCell;
@protocol ISStyleDetailCellDelegate <NSObject>
@optional
/**  点击选择模板按钮 */
- (void)styleCell:(ISStyleDetailCell *)styleCell didClickChooseButton:(UIButton *)chooseButton;
/**  当前的模板视频是否正在播放 */
- (void)styleCell:(ISStyleDetailCell *)styleCell isPlaying:(BOOL)isPlaying;
@end

@interface ISStyleDetailCell : UITableViewCell
/**  尺寸模型 */
@property (strong, nonatomic) ISStyleDetailFrame *styleF;
/**  点击选择模板的代理 */
@property (weak, nonatomic)  id<ISStyleDetailCellDelegate> delegate;
/**  记录当前 cell 的模板视频是否正在播放 */
@property (assign, nonatomic) BOOL isPlaying;

+ (instancetype)cellWithTableView:(UITableView *)tableView  andIndex:(NSIndexPath *)index;

/**  取消当前选中的模板 */
- (void)deselectCurrentTemplate:(ISStyleDetailCell *)cell;

/**  取消当前的模板的视频播放 */
- (void)cancleCurrentTemplatePlaying:(ISStyleDetailCell *)cell;
@end






