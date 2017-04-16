//
//  ISHomeBannerView.h
//  M-Cut
//
//  Created by 李亚飞 on 15/12/10.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>

//@class ScrollViewLoop;
//
//
//@interface ISHomeBannerView : UICollectionReusableView
///**  滚动图 */
//@property (weak, nonatomic) ScrollViewLoop *scrollView;
//
//@end


@class ScrollViewLoop, ISHomeBannerView;


@protocol ISHomeBannerViewDelegate <NSObject>
@optional
/**  banner 搜索事件 */
- (void)homeBannerView:(ISHomeBannerView *)bannerView search:(NSString *)text;

/**  banner 图片点击事件 */
- (void)homeBannerView:(ISHomeBannerView *)bannerView adDetail:(NSURL *)url;
@end

@interface ISHomeBannerView : UICollectionReusableView
/**  滚动图 */
@property (weak, nonatomic) IBOutlet ScrollViewLoop *scrollView;

@property (weak, nonatomic) id<ISHomeBannerViewDelegate> delegate;
@end
