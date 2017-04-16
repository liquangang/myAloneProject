 //
//  ISCutProStyleDetailViewController.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/26.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISCutProStyleDetailViewController.h"
#import "ISStyleDetailCell.h"
#import "SoapOperation.h"
#import "GlobalVars.h"
#import "MJRefresh.h"
#import "ISStyleDetailHeaderView.h"
#import "ISCutPreViewController.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "ConnectFailedView.h"
#import "MovierUtils.h"

// 需要使用 ISStyle 模型
#import "ISStyleCell.h"
// 根目录
#import "ISCutProViewController.h"
// 影片详情返回制作首页, 使用通知传递参数
#define ISStyleDetailBacktoCutProParams         @"ISStyleDetailBacktoCutProParams"
#define ISStyleDetailBacktoCutProNotification   @"ISStyleDetailBacktoCutProNotification"

@interface ISCutProStyleDetailViewController () <UITableViewDataSource, UITableViewDelegate, ISStyleDetailCellDelegate>
@property (weak, nonatomic) UIButton *rightBarButton;
/**  tableView */
@property (weak, nonatomic) UITableView *tableView;
//连接失败页面
@property (weak, nonatomic)ConnectFailedView *failedView;
/**  styleDetail 数据模型 */
@property (strong, nonatomic) NSMutableArray *styleFrames;
/**  记录开始请求的位置 */
@property (assign, nonatomic)  NSInteger startPos;
/**  当前----选中模板所在的 cell */
@property (strong, nonatomic) ISStyleDetailCell *selectedCell;
/**  当前----播放视频模板所在的 cell */
@property (strong, nonatomic) ISStyleDetailCell *playCell;
/**  标记是否有模板视频正在播放 */
@property (assign, nonatomic) BOOL isPlaying;
/**  记录是否有模板被选中 */
@property (assign, nonatomic) BOOL isSelected;
@end

@implementation ISCutProStyleDetailViewController

- (NSMutableArray *)styleFrames {
    if (!_styleFrames) {
        self.styleFrames = [NSMutableArray array];
    }
    return _styleFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条
    [self setupNavigation];
    
    // 创建 tableview
    [self setupTableView];
    [self setupConnectfailed];
    
    // 请求数据
    [self getStyleDetail:@(0) count:@(10)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**  设置导航信息 */
- (void)setupNavigation {
    // 标题
    NAVIGATIONBARTITLEVIEW(@"风格选取")
    
    // 左侧按钮
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 11, 30);
    [leftBarButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    leftBarButton.titleLabel.font = ISFont_16;
    [leftBarButton addTarget:self action:@selector(leftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    
    // 右侧按钮
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSString *rightBarTitle = @"下一步";
    [rightBarButton setTitle:rightBarTitle forState:UIControlStateNormal];
    // 在没有选择任何模板的情况下, 右侧按钮不能被点击
    rightBarButton.userInteractionEnabled = NO;
    rightBarButton.titleLabel.font = ISFont_16;
    CGSize rightBarSize = [rightBarTitle sizeWithWidth:MAXFLOAT font:ISFont_16];
    rightBarButton.frame = CGRectMake(0, 0, rightBarSize.width, rightBarSize.height);
    [rightBarButton addTarget:self action:@selector(rightBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    self.rightBarButton = rightBarButton;
}

/**  导航左侧按钮点击 */
- (void)leftBarButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

/**  导航右侧按钮点击 */
- (void)rightBarButtonClick:(UIButton *)button {
    // 从选择   风格选择界面跳转到  制作界面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[ISStyleDetailBacktoCutProParams] = self.selectedCell.styleF.styleDetail;
        [[NSNotificationCenter defaultCenter] postNotificationName:ISStyleDetailBacktoCutProNotification object:nil userInfo:attrs];
    });
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**  获取风格详情 */
- (void)getStyleDetail:(NSNumber *)start count:(NSNumber *)count {
    
    //网络判断
    NSInteger num = [[VideoDBOperation Singleton]DB_GetTempNum:self.style.nID];
    if(![MovierUtils GetCurrntNet]){
        [UIWindow showMessage:@"网络好像有问题哦，请刷新重试" withTime:2.0];
        if (num>0) {
            [self RefreshDate:[NSNumber numberWithInt:num+10] UpdateDB:NO];
        }else{
            [self.tableView setHidden:YES];
            [self.failedView setHidden:NO];
        }
        return;
    }
    [self RefreshDate:[NSNumber numberWithInt:num+10] UpdateDB:YES];
}

-(void)RefreshDate:(NSNumber*)tempID UpdateDB:(BOOL)updatesql{
    BOOL needfresh = NO;
    NSMutableArray *stylearray = [[VideoDBOperation Singleton]DB_GetTempByCat:self.style.nID];
    if([stylearray count]==0)
        needfresh = YES;//之前数据库为空，页面需要重新刷新
    [self.styleFrames removeAllObjects];
    for (MovierDCInterfaceSvc_vpVDCHeaderAndTailC *detail in stylearray) {
        ISStyleDetailFrame *styleF = [[ISStyleDetailFrame alloc] init];
        ISStyleDetail *style = [[ISStyleDetail alloc] init];
        style.nID = detail.nID;
        style.nHeaderAndTailStyle = detail.nHeaderAndTailStyle;
        style.videoUrl = detail.szReference;
        style.title = detail.szName;
        style.visitCount = detail.nHotIndex;
        style.thumbnail =  [detail.szThumbnail stringByReplacingOccurrencesOfString:@"thumbnail.jpg" withString:@"thumbnail720.jpg"];
        style.intro = detail.szDesc;
        style.sence = detail.szFit;
        style.szCreateTime = detail.szCreateTime;
        styleF.styleDetail = style;
        [self.styleFrames addObject:styleF];
    }
    [self.tableView reloadData];
    if (updatesql){
        SoapOperation *soap = [SoapOperation Singleton];
        [soap WS_GetStylebyCat:nil CatType:self.style.nID Start:@(0) Count:@([stylearray count]+10) Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailArray *array) {
            [[VideoDBOperation Singleton] MC_CleanAllTemp:self.style.nID];
            if (array.item.count > 0) {
                for (NSInteger i = 0; i < array.item.count; i++) {
                    MovierDCInterfaceSvc_vpVDCHeaderAndTailC *detail = array.item[i];
                    [[VideoDBOperation Singleton] MC_AddTemp:detail CatID:self.style.nID];
                }
                if (needfresh) {//重新刷新数据但不更新数据库
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self RefreshDate:[NSNumber numberWithInt:array.item.count] UpdateDB:NO];
                    });
                }
            }
        } Fail:^(NSError *error) {
            NSLog(@"-----%s", __func__);
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIWindow showMessage:@"网络请求失败，请重试！" withTime:2.0];
            });
        }];
    }
}

/**   tableView视图  */
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    CGFloat tableViewX = 0;
    CGFloat tableViewY = 0;
    CGFloat tableViewW = ISScreen_Width;
    CGFloat tableViewH = ISScreen_Height - ISNavigationHeight;
    tableView.frame = CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH);
    tableView.backgroundColor = ISBackgroundColor;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    // 上下拉刷新
    [tableView addHeaderWithTarget:self action:@selector(addHeader)];
    [tableView addFooterWithTarget:self action:@selector(addFooter)];
    
    tableView.tableHeaderView = [[UIView alloc] init];
    self.tableView = tableView;
}

-(void)setupConnectfailed{
    ConnectFailedView *failed = [[ConnectFailedView alloc]initWithFrame:CGRectMake(0, 0, ISScreen_Width, ISScreen_Height-ISNavigationHeight)];
    [self.view addSubview:failed];
    self.failedView = failed;
    [self.failedView setHidden:YES];
}

- (void)addHeader {
    [self getStyleDetail:@(0) count:@(5)];
    [self.tableView headerEndRefreshing];
}

- (void)addFooter {
    self.startPos = self.styleFrames.count;
    [self getStyleDetail:@(self.startPos) count:@(10)];
    [self.tableView footerEndRefreshing];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.styleFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    ISStyleDetailCell *cell = [ISStyleDetailCell cellWithTableView:tableView];
    ISStyleDetailCell *cell = [ISStyleDetailCell cellWithTableView:tableView andIndex:indexPath];
    cell.styleF = self.styleFrames[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.styleFrames[indexPath.row] cellH];
}

// 先设置头的高度, 调用heightForHeaderInSection: ,才能调用viewForHeaderInSection:
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 118.0 / 667 * ISScreen_Height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ISStyleDetailHeaderView *headerView = [ISStyleDetailHeaderView viewWithTableView:tableView];
    headerView.style = self.style;
    return headerView;
}

#pragma mark --- ISStyleDetailCellDelegate  选中模板
- (void)styleCell:(ISStyleDetailCell *)styleCell didClickChooseButton:(UIButton *)chooseButton {
    if (self.selectedCell) {
        if (self.selectedCell == styleCell) {
            self.selectedCell = nil;
        } else {
            [self.selectedCell deselectCurrentTemplate:self.selectedCell];
            self.selectedCell = styleCell;
        }
    } else {
        self.selectedCell = styleCell;
    }
    
    if (self.selectedCell) {
        self.rightBarButton.userInteractionEnabled = YES;
    } else {
        self.rightBarButton.userInteractionEnabled = NO;
    }
    
    // styleCell 就是当前选中的模板, 更新数据库  订单的风格
    NewNSOrderDetail *noworder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    noworder.nHeaderAndTailID = [self.selectedCell.styleF.styleDetail.nID intValue];
    [MC_OrderAndMaterialCtrl UpdateFresh:noworder];
}

- (void)styleCell:(ISStyleDetailCell *)styleCell isPlaying:(BOOL)isPlaying {

    if (self.playCell && self.isPlaying == YES) {   // 如果上一个播放的模板存在, 并且正在播放
        [self.playCell cancleCurrentTemplatePlaying:self.playCell];
    }
    self.isPlaying = isPlaying;
    self.playCell = styleCell;
}
@end
