#import "CloudFilesTableViewController.h"
#import "DetailsViewController.h"
#import "LocalMaterialsViewController.h"
#import "CloudMaterialTableViewCell.h"
#import "APPUserPrefs.h"

@interface CloudFilesTableViewController ()
@property (nonatomic,strong) UIWindow *window;

@end

@implementation CloudFilesTableViewController

@synthesize client = _client;
@synthesize objects = _objects;
@synthesize bucketName = _bucketName;
@synthesize cloudId = _cloudId;
@synthesize cloudKey = _cloudKey;
@synthesize endPoint = _endPoint;
@synthesize objectsst = _objectsst;
@synthesize foldersst = _foldersst;



-(void) dealloc
{
    self.client = nil;
    self.objects = nil;
    self.bucketName = nil;
    self.cloudId = nil;
    self.cloudKey = nil;
    self.endPoint = nil;
    self.objectsst = nil;
    self.foldersst = nil;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _client.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _buckets = [[NSMutableArray alloc] init];
    _objects = [[NSMutableArray alloc] init];
    _folders = [[NSMutableArray alloc] init];
    _objectsst = [[NSMutableArray alloc] init];
    _foldersst = [[NSMutableArray alloc] init];
    [self ossinit];
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

-(void)ossinit{
    NSString* myossid = [UserEntity sharedSingleton].ossID;
    NSString* myosskey = [UserEntity sharedSingleton].ossKey;
    NSString* myossEndpoint =@"http://";
    myossEndpoint = [NSString stringWithFormat:@"http://%@",[UserEntity sharedSingleton].ossEndpoint];
    [self loginWithUser:myossid andPsw:myosskey andEndP:myossEndpoint];
    
    self.bucketName = [UserEntity sharedSingleton].ossBucket;
    self.prefix = [UserEntity sharedSingleton].ossDir;
    
    ListObjectsRequest * lor = [[ListObjectsRequest alloc] initWithBucketName:self.bucketName prefix:self.prefix marker:nil maxKeys:0 delimiter:@"/"];
    [_client listObjects:lor];
    lor = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int rtn =0;
    rtn = [self.folders count] + [self.objects count];
    return rtn;
}

-(void) loginWithUser:(NSString*) userName andPsw:(NSString *)psw
{
    if (_client != nil) {
        _client = nil;
    }
    _client = [[OSSClientZhang alloc] initWithAccessId:userName andAccessKey:psw];
    _client.delegate = self;
}

-(void) loginWithUser:(NSString*) userName andPsw:(NSString *)psw andEndP:(NSString*)endp
{
    if (_client != nil) {
        _client = nil;
    }
    _client = [[OSSClientZhang alloc] initWithEndPoint:endp AccessId:userName andAccessKey:psw];
    _client.delegate = self;
}

-(void) listBucket
{
    [_client listBuckets];
}

-(void)bucketListFinish:(OSSClientZhang*) client result:(NSArray*) bucketList
{
    _indexPath = nil;
    _buckets = [[NSMutableArray alloc] initWithCapacity:20];
    
    [self dismissModalViewControllerAnimated:YES];
    [self.buckets addObjectsFromArray: bucketList];
    UITableView *tb = (UITableView*)self.view;
    [tb reloadData];
}

-(void)bucketListFailed:(OSSClientZhang*) client error:(OSSError*) error
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"登陆失败，请检查用户名密码" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
    alert = nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CloudFilesTabIdentifier";
    
    CloudMaterialTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[CloudMaterialTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSString *strIndex;
    if (indexPath.row < [self.folders count]) {
        NSString *strFolder = [self.folders objectAtIndex:indexPath.row];
        NSArray *sSplit = [strFolder componentsSeparatedByString:@"/"];
        strIndex =[NSString stringWithFormat:@"%@",[sSplit objectAtIndex:[sSplit count]-2] ];
    }
    else {
        OSSObjectSummary * obj = [self.objects objectAtIndex:indexPath.row-[self.folders count]];
        NSArray *sSplit2 = [obj.key componentsSeparatedByString:@"/"];
        NSString *strKey;
        if ([sSplit2 count] >1) {
            strKey =[NSString stringWithFormat:@"%@",[sSplit2 objectAtIndex:[sSplit2 count]-1] ];
        }
        else {
            strKey= obj.key;
        }
        strIndex =[NSString stringWithFormat:@"%@",strKey];
        NSString *selectItem = [self.objectsst objectAtIndex:indexPath.row - [self.folders count]];
        if ([selectItem isEqualToString:@"FALSE"]) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
    cell.folderNameLabel.text = strIndex;
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < [self.folders count]) {
        NSString * str = [self.folders objectAtIndex:indexPath.row];
        DetailsViewController * detailsVC = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
        detailsVC.client = _client;
        detailsVC.bucketName = self.bucketName;
        detailsVC.prefix = str;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }else{
        NSString * obj = [self.objectsst objectAtIndex:indexPath.row-[self.folders count]];
        
        if([obj isEqualToString:@"FALSE"])
        {
            OSSObjectSummary *ss = [self.objects objectAtIndex:indexPath.row-[self.folders count]];
            obj = @"TRUE";
            [self.objectsst replaceObjectAtIndex:indexPath.row-[self.folders count]  withObject:@"TRUE"];
            NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
//            NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
            NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
            newOrderVideoMaterial.createTime = newNSOrderDetail.createTime;
            newNSOrderDetail = [[APPUserPrefs Singleton] APP_OrderDetailCacheInformationDBSearch:newNSOrderDetail];
            newOrderVideoMaterial.order_id = newNSOrderDetail.order_id;
            newOrderVideoMaterial.material_type = 3;
            newOrderVideoMaterial.material_index = orderCurrent;
            newOrderVideoMaterial.material_localURL = @"";
//            newOrderVideoMaterial.material_ossURL = [@"http://movier-vdc.oss-cn-beijing.aliyuncs.com/" stringByAppendingFormat:@"%@",ss.key ];
            newOrderVideoMaterial.material_ossURL = [@"http://" stringByAppendingFormat:@"%@.%@/%@",[UserEntity sharedSingleton].ossBucket,[UserEntity sharedSingleton].ossEndpoint,ss.key ];
//            fileurl = [fileurl stringByAppendingFormat:@"http://%@.%@/%@",[UserEntity sharedSingleton].ossBucket,[UserEntity sharedSingleton].ossEndpoint,[UserEntity sharedSingleton].ossDir];
            NSString *videoUrl = @"http://movier-vdc.oss-cn-beijing.aliyuncs.com/movier/admin/modules/module-1/1422258921437.jpg";
            NSError *error=nil;
            newOrderVideoMaterial.material_stream = [UIImage imageWithData:[NSURLConnection sendSynchronousRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:videoUrl]] returningResponse:nil error:&error]];
            newOrderVideoMaterial.material_assetsURL = @"";
            [[APPUserPrefs Singleton] APP_MaterialCacheInformationDBInsert:newOrderVideoMaterial];
            orderCurrent++;
        }else{
            obj = @"FALSE";
            [self.objectsst replaceObjectAtIndex:indexPath.row-[self.folders count]  withObject:@"FALSE"];
            NewOrderVideoMaterial *newOrderVideoMaterial = [[NewOrderVideoMaterial alloc] init];
//            NewNSOrderDetail *newNSOrderDetail = [[NewNSOrderDetail alloc] init];
            NewNSOrderDetail *newNSOrderDetail = [[NewUserOrderList Singleton].newcutlist objectAtIndex:0];
            newOrderVideoMaterial.order_id = newNSOrderDetail.order_id;
            [[APPUserPrefs Singleton] APP_MaterialCacheInformationDBDelete:newOrderVideoMaterial];
            orderCurrent--;
        }
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

-(void) showError:(OSSError*) error
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"提示:" message:error.errorMessage delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
    alert = nil;
}

-(void)bucketListObjectsFinish:(OSSClientZhang*) client result:(ObjectListing*) result
{
    NSArray *objs = result.objectSummaries;
    NSMutableArray * newobjs = [[NSMutableArray alloc] init];
    for (int j =0; j< [objs count]; j++) {
        OSSObjectSummary * objSummary = [objs objectAtIndex:j];
        if (![objSummary.key isEqualToString:self.prefix]) {
            [newobjs addObject:objSummary];
            NSString *ObjStatue = @"FALSE";
            [[OssTemp Singleton].selectedobjs addObject:ObjStatue];
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
            [self.objectsst addObject:ObjStatue];
        }
    }
    [self.objects addObjectsFromArray:newobjs];
    [self.folders addObjectsFromArray:result.commonPrefixes];
    UITableView *tb = (UITableView*)self.view;
    [tb reloadData];
}

-(void)bucketListObjectsFailed:(OSSClientZhang*) client error:(OSSError*) error
{
    [self showError:error];
}


@end
