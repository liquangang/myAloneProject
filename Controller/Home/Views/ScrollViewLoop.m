//
//  ScrollViewLoop.m
//
//
//  Created by 李亚飞 on 15/11/18.
//  Copyright © 2015年 李亚飞. All rights reserved.
//


#import "ScrollViewLoop.h"
#import "UIImageView+WebCache.h"

static CGFloat margin = 4;

// 自定义的 scrollView 的比例
#define ISScrollViewRatio   (286.0 / 735.0)
#define ISScrollViewHeight  ((ISScreen_Width - 2 * margin) * ISScrollViewRatio)
#define ISScrollViewWidth   (ISScreen_Width - margin * 2)

@interface ScrollViewLoop()<UIScrollViewDelegate>

/**  广告滚动视图 */
@property (nonatomic, strong) UIScrollView *scrollView;

/**   显示广告信息的label  */
@property (nonatomic, retain) UILabel *adMessageLabel;

/**   图片文件名  */
@property (nonatomic, retain) NSMutableArray *adInfoArray;

/**  广告个数  */
@property (nonatomic, assign) NSInteger adCount;

/**  imageViewArray数组里面存储了三个UIImageView对象 */
@property (nonatomic, strong) NSMutableArray *imageViewArray;

/**  当前选中图片的索引 */
@property (nonatomic, assign) NSInteger currentIndex;

/**  定时器 */
@property (nonatomic, strong) NSTimer *timer;

/**  pageControl */
@property (nonatomic, strong) UIPageControl *pageControl;
@end

@implementation ScrollViewLoop

- (NSMutableArray *)imageViewArray {
    if (!_imageViewArray) {
        self.imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}

// 从 xib 中加载, 初始化的视图在初始化图片数组时  setAds:  创建
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

// 用代码加载, 初始化的视图在初始化图片数组时  setAds:  创建
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andAdInfo:(NSMutableArray*)adInfoArray {
    self = [super initWithFrame:frame];
    if (self) {
        //         给adInfoArray属性赋值
        self.adInfoArray = adInfoArray;
        self.adCount = self.adInfoArray.count;
        
        [self setupScrollView];
        [self setupImageViews];
        [self setupPageControlWithCount:adInfoArray.count];
        [self setImageviewFrameWithCurrentAdIndex:0];
    }
    return self;
}

- (void)setAds:(NSMutableArray *)ads {
    _ads = ads;
    
    // 初始化操作
    self.adInfoArray = ads;
    self.adCount = ads.count;
    [self setupScrollView];
    [self setupImageViews];
    [self setupPageControlWithCount:ads.count];
    [self setImageviewFrameWithCurrentAdIndex:0];
}

- (void)updateAds:(NSMutableArray *)ads {
    self.adInfoArray = ads;
}

- (void)setNeedsAutoPlay:(BOOL)needsAutoPlay {
    _needsAutoPlay = needsAutoPlay;
    if (needsAutoPlay == NO) {
        return;
    }
    // 添加定时器
    [self addTimer];
}

- (void)addTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

- (void)removeTimer {
    [self.timer invalidate];
}

- (void)nextPage {
    NSInteger index = self.currentIndex + 2;
    [self setPageWithIndex:index];
}

/**  创建 scrollView */
- (void)setupScrollView {
    // 1. 创建 scrollView
    CGRect frame = CGRectMake(0, margin, ISScrollViewWidth, ISScrollViewHeight);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    // 设置contentSize属性
    //    scrollView.contentSize = CGSizeMake((self.adCount+2) * self.bounds.size.width, self.bounds.size.height);
    scrollView.contentSize = CGSizeMake((self.adCount+2) * ISScrollViewWidth, 0);
    //    scrollView.contentSize = CGSizeMake(0.5 * ISScrollViewWidth, 0);
    // 刚初始化时，为了让第一张图片显示，所以需要设置contentOffset属性
    // 4.png  1.png   2.png  3.png  4.png  1.png
    //    scrollView.contentOffset = CGPointMake(self.bounds.size.width, 0);
    scrollView.contentOffset = CGPointMake(ISScrollViewWidth, 0);
    // 设置分页
    scrollView.pagingEnabled = YES;
    // 设置代理
    scrollView.delegate = self;
    // 为了测试先给_scrollView设置一下背景颜色
//    scrollView.backgroundColor = [UIColor orangeColor];
    
    // 设置 scrollView 滚动条不显示
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewClick:)];
    [scrollView addGestureRecognizer:tap];
    
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

- (void)scrollViewClick:(UITapGestureRecognizer *)tap {
    // 点击事件由代理响应 或者注册一个 NSNotificationCenter 来监听点击事件, 避免使用代理进行多级传递
#pragma mark ---    通知 方法
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    info[ScrollViewLoopIndex] = @(self.currentIndex);
    [[NSNotificationCenter defaultCenter] postNotificationName:ScrollViewLoopClickNotification object:nil userInfo:info];
    
#pragma mark ---    代理 方法
    if ([self.delegate respondsToSelector:@selector(scrollView:clickAdAtIndex:)]) {
        [self.delegate scrollView:self clickAdAtIndex:self.currentIndex];
    }
}

/**  创建3个 imageView */
- (void)setupImageViews {
    for (int i = 0; i < 3; i++) {
        CGRect frame = CGRectMake(0, 0, ISScrollViewWidth, ISScrollViewHeight);
        // self.bounds只是为了给imageView设置宽和高，x，和y我们暂时不需要关心,暂时也不需要给它赋image属性
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        
        imageView.contentMode = UIViewContentModeScaleToFill;
        // 将imageView添加到数组里面
        imageView.userInteractionEnabled = YES;
        
        [self.imageViewArray addObject:imageView];
        [self.scrollView addSubview:imageView];
    }
}

- (void)setupPageControlWithCount:(NSInteger)count {
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    CGFloat x = 158.0 / 375 * ISScreen_Width;
    CGFloat w = ISScreen_Width - 2 * x;
    CGFloat h = 37;
    CGFloat y = ISScrollViewHeight - h;
    pageControl.frame = CGRectMake(x, y, w, h);
    
    pageControl.numberOfPages = count;
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

/**  创建广告信息 label */
- (void)setupAdLabels {
    UILabel *adMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.bounds.size.width-200)/2, 400, 200, 40)];
    adMessageLabel.textAlignment = NSTextAlignmentCenter;
    adMessageLabel.backgroundColor = [UIColor yellowColor];
    [self addSubview:adMessageLabel];
    self.adMessageLabel = adMessageLabel;
}

#pragma mark --通过索引整体改变三个UIImageView对象的frame
- (void)setImageviewFrameWithCurrentAdIndex:(NSInteger)index {
    //    计算位置的方法
    //    index = 0   3(0 + 4 - 1) % 4   0  1
    //    index = 1   0   1   2
    //    index = 2   1   2   3
    //    index = 3   2   3   0
    
    //    NSInteger startIndex = (index + self.adCount - 1) % self.adCount;
    //    NSInteger endIndex = (index + 1) % self.adCount;
    
    self.currentIndex = index;
    self.pageControl.currentPage = index;
//    NSLog(@"-----%ld------%ld-----%ld", self.currentIndex, self.pageControl.currentPage, index);
    
    for (int i = 0; i < self.imageViewArray.count; i++) {
        // 索引
        NSInteger imageIndex = (index + self.adCount - 1 + i) % self.adCount;
        // 获取数据名称
#pragma mark ----- 如果ads\adInfoArray 中存放的不是图片名, 在此处修改
        NSString *name = self.adInfoArray[imageIndex];
//        UIImage *image = [UIImage imageNamed:name];
        // 根据索引获取数组里面UIImageView
        UIImageView *imageView = (UIImageView *)self.imageViewArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:name] placeholderImage:[UIImage imageNamed:@"BG"] options:SDWebImageRetryFailed | SDWebImageRefreshCached];
        // 设置image属性
//        imageView.image = image;
//        CGFloat offset = ISScreen_Width - ISScrollViewWidth + margin * 2.5;
        imageView.frame = CGRectMake((index + i) * ISScrollViewWidth , 0, ISScrollViewWidth, ISScrollViewHeight);
    }
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.needsAutoPlay == YES) {
        [self removeTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.needsAutoPlay == YES) {
        [self addTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / ISScrollViewWidth;
    [self setImageWithIndex:index];
}

/**  设置页码 */
- (void)setPageWithIndex:(NSInteger)index {
    [self setImageWithIndex:index];
}

- (void)setImageWithIndex:(NSInteger)index {
    if (index == 0 || index == self.adCount + 1) {
        if (index == 0) {
            index = self.adCount;
        }else{
            index = 1;
        }
    }
    self.scrollView.contentOffset = CGPointMake(index * ISScrollViewWidth, 0);
    [self setImageviewFrameWithCurrentAdIndex:index - 1];
}

@end
