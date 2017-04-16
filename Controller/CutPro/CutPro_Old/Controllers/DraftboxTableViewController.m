//
//  DraftboxTableViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/5/28.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "DraftboxTableViewController.h"
#import "DraftboxTableViewcell.h"
#import "MC_OrderAndMaterialCtrl.h"

@implementation DraftboxTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"草稿箱";
    int ret = [self judgeStatus];
//    if (ret == 0) {
//        array = [[NSMutableArray alloc] init];
//        array = [[APPUserPrefs Singleton] APP_OrderDetail_Custerm0_CacheInformationDBSearch];
//    }else if(ret == 1){
//        array = [[NSMutableArray alloc] init];
//        array = [[APPUserPrefs Singleton] APP_OrderDetail_Custerm1_CacheInformationDBSearch:[[UserEntity sharedSingleton].customerId intValue]];
//    }
    if (ret==1) {
        MC_OrderAndMaterialCtrl *orderctl = [[MC_OrderAndMaterialCtrl alloc]init];
        array = [[orderctl GetUncommitOrder:[[UserEntity sharedSingleton].customerId intValue]] mutableCopy];
    }
    [self.navigationController.tabBarController.tabBar setHidden:true];
    self.tabV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 返回按钮点击方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(int)judgeStatus
{
    int ret = -1;
    if ([UserEntity sharedSingleton].customerId == 0) {
        ret = 0;
    }else{
        ret = 1;
    }
    return ret;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([array count] == 0) {
        UIView * tableBackView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.tabV.backgroundView = tableBackView;
        tableBackView.tag = 10000;
        UILabel * tableBackLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, ISScreen_Height / 2 - 64, ISScreen_Width, 32)];
        [tableBackView addSubview:tableBackLabel];
        tableBackLabel.text = @"您没有添加草稿";
        tableBackLabel.textColor = [UIColor grayColor];
        tableBackLabel.font = [UIFont fontWithName:@"Helvetica" size:18.f];
        tableBackLabel.textAlignment = NSTextAlignmentCenter;
        tableBackView.hidden = NO;
    }else{
        UIView * myView = (id)[self.view viewWithTag:10000];
        myView.hidden = YES;
        [myView removeFromSuperview];
        myView = nil;
    }
    return [array count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *DraftboxIdentifier = @"DraftboxIdentifier";
    DraftboxTableViewcell *cell = [tableView dequeueReusableCellWithIdentifier:DraftboxIdentifier];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DraftboxIdentifier];
    if (cell == nil) {
        cell = [[DraftboxTableViewcell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:DraftboxIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    NewNSOrderDetail *OrderDetail = [array objectAtIndex:row];
    cell.draftboxTimeLabel.text = OrderDetail.createTime;
    cell.draftboxlabel.text = OrderDetail.szVideoName;
    NSMutableArray *ordermaterials = [MC_OrderAndMaterialCtrl GetMaterial:[[UserEntity sharedSingleton].customerId intValue] Orderid:OrderDetail.order_id];

//    if ([ordermaterials count]) {
//        NewOrderVideoMaterial *firstmaterial = [ordermaterials objectAtIndex:0];
//        if (![firstmaterial.material_assetsURL isEqualToString:@""]) {
//            ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
//            NSURL *asseturl = [NSURL URLWithString:firstmaterial.material_assetsURL];
//            [library assetForURL:asseturl resultBlock:^(ALAsset *asset) {
//                if (!asset){
//                }else{
//                    cell.imageview.image = [UIImage imageWithCGImage:asset.thumbnail];
//                }
//            } failureBlock:^(NSError *error) {
//                
//            }];
//        }
//    }
    BOOL hasPhoto = NO;
    NSInteger index = 0;
    for (NSInteger i = 0; i < ordermaterials.count; i ++) {  // 看是否有图片素材
        NewOrderVideoMaterial *materil = ordermaterials[i];
        if (materil.material_type == 1) {   // material_type  1: 照片, 2: 视频
            index = i;
            hasPhoto = YES;
            break;
        }
    }
    ALAssetsLibrary *lib = [[ALAssetsLibrary alloc] init];
    if (hasPhoto == YES) {  // 有图片
        NSURL *url = [NSURL URLWithString:[ordermaterials[index] material_assetsURL]];
        [lib assetForURL:url resultBlock:^(ALAsset *asset) {
            UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
            cell.imageView.image = image;
            cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        } failureBlock:^(NSError *error) {
            NSLog(@"-----%s------%@", __func__, error);
        }];
    } else {    // 没有图片
        NSURL *url = [NSURL URLWithString:[ordermaterials[0] material_assetsURL]];
        [lib assetForURL:url resultBlock:^(ALAsset *asset) {
            UIImage *image = [UIImage imageWithCGImage:asset.thumbnail];
            cell.imageView.image = image;
            cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        } failureBlock:^(NSError *error) {
            NSLog(@"-----%s------%@", __func__, error);
        }];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ISCutProViewController *setPrizeVC = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-1];
//    setPrizeVC.newsNSOrderDetail = [array objectAtIndex:indexPath.row];
    NewNSOrderDetail* order = [MC_OrderAndMaterialCtrl GetDraftOrder:[[UserEntity sharedSingleton].customerId intValue] Index:indexPath.row];
    [MC_OrderAndMaterialCtrl Fresh2Uncommit:[[UserEntity sharedSingleton].customerId intValue]];
    [MC_OrderAndMaterialCtrl ChangeOrderStatus:order.order_id Status:FRESHORDER];
    NSDictionary * orderInfo = [NSDictionary dictionaryWithObjectsAndKeys:@(order.order_id), @"orderID", nil];
    [[NSNotificationCenter defaultCenter] postNotification:[[NSNotification alloc] initWithName:@"pushToISCutPreViewController" object:nil userInfo:orderInfo]];
    [self.navigationController.tabBarController setSelectedIndex:1];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
//        NewNSOrderDetail *newNSOrderDetail1 = [[NewNSOrderDetail alloc] init];
        NewNSOrderDetail *newNSOrderDetail = [array objectAtIndex:indexPath.row];
        [array removeObjectAtIndex:[indexPath row]];
        [MC_OrderAndMaterialCtrl DeleteDraftOrder:[[UserEntity sharedSingleton].customerId intValue] Order:newNSOrderDetail.order_id];
        
//        NewNSOrderDetail *newNSOrderDetail1 = nil;
//        if ([NewUserOrderList Singleton].newcutlist.count > 0) {
//            newNSOrderDetail1 = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
//        }

//        if ([newNSOrderDetail.createTime isEqualToString:newNSOrderDetail1.createTime]) {
//            [[NewUserOrderList Singleton].newcutlist removeAllObjects];
//            if([array count]){
////                NewNSOrderDetail *newNSOrderDetail2 = [[NewNSOrderDetail alloc] init];
//                NewNSOrderDetail *newNSOrderDetail2 = [array objectAtIndex:0];
//                [[NewUserOrderList Singleton].newcutlist addObject:newNSOrderDetail2];
//            }
//        }
//        [[APPUserPrefs Singleton] APP_OrderDetailSelect_CacheInformationDBDelete:newNSOrderDetail];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationTop];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController.tabBarController.tabBar setHidden:NO];
}

@end
