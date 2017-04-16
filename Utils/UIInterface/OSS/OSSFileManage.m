//
//  OSSFileManagebyBaocai.m
//  M-Cut
//
//  Created by zhangxiaotian on 15/3/29.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//

#import "OSSFileManage.h"

@implementation OSSFileManage
@synthesize indexPaths,client,bucketName,prefix,cloudId,cloudKey,endPoint,buckets,objects,folders,selectedobjs,objectsURL;

- (OSSFileManage *)init{
    [super init];
    self.buckets = [[NSMutableArray alloc] init];
    self.objects = [[NSMutableArray alloc] init];
    self.folders = [[NSMutableArray alloc] init];
    self.selectedobjs = [[NSMutableArray alloc] init];
    self.objectsURL = [[NSMutableArray alloc] init];
    return  self;
}

-(void) dealloc
{
    client = nil;
    bucketName = nil;
    prefix = nil;
    cloudId = nil;
    cloudKey = nil;
    endPoint = nil;
    buckets = nil;
    objects = nil;
    folders = nil;
    selectedobjs = nil;
    objectsURL = nil;
    [super dealloc];
}

-(void)ossinit{
    NSString* myossid = [UserEntity sharedSingleton].ossID;
    NSString* myosskey = [UserEntity sharedSingleton].ossKey;
    NSString* myossEndpoint =@"http://";
    myossEndpoint = [NSString stringWithFormat:@"http://%@",[UserEntity sharedSingleton].ossEndpoint];
    //登录云端
    [self loginWithUser:myossid andPsw:myosskey andEndP:myossEndpoint];
    
//    objects = [[NSMutableArray alloc] initWithCapacity:10000];
//    folders = [[NSMutableArray alloc] initWithCapacity:1000];
//    selectedobjs = [[NSMutableArray alloc] initWithCapacity:10000];
//    objectsURL = [[NSMutableArray alloc] initWithCapacity:100];
    
    self.bucketName = [UserEntity sharedSingleton].ossBucket;
    self.prefix = [UserEntity sharedSingleton].ossDir;
    
    ListObjectsRequest * lor = [[ListObjectsRequest alloc] initWithBucketName:self.bucketName prefix:self.prefix marker:nil maxKeys:0 delimiter:@"/"];
    [client listObjects:lor];
    [lor release];
    lor = nil;
}
//登录云端
-(void) loginWithUser:(NSString*) userName andPsw:(NSString *)psw
{
    if (client != nil) {
        [client release];
        client = nil;
    }
    client = [[OSSClientZhang alloc] initWithAccessId:userName andAccessKey:psw];
    client.delegate = self;
    
}
//登录云端
-(void) loginWithUser:(NSString*) userName andPsw:(NSString *)psw andEndP:(NSString*)endp
{
    if (client != nil) {
        [client release];
        client = nil;
    }
    client = [[OSSClientZhang alloc] initWithEndPoint:endp AccessId:userName andAccessKey:psw];
    client.delegate = self;
    
}

-(void)bucketListFinish:(OSSClientZhang*)client result:(NSArray*) bucketList
{
    indexPaths = nil;
    buckets = [[NSMutableArray alloc] initWithCapacity:20];
    
    [self dismissModalViewControllerAnimated:YES];
    [self.buckets addObjectsFromArray: bucketList];
}

-(void)bucketListFailed:(OSSClientZhang*) client error:(OSSError*) error
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"登陆失败，请检查用户名密码" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
    [alert release];
    alert = nil;
}

-(void)bucketListObjectsFinish:(OSSClientZhang*) client result:(ObjectListing*) result
{
    NSArray *objs = result.objectSummaries;
    //去掉和prefix 同名的对象
    NSMutableArray * newobjs = [NSMutableArray arrayWithCapacity:[objs count]];
    for (int j =0; j< [objs count]; j++) {
        OSSObjectSummary * objSummary = [objs objectAtIndex:j];
        if (![objSummary.key isEqualToString:self.prefix]) {
            [newobjs addObject:objSummary];
            NSString *ObjStatue = @"FALSE";
            [self.selectedobjs addObject:ObjStatue];
            
            NSString *fileurl = @"";
            fileurl = [fileurl stringByAppendingFormat:@"http://%@.%@/%@",[UserEntity sharedSingleton].ossBucket,[UserEntity sharedSingleton].ossEndpoint,[UserEntity sharedSingleton].ossDir];
            NSArray *sSplit2 = [objSummary.key componentsSeparatedByString:@"/"];
            NSString *strKey;
            if ([sSplit2 count] >1) {
                strKey =[NSString stringWithFormat:@"%@",[sSplit2 objectAtIndex:[sSplit2 count]-1] ];
            }
            else {
                strKey= objSummary.key;
            }
            fileurl = [fileurl stringByAppendingString:strKey];
            [self.objectsURL addObject:fileurl];
        }
    }
    [self.objects addObjectsFromArray: newobjs];
    [self.folders addObjectsFromArray: result.commonPrefixes];
//    [self.view reloadData];
}

//-(void)bucketListObjectsFailed:(OSSClientZhang*) client error:(OSSError*) error
//{
//    [self showError:error];
//}

-(void)addPictureFromPhotoLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = NO;
    [self presentModalViewController:picker animated:YES];
    [picker release];
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    NSString *imageId;
    NSString *imageType;
    
    [picker dismissModalViewControllerAnimated:YES];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //        image = [image fixOrientation];
        
        NSURL *url = [info objectForKey: @"UIImagePickerControllerReferenceURL"];
        
        imageId = [url absoluteString];
        NSArray *tmpArray = [imageId componentsSeparatedByString: @"="];
        imageId = [tmpArray objectAtIndex:1];
        imageType = [tmpArray objectAtIndex:2];
        NSArray *tmpArray2 = [imageId componentsSeparatedByString: @"&"];
        imageId = [tmpArray2 objectAtIndex:0];
        
        NSString *fileName;
        NSDate * date = [NSDate date];
        
        NSData *data;
        
        if (UIImagePNGRepresentation(image) == nil)
        {
            data = UIImageJPEGRepresentation(image, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(image);
            imageType = @"png";
        }
        if (imageId == nil || [imageId isEqualToString:@""]) {
            NSString *strTime =[NSString stringWithFormat:@"%ld",(long)date.timeIntervalSinceReferenceDate];
            fileName = [[NSString alloc] initWithFormat: @"photo%@.%@", strTime, imageType];
        }
        else
        {
            fileName = [[NSString alloc] initWithFormat: @"%@.%@", imageId, imageType];
        }
        // No need to retain (just a local variable)
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
//        hud.labelText = @"图片上传中...";
//        
//        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//            // Do a taks in the background
//            [self putObject:fileName data:data];
//            // Hide the HUD in the main tread
//        });
    }
}

-(void) putObject:(NSString * )fileName data:(NSData*) data
{
    client.delegate = self;
    NSString *strKey = [NSString stringWithFormat:@"%@%@",self.prefix,fileName];
    NSLog(@"%@",strKey);
    ObjectMetadata * objMetadata = [[ObjectMetadata alloc] init];
    [client putObject:self.bucketName key:strKey data:data objectMetadata:objMetadata];
    [objMetadata release];
}

-(void)OSSObjectPutObjectFinish:(OSSClientZhang*) client result:(PutObjectResult*) result
{
//    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    //folder
    if ([result.key endsWith:@"/"]) {
        [self.folders addObject:result.key];
    }
    else
    {
        OSSObjectSummary * obj= [[OSSObjectSummary  alloc] initWithBucketName:self.bucketName key:result.key eTag:nil size:0 lastModified:nil storageClass:nil owner:nil];
        [self.objects addObject:obj];
        
        NSString* objectSelect = @"FALSE";
        [self.selectedobjs addObject:objectSelect];
        NSString *fileurl = @"";
        fileurl = [fileurl stringByAppendingFormat:@"http://%@.%@/%@",[UserEntity sharedSingleton].ossBucket,[UserEntity sharedSingleton].ossEndpoint,[UserEntity sharedSingleton].ossDir];
        NSArray *sSplit2 = [obj.key componentsSeparatedByString:@"/"];
        NSString *strKey;
        if ([sSplit2 count] >1) {
            strKey =[NSString stringWithFormat:@"%@",[sSplit2 objectAtIndex:[sSplit2 count]-1] ];
        }
        else {
            strKey= obj.key;
        }
        fileurl = [fileurl stringByAppendingString:strKey];
        [self.objectsURL addObject:fileurl];
        
        [obj release];
    }
//    [icloudTabV reloadData];
}

-(void)OSSObjectPutObjectFailed:(OSSClientZhang*) client error:(OSSError*) error
{
//    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [self showError:error];
}

-(void) fetchObject:(NSString*) bucketName key:(NSString*) key
{
    client.delegate = self;
    [client fetchObject:bucketName key:key];
}

-(void)OSSObjectFetchObjectFinish:(OSSClientZhang*) client result:(OSSObjectZhang*) result
{
//    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
}

-(void)OSSObjectFetchObjectFailed:(OSSClientZhang*) client error:(OSSError*) error
{
//    [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    [self showError:error];
}

-(void) showError:(OSSError*) error
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.errorMessage delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
    [alert release];
    alert = nil;
}

-(void)bucketListObjectsFailed:(OSSClientZhang*) client error:(OSSError*) error
{
    [self showError:error];
}

-(void)OSSObjectDeleteObjectFinish:(OSSClientZhang*) client bucketName:(NSString*) bucketName key:(NSString*)key
{
    if (indexPaths != nil) {
        if (indexPaths.row < [self.folders count]) {
            [self.folders removeObjectAtIndex:indexPaths.row];
        }
        else
        {
            [self.objects removeObjectAtIndex:indexPaths.row-[self.folders count]];
        }
        
        // Delete the row from the data source.
        //        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPaths] withRowAnimation:UITableViewRowAnimationFade];
//        [self.icloudTabV deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPaths] withRowAnimation:UITableViewRowAnimationFade];
        [indexPaths release];
    }
    
    indexPaths = nil;
}

-(void)OSSObjectDeleteObjectFailed:(OSSClientZhang*) client error:(OSSError*) error
{
    [self showError:error];
}





@end
