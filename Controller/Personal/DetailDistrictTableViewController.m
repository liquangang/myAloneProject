//
//  DetailDistrictTableViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/29.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "DetailDistrictTableViewController.h"
//#import "PersonalInfoTableViewController.h"
#import "DistrictTableViewController.h"

@implementation DetailDistrictTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city.plist" ofType:nil]];
    cities = [[provinces objectAtIndex:dissession] objectForKey:@"cities"];
}

- (void)backButtonAction{
    [self.navigationController  popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DetailDistrictIdentifier = @"DetailDistrictIdentifier";
    DowntownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailDistrictIdentifier forIndexPath:indexPath];
    cell.downtownLabel.text = [cities objectAtIndex:indexPath.row];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    city = [cities objectAtIndex:indexPath.row];
    finish = [finish stringByAppendingString:@"-"];
    finish = [finish stringByAppendingString:city];
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"userAddress" object:nil userInfo:nil]];
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"全部";
}


@end
