//
//  ISHomeBannerCell.h
//  INSHOW
//
//  Created by 李亚飞 on 15/11/16.
//  Copyright © 2015年 李亚飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ISHomeBannerCell, ScrollViewLoop;

@protocol ISHomeBannerCellDelegate <NSObject>
@optional
/**  banner 搜索事件 */
- (void)homeBannerCell:(ISHomeBannerCell *)bannerCell search:(NSString *)text;

/**  banner 图片点击事件 */
- (void)homeBannerCell:(ISHomeBannerCell *)bannerCell adDetail:(NSURL *)url;
@end

@interface ISHomeBannerCell : UICollectionViewCell
/**  广告框, 需要设置 ScrollViewLoop 的代理为控制器, 否则需要设置两层代理 */
@property (weak, nonatomic) IBOutlet ScrollViewLoop *scrollView;

@property (weak, nonatomic) id<ISHomeBannerCellDelegate> delegate;
@end
