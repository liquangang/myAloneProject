//
//  SubtitleViewC.m
//  M-Cut
//
//  Created by Crab00 on 15/8/17.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "SubtitleViewC.h"
#import "APPUserPrefs.h"
#import "CaptionEditeCollecterViewController.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "MovierDCInterfaceSvc.h"
#import "UserEntity.h"
#import "CaptionEditeNewViewController.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MJRefresh.h"
#import "CustomeClass.h"

static NSString *resuableStr;

@interface SubtitleViewC () <LQGCaptionEditeViewControllerDelegate, TextFieldChangeDelegate>
/**  存放字幕对象的数组 */
@property (strong,nonatomic) NSMutableArray *subtitleArray;
/**  选中的字幕模型 */
@property (strong, nonatomic) MovierDCInterfaceSvc_vpVDCSubtitleC *selectTitle;
/**  记录选中的哪一行 */
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) SubtitleCell *selectedCell;
/**  记录编辑按钮点击的位置*/
@property (nonatomic, assign) NSInteger editIndex;
/**  传回影片概览页面的字母对象*/
@property (nonatomic, strong) MovierDCInterfaceSvc_vpVDCSubtitleC * passSubtitle;
/**  保存用户选中的状态*/
@property (nonatomic, assign) BOOL isSelectSubtitle;
@property (nonatomic, strong) AVPlayerViewController * subtitlePreviewPlayer;
@end

@implementation SubtitleViewC

DEALLOCMETHOD

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //默认没有选中任何字幕
    self.isSelectSubtitle = NO;
    
    //默认没有选择任何cell
    selectedCell = 0;
    [self setNav];
    [self downloadDataWithStart:0];
}

#pragma mark - 接口

NAVIGATIONBACKITEMMETHOD

// 设置导航左侧按钮
- (void)setNav {
    
    // 左侧按钮
    NAVIGATIONBACKBARBUTTONITEM
    
    // 标题
    NAVIGATIONBARTITLEVIEW(@"选择字幕")
    
    //完成按钮
    NAVIGATIONBARRIGHTBARBUTTONITEM(@"完成")
}

- (void)leftBarButtonClick:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonItemAction:(UIButton *)btn{
    
    if (self.subTitle) {
        self.subTitle(self.passSubtitle);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downloadDataWithStart:(NSInteger)startNum{
    WEAKSELF2
    [[SoapOperation Singleton] WS_GetSubtitleList:[self getRequestObj] Start:@(startNum) Count:@(18) Success:^(MovierDCInterfaceSvc_vpVDCSubtitleArray *SList) {
        if (SList.item.count < 18) {
            [weakSelf.SubtitleList footerEndRefreshing];
            [weakSelf.SubtitleList removeFooter];
        }
        [weakSelf.subtitleArray addObjectsFromArray:[SList.item copy]];
        
        MAINQUEUEUPDATEUI({
            [weakSelf.SubtitleList reloadData];
        })
        
    } Fail:^(NSError *error) {
        RELOADSERVERDATA([weakSelf downloadDataWithStart:startNum];);
    }];
}

- (MovierDCInterfaceSvc_vpQueryCond *)getRequestObj{
    MovierDCInterfaceSvc_vpQueryCond *QueryCond = [[MovierDCInterfaceSvc_vpQueryCond alloc] init];
    QueryCond.nStyleID = 0;
    QueryCond.nFilterID = 0;
    QueryCond.nMusicID = 0;
    QueryCond.nSubtitleID = 0;
    return QueryCond;
}

////初始化的时候执行一次
//-(void)initSubtitleView
//{
//    MovierDCInterfaceSvc_vpQueryCond *QueryCond = [[MovierDCInterfaceSvc_vpQueryCond alloc] init];
//    QueryCond.nStyleID = 0;
//    QueryCond.nFilterID = 0;
//    QueryCond.nMusicID = 0;
//    QueryCond.nSubtitleID = 0;
//    NewNSOrderDetail *noworder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
//    __weak typeof(self) weakSelf = self;
//    [[SoapOperation Singleton] WS_GetSubtitleList:QueryCond Start:@(0) Count:@(50) Success:^(MovierDCInterfaceSvc_vpVDCSubtitleArray *SList) {
//        _SubtitleArray = [[NSMutableArray alloc]initWithCapacity:1];
//        for (int i = 0 ; i < [SList.item count]; i++){
//            MovierDCInterfaceSvc_vpVDCSubtitleC *Subtitleinfo = [SList.item objectAtIndex:i];
//            NSString *Name = (Subtitleinfo.szName==nil)?@"":Subtitleinfo.szName;
//            NSString *Thumbnail = (Subtitleinfo.szThumbnail==nil)?@"":Subtitleinfo.szThumbnail;
//            NSString *URL = (Subtitleinfo.szUrl==nil)?@"":Subtitleinfo.szUrl;
//            NSString *Model = (Subtitleinfo.szModel==nil)?@"":Subtitleinfo.szModel;
//            NSString *Recommond = (Subtitleinfo.szRecommend==nil)?@"":Subtitleinfo.szRecommend;
//            NSString *Id = [NSString  stringWithFormat:@"%@",Subtitleinfo.nID ];
//            if ([Id isEqualToString:[NSString stringWithFormat:@"%d",noworder.nSubtitleID]]&&![noworder.szCustomerSubtitle isEqualToString:@""]) {
//                Recommond = noworder.szCustomerSubtitle;
//            }
//            NSString *Reference = (Subtitleinfo.szReference==nil)?@"":Subtitleinfo.szReference;
//
//            //字典表  name   URL    id    PlayURL   Discribe   Class
//            NSDictionary *Item = [NSDictionary dictionaryWithObjectsAndKeys:Name,@"name",
//                                  Thumbnail,@"URL",Id,@"id",URL,@"PlayURL",
//                                  Model,@"Model",Recommond,@"Recommond",Reference,@"ReferenceURL",nil];
//            if ([Subtitleinfo.nLength isEqualToNumber:@(90)]==YES)//
//            {
//                [self.subTitles addObject:Subtitleinfo];
//                [_SubtitleArray addObject:Item];
//            }
//
//        };
//        dispatch_async(dispatch_get_main_queue(),^(void){
//            [self.SubtitleList reloadData];
//        });
//    } Fail:^(NSError *error) {
//        if (weakSelf.downloadTimes > 6) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [UIWindow showMessage:@"网络好像有问题，请重试！" withTime:1.0];
//            });
//            return;
//        }
//        weakSelf.downloadTimes++;
//        [weakSelf initSubtitleView];
//    }];
//}

//-(void)viewDidLayoutSubviews
//{
//    CGRect frame = self.SubtitleShow.frame;
//    frame.size.height = frame.size.width*408/720;
//    [self.SubtitleShow setFrame:frame];
//
//}

//-(void)changeOrderInfo:(int)subtitleId
//{
//    NewNSOrderDetail *noworder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
//    noworder.nSubtitleID = subtitleId;
//    [MC_OrderAndMaterialCtrl UpdateFresh:noworder];
//}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.subtitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MovierDCInterfaceSvc_vpVDCSubtitleC *subTitle = self.subtitleArray[indexPath.section];
    SubtitleCell *cell = [tableView dequeueReusableCellWithIdentifier:resuableStr];
//    [cell setContent:subTitle.szRecommend];
//    cell.delegate = self;
    cell.tag = indexPath.section;
    cell.FirstT.tag = 100 + indexPath.section;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovierDCInterfaceSvc_vpVDCSubtitleC *subTitle = self.subtitleArray[indexPath.section];
    
    //播放视频
    if (subTitle.szUrl) {
        AVPlayerItem *playItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:subTitle.szUrl]];
        self.subtitlePreviewPlayer.player = [AVPlayer playerWithPlayerItem:playItem];
        [self.subtitlePreviewPlayer.player play];
    }
}

#pragma mark --- TextFieldChangeDelegate
-(void)changeText:(NSString *)text {
    if (self.passSubtitle) {
        
        //设置修改后的字母对象的相关属性
        self.passSubtitle.szRecommend = text;
    }
    // 设置修改后的文字
    [self SetCellText:text];
}

#pragma mark ---- 编辑字幕 EditSubtitleDeleget

- (void)Editbuttonttouched:(NSString*)context Index:(NSInteger)selectindex {
    self.editIndex = selectindex;
    CaptionEditeNewViewController * captionEdit = [[CaptionEditeNewViewController alloc] init];
    captionEdit.stringText = context;
    captionEdit.delegate = self;
    [self.navigationController pushViewController:captionEdit animated:YES];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//    SubtitleCell *cell = (SubtitleCell*)[tableView cellForRowAtIndexPath:indexPath];
//    NSString *content = cell.FirstT.text;
//    
//    if (self.selectedCell == cell) {
//        self.selectedCell.seleImageView.hidden = !self.selectedCell.seleImageView.hidden;
//        self.passSubtitle = nil;
//    }else{
//        self.passSubtitle = [self.subTitles objectAtIndex:indexPath.section];
//        self.passSubtitle.szRecommend = content;
//        
//        self.selectedCell.seleImageView.hidden = YES;
//        cell.seleImageView.hidden = NO;
//        self.selectedCell = cell;
//    }
//    
//    NSDictionary *subtitle = [_SubtitleArray objectAtIndex:indexPath.section];
//    NSString *id = [subtitle objectForKey:@"id"];
//    NSString *thumbnailURL = [subtitle objectForKey:@"URL"];
//    NSString *playURL = [subtitle objectForKey:@"ReferenceURL"];
//    
//    [self.SubtitleShow setImageWithURL:[NSURL URLWithString:thumbnailURL]
//                      placeholderImage:[UIImage imageNamed:@"Default"]];
//    
//    if (playURL!=nil) {
//        [self playinit:playURL Name:@""];
//    }
//    
//    if (self.selectedCell.seleImageView.hidden == YES) {
//        self.selectTitle = nil;
//        self.indexPath = nil;
//        //        [self changeOrderInfo:-1];
//    }else{
//        self.selectTitle = self.subTitles[indexPath.section];
//        self.indexPath = indexPath;
//        //        [self changeOrderInfo:[id intValue]];
//    }
//}

- (void)getSubTitle:(void (^)(MovierDCInterfaceSvc_vpVDCSubtitleC *))subTitle{
    self.subTitle = subTitle;
}

- (void)SetSelectTableCell:(NSInteger)index{
    selectedCell = index;
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:index];
    [self.SubtitleList selectRowAtIndexPath:indexpath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    return;
}

//设置cell内容
- (void)SetCellText:(NSString*)newtext{
    SubtitleCell *cell = self.selectedCell;
    cell.FirstT.text = newtext;
    UILabel * label = (id)[self.view viewWithTag:100 + self.editIndex];
    label.text = newtext;
    return;
}

#pragma mark - 懒加载

- (NSMutableArray *)subtitleArray{
    LAZYINITMUARRAY(_subtitleArray)
}

- (UITableView *)SubtitleList{
    
    if (resuableStr.length == 0) {
        
        //注册cell
        resuableStr = @"SubtitleCell";
        [self.SubtitleList registerNib:[UINib nibWithNibName:resuableStr bundle:nil] forCellReuseIdentifier:resuableStr];
        
        //添加footer
        WEAKSELF2
        [self.SubtitleList addFooterWithCallback:^{
            [weakSelf downloadDataWithStart:weakSelf.subtitleArray.count];
        }];
    }
    return _SubtitleList;
}

- (AVPlayerViewController *)subtitlePreviewPlayer{
    if (!_subtitlePreviewPlayer) {
        _subtitlePreviewPlayer = [AVPlayerViewController new];
        _subtitlePreviewPlayer.view.frame = self.SubtitleShow.frame;
        [self.view addSubview:self.subtitlePreviewPlayer.view];
        _subtitlePreviewPlayer.showsPlaybackControls = NO;
    }
    return _subtitlePreviewPlayer;
}

@end
