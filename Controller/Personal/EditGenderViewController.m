//
//  EditGenderViewController.m
//  M-Cut
//
//  Created by apple on 16/5/16.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "EditGenderViewController.h"
#import "SoapOperation.h"

@interface EditGenderViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *genderTable;
@property (nonatomic, assign) int selectIndex;
@end

@implementation EditGenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

/** 初始化相关控件*/
- (void)initUI{
    //标题
    UILabel *label = [[UILabel alloc] init];
    label.text = @"编辑性别";
    label.font = ISFont_17;
    label.textColor = [UIColor whiteColor];
    CGSize labelSize = [label.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:17], NSFontAttributeName, nil]];
    label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    self.navigationItem.titleView = label;
    
    self.selectIndex = [self.myUserInfo.nGender intValue] - 1;
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //完成按钮
    UIButton * finishBtn = [UIButton new];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:finishBtn];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    CGSize mySize = [@"完成" sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:16], NSFontAttributeName, nil]];
    finishBtn.frame = CGRectMake(0, 0, 40, mySize.height);
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化table
    self.genderTable.delegate = self;
    self.genderTable.dataSource = self;
}

/** 返回按钮点击方法*/
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

/** 完成按钮的点击方法*/
- (void)finishButtonAction{
    [[SoapOperation Singleton] WS_SetUserInfo:self.myUserInfo
                                      Success:^(NSNumber *num) {
                                          NSLog(@"上传性别成功--------%@", num);
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                          });
                                      } Fail:^(NSError *error){
                                          NSLog(@"上传性别失败------%@", error);
                                      }];
    [self.navigationController popViewControllerAnimated:YES];
}

//table的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"男";
        }
            break;
            
        default:
        {
            cell.textLabel.text = @"女";
        }
            break;
    }
    if (self.selectIndex == indexPath.row) {
        UIImageView * selectImage = [[UIImageView alloc] initWithFrame:CGRectMake(ISScreen_Width - 46, 17, 12, 10)];
        [cell.contentView addSubview:selectImage];
        selectImage.image = [UIImage imageNamed:@"勾选"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row;
    self.myUserInfo.nGender = @(indexPath.row + 1);
    [self.genderTable reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
