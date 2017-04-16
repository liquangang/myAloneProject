//
//  IntegralRecordViewController.m
//  M-Cut
//
//  Created by apple on 16/6/12.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "IntegralRecordViewController.h"
#import "integralRecordUserCell.h"
#import "CustomeClass.h"
#import "SoapOperation.h"
//记录自定义cell
#import "IntegralRecordTableViewCell.h"
#import "MJRefresh.h"


@interface taskObj : NSObject
@property (nonatomic, strong) MovierDCInterfaceSvc_VDCMyScoreLog * taskLog;
/** 是否已经被分组*/
@property (nonatomic, assign) BOOL isGrouped;
@end

@implementation taskObj
@end

@interface IntegralRecordViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray * taskDataMuArray;
@property (weak, nonatomic) IBOutlet UITableView *taskTable;
/** 下载数据的个数*/
@property (nonatomic, assign) int downloadDataNum;
@end

@implementation IntegralRecordViewController

#pragma mark - 数组懒加载
LAZYLOADINGARRAY(taskDataMuArray, _taskDataMuArray)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self downloadData];
}

#pragma mark - 下载数据
- (void)downloadData{
    DEFAULTQUEUEANALYSISANDMAINQUEUEUPDATEUI({
        [self downloadDataWithOffest:0 Count:self.downloadDataNum+=16];
    }, {})
    
}

/** 根据传入的起始位置和数据个数下载数据并刷新table*/
- (void)downloadDataWithOffest:(NSInteger)myOffest Count:(NSInteger)myCount{
    __weak typeof(self) weakSelf = self;
    [CustomeClass hudShowWithView:weakSelf.view Tag:1234];
    [[SoapOperation Singleton] ws_GetscorelogWithOffest:myOffest Count:myCount Success:^(MovierDCInterfaceSvc_VDCMyScoreLogArr *integralInfo) {
        [weakSelf.taskDataMuArray removeAllObjects];
        weakSelf.taskDataMuArray = [weakSelf groupDataWithArray:integralInfo.item];
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomeClass hudHiddenWithView:weakSelf.view Tag:1234];
            [weakSelf.taskTable reloadData];
            [weakSelf.taskTable footerEndRefreshing];
            if (integralInfo.item.count == 0) {
                [weakSelf.taskTable removeFooter];
            }
        });
    } Fail:^(NSError *error) {
        [CustomeClass hudHiddenWithView:weakSelf.view Tag:1234];
        RELOADSERVERDATA([weakSelf downloadDataWithOffest:myOffest Count:myCount];)
    }];
}

/** 给数据分组*/
- (NSMutableArray *)groupDataWithArray:(NSMutableArray *)myMuArray{
    NSMutableArray * taksObjArray = [NSMutableArray new];
    for (MovierDCInterfaceSvc_VDCMyScoreLog * scoreLog in myMuArray) {
        taskObj * newTaskObj = [taskObj new];
        newTaskObj.taskLog = scoreLog;
        newTaskObj.isGrouped = NO;
        [taksObjArray addObject:newTaskObj];
    }
    NSMutableArray * objMuArray = [NSMutableArray new];
    int k = 0;
    for (int i = 0; i < taksObjArray.count - 1; i++) {
        taskObj * firstLog = [taskObj new];
        if (taksObjArray.count > i) {
            firstLog = taksObjArray[i];
        }
        if (!firstLog.isGrouped && taksObjArray.count > i) {
            if (objMuArray.count - 1 != k) {
                [objMuArray addObject:[NSMutableArray new]];
            }
            [objMuArray[k] addObject:firstLog.taskLog];
            firstLog.isGrouped = YES;
            for (int j = i + 1; j < taksObjArray.count; j++) {
                taskObj * secondLog = taksObjArray[j];
                if ([firstLog.taskLog.szCreateDate isEqualToString:secondLog.taskLog.szCreateDate]) {
                    if (!secondLog.isGrouped) {
                        secondLog.isGrouped = YES;
                        [objMuArray[k] addObject:secondLog.taskLog];
                    }
                }
                if (i == taksObjArray.count - 2 && j == taksObjArray.count - 1 && ![firstLog.taskLog.szCreateDate isEqualToString:secondLog.taskLog.szCreateDate]) {
                    if (!secondLog.isGrouped) {
                        secondLog.isGrouped = YES;
                        k++;
                        if (objMuArray.count - 1 != k) {
                            [objMuArray addObject:[NSMutableArray new]];
                        }
                        [objMuArray[k] addObject:secondLog.taskLog];                    }
                }
            }
            k++;
        }
    }
    NSMutableArray * newObjArray = [NSMutableArray new];
    if (self.isFromMyCoinVc) {
        int i = 0;
        for (NSMutableArray * dataMuArray in objMuArray) {
            for (MovierDCInterfaceSvc_VDCMyScoreLog * scoreLog in dataMuArray) {
                if ([scoreLog.nInshianCoin intValue] != 0) {
                    if ((newObjArray.count - 1) != i) {
                        [newObjArray addObject:[NSMutableArray new]];
                    }
                    [newObjArray[i] addObject:scoreLog];
                }
            }
            if ([newObjArray count] - 1 == i) {
                i++;
            }
        }
    }else{
        int i = 0;
        for (NSMutableArray * dataMuArray in objMuArray) {
            for (MovierDCInterfaceSvc_VDCMyScoreLog * userLog in dataMuArray) {
                if ([userLog.nScore intValue] != 0) {
                    if ((newObjArray.count - 1) != i) {
                        [newObjArray addObject:[NSMutableArray new]];
                    }
                    [newObjArray[i] addObject:userLog];
                }
            }
            if ([newObjArray count] == i + 1) {
                i++;
            }
        }
    }
    return newObjArray;
}

#pragma mark - initUI
- (void)initUI{
    self.title = @"积分记录";
    if (self.isFromMyCoinVc) {
        self.title = @"映币记录";
    }
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    self.downloadDataNum = 16;
    [self.taskTable addFooterWithTarget:self action:@selector(downloadData)];
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return [self.taskDataMuArray[section - 1] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.taskDataMuArray.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 88;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 12;
    }
    if (section == self.taskDataMuArray.count) {
        return 1;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }
    return 22;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ISScreen_Width, 22)];
        headerView.backgroundColor = [UIColor whiteColor];
        MovierDCInterfaceSvc_VDCMyScoreLog * scoreLog = self.taskDataMuArray[section - 1][0];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, ISScreen_Width - 16, 22)];
        label.text = scoreLog.szCreateDate;
        label.textColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1];
        [headerView addSubview:label];
        UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 21, ISScreen_Width, 1)];
        lineLabel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [headerView addSubview:lineLabel];
        UILabel * lineLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, ISScreen_Width, 1)];
        [headerView addSubview:lineLabel2];
        lineLabel2.backgroundColor = [UIColor groupTableViewBackgroundColor];
        return headerView;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor whiteColor];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    view.tintColor = [UIColor clearColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        integralRecordUserCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"integralRecordUserCell" owner:nil options:nil] lastObject];
        }
        [cell setUserIntegralLabelWithStr:self.userAllScore];
        return cell;
    }
    
    IntegralRecordTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"IntegralRecordTableViewCell" owner:nil options:nil] lastObject];
    }
    [cell setCellWithObj:self.taskDataMuArray[indexPath.section - 1][indexPath.row] needShowImage:self.isFromMyCoinVc];
    return cell;
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
