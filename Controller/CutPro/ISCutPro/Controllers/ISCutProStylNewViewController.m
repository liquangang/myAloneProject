//
//  ISCutProStylNewViewController.m
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ISCutProStylNewViewController.h"
#import "styleCell.h"
#import "ISStyleCell.h"
#import "VideoDBOperation.h"
#import "MovierUtils.h"
#import "SoapOperation.h"
#import "ISStyleDetailCell.h"
#import "StyleDetailCell.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "UserEntity.h"
#import "ISStylePlayerCell.h"
#import "ISCutPreViewController.h"
#import "CustomeClass.h"

// 影片详情返回制作首页, 使用通知传递参数
#define ISStyleDetailBacktoCutProParams         @"ISStyleDetailBacktoCutProParams"
#define ISStyleDetailBacktoCutProNotification   @"ISStyleDetailBacktoCutProNotification"

@interface ISCutProStylNewViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, styleCellDelegate, StyleDetailCellDelegate>
/** 模板分类数据源*/
@property (nonatomic, strong) NSMutableArray * styleClassMuArray;
/** 具体模板数据源*/
@property (nonatomic, strong) NSMutableArray * styleMuArray;
/** 记录选中的模板分类*/
@property (nonatomic, strong) ISStyle * selectStyle;
/** 记录选中的具体模板信息*/
@property (nonatomic, strong) ISStyleDetailFrame * selectStyleDetail;
/** 下一步按钮*/
@property (nonatomic, strong) UIButton * nextBtn;
/** 无具体模板提示标签*/
@property (nonatomic, strong) UILabel * propmtLabel;
/** 左侧箭头按钮*/
@property (nonatomic, strong) UIButton * leftArrowButton;
/** 右侧箭头按钮*/
@property (nonatomic, strong) UIButton * rightArrowButton;
///** 模板分类下载次数*/
//@property (nonatomic, assign) int downloadStyleClassTimes;
///** 具体模板下载次数*/
//@property (nonatomic, assign) int downloadStyleTimes;
/** 播放样片cell*/
@property (nonatomic, strong) ISStylePlayerCell * videoPlayCell;
@end

@implementation ISCutProStylNewViewController

- (void)dealloc{
    [self.videoPlayCell.mpMovierPlayerVc.moviePlayer pause];
    self.videoPlayCell.mpMovierPlayerVc = nil;
    self.videoPlayCell = nil;
    DEBUGSUCCESSLOG(@"dealloc")
}

//数据源懒加载
- (NSMutableArray *)styleClassMuArray{
    if (!_styleClassMuArray) {
        _styleClassMuArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _styleClassMuArray;
}

- (NSMutableArray *)styleMuArray{
    if (!_styleMuArray) {
        _styleMuArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _styleMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self loadStyleClassData];
}

/** 下载具体模板的数据*/
- (void)loadStyleData{
    //网络判断
    NSInteger num = [[VideoDBOperation Singleton]DB_GetTempNum:self.selectStyle.nID];
    if(![MovierUtils GetCurrntNet]){
        [UIWindow showMessage:@"网络好像有问题哦，请刷新重试" withTime:1.0];
        if (num>0) {
            [self RefreshDate:[NSNumber numberWithInt:num+10] UpdateDB:NO];
        }else{
        }
        return;
    }
    [self RefreshDate:[NSNumber numberWithInt:num+10] UpdateDB:YES];
}

/** 向数据源添加具体模板*/
- (void)addDataForStyleWithArray:(NSMutableArray *)dataArray{
    [self.styleMuArray removeAllObjects];
    for (MovierDCInterfaceSvc_vpVDCHeaderAndTailC *detail in dataArray) {
        ISStyleDetailFrame *styleF = [[ISStyleDetailFrame alloc] init];
        ISStyleDetail *style = [[ISStyleDetail alloc] init];
        style.nID = detail.nID;
        style.nHeaderAndTailStyle = detail.nHeaderAndTailStyle;
        style.videoUrl = detail.szReference;
        style.title = detail.szName;
        style.visitCount = detail.nHotIndex;
        style.thumbnail = detail.szThumbnail;
        style.intro = detail.szDesc;
        style.sence = detail.szFit;
        style.szCreateTime = detail.szCreateTime;
        styleF.styleDetail = style;
        [self.styleMuArray addObject:styleF];
    }
    self.rightArrow.image = nil;
    if (self.styleMuArray.count > 4) {
        self.rightArrow.image = [UIImage imageNamed:@"滑动箭头"];
    }
    [self.styleCollectionView setContentOffset:CGPointMake(- ISScreen_Width, 0)];

    WEAKSELF2
    [UIView animateWithDuration:0.4 animations:^{
        [weakSelf.styleCollectionView setContentOffset:CGPointMake(0, 0)];
        [weakSelf.styleCollectionView reloadData];
    }];
}

/** 加载具体模板数据*/
-(void)RefreshDate:(NSNumber*)tempID UpdateDB:(BOOL)updatesql{
    NSMutableArray *stylearray = [[VideoDBOperation Singleton]DB_GetTempByCat:self.selectStyle.nID];
    [self addDataForStyleWithArray:stylearray];
    if (updatesql){
        __weak typeof(self) weakSelf = self;
        SoapOperation *soap = [SoapOperation Singleton];
        [soap WS_GetStylebyCat:nil CatType:self.selectStyle.nID Start:@(0) Count:@(10000) Success:^(MovierDCInterfaceSvc_vpVDCHeaderAndTailArray *array) {
            [[VideoDBOperation Singleton] MC_CleanAllTemp:self.selectStyle.nID];
            if (array.item.count != stylearray.count) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf addDataForStyleWithArray:array.item];
                });
            }
            for (NSInteger i = 0; i < array.item.count; i++) {
                MovierDCInterfaceSvc_vpVDCHeaderAndTailC *detail = array.item[i];
                [[VideoDBOperation Singleton] MC_AddTemp:detail CatID:self.selectStyle.nID];
            }
        } Fail:^(NSError *error) {
            RELOADSERVERDATA([weakSelf RefreshDate:tempID UpdateDB:updatesql];);
        }];
    }
}

/** 下载模板分类的数据*/
- (void)loadStyleClassData{
    NSInteger num = [[VideoDBOperation Singleton]DB_GetTempCatNum];
    if(![MovierUtils GetCurrntNet]){
        if (num>0) {
            [self ReGetTemplate:[NSNumber numberWithInt:num+15] UpdateDB:NO];
        }else{
        }
        return;
    }
    [self ReGetTemplate:[NSNumber numberWithInt:num+15] UpdateDB:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self setFrameWithStyleClassCollectionViewFrame:CGRectMake(6, self.styleClassPageControl.frame.origin.y + self.styleClassPageControl.frame.size.height + 6, ISScreen_Width - 12, (ISScreen_Width) / 3 * 2)];
    
    //禁止侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    //打开侧滑手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)addStyleClassFromArray:(NSMutableArray *)array{
    [self.styleClassMuArray removeAllObjects];
    for (MovierDCInterfaceSvc_TemplateCat *object in array) {
        ISStyle *style      = [[ISStyle alloc] init];
        style.nID           = object.nID;
        style.szName        = object.szName;
        style.szDesc        = object.szDesc;
        style.szThumbnail   = object.szThumbnail;
        [self.styleClassMuArray addObject:style];
    }
    [self.styleClassCollection reloadData];
}

/** 加载模板分类数据*/
-(void)ReGetTemplate:(NSNumber*)num UpdateDB:(BOOL)sqlupdate {
    NSMutableArray * styleClassMuArray = [[VideoDBOperation Singleton]DB_GetTempCat];
    [self addStyleClassFromArray:styleClassMuArray];
    if (sqlupdate) {
        __weak typeof(self) weakSelf = self;
        [[SoapOperation Singleton] WS_GetTemplateCat:nil Start:@(0) Count:@(10000) Success:^(MovierDCInterfaceSvc_VDCTemplateCatArr *array) {
            if (array.item.count != styleClassMuArray.count) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf addStyleClassFromArray:array.item];
                });
            }
            [[VideoDBOperation Singleton]DB_ClearTempCat];
            for (NSInteger i = 0; i < array.item.count; i++) {
                MovierDCInterfaceSvc_TemplateCat *template = array.item[i];
                [[VideoDBOperation Singleton] DB_AddTempCat:[template.nID integerValue] CatName:template.szName CatReference:template.szThumbnail CatDesc:template.szDesc];
            }
        } Fail:^(NSError *error) {
            RELOADSERVERDATA([weakSelf ReGetTemplate:num UpdateDB:sqlupdate];);
        }];
    }
}

static NSString * cellID1 = @"collectionViewCell";
static NSString * cellID2 = @"collectionViewCell2";

/** 初始化界面*/
- (void)initUI{
    
    if ([SINGLETON(AFNetWorkManager) netStatus] == AFNetworkReachabilityStatusUnknown || [SINGLETON(AFNetWorkManager) netStatus] == AFNetworkReachabilityStatusNotReachable) {
        [CustomeClass showMessage:@"网络好像断开了！" ShowTime:3];
    }
    
    UILabel * titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"风格选取";
    titleLabel.textColor = [UIColor whiteColor];
    CGSize mySize = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:16], NSFontAttributeName, nil]];
    titleLabel.frame = CGRectMake(0, 0, mySize.width, mySize.height);
    self.navigationItem.titleView = titleLabel;
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //下一步按钮
    NSString *rightButtonTitle;
    NSArray *vcArray = self.navigationController.viewControllers;
    
    if ([vcArray[vcArray.count - 2] isKindOfClass:[ISCutPreViewController class]]) {
        rightButtonTitle = @"完成";
    }else{
        rightButtonTitle = @"下一步";
    }
    
    self.nextBtn = [UIButton new];
    [_nextBtn setTitle:rightButtonTitle forState:UIControlStateNormal];
    [_nextBtn setTitleColor:ISARGBColor(64, 74, 88, 0.5) forState:UIControlStateNormal];
    _nextBtn.font = [UIFont systemFontOfSize:17];
    [_nextBtn addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    CGSize mySize2 = [rightButtonTitle sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17], NSFontAttributeName, nil]];
    _nextBtn.frame = CGRectMake(0, 0, mySize2.width, mySize2.height);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_nextBtn];
    self.nextBtn.enabled = NO;
    
    //初始化模板分类collectionview
    UICollectionViewFlowLayout * myFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.styleClassCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:myFlowLayout];
    myFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.styleClassCollection.collectionViewLayout = myFlowLayout;
    self.styleClassCollection.backgroundColor = [UIColor whiteColor];
    self.styleClassCollection.delegate = self;
    self.styleClassCollection.dataSource = self;
    self.styleClassCollection.pagingEnabled = YES;
    self.styleClassCollection.showsVerticalScrollIndicator = NO;
    self.styleClassCollection.showsHorizontalScrollIndicator = NO;
    
    //注册模板分类cell
    [self.styleClassCollection registerNib:[UINib nibWithNibName:@"styleCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellID1];
    
    //初始化具体模板collectionview
    UICollectionViewFlowLayout * myFlowLayout2 = [UICollectionViewFlowLayout new];
    myFlowLayout2.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.styleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:myFlowLayout2];
    self.styleCollectionView.collectionViewLayout = myFlowLayout2;
    self.styleCollectionView.backgroundColor = [UIColor whiteColor];
    self.styleCollectionView.delegate = self;
    self.styleCollectionView.dataSource = self;
    self.styleCollectionView.showsHorizontalScrollIndicator = NO;
    self.styleCollectionView.showsVerticalScrollIndicator = NO;
    
    //注册具体模板cell
    [self.styleCollectionView registerNib:[UINib nibWithNibName:@"StyleDetailCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellID2];
    //默认不显示具体模板collectionview
    self.styleCollectionView.hidden = YES;
    self.styleCollectionView.pagingEnabled = YES;
    
    //默认选择第一个页面
    self.styleClassPageControl.currentPage = 0;
    
    //默认不选中任何模板分类
    self.selectStyle = nil;
    
    //默认不选择任何模板
    self.selectStyleDetail = nil;
    
    //默认不显示两个箭头
    self.leftArrow = [UIImageView new];
    self.leftArrow.image = nil;
    self.rightArrow = [UIImageView new];
    self.rightArrow.image = nil;
    
    //初始化模板播放界面
    self.videoPlayerTable.delegate = self;
    self.videoPlayerTable.dataSource = self;
    self.videoPlayerTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.videoPlayerTable.scrollEnabled = NO;
}

- (void)setFrameWithStyleClassCollectionViewFrame:(CGRect)myRect{
    self.styleClassCollection.frame = myRect;
    [self.view addSubview:self.styleClassCollection];
    self.styleCollectionView.frame = CGRectMake(18, self.styleClassCollection.frame.origin.y + self.styleClassCollection.frame.size.height / 2, ISScreen_Width - 36, self.styleClassCollection.frame.size.height / 2 - 8);
    [self.view insertSubview:self.styleCollectionView aboveSubview:self.styleClassCollection];
    self.leftArrow.frame = CGRectMake(18, self.styleCollectionView.frame.origin.y + self.styleCollectionView.frame.size.height / 16 * 7, 5, self.styleCollectionView.frame.size.height / 8);
    [self.view insertSubview:self.leftArrow aboveSubview:self.styleCollectionView];
    self.rightArrow.frame = CGRectMake(ISScreen_Width - 23, self.styleCollectionView.frame.origin.y + self.styleCollectionView.frame.size.height / 16 * 7, 5, self.styleCollectionView.frame.size.height / 8);
    [self.view insertSubview:self.rightArrow aboveSubview:self.styleCollectionView];
    
    self.leftArrowButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.styleCollectionView.frame.origin.y, 36, self.styleCollectionView.frame.size.height)];
    [self.view insertSubview:self.leftArrowButton aboveSubview:self.leftArrow];
    self.leftArrowButton.backgroundColor = [UIColor clearColor];
    self.rightArrowButton = [[UIButton alloc] initWithFrame:CGRectMake(ISScreen_Width - 36, self.styleCollectionView.frame.origin.y, 36, self.styleCollectionView.frame.size.height)];
    [self.view insertSubview:self.rightArrowButton aboveSubview:self.rightArrow];
    self.rightArrowButton.backgroundColor = [UIColor clearColor];
    [self.leftArrowButton addTarget:self action:@selector(leftArrowButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.rightArrowButton addTarget:self action:@selector(rightArrowButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.styleCollectionView.backgroundColor = [UIColor clearColor];
    
    //设置无模板提示标签
    self.propmtLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width - 36, self.styleCollectionView.frame.size.height)];
    self.propmtLabel.text = @"暂无模板\n试试其他风格吧~";
    self.propmtLabel.textColor = [UIColor grayColor];
    self.propmtLabel.textAlignment = NSTextAlignmentCenter;
    self.propmtLabel.font = [UIFont fontWithName:@"Helvetica" size:18.f];
    self.propmtLabel.numberOfLines = 2;
    [self.styleCollectionView addSubview:self.propmtLabel];
    self.propmtLabel.hidden = YES;
}

#pragma mark - viewDidAppear


/** 向右滑动*/
- (void)rightArrowButtonAction{
    if ([self.rightArrow.image isEqual:[UIImage imageNamed:@"滑动箭头"]]) {
        WEAKSELF2
        [UIView animateWithDuration:0.6 animations:^{
            [weakSelf.styleCollectionView setContentOffset:CGPointMake((((ISScreen_Width - 36) / 4) * (weakSelf.styleMuArray.count / 4 * 4 + ((weakSelf.styleMuArray.count % 4) ? 4 : 0) - 4)), 0)];
        }];
    }
}

/** 向左滑动*/
- (void)leftArrowButtonAction{
    if ([self.leftArrow.image isEqual:[UIImage imageNamed:@"滑动箭头左"]]) {
        WEAKSELF2
        [UIView animateWithDuration:0.6 animations:^{
            [weakSelf.styleCollectionView setContentOffset:CGPointMake(0, 0)];
        }];
    }
}

/** 下一步按钮点击方法*/
- (void)nextButtonAction{
    
    if ([self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2] isKindOfClass:[ISCutPreViewController class]]) {
        self.updateStyleBlock(self.selectStyleDetail.styleDetail);
        [self backButtonAction];
    }else{
        
        //从选择风格选择界面跳转到影片概览界面
        WEAKSELF2
        MAINQUEUEUPDATEUI({
            UINavigationController *preview = [[UIStoryboard storyboardWithName:@"Preview" bundle:nil] instantiateViewControllerWithIdentifier:@"ISCutPreView_ID"];
            ISCutPreViewController *pre = [preview.childViewControllers firstObject];
            pre.Direct2Main = YES;
            pre.styleDetail = weakSelf.selectStyleDetail.styleDetail;
            [weakSelf presentViewController:preview animated:YES completion:^{
                MAINQUEUEUPDATEUI({
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                })
            }];
        })
    }
}

/** 返回按钮点击方法*/
- (void)backButtonAction{
    [self postNoti];
    [self.navigationController popViewControllerAnimated:YES];
}

/** 发出视频停止播放的通知*/
- (void)postNoti{
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"pauseVideo" object:nil userInfo:nil]];
}

//collectionView的代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.styleClassCollection) {
        if (self.styleCollectionView.hidden == YES) {
            self.styleClassPageControl.numberOfPages = self.styleClassMuArray.count / 8 + (self.styleClassMuArray.count % 8 ? 1 : 0);
            return self.styleClassMuArray.count / 8 * 8 + ((self.styleClassMuArray.count % 8) ? 8 : 0);
        }else{
            self.styleClassPageControl.numberOfPages = self.styleClassMuArray.count / 4 + (self.styleClassMuArray.count % 4 ? 1 : 0);
            return self.styleClassMuArray.count / 4 * 4 + ((self.styleClassMuArray.count % 4) ? 4 : 0);
        }
        
    }
    else if(collectionView == self.styleCollectionView){
        self.propmtLabel.hidden = YES;
        if (self.styleMuArray.count == 0) {
            self.propmtLabel.hidden = NO;
        }
        return self.styleMuArray.count / 4 * 4 + ((self.styleMuArray.count % 4) ? 4 : 0);
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.styleClassCollection) {
        if (self.styleCollectionView.hidden == NO) {
            return (CGSize){(ISScreen_Width - 12) / 4, self.styleClassCollection.frame.size.height};
        }
        return (CGSize){(ISScreen_Width - 12) / 4, self.styleClassCollection.frame.size.height / 2};
    }
    else if (collectionView == self.styleCollectionView){
        return (CGSize){(ISScreen_Width - 36) / 4, self.styleClassCollection.frame.size.height / 2};
    }
    return (CGSize){(ISScreen_Width - 12) / 4, self.styleClassCollection.frame.size.height / 2};
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.styleClassCollection) {
        styleCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID1 forIndexPath:indexPath];
        cell.delegate = self;
        cell.myIndex = indexPath;
        //cell的设置方法
        if (!self.selectStyle) {
            //未被选中时的状态
            if(self.styleClassMuArray.count > indexPath.row){
                [cell setNormalCellWithStyle:self.styleClassMuArray[indexPath.row]];
            }else if(self.styleClassMuArray.count <= indexPath.row){
                cell.hidden = YES;
            }
        }else if(self.selectStyle){
            if (self.styleClassMuArray.count > indexPath.row) {
                //设置选中与未选中的状态
                //未被选中
                if (self.selectStyle != self.styleClassMuArray[indexPath.row]) {
                    [cell setSelectCellWithStyle:self.styleClassMuArray[indexPath.row]];
                    
                }
                //被选中
                else if (self.selectStyle == self.styleClassMuArray[indexPath.row]) {
                    [cell setDidSelectCellWithStyle:self.styleClassMuArray[indexPath.row]];
                }
            }else if(self.styleClassMuArray.count <= indexPath.row){
                cell.hidden = YES;
            }
        }
        return cell;
    }else if(collectionView == self.styleCollectionView){
        StyleDetailCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID2 forIndexPath:indexPath];
        cell.delegate = self;
        cell.myIndex = indexPath;
        if (self.styleMuArray.count > indexPath.row) {
            cell.hidden = NO;
            //cell的设置属性的方法
            if (self.selectStyleDetail == self.styleMuArray[indexPath.row]) {
                //设置cell显示为选中状态
                [cell setDidSelectDetailCellWithStyle:self.selectStyleDetail];
            }
            else if (self.selectStyleDetail != self.styleMuArray[indexPath.row]){
                //设置cell为不选中状态
                [cell setNormalDetailCellWithStyle:self.styleMuArray[indexPath.row]];
            }
        }
        else{
            cell.hidden = YES;
        }
        return cell;
    }
    
    //防止崩溃
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID1 forIndexPath:indexPath];
    return cell;
}

/** 模板分类的代理方法*/
- (void)didSelectStyleCellWithIndex:(NSIndexPath *)indexPath{
    if (self.styleCollectionView.hidden == YES || self.selectStyle != self.styleClassMuArray[indexPath.row]) {
        //隐藏 要显示
        //打开具体模板collectionview 并添加红圈等信息
        WEAKSELF2
        [UIView animateWithDuration:0.4 animations:^{
            [weakSelf.styleClassCollection reloadData];
            [weakSelf.styleClassCollection setContentOffset:CGPointMake(indexPath.row / 4 * (ISScreen_Width - 12), 0)];
        }];
        self.styleCollectionView.hidden = NO;
        //下载具体模板数据
        self.selectStyle = self.styleClassMuArray[indexPath.row];
        self.styleClassLabel.text = self.selectStyle.szName;
        [self loadStyleData];
        self.leftArrow.image = nil;
    }
    else if(self.styleCollectionView.hidden == NO || self.selectStyle == self.styleClassMuArray[indexPath.row]){
        //未隐藏 要隐藏
        self.selectStyle = nil;
        self.styleClassLabel.text = @"";
        self.styleLabel.text = @"";
        self.selectStyleDetail = nil;
        //显示默认封面
        [self.videoPlayCell hiddenVideoImage];
        
        [self.styleClassCollection reloadData];
        [self.styleClassCollection setContentOffset:CGPointMake(0, 0)];
        [self.videoPlayerTable reloadData];
        self.rightArrow.image = nil;
        self.leftArrow.image = nil;
        self.styleCollectionView.hidden = YES;
    }
    [UIApplication sharedApplication].statusBarHidden = NO;
}

/** 具体模板信息的代理方法*/
- (void)didSelectStyleDetailWithIndex:(NSIndexPath *)indexPath{
    //点击时添加红圈
    self.selectStyleDetail = self.styleMuArray[indexPath.row];
    [self.styleCollectionView reloadData];
    //显示样片缩略图
    [self.videoPlayCell showVideoImageWithStyle:self.selectStyleDetail];
    
    self.styleClassLabel.text = [NSString stringWithFormat:@"%@ : %@", self.selectStyle.szName, self.selectStyleDetail.styleDetail.title];
    self.styleLabel.text = self.selectStyleDetail.styleDetail.sence;
    self.nextBtn.enabled = YES;
    [self.nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [UIApplication sharedApplication].statusBarHidden = NO;
}

//scroll的回调方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //pagecontrol转换方法
    if(scrollView == self.styleClassCollection){
        self.styleClassPageControl.currentPage = self.styleClassCollection.contentOffset.x / (ISScreen_Width - 12);
    }
    else if (scrollView == self.styleCollectionView){
        self.rightArrow.image = nil;
        self.leftArrow.image = nil;
        if (self.styleMuArray.count > 4 && self.styleCollectionView.contentOffset.x < (((ISScreen_Width - 36) / 4) * (self.styleMuArray.count / 4 * 4 + ((self.styleMuArray.count % 4) ? 4 : 0) - 4))) {
            self.rightArrow.image = [UIImage imageNamed:@"滑动箭头"];
        }
        
        if (self.styleCollectionView.contentOffset.x >= ((ISScreen_Width - 36) / 4)){
            self.leftArrow.image = [UIImage imageNamed:@"滑动箭头左"];
        }
    }
}

//table的代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.videoPlayerTable.frame.size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectio{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ISStylePlayerCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ISStylePlayerCell" owner:self options:nil] lastObject];
    }
    self.videoPlayCell = cell;
    return cell;
}

@end
