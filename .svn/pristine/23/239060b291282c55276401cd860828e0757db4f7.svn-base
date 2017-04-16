//
//  DistrictTableViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/29.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "DistrictTableViewController.h"
#import "SoapOperation.h"

@implementation DistrictTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
//    cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
    
//    self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
//    self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
//    
//    areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
//    if (areas.count > 0) {
//        self.locate.district = [areas objectAtIndex:0];
//    } else{
//        self.locate.district = @"";
//    }
    
    //标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"编辑地区";
    label.font = ISFont_17;
    label.textColor = [UIColor whiteColor];
    CGSize labelSize = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.titleView = label;
    
    //返回按钮
    UIButton * backButton = [UIButton new];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [backButton setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //注册接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(uploadAddress:) name:@"userAddress" object:nil];
}

/** 通知方法*/
- (void)uploadAddress:(NSNotification *)noti{
    NSArray * addressArray = [finish componentsSeparatedByString:@"-"];
    self.myUserInfo.szLocationProvince = addressArray[0];
    self.myUserInfo.szLocationCity = addressArray[1];
    [[SoapOperation Singleton] WS_SetUserInfo:self.myUserInfo Success:^(NSNumber *num) {
        NSLog(@"上传用户地址成功");
    } Fail:^(NSError *error) {
        NSLog(@"上传用户地址失败-------%@", error);
    }];
}

- (void)backButtonAction{
    [self.navigationController  popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.districtTabV reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return [provinces count];
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *DistrictIdentifier_orientation = @"DistrictIdentifier_orientation";
        UITableViewCell *cell_orientation = [tableView dequeueReusableCellWithIdentifier:DistrictIdentifier_orientation];
        cell_orientation.textLabel.text = finish;
        return cell_orientation;
    } else {
        static NSString *DistrictIdentifier_location = @"DistrictIdentifier_location";
        ProvincialTableViewCell *cell_location = [tableView dequeueReusableCellWithIdentifier:DistrictIdentifier_location];
        cell_location.provincialLabel.text = [[provinces objectAtIndex:indexPath.row] objectForKey:@"state"];
        return cell_location;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    state = [[provinces objectAtIndex:indexPath.row] objectForKey:@"state"];
    finish = state;
    dissession = (int)indexPath.row;
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"定位到的位置";
    } else {
        return @"全部";
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    self.districtBlock(finish);
}

@end
