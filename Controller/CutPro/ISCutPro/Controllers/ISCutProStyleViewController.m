//
//  ISCutProStyleViewController.m
//  M-Cut
//
//  Created by 李亚飞 on 15/11/25.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "ISCutProStyleViewController.h"
#import "MWaterflowLayout.h"
#import "ISStyleCell.h"
#import "ISCutProStyleDetailViewController.h"
#import "SoapOperation.h"
#import "GlobalVars.h"
//#import "MBProgressHUD+MJ.h"
#import "VideoDBOperation.h"
#import "MovierUtils.h"
#import "ConnectFailedView.h"

/** 列数 */
#define CutStyleColumnsCount 2
/** 列间距 */
#define CutStyleColumnMargin 4
/** cell 和屏幕的上间距 */
#define CutStyleTopMargin 0
/** cell 和屏幕的左间距 */
#define CutStyleLeftMargin 0
/** cell 和屏幕的右间距 */
#define CutStyleRightmargin CutStyleLeftMargin
/** cell 的宽度 */
#define CutStyleCellWidth (ISScreen_Width - CutStyleLeftMargin - CutStyleRightmargin - CutStyleColumnMargin) * 0.5

@interface ISCutProStyleViewController () <UICollectionViewDataSource, UICollectionViewDelegate, MWaterflowLayoutDelegate>
@property (weak, nonatomic) UICollectionView *collectionView;
@property(weak,nonatomic)ConnectFailedView *defaultView;
/**  存放所有的风格数据 */
@property (strong, nonatomic) NSMutableArray *styles;
@property (nonatomic) NSInteger trytime;
@end

@implementation ISCutProStyleViewController

static NSString *CutProStyleIdentifier_cell = @"CutProStyleIdentifier_cell";

- (NSMutableArray *)styles {
    if (!_styles) {
        self.styles = [NSMutableArray array];
    }
    return _styles;
}

- (void)viewDidLoad {
    _trytime = SOAPTRYTIME;
    [super viewDidLoad];
    // 设置导航
    [self setupNavigation];
    // 创建 collectionView 视图
    [self setupCollectionView];
    // 获得所有风格
    [self getAllStyles];
}

/**  设置导航信息 */
- (void)setupNavigation {
    // 标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"风格选取";
    label.font = ISFont_17;
    CGSize labelSize = [label.text sizeWithWidth:MAXFLOAT font:ISFont_17];
    label.textColor = ISRGBColor(255, 255, 255);
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.titleView = label;
    
    // 左侧按钮
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 30, 30);
    [leftBarButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    leftBarButton.titleLabel.font = ISFont_16;
    [leftBarButton addTarget:self action:@selector(leftBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
}

- (void)leftBarButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getAllStyles {
#pragma mark ---- 获得风格列表
    NSInteger num = [[VideoDBOperation Singleton]DB_GetTempCatNum];
    if(![MovierUtils GetCurrntNet]){
        [UIWindow showMessage:@"网络好像有问题哦，请刷新重试" withTime:2.0];
        if (num>0) {
            [self ReGetTemplate:[NSNumber numberWithInt:num+15] UpdateDB:NO];
        }else{
            [self.collectionView setHidden:YES];
            [self.defaultView setHidden:NO];
        }
        return;
    }
    [self ReGetTemplate:[NSNumber numberWithInt:num+15] UpdateDB:YES];
  
    /*
    SoapOperation *soap = [SoapOperation Singleton];
    [soap WS_GetTemplateNum:nil Success:^(NSNumber *num) {
        if ([num integerValue] > 0) {
            [self ReGetTemplate:num];
        }
    }Fail:^(NSError *error){
        if (_trytime<0) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIWindow showMessage:@"网络请求失败，请重试！" withTime:2.0];
            });
        }else{
            [self getAllStyles];
        }
        NSLog(@"----%s-----%@", __func__, error);
    }];*/
}

-(void)ReGetTemplate:(NSNumber*)num UpdateDB:(BOOL)sqlupdate {
    BOOL needfresh = NO;
    NSMutableArray *array = [[VideoDBOperation Singleton]DB_GetTempCat];
    if([array count]==0)
        needfresh = YES;//之前数据库为空，页面需要重新刷新
    [self.styles removeAllObjects];
    for (MovierDCInterfaceSvc_TemplateCat *object in array) {
        ISStyle *style      = [[ISStyle alloc] init];
        style.nID           = object.nID;
        style.szName        = object.szName;
        style.szDesc        = object.szDesc;
        style.szThumbnail   = object.szThumbnail;
        [self.styles addObject:style];
    }
    [self.collectionView reloadData];
    if (sqlupdate) {
        [[SoapOperation Singleton] WS_GetTemplateCat:nil Start:@(0) Count:@([num intValue]+5) Success:^(MovierDCInterfaceSvc_VDCTemplateCatArr *array) {
            if (array.item.count > 0) {
                [[VideoDBOperation Singleton]DB_ClearTempCat];
                for (NSInteger i = 0; i < array.item.count; i ++) {
                    MovierDCInterfaceSvc_TemplateCat *template = array.item[i];
                    [[VideoDBOperation Singleton]DB_AddTempCat:[template.nID intValue] CatName:template.szName CatReference:template.szThumbnail CatDesc:template.szDesc];
                }
                if (needfresh) {//重新刷新数据
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self ReGetTemplate:[NSNumber numberWithInt:array.item.count] UpdateDB:NO];
                    });
                }
            }
        } Fail:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIWindow showMessage:@"网络请求失败，请重试！" withTime:2.0];
            });
            NSLog(@"----%s-----%@", __func__, error);
        }];
    }
}

- (void)setupCollectionView {
    MWaterflowLayout *layout = [[MWaterflowLayout alloc] init];
    layout.columnsCount = CutStyleColumnsCount;
    layout.columnMargin = CutStyleColumnMargin;
    layout.rowMargin    = CutStyleColumnMargin;
    // 设置 cell 的边距
    layout.sectionInset = UIEdgeInsetsMake(CutStyleTopMargin, CutStyleLeftMargin, CutStyleColumnMargin, CutStyleRightmargin);
    layout.delegate = self;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:layout];
    
    UINib *cellNib = [UINib nibWithNibName:@"ISStyleCell" bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:CutProStyleIdentifier_cell];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = ISBackgroundColor;
    collectionView.alwaysBounceVertical = YES;
    
    ConnectFailedView *defaultview = [[ConnectFailedView alloc] initWithFrame:CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT -64)];

    defaultview.backgroundColor = ISBackgroundColor;
//    defaultview.image = [UIImage imageNamed:@"LaunchImage"];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;

    [self.view addSubview:defaultview];
    self.defaultView = defaultview;
    [self.defaultView setHidden:YES];
    
//    self.defaultView.image
}

#pragma mark ----- UICollectionViewDataSource, UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.styles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ISStyleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CutProStyleIdentifier_cell forIndexPath:indexPath];
    cell.style = self.styles[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ISCutProStyleDetailViewController *detail = [[ISCutProStyleDetailViewController alloc] init];
    detail.style = self.styles[indexPath.item];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark ----  MWaterflowLayoutDelegate
- (CGFloat)waterflowLayout:(MWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath {
    return CutStyleCellWidth;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
