//
//  ChatViewController.m
//  M-Cut
//
//  Created by apple on 16/7/7.
//  Copyright © 2016年 Crab movier. All rights reserved.
//
/*
 数据源保存对象内容(时间、聊天内容、用户头像url)
 分组显示，组的头视图显示时间
 默认显示最近聊天内容，所以偏移量是到最底部
 */
#import "ChatViewController.h"
#import "FriendChatCell.h"
#import "MyChatCell.h"
#import "VideoDBOperation.h"
#import "PrivateMesObj.h"
#import "UserEntity.h"
#import "SoapOperation.h"
#import "CustomeClass.h"
#import "HomeVideoReportViewController.h"

@interface ChatViewController ()<UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (weak, nonatomic) IBOutlet UITableView *chatTable;
/** 聊天数据源*/
@property (nonatomic, strong) NSMutableArray * chatMuArray;
/** 聊天背景框*/
@property (nonatomic, strong) UIView * tabBackView;
/** 键盘高度*/
@property (nonatomic, assign) CGFloat currentKeyboardHeight;
@end

@implementation ChatViewController

#pragma mark - 数据源懒加载
//LAZYLOADINGARRAY(chatMuArray, _chatMuArray)
- (NSMutableArray *)chatMuArray{
    if (!_chatMuArray) {
        _chatMuArray = [NSMutableArray new];
    }
    return _chatMuArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [self downloadData];
}



#pragma mark - downloadData
- (void)downloadData{
    //获得当前登录用户和这个好友的私信信息
    WEAKSELF(weakSelf);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf.chatMuArray addObjectsFromArray:[[VideoDBOperation Singleton] selectMesFromMesTabWithStartUserId:self.friendInfo.userId]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.chatTable reloadData];
            if (weakSelf.chatMuArray.count > 0) {
                [weakSelf.chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.chatMuArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
            
        });
    });
}

#pragma mark - initUI
- (void)initUI{
    self.title = self.friendInfo.nickName;
    
    //返回按钮
    UIButton * backBtn = [UIButton new];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"backbutton"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    //注册键盘高度获取通知
    self.currentKeyboardHeight = 0;
    REGISTEREDNOTI(keyboardChange:, UIKeyboardDidChangeFrameNotification);
    
    //注册接受私信消息的通知
    REGISTEREDNOTI(updatechatTable:, PRIVATEMESNOTI);
    
    //键盘退出手势
    ADDTAPGESTURE(self.view, hiddenKeyboard);
    
    //导航栏右侧按钮
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"little"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonItemAction)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)rightBarButtonItemAction{
    [self.view endEditing:YES];
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"举报" otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        // 进入举报界面
        HomeVideoReportViewController *report = [[HomeVideoReportViewController alloc] initWithNibName:@"HomeVideoReportViewController" bundle:nil];
        [self.navigationController pushViewController:report animated:YES];
    }
}

- (void)hiddenKeyboard:(UITapGestureRecognizer *)tap{
    [self.view endEditing:YES];
}

- (void)updatechatTable:(NSNotification *)noti{
    //接收到好友发来的消息刷新
    //查询数据库刷新页面
    [self downloadData];
}


#pragma mark - 键盘变化

- (void)setTableWithNoti:(NSNotification *)noti{
    CGSize keyboardSize = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    int changHeight = [[NSString stringWithFormat:@"%f", self.currentKeyboardHeight] intValue] - [[NSString stringWithFormat:@"%f", keyboardSize.height] intValue];
    
    self.currentKeyboardHeight = keyboardSize.height;
    if (changHeight == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            self.sendBtn.frame = CGRectMake(self.sendBtn.frame.origin.x, self.sendBtn.frame.origin.y + keyboardSize.height, self.sendBtn.frame.size.width, self.sendBtn.frame.size.height);
            self.inputTextView.frame = CGRectMake(self.inputTextView.frame.origin.x, self.inputTextView.frame.origin.y + keyboardSize.height, self.inputTextView.frame.size.width, self.inputTextView.frame.size.height);
            self.chatTable.frame = CGRectMake(0, 0, self.chatTable.frame.size.width, self.chatTable.frame.size.height + keyboardSize.height);
        }];
        self.currentKeyboardHeight = 0;
        return;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.sendBtn.frame = CGRectMake(self.sendBtn.frame.origin.x, self.sendBtn.frame.origin.y + changHeight, self.sendBtn.frame.size.width, self.sendBtn.frame.size.height);
        self.inputTextView.frame = CGRectMake(self.inputTextView.frame.origin.x, self.inputTextView.frame.origin.y + changHeight, self.inputTextView.frame.size.width, self.inputTextView.frame.size.height);
        self.chatTable.frame = CGRectMake(0, 0, self.chatTable.frame.size.width, self.chatTable.frame.size.height + changHeight);
    }];
    
}

- (void)keyboardChange:(NSNotification *)noti{
    [self setTableWithNoti:noti];
}

#pragma mark - 返回按钮方法
- (void)backButtonAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)sendBtnAction:(id)sender {
    [self sendButtonAction];
}

/** 发送按钮点击方法*/
- (void)sendButtonAction{
    NSString * sendStr = [self.inputTextView.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (sendStr.length == 0) {
        [CustomeClass showMessage:@"不能发送空格" ShowTime:1.5];
        return;
    }
    
    [self.view endEditing:YES];
    
    //发送给后台
    WEAKSELF(weakSelf);
    [[SoapOperation Singleton] WS_sendprivatemessageWithTargetUserId:self.friendInfo.userId MesContent:self.inputTextView.text Success:^(NSNumber *num) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //保存当前用户的私信信息
            [weakSelf.chatMuArray addObject:[PrivateMesObj saveCurrentLoginUserChatContent:weakSelf.friendInfo Content:weakSelf.inputTextView.text]];
            [weakSelf.chatTable reloadData];
            [weakSelf.chatTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:weakSelf.chatMuArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            weakSelf.inputTextView.text = @"";
            [CustomeClass showMessage:@"发送成功" ShowTime:1.5];
        });
        
    } Fail:^(NSError *error) {
        if (error.code == 49) {
            [CustomeClass showMessage:@"只有好友才可以发送消息哦！" ShowTime:1.5];
        }else{
            MAINQUEUEUPDATEUI([CustomeClass showMessage:@"发送失败" ShowTime:1.5];)
            DEBUGLOG(error);
        }
    }];
}

#pragma mark - tableDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BACKPROPMTVIEW(self.chatMuArray.count == 0, 1000, @"您与这个好友还没有聊天消息", chatTable)
    return self.chatMuArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PrivateMesObj * priMesObj = self.chatMuArray[indexPath.row];
    if ([priMesObj.mesStartId isEqualToString:CURRENTUSERID]) {
        MyChatCell * cell = [MyChatCell getMyChatCellWithTable:tableView ChatContent:priMesObj.mesContent];
        return cell.myChatContentTextViewHeight.constant + 32;
    }else{
        FriendChatCell * cell = [FriendChatCell getFriendChatCellWithTable:tableView FriendHeadImageUrl:priMesObj.startUserIconUrl ChatContent:priMesObj.mesContent];
        return cell.friendContentHeight.constant + 32;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PrivateMesObj * priMesObj = self.chatMuArray[indexPath.row];
    if ([priMesObj.mesStartId isEqualToString:CURRENTUSERID]) {
        return [MyChatCell getMyChatCellWithTable:tableView ChatContent:priMesObj.mesContent];
    }else{
        return [FriendChatCell getFriendChatCellWithTable:tableView FriendHeadImageUrl:priMesObj.startUserIconUrl ChatContent:priMesObj.mesContent];
    }
}

@end
