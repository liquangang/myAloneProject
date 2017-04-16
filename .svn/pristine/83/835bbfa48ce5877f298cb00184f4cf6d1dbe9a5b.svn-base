

//
//  AddAddressBookPersonViewController.m
//  M-Cut
//
//  Created by apple on 16/7/25.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "AddAddressBookPersonViewController.h"
#import <MessageUI/MessageUI.h>
#import "AddAddressBookPersonCell.h"
#import "CustomeClass.h"
#import "SoapOperation.h"
#import "Video.h"

@interface AddAddressBookPersonViewController ()<UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate>
/** 界面数据源*/
@property (nonatomic, strong) NSMutableArray * personMuArray;
@property (weak, nonatomic) IBOutlet UITableView *personTable;
/** 通讯录信息*/
@property (nonatomic, strong) NSDictionary * addressDic;
@end

@implementation AddAddressBookPersonViewController

#pragma mark - 数据源懒加载
- (NSMutableArray *)personMuArray{
    if (!_personMuArray) {
        _personMuArray = [NSMutableArray new];
    }
    return _personMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
    [self downloadData];
}

- (void)initUI{
    self.title = @"手机好友";
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downloadData{
    [CustomeClass hudShowWithView:self.view Tag:100000];
    WEAKSELF(weakSelf);
    [CustomeClass loadAddressBookDataWithBlock:^(NSDictionary *dataDic) {
        weakSelf.addressDic = [[NSDictionary alloc] initWithDictionary:dataDic];
        [weakSelf.personMuArray removeAllObjects];
        NSMutableArray * telArray = [NSMutableArray new];
        for (AddressBookModel * personModel in [dataDic objectForKey:ADDRESSBOOKDATA]) {
            if (personModel.tel) {
                [telArray addObject:personModel.tel];
            }
            
        }
        if (telArray.count == 0) {
            MAINQUEUEUPDATEUI({
                [weakSelf.personTable reloadData];
                [CustomeClass hudHiddenWithView:weakSelf.view Tag:100000];
            })
            return;
        }
        [[SoapOperation Singleton] WS_searchtelfriendWithTelArray:[telArray copy] Success:^(NSMutableArray *serverDataArray) {
            [telArray removeAllObjects];
            for (AddressBookModel * personModel in [dataDic objectForKey:ADDRESSBOOKDATA]) {
                for (MovierDCInterfaceSvc_SearchRetForTelFriend * searchFriend in serverDataArray) {
                    if ([personModel.tel isEqualToString:searchFriend.szTelNum]) {
                        personModel.inshowName = searchFriend.szNickname;
                        personModel.iconUrl = searchFriend.szAvatar;
                        personModel.friendType = [searchFriend.nFriendFlag stringValue];
                        personModel.userId = [searchFriend.nCustomerID stringValue];
                    }
                }
                [telArray addObject:personModel];
            }
            [weakSelf.personMuArray addObjectsFromArray:[telArray copy]];
            MAINQUEUEUPDATEUI({
                [weakSelf.personTable reloadData];
                [CustomeClass hudHiddenWithView:weakSelf.view Tag:100000];
            })
            
        } Fail:^(NSError *error) {
            DEBUGLOG(error);
        }];
    }];
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.addressDic) {
        if ([self.addressDic[ADDRESSBOOKPERMISSIONS] boolValue]) {
            //为真 权限已打开
            BACKPROPMTVIEW(self.personMuArray.count == 0, 1000, @"您还没有联系人", self.personTable);
        }else{
            //没有权限
            BACKPROPMTVIEW(YES, 1000, @"取通讯录权限关闭\n请到“设置-隐私-通讯录”中开启权限吧", self.personTable);
        }
    }
    return self.personMuArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressBookModel * personModel = self.personMuArray[indexPath.row];
    AddAddressBookPersonCell * cell = [AddAddressBookPersonCell getAddAddressBookPersonCellWithTable:tableView UserIconUrl:personModel.iconUrl UserName:personModel.name UserNickName:personModel.inshowName UserId:personModel.userId FriendType:personModel.friendType];
    WEAKSELF(weakSelf);
    [cell sendMes:^{
        [weakSelf showMessageView:@[personModel.tel] title:@"邀请好友" body:@"一起来玩映像吧！https://itunes.apple.com/cn/app/ying-xiang/id1013565760?mt=8"];
    }];
    [cell followUser:^{
        [weakSelf followSomeone:cell.userId];
    }];
    return cell;
}

/** 关注方法*/
- (void)followSomeone:(NSString *)userId{
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_followWithCustomID:userId Success:^(NSNumber *num) {
        DEBUGLOG(@"关注成功");
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomeClass showMessage:@"关注成功" ShowTime:2];
            [weakSelf downloadData];
        });
        
    } Fail:^(NSError *error) {
        DEBUGLOG(@"关注失败");
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [CustomeClass showMessage:@"关注失败" ShowTime:1.5];
        });
        NSLog(@"error---%@", error);
    }];
}

#pragma mark - MFMessageComposeViewControllerDelegate
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
        {
            [CustomeClass showMessage:@"邀请成功" ShowTime:1.5];
        }
            
            break;
        case MessageComposeResultFailed:
            //信息传送失败
        {
            [CustomeClass showMessage:@"邀请失败" ShowTime:1.5];
        }
            
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
            
            break;
        default:
            break;
    }
}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        controller.recipients = phones;
        controller.navigationBar.tintColor = [UIColor redColor];
        controller.body = body;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

@end
