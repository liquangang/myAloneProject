//
//  EditMyInforTableViewController.m
//  M-Cut
//
//  Created by losehero on 15/12/4.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "EditMyInforTableViewController.h"
#import "EditInforCell.h"
#import "RFKeyboardToolbar.h"
#import "RFExampleToolbarButton.h"
#import "DistrictTableViewController.h"
#import "DateSelecterViewController.h"
#import "SoapOperation.h"
#import "HeaderChange.h"
#import "UserEntity.h"

@interface EditMyInforTableViewController ()<UITextViewDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,EditInforCellDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) NSArray *rowsData;
@property (nonatomic,strong) UITextField *currentTextField;
@property (nonatomic,retain) EditInforCell *currentCell;
@property (nonatomic,strong) MovierDCInterfaceSvc_VDCCustomerInfo *Userinfo;
@end

@implementation EditMyInforTableViewController
{
    RFExampleToolbarButton *exampleButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyInformation" ofType:@"plist"];
    self.rowsData = [NSArray arrayWithContentsOfFile:path];
    
    self.title = @"编辑个人资料";
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc]
                                     initWithImage:nil
                                     style:UIBarButtonItemStylePlain
                                     target:self action:@selector(saveButtonAction)];
    saveButton.title = @"保存";
    
    self.navigationItem.rightBarButtonItem = saveButton;

    __weak typeof(self) wself = self;
    
    [[SoapOperation Singleton] WS_QueryUserInfo:^(MovierDCInterfaceSvc_VDCCustomerInfo *info) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"szTel1--------%@", info.szTel);
            wself.Userinfo = info;
            [wself.tableView reloadData];
            
                });
        
    } Fail:^(NSError *error) {
        
    }];
    
}

-(void)saveButtonAction
{
    [self textFieldShouldReturn:_currentTextField];
    
    [[SoapOperation Singleton] WS_SetUserInfo:self.Userinfo
                                  Success:^(NSNumber *num) {

                                      dispatch_async(dispatch_get_main_queue(), ^{
                                         NSLog(@"szTel2--------%@", self.Userinfo.szTel);
                                          UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                                              message:@"用户信息修改成功!"
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil, nil];
                                          alertView.delegate = self;
                                          [alertView show];
  
                                          
                                      });
                                      
                                      
                                      NSLog(@"success num : %td",[num integerValue]);
                                      
                                  } Fail:^(NSError *error)
                                  {
                                      [self.navigationController popViewControllerAnimated:YES];
                                      NSLog(@"error : %@",error);
                                  }];
  [self.navigationController popViewControllerAnimated:YES];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.rowsData count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.rowsData objectAtIndex:section] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 4)];
    view.backgroundColor = [UIColor colorWithRed:209.0/255.0 green:211.0/255.0 blue:212.0/255.0 alpha:2];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [[self.rowsData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *title = [[dic allKeys] lastObject];
    if ([title isEqualToString:@"个人签名"])
    {
        return 155;
    }
    if ([title isEqualToString:@"邮箱"]) {
        return 0;
    }
    
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = [[self.rowsData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *title = [[dic allKeys] lastObject];
    NSString *identifier = @"EditInforCell";
    
    if ([title isEqualToString:@"头像"])
    {
        identifier = @"EditHeadCell";
    }
    else if([title isEqualToString:@"性别"])
    {
        identifier = @"EditInforSexCell";
    }
    else if([title isEqualToString:@"个人签名"])
    {
        identifier = @"EditInforTextViewCell";
    }
    
    
    EditInforCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.userInfo = self.Userinfo;
    cell.titleLabel.text = title;
    cell.delegate = self;
    cell.textView.delegate = self;
    cell.editField.delegate = self;
    cell.editField.tag = (indexPath.section+1) *1000 + indexPath.row;
    cell.editField.returnKeyType = UIReturnKeyDone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (!exampleButton && cell.textView)
    {
        exampleButton = [RFExampleToolbarButton new];
        [RFKeyboardToolbar addToTextView:cell.textView withButtons:@[exampleButton]];
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_currentTextField resignFirstResponder];
    _currentCell = [tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *dic = [[self.rowsData objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *title = [[dic allKeys] lastObject];
    
    if (indexPath.section == 0)
    {
        [self uploadImage];
    }
    
    if (indexPath.section == 3)
    {
        if ([title isEqualToString:@"地区"])
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
            DistrictTableViewController *districtTabVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"DistrictTabVCStoryBoardID"];
            districtTabVC.districtBlock = ^(NSString *st)
            {
                NSArray *citys = [st componentsSeparatedByString:@"--"];
                if ([citys count] == 1)
                {
                    self.Userinfo.szLocationProvince = st;
                }
                else if([citys count] > 1)
                {
                    self.Userinfo.szLocationProvince = [citys firstObject];
                    self.Userinfo.szLocationCity = [citys lastObject];
                }
                
                if (citys.count > 1) {
                    [_currentCell.editField setText:st];
                }
                
            };
            
            [self.navigationController pushViewController:districtTabVC animated:YES];
        }else if([title isEqualToString:@"生日"])
        {
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
            DateSelecterViewController *DateSelecterVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"DateSelecterVCStoryBoardID"];
            [self.navigationController pushViewController:DateSelecterVC animated:YES];
            DateSelecterVC.dateBlock = ^(NSString *strin){
                NSArray *arrayl = [strin componentsSeparatedByString: @"/"];
                NSString *date = [NSString stringWithFormat:@"%d-%d-%d",[[arrayl objectAtIndex:0] intValue],
                                                                        [[arrayl objectAtIndex:1] intValue],
                                                                        [[arrayl objectAtIndex:2] intValue]];
                
                self.Userinfo.nBirthdayY = [NSNumber numberWithInt:[[arrayl objectAtIndex:0] intValue]];
                self.Userinfo.nBirthdayM = [NSNumber numberWithInt:[[arrayl objectAtIndex:1] intValue]];
                self.Userinfo.nBirthdayD = [NSNumber numberWithInt:[[arrayl objectAtIndex:2] intValue]];
                
                [_currentCell.editField setText:date];
            };
        }
    }

}


- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"textView.text : %@",textView.text);
    if (textView.text.length > 50)
    {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"签名数字限制为50个字符以内!"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    else
    {
        self.Userinfo.szSignature = textView.text;
    }
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"请输入50个字以内的个性签名"]) {
        textView.text = @"";
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _currentTextField = textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    NSLog(@"textField.tag : %d",textField.tag);
    
    if (textField.tag == 2000)
    {
        if (textField.text.length < 1 || textField.text.length > 16)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                                message:@"昵称为1-16个字，请重新输入"
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
        else
        {
                self.Userinfo.szNickname = textField.text;
        }

    }
    
    if (textField.tag == 4002)
    {
        if (textField.text.length)
        {
            self.Userinfo.szEmail = textField.text;
        }
    }
    
    _currentTextField = nil;
    return YES;
}


-(void)EditInforCellSelectisBoyDelegate:(BOOL)isboy
{
    if (isboy)
    {
        self.Userinfo.nGender = [NSNumber numberWithInt:1];
    }
    else
    {
        self.Userinfo.nGender = [NSNumber numberWithInt:2];
    }
    
    NSLog(@"isBoy : %d",isboy);
}



-(void)uploadImage
{
    UIActionSheet *sheet;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择"
                                             delegate:self
                                    cancelButtonTitle:@"取消"
                               destructiveButtonTitle:nil
                                    otherButtonTitles:@"拍照",@"从相册选择",nil];
        
    }
    
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择"
                                            delegate:self
                                   cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                                   otherButtonTitles:@"从相册选择", nil];
        
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
    
}

-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    //照相
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 2:
                    // 取消
                    return;
                    
            }
        }
        else {
            if (buttonIndex == 0) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else {
                return;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
    //    [self saveImage:image withName:@"currentImage.png"];
    
    //    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    
    //    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //    NSData *imagedata = image
    NSData *imageData = UIImageJPEGRepresentation(image, .4);
    //UIImagePNGRepresentation(image);
    //    NSLog(@"savedImage : %@",imagedata);
    
    // type=avatar
    
//    
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
//                         imageData,@"upfile",
//                         @"avatar",@"type",
//                         nil];
    
    
    HeaderChange *headerChage = [HeaderChange Singleton];
    
    NSString *status =[headerChage UploadUserHeader:[NSString stringWithFormat:@"%d", [[UserEntity sharedSingleton].customerId intValue]]
                                                 EXt:@"jpg"
                                            Yourdata:imageData];
    
    NSLog(@"status : %@",status);
    
    self.Userinfo.szAcatar = status;
    
    [UserEntity sharedSingleton].szAcatar = status;
    [_currentCell.headImageView setImage:image];
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
