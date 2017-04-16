//
//  MyAccountTableViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/16.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "MyAccountTableViewController.h"

@implementation MyAccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyAccountList" ofType:@"plist"];
    self.myAccountDic = [NSDictionary dictionaryWithContentsOfFile:path];
    self.myAccountkeys = [self.myAccountDic allKeys];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _myAccountkeys.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = self.myAccountkeys[section];
    NSArray *arr = [self.myAccountDic objectForKey:key];
    return [arr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *myAccountIdentifier_detail = @"MyAccountIdentifier_detail";
    static NSString *myAccountIdentifier_button = @"MyAccountIdentifier_button";
    if (indexPath.row == 0) {
        UITableViewCell *cell_detail = [tableView dequeueReusableCellWithIdentifier:myAccountIdentifier_detail forIndexPath:indexPath];
        cell_detail.textLabel.text = [_myAccountDic allValues][indexPath.section][0];
        cell_detail.detailTextLabel.text = @"登陆";
        return cell_detail;
    }else{
        UITableViewCell *cell_button = [tableView dequeueReusableCellWithIdentifier:myAccountIdentifier_button forIndexPath:indexPath];
        UIImage *image= [ UIImage imageNamed:@"cutPro_tab" ];
        UIButton *bindButton = [ UIButton buttonWithType:UIButtonTypeCustom ];
        bindButton.frame = CGRectMake( 0.0 , 0.0 , image.size.width , image.size.height );;
        [bindButton setTitle:@"绑定" forState:UIControlStateNormal];
        bindButton.backgroundColor = [UIColor clearColor];
        [bindButton setImage:image forState:UIControlStateNormal];
        [bindButton addTarget:self action:@selector(bindButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cell_button.accessoryView = bindButton;
        NSString *key = self.myAccountkeys[indexPath.section];
        NSArray *arr = [self.myAccountDic objectForKey:key];
        cell_button.textLabel.text = arr[indexPath.row];
        return cell_button;
    }
}

- (void)bindButtonAction:(UIButton *)button{
    NSLog(@"绑定");
}
@end
