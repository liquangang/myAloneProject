//
//  MusicClipsTViewC.m
//  M-Cut
//
//  Created by Crab00 on 15/8/17.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "MusicClipsTViewC.h"
#import "MusicCell.h"
#import "APPUserPrefs.h"
#import "MC_OrderAndMaterialCtrl.h"
#import "UserEntity.h"

@interface MusicClipsTViewC ()
/**  存放music 模型的数组 */
@property (strong, nonatomic) NSMutableArray *musics;
@property (strong, nonatomic) NSIndexPath *seletedIndex;
@end

@implementation MusicClipsTViewC

- (NSMutableArray *)musics {
    if (!_musics) {
        self.musics = [NSMutableArray array];
    }
    return _musics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    static NSString *CellTableIdentifier = @"MusicCellIdentify";
    UINib *nib = [UINib nibWithNibName:@"MusicCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    [self initMusicView];
    [self setupNavigation];
    if (!self.selIndex) {
        self.selIndex = [NSIndexPath indexPathForItem:0 inSection:0];
    }
    self.tempSelIndex = self.selIndex;
    NSLog(@"选中的是row%ld---section%ld",(long)self.selIndex.row,(long)self.selIndex.section);
}

/**  设置导航信息 */
- (void)setupNavigation {
    // 标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"音乐选取";
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
    [leftBarButton addTarget:self action:@selector(leftBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    
    // 右侧按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, self.view.frame.size.width - 30, 30, 30);
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    rightButton.titleLabel.font = ISFont_15;
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self StopPlay];
}
-(void)leftBarButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
    [self StopPlay];
}
-(void)rightBarButtonClick
{
    NSDictionary *music = [_MusicList objectAtIndex:self.tempSelIndex.row];
    NSString *musicid = nil;
    if (self.tempSelIndex.section == 0) {
        musicid =  [NSString stringWithFormat:@"%@",self.recommadMusic.nID];
        // 传递数据到预览界面
        self.music(self.recommadMusic,self.tempSelIndex);
    }else
    {
        musicid =  [music objectForKey:@"id"];
        // 传递数据到预览界面
        self.music(self.musics[self.tempSelIndex.row],self.tempSelIndex);
    }
    [self changeOrderInfo:[musicid intValue]];
    self.selIndex = self.tempSelIndex;
    [self leftBarButtonClick];
}
//初始化的时候执行一次
-(void)initMusicView
{
    NewNSOrderDetail *noworder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    MovierDCInterfaceSvc_vpQueryCond *QueryCond = [[MovierDCInterfaceSvc_vpQueryCond alloc] init];
    QueryCond.nStyleID = @(noworder.nHeaderAndTailID);
    QueryCond.nFilterID = 0;
    QueryCond.nMusicID = 0;
    QueryCond.nSubtitleID = 0;
    [[SoapOperation Singleton] WS_GetMusicList:QueryCond Start:@(0) Count:@(500) Success:^(MovierDCInterfaceSvc_vpVDCMusicArray *abc) {
        _MusicList = [[NSMutableArray alloc]initWithCapacity:1];
        for (int i = 0 ; i < [abc.item count]; i++){
            MovierDCInterfaceSvc_vpVDCMusicC *Styleinfo = [abc.item objectAtIndex:i];
            NSString *Name = Styleinfo.szName;
            NSString *URL = Styleinfo.szUrl;
            NSString *Dis = Styleinfo.szDesc;
            NSString *Id = [NSString  stringWithFormat:@"%@",Styleinfo.nID];
            //字典表  name   URL    id    Discribe
            NSDictionary *MusicItem = [NSDictionary dictionaryWithObjectsAndKeys:Name,@"name",
                                       URL,@"URL",Id,@"id",
                                       Dis,@"Discribe",nil];
            [self.musics addObject:Styleinfo];
            [_MusicList addObject:MusicItem];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        };
    } Fail:^(NSError *error) {
        
    }];
    
    return;
    
//    App_vpQueryCond *app_vpQueryCond = [[App_vpQueryCond alloc] init];
//    [app_vpQueryCond setCond:0 filter:0 music:0 sub:0];//查询条件
//    dispatch_async(dispatch_get_global_queue(0, 0),^(void){
////        NSMutableArray *MusicArrays = [[NSMutableArray alloc]init];
//        NSMutableArray *MusicArrays = [[APPUserPrefs Singleton] APP_vpgetmusic:app_vpQueryCond Noffset:0 Ncount:120];
//        while ([MusicArrays count]==0) {
//            MusicArrays = [[APPUserPrefs Singleton] APP_vpgetmusic:app_vpQueryCond Noffset:0 Ncount:120];
//            sleep(1);
//        }
//        
//        _MusicList = [[NSMutableArray alloc]initWithCapacity:1];
//        for (int i = 0 ; i < MusicArrays.count; i++){
//            App_vpVDCMusic_C *Styleinfo = [MusicArrays objectAtIndex:i];
//            NSString *Name = Styleinfo.szName;
//            NSString *URL = Styleinfo.szUrl;
//            NSString *Dis = Styleinfo.szDesc;
//            NSString *Id = [NSString  stringWithFormat:@"%d",Styleinfo.nID ];
//            //字典表  name   URL    id    Discribe
//            NSDictionary *MusicItem = [NSDictionary dictionaryWithObjectsAndKeys:Name,@"name",
//                                       URL,@"URL",Id,@"id",
//                                       Dis,@"Discribe",nil];
//            [_MusicList addObject:MusicItem];
//        }
//
//        dispatch_async(dispatch_get_main_queue(),^(void){
//            [self.tableView reloadData];
//        });
//    });
}

-(void)changeOrderInfo:(int)musicId
{
    NewNSOrderDetail *noworder = [MC_OrderAndMaterialCtrl GetFreshOrder:[[UserEntity sharedSingleton].customerId intValue]];
    noworder.nMusicID = musicId;
    [MC_OrderAndMaterialCtrl UpdateFresh:noworder];
}

-(void)StopPlay{
    [self.player setURL:nil];
    [self.player.view setHidden:true];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else
    {
       return _MusicList.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MusicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicCellIdentify" forIndexPath:indexPath];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"MusicCell" owner:nil options:nil][0];
    }
    NSDictionary *music = [_MusicList objectAtIndex:indexPath.row];
    NSString *musicname = [music objectForKey:@"name"];
    if (indexPath.section == 0) {
        if (self.recommadMusic.szName) {
            cell.MusicName.text = self.recommadMusic.szName;
        }else
        {
            cell.MusicName.text = @"无";
        }
        
    }else
    {
       cell.MusicName.text = musicname;
    }
    cell.MusicName.highlightedTextColor = [UIColor redColor];
    cell.MusicName.textColor = [UIColor colorWithRed:219/256 green:219/256 blue:219/256 alpha:1.0];
    [cell.playview setHidden:TRUE];
    if (indexPath == self.tempSelIndex) {
        cell.seleImageView.hidden = NO;
    }else
    {
        cell.seleImageView.hidden = YES;
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 40)];
    if (section == 0) {
        label.text = @"  最佳匹配音乐";
    }else
    {
        label.text = @"  其他音乐";
    }
    label.backgroundColor = [UIColor lightGrayColor];
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCell *slectedCell = [tableView cellForRowAtIndexPath:self.tempSelIndex];
    slectedCell.seleImageView.hidden = YES;
    MusicCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
    Cell.seleImageView.hidden = NO;
    
    self.tempSelIndex = indexPath;
    
    NSDictionary *music = [_MusicList objectAtIndex:indexPath.row];
    NSString *musicURL = nil;
//    NSString *musicid = nil;
    if (indexPath.section == 0) {
        musicURL = self.recommadMusic.szUrl;
        musicURL = [musicURL stringByAppendingString:@"music.mp3"];
//        musicid =  [NSString stringWithFormat:@"%@",self.recommadMusic.nID];
//        // 传递数据到预览界面
//        self.music(self.recommadMusic,indexPath);
    }else
    {
        musicURL = [music objectForKey:@"URL"];
        musicURL = [musicURL stringByAppendingString:@"music.mp3"];
//        musicid =  [music objectForKey:@"id"];
//        // 传递数据到预览界面
//        self.music(self.musics[indexPath.row],indexPath);
    }
    [self playinit:musicURL Name:@""];
//    [self changeOrderInfo:[musicid intValue]];
//    self.selIndex = indexPath;
    return indexPath;
}

- (void)getMusic:(void (^)(MovierDCInterfaceSvc_vpVDCMusicC *music,NSIndexPath *seleteIndex))music {
    self.music = music;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    MusicCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell.playview setHidden:FALSE];
//}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCell *cell = (MusicCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.playview setHidden:TRUE];
}

-(void)playinit:(NSString*)url Name:(NSString*)videoname{
    
    if (self.player == nil) {
        self.player = [[NGMoviePlayer alloc] init];
        [self.player.layout.zoomControl setHidden:TRUE];
    }
    self.player.delegate = self;
    [self.player.view setHidden:TRUE];
    [self.player setURL:[NSURL URLWithString:url] title:videoname];
}

- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didStartPlaybackOfURL:(NSURL *)URL{
    
    NSIndexPath *select = [self.tableView indexPathForSelectedRow];
    MusicCell *cell = (MusicCell*)[self.tableView cellForRowAtIndexPath:select];
    [cell.playview setHidden:FALSE];
}

- (void)moviePlayer:(NGMoviePlayer *)moviePlayer didFinishPlaybackOfURL:(NSURL *)URL {
    [self.player pause];
}

@end
