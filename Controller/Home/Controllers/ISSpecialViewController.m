//
//  ISSpecialViewController.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/30.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISSpecialViewController.h"
#import "ISSpecialFlowLayout.h"
#import "ISHomeVideoCell.h"
#import "ISLabel.h"
#import "GlobalVars.h"
#import "APPUserPrefs.h"
#import "MJRefresh.h"
#import "ISSpecialTopCell.h"
#import "VideoInformationObject.h"
#import "HomeVideoDetailViewController.h"
#import "MovierUtils.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "ISCutProViewController.h"
#import "ISStyleDetailCell.h"
#import "VideoShowViewController.h"

// 瀑布流
#import <LIWaterflowLayout/LIWaterflowLayout.h>
#import "ISSpecialHeaderView.h"

// cell 之间的间距
#define ISSpecoalCellMargin 4
// cell 显示的列数
#define ISSpecoalCellColumn 2
// cell 的宽度
#define ISSpecoalCellWidth (ISScreen_Width - ISSpecoalCellMargin * (ISSpecoalCellColumn + 1)) * 0.5
// cell 的宽高比
#define ISSpecoalCellRatio (457 / 363.0)
// 顶部视图的高度
#define ISSpecoalTopViewRatio (372.0 / 740.0)
#define ISSpecoalTopViewRatioWhenSearchBarHidden (288.0 / 740.0)
#define ISSpecoalTopViewHeight ((ISScreen_Width - 2 * ISSpecoalCellMargin) * ISSpecoalTopViewRatio)
#define ISSpecoalTopViewHeightWhenSearchBarHidden ((ISScreen_Width - 2 * ISSpecoalCellMargin) * ISSpecoalTopViewRatioWhenSearchBarHidden)


@interface ISSpecialViewController () <UICollectionViewDataSource, UICollectionViewDelegate, LIWaterflowLayoutDelegate>
/**  存放视频的数据模型 */
@property (strong, nonatomic)  NSMutableArray *videoInfos;
/**  collectionview 视图 */
@property (weak, nonatomic)  UICollectionView *collectionView;
/**  记录 cell 开始加载的位置 */
@property (assign, nonatomic)  int numberOfArra;
/**  第一个 cell */
@property (strong, nonatomic) ISSpecialTopCell *specialCell;

/**  存放 label 信息的, 第一个 cell */
@property (strong, nonatomic)  NSMutableArray *labelInfos;

/**  提示 view */
@property (weak, nonatomic) UIView *msgView;

@property(nonatomic,retain) MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *videoStyle;//存放活动模板
@end

@implementation ISSpecialViewController
/**  cell 重用标示 --- 使用一级界面的 cell */
static NSString *home_cell = @"home_cell";
static NSString *specialHeaderView = @"specialHeaderView";

- (NSMutableArray *)videoInfos {
    if (!_videoInfos) {
        self.videoInfos = [NSMutableArray array];
    }
    return _videoInfos;
}

- (NSMutableArray *)labelInfos {
    if (!_labelInfos) {     // 初始化时添加 数据模型
        ISLabelFrame *labelF = [[ISLabelFrame alloc] init];
        labelF.label = self.label;
        self.labelInfos = [NSMutableArray arrayWithObject:labelF];
    }
    return _labelInfos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    [self setupCollectionView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshReDo];
}

/**  设置导航信息 */
- (void)setupNavigation {
    // 标题
    UILabel *label = [[UILabel alloc] init];
    label.text = self.label.szLabelName;
    label.font = ISFont_17;
    CGSize labelSize = [label.text sizeWithWidth:MAXFLOAT font:ISFont_17];
    label.textColor = ISRGBColor(255, 255, 255);
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.titleView = label;
    
    // 左侧按钮
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 30, 30);
    [leftBarButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [leftBarButton addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = CGRectMake(0, 0, 50, 30);
    [rightBarButton setTitle:@"参加" forState:UIControlStateNormal];
    [rightBarButton setTitleColor:[UIColor colorWithRed:1.0 green:78.0/255.0 blue:77.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [rightBarButton addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    self.navigationItem.rightBarButtonItem.customView.hidden=YES;
}

-(void)refreshReDo{
    [[SoapOperation Singleton] WS_GetStylebyLabelId:self.label.nLabelID Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailExC *style) {
        self.videoStyle = style;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.rightBarButtonItem.enabled = TRUE;
            self.navigationItem.rightBarButtonItem.customView.hidden=NO;
        });
    } Fail:^(NSError *error) {
        self.videoStyle = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.rightBarButtonItem.enabled = FALSE;
            self.navigationItem.rightBarButtonItem.customView.hidden=YES;
        });
    }];
}

- (void)leftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBarButtonClick{
    if (![[UserEntity sharedSingleton] isAppHasLogin]) {
        [UIWindow showMessage:@"用户未登录" withTime:3.0];
        return;
    }
    //照做，video已获得headandtailid
    //正在制作订单的素材数量为空  或 不为空
    int customer = [[UserEntity sharedSingleton].customerId intValue];
    NewNSOrderDetail *freshOrder = [MC_OrderAndMaterialCtrl GetFreshOrder:customer];
    NSMutableArray *materials = [MC_OrderAndMaterialCtrl GetMaterial:customer Orderid:freshOrder.order_id];
    if ([materials count]>0) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否使用原有素材？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        myAlertView.tag = 10;
        [myAlertView show];
    }else{
        [self presentCreatePage];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 10) {
        if (buttonIndex != 0) {
            NewNSOrderDetail *fresh = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
            fresh.nVideoLength =0.0;
            [MC_OrderAndMaterialCtrl UpdateFresh:fresh];
            [MC_OrderAndMaterialCtrl DeleteMaterialsInOrder:[[UserEntity sharedSingleton].customerId intValue] Orderid:fresh.order_id];
        }
        //跳转制作页面
        [self presentCreatePage];
    }
}

//跳转制作页面
-(void)presentCreatePage{
    
    //数据库订单数据填充
    NewNSOrderDetail *fresh = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    fresh.nHeaderAndTailID = [self.videoStyle.nID intValue];
    [MC_OrderAndMaterialCtrl UpdateFresh:fresh];
    
    ISCutProViewController *cut = [[UIStoryboard storyboardWithName:@"Preview" bundle:nil] instantiateViewControllerWithIdentifier:@"ISCutProRechoose_ID"];
    cut.isTransFromPreview = YES;//使用返回键
    cut.next2Preview = YES;//下一步直接跳转preview界面
    ISStyleDetail *style = [[ISStyleDetail alloc] init];
    style.nID = self.videoStyle.nID;
    style.nHeaderAndTailStyle = self.videoStyle.nHeaderAndTailStyle;
    style.videoUrl = self.videoStyle.szReference;
    style.title = self.videoStyle.szName;
    style.visitCount = self.videoStyle.nHotIndex;
    style.thumbnail = self.videoStyle.szThumbnail;
    style.intro = self.videoStyle.szDesc;
    style.sence = self.videoStyle.szFit;
    style.szCreateTime = self.videoStyle.szCreateTime;
    cut.styleDetail = style;

    [cut setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:cut animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupCollectionView {
    LIWaterflowLayout *layout = [[LIWaterflowLayout alloc] init];
    layout.addItemByOrder = YES;
    layout.columnsCount = ISSpecoalCellColumn;
    layout.columnMargin = ISSpecoalCellMargin;
    layout.rowMargin    = ISSpecoalCellMargin;
    // 设置 cell 的边距
    layout.itemEdgeInset = UIEdgeInsetsMake(ISSpecoalCellMargin, ISSpecoalCellMargin, ISSpecoalCellMargin, ISSpecoalCellMargin);
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,  ISScreen_Width, ISScreen_Height - ISTabBarHeight * 2) collectionViewLayout:layout];
    
    [collectionView registerNib:[UINib nibWithNibName:@"ISHomeVideoCell" bundle:nil] forCellWithReuseIdentifier:home_cell];
    [collectionView registerClass:[ISSpecialHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:specialHeaderView];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = ISBackgroundColor;
    collectionView.alwaysBounceVertical = YES;
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 下拉刷新
    [collectionView addHeaderWithTarget:self action:@selector(addHeader)];
    // 上拉加载
    [collectionView addFooterWithTarget:self action:@selector(addFooter)];
    
    // 加载二级界面
    [self addHeader];
}

#pragma mark ----- UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 第一个 cell 加载特殊 cell
    return self.videoInfos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ISHomeVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:home_cell forIndexPath:indexPath];
    cell.video = self.videoInfos[indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    ISSpecialHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:specialHeaderView forIndexPath:indexPath];
    header.labelF = self.labelInfos[0];
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoInformationObject *video = self.videoInfos[indexPath.item];
    [[Video Singleton] setContent:video];
    HomeVideoDetailViewController *detail = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MovieDetailPreviewStoryboardID1"];
    VideoShowViewController * detailViewC = [VideoShowViewController new];
    [self.navigationController pushViewController:detailViewC animated:YES];
}

#pragma mark --- 上下拉刷新
- (void)addHeader {     // 根据 label 请求 video 数据
    [self requestFromServerWithLableID:self.label.nLabelID start:@(0) count:@(10)];
}

- (void)requestFromServerWithLableID:(NSNumber *)lableID start:(NSNumber *)start count:(NSNumber *)count {
    SoapOperation *soap = [SoapOperation Singleton];
    [soap WS_GetVideosbyLabel:nil Label:self.label.nLabelID Start:start Count:count Success:^(MovierDCInterfaceSvc_VDCVideoInfoExArray *array) {
        if ([start intValue] == 0) {
            [self.videoInfos removeAllObjects];
        }
        for (NSInteger i = 0; i < array.item.count; i++) {
            MovierDCInterfaceSvc_VDCVideoInfoEx *videoInfoEx = array.item[i];
            VideoInformationObject *videoInfo = [[VideoInformationObject alloc] init];
            videoInfo.videoID = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoID];
            videoInfo.videoName = videoInfoEx.szVideoName;
            videoInfo.ownerID = [NSString stringWithFormat:@"%@", videoInfoEx.nOwnerID];
            videoInfo.ownerName = videoInfoEx.szOwnerName;
            videoInfo.ownerAcatar = videoInfoEx.szAcatar;
            videoInfo.videoLabelName = videoInfoEx.szVideoLabel;
            videoInfo.videoCreateTime = videoInfoEx.szCreateTime;
            videoInfo.videoThumbnailUrl = [videoInfoEx.szThumbnail stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            videoInfo.videoReferenceUrl = [videoInfoEx.szReference stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            videoInfo.videoSignature = videoInfoEx.szSignature;
            videoInfo.videoNumberOfPraise = [NSString stringWithFormat:@"%@", videoInfoEx.nPraise];
            videoInfo.videoNumberOfShare = [NSString stringWithFormat:@"%@", videoInfoEx.nShareNum];
            videoInfo.videoNumberOfFavorite = [NSString stringWithFormat:@"%@", videoInfoEx.nFavoritesNum];
            videoInfo.videoNumberOfComment = [NSString stringWithFormat:@"%@", videoInfoEx.nCommentsNum];
            videoInfo.videoCollectStatus = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoStatus];
            videoInfo.videoShare = [NSString stringWithFormat:@"%@", videoInfoEx.nVideoShare];
            videoInfo.videoPlayCount = [NSString stringWithFormat:@"%@", videoInfoEx.nVisitCount];
            //            MovierDCInterfaceSvc_VDCLabelForVideo * stLabels;
            [self.videoInfos addObject:videoInfo];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self.collectionView footerEndRefreshing];
            [self.collectionView headerEndRefreshing];
        });
    } Fail:^(NSError *error) {
        NSLog(@"-----%s---%@", __func__, error);
    }];
}

- (void)addFooter {
    NSInteger start = self.videoInfos.count;
    if (start < 10) {   // 第一次已经将数据加载完了
        [self.collectionView footerEndRefreshing];
        return;
    }
    [self requestFromServerWithLableID:self.label.nLabelID start:@(start) count:@(10)];
}

#pragma mark ----  LIWaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(LIWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 4 == 0 || indexPath.item % 4 == 3) {
        return ISHomeCellWidth * ISHomeCellRatio;
    } else {
        return ISHomeCellWidth * ISHomeCellRatio * 0.5;
    }
}

- (CGSize)waterflowLayout:(LIWaterflowLayout *)waterflowLayout sectionHeaderAtIndexPath:(NSIndexPath *)indexPath {
    ISLabelFrame *labelF = self.labelInfos[0];
    return CGSizeMake(ISScreen_Width - ISHomeCellMargin * 2, labelF.cellH);
}

@end
