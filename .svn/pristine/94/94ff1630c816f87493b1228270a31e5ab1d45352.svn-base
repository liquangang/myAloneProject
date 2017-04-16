//
//  PersonalInfoTableViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/28.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "PersonalInfoTableViewController.h"

@implementation PersonalInfoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    personalInformationSet = [[PersonalInformationSet alloc] init];
    personalInformationSet = [APPUserPrefs APP_getcustomerinfoex];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"PersonalInfoList.plist" ofType:nil];
    self.personInfoArra = [NSArray arrayWithContentsOfFile:plistPath];
    self.tableView.contentInset = UIEdgeInsetsMake(-1, 0, 0, 0);
    [self ossinit];
}

-(void)ossinit{
    NSString* myossid = [UserEntity sharedSingleton].ossID;
    NSString* myosskey = [UserEntity sharedSingleton].ossKey;
    NSString* myossEndpoint =@"http://";
    myossEndpoint = [NSString stringWithFormat:@"http://%@",[UserEntity sharedSingleton].ossEndpoint];
    [self loginWithUser:myossid andPsw:myosskey andEndP:myossEndpoint];
    _objects = [[NSMutableArray alloc] initWithCapacity:10000];
    _folders = [[NSMutableArray alloc] initWithCapacity:1000];
    _selectedobjs = [[NSMutableArray alloc] initWithCapacity:10000];
    _objectsURL = [[NSMutableArray alloc] initWithCapacity:100];
    self.bucketName = [UserEntity sharedSingleton].ossBucket;
    self.prefix = [UserEntity sharedSingleton].ossDir;
    ListObjectsRequest * lor = [[ListObjectsRequest alloc] initWithBucketName:self.bucketName prefix:self.prefix marker:nil maxKeys:0 delimiter:@"/"];
    [_client listObjects:lor];
    lor = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _personInfoArra.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr =  _personInfoArra[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *PersonInfoIdentifier_headPortrait = @"PersonInfoIdentifier_headPortrait";
    static NSString *PersonInfoIdentifier_right = @"PersonInfoIdentifier_right";
    static NSString *PersonInfoIdentifier_center = @"PersonInfoIdentifier_center";
    if ((indexPath.section ==0) &&(indexPath.row == 0)) {
        cell_headPortrait = [tableView dequeueReusableCellWithIdentifier:PersonInfoIdentifier_headPortrait forIndexPath:indexPath];
        cell_headPortrait.userHeadPortraitImgV.image = [[APPUserPrefs Singleton] APP_getImg:personalInformationSet.userHeadPortraitUrl ImageView:cell_headPortrait.userHeadPortraitImgV ImageName:@"head"];
        return cell_headPortrait;
    }else if(indexPath.section == 2){
        UITableViewCell *cell_center = [tableView dequeueReusableCellWithIdentifier:PersonInfoIdentifier_center forIndexPath:indexPath];
        cell_center.textLabel.text = _personInfoArra[indexPath.section][indexPath.row];
        cell_center.textLabel.textAlignment = NSTextAlignmentCenter;
        return cell_center;
    }else{
        cell_right = [tableView dequeueReusableCellWithIdentifier:PersonInfoIdentifier_right forIndexPath:indexPath];
        if ((indexPath.section == 0) && (indexPath.row == 1)) {
            cell_right.rightLabel.text = personalInformationSet.userNickName;
            namenick = [[NSString alloc] initWithString:personalInformationSet.userNickName];
        }else if ((indexPath.section == 0) && (indexPath.row == 2)) {
            cell_right.accessoryType = UITableViewCellAccessoryNone;
//            cell_right.rightLabel.text = [[APPUserPrefs Singleton] APP_LoginCacheInformationDBSearch].userName;
            cell_right.rightLabel.text = [UserEntity sharedSingleton].appUserName;
        }else if ((indexPath.section == 1) && (indexPath.row == 0)) {
            cell_right.rightLabel.text = personalInformationSet.userSex;
        }else if ((indexPath.section == 1) && (indexPath.row == 1)) {
            NSString *szBirthday = [[NSString alloc] initWithFormat:@"%d/%d/%d",personalInformationSet.nBirthdayY,personalInformationSet.nBirthdayM,personalInformationSet.nBirthdayD];
            cell_right.rightLabel.text = szBirthday;
        }else if ((indexPath.section == 1) && (indexPath.row == 2)) {
            cell_right.rightLabel.text = personalInformationSet.userRegion;
            finish = personalInformationSet.userRegion;
        }else if ((indexPath.section == 1) && (indexPath.row == 3)) {
            cell_right.rightLabel.text = personalInformationSet.userCelebratedDictum;
            szPersonalSignature = personalInformationSet.userCelebratedDictum;
        }else if ((indexPath.section == 1) && (indexPath.row == 4)) {
            cell_right.rightLabel.text = personalInformationSet.szEmail;
            szEmails = [[NSString alloc] initWithString:personalInformationSet.szEmail];
        }
        cell_right.textLabel.text = _personInfoArra[indexPath.section][indexPath.row];
        return cell_right;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ((indexPath.section == 0) &&(indexPath.row == 0)) {
        [self openMenu];
    }else if ((indexPath.section == 0) &&(indexPath.row == 1)) {
        NickNameViewController *nickNameVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NickNameVCStoryBoardID"];
        nickNameVC.nickBlock = ^(NSString *strg){
            personalInformationSet.userNickName = strg;
            [APPUserPrefs APP_updatecustomerinfo:personalInformationSet];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
        };
        [self.navigationController pushViewController:nickNameVC animated:YES];
    }else if ((indexPath.section == 0) &&(indexPath.row == 2)) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }else if ((indexPath.section == 1) &&(indexPath.row == 0)) {
        SexViewController *sexVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SexVCStoryBoardID"];
        [self.navigationController pushViewController:sexVC animated:YES];
        sexVC.sexBlock = ^(NSString *strin){
            personalInformationSet.userSex = strin;
            [APPUserPrefs APP_updatecustomerinfo:personalInformationSet];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
        };
    }else if ((indexPath.section == 1) &&(indexPath.row == 1)) {
        DateSelecterViewController *DateSelecterVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DateSelecterVCStoryBoardID"];
        [self.navigationController pushViewController:DateSelecterVC animated:YES];
        DateSelecterVC.dateBlock = ^(NSString *strin){
            NSArray *arrayl = [strin componentsSeparatedByString: @"/"];
            personalInformationSet.nBirthdayY = [[arrayl objectAtIndex:0] intValue];
            personalInformationSet.nBirthdayM = [[arrayl objectAtIndex:1] intValue];
            personalInformationSet.nBirthdayD = [[arrayl objectAtIndex:2] intValue];
            [APPUserPrefs APP_updatecustomerinfo:personalInformationSet];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
        };
    }else if ((indexPath.section == 1) &&(indexPath.row == 2)) {
        DistrictTableViewController *districtTabVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DistrictTabVCStoryBoardID"];
        districtTabVC.districtBlock = ^(NSString *st){
            PersonalInformationSet *tempSets = [APPUserPrefs APP_getcustomerinfoex];
            tempSets.userRegion = st;
            [APPUserPrefs APP_updatecustomerinfo:tempSets];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
        };
        [self.navigationController pushViewController:districtTabVC animated:YES];
    }else if ((indexPath.section == 1) &&(indexPath.row == 3)) {
        PersonalSignatureViewController *personalSignatureVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PersonalSignatureVCStoryBoardID"];
        personalSignatureVC.personalSignatureBlock = ^(NSString *str){
//            PersonalInformationSet *tempSets = [APPUserPrefs APP_getcustomerinfoex];
            personalInformationSet.userCelebratedDictum = str;
            [APPUserPrefs APP_updatecustomerinfo:personalInformationSet];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
        };
        [self.navigationController pushViewController:personalSignatureVC animated:YES];
    }else if ((indexPath.section == 1) &&(indexPath.row == 4)) {
        EmailViewController *emailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EmailVCStoryBoardID"];
        emailVC.emailBlock = ^(NSString *strg){
            personalInformationSet.szEmail = strg;
            [APPUserPrefs APP_updatecustomerinfo:personalInformationSet];
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationMiddle];
        };
        [self.navigationController pushViewController:emailVC animated:YES];
    }
}

-(void)openMenu
{
    photoActionSheet = [[UIActionSheet alloc]
                        initWithTitle:nil
                        delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [photoActionSheet showInView:self.view];
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == photoActionSheet.cancelButtonIndex){
        NSLog(@"取消");
    }
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self LocalPhoto];
            break;
        default:
            break;
    }
}

-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

-(void)LocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    UIImage *images = [editingInfo objectForKey:UIImagePickerControllerEditedImage];
    images = [self getImageFromImage:image scale:512];
    NSURL *url = [editingInfo objectForKey:UIImagePickerControllerReferenceURL];
    NSString *imageId = [url absoluteString];
    NSArray *tmpArray = [imageId componentsSeparatedByString: @"="];
    imageId = [tmpArray objectAtIndex:1];
    NSString *imageType = [tmpArray objectAtIndex:2];
    NSArray *tmpArray2 = [imageId componentsSeparatedByString: @"&"];
    imageId = [tmpArray2 objectAtIndex:0];
    NSString *fileName;
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil)
    {
        data = UIImageJPEGRepresentation(image, 1.0);
    }else{
        data = UIImagePNGRepresentation(image);
        imageType = @"png";
    }
    if (imageId == nil || [imageId isEqualToString:@""]) {
        fileName = [[NSString alloc] initWithFormat:@"movier/sysres/userheaderimage/%d.%@",VDC_session._session._nCustomerID, imageType];
    }else{
        fileName = [[NSString alloc] initWithFormat: @"movier/sysres/userheaderimage/%d.%@",VDC_session._session._nCustomerID, imageType];
    }
    cell_headPortrait.userHeadPortraitImgV.image = image;
    personalInformationSet.userHeadPortraitUrl = [[NSString alloc] initWithFormat: @"http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/sysres/userheaderimage/%d.%@",VDC_session._session._nCustomerID, imageType];
    NSString *string = [[NSString alloc] initWithFormat: @"userheaderimage%d.%@",VDC_session._session._nCustomerID, imageType];
    [APPUserPrefs APP_updatecustomerinfo:personalInformationSet];
    [[APPUserPrefs Singleton] APP_WriteToFile:image FilePath:string];
    [self putObject:fileName data:data];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
-(void) loginWithUser:(NSString*) userName andPsw:(NSString *)psw andEndP:(NSString*)endp
{
    if (_client != nil) {
        _client = nil;
    }
    _client = [[OSSClientZhang alloc] initWithEndPoint:endp AccessId:userName andAccessKey:psw];
//    _client.delegate = self;
}

-(void) putObject:(NSString * )fileName data:(NSData*) data
{
    _client.delegate = self;
    NSString *strKey = fileName;
    NSLog(@"%@",strKey);
    ObjectMetadata * objMetadata = [[ObjectMetadata alloc] init];
    [_client putObject:self.bucketName key:strKey data:data objectMetadata:objMetadata];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    } else if(section == 1){
        return 5;
    }else{
        return 100;
    }
}

-(UIImage *)getImageFromImage:(UIImage *)in scale:(float)tosize{
    int min = in.size.width > in.size.height ? in.size.height : in.size.width;
    if(min < 1){
        return [UIImage imageNamed:@"Default"];
    }
    CGRect myImageRect;
    if(min == in.size.width){
        myImageRect = CGRectMake(0,(in.size.height-in.size.width)/2,min,min);
    }else{
        myImageRect = CGRectMake((in.size.width-in.size.height)/2,0,min,min);
    }
    CGImageRef imageRef = in.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    CGSize size;
    size.width = min;
    size.height = min;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, myImageRect, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    float scaleSize = (float)tosize/min;
    if(scaleSize < 1){
        UIGraphicsBeginImageContext(CGSizeMake(smallImage.size.width*scaleSize, smallImage.size.width*scaleSize));
        [smallImage drawInRect:CGRectMake(0,0,smallImage.size.width*scaleSize,smallImage.size.height*scaleSize)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
//        NSData * imageData = UIImageJPEGRepresentation(scaledImage,1);
//        float length = [imageData length]/1024;
        return scaledImage;
    }else
        return smallImage;
}

//-(void)OSSObjectPutObjectFinish:(OSSClientZhang*) client result:(PutObjectResult*) result
//{
//
//}


@end
