//
//  LocalMaterialsViewController.m
//  M-Cut
//
//  Created by 刘海香 on 15/1/19.
//  Copyright (c) 2015年 Crab movier. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "LocalMaterialsViewController.h"
//#import "UIViewExt.h"
//#import "LocalMaterialPhotoCollectionViewCell.h"
//#import "LocalMaterialVideoCollectionViewCell.h"


#define randomColor [UIColor colorWithRed:random()/255 green:random()/255 blue:random()/255 alpha:1];


@interface LocalMaterialsViewController () <UzysAssetsPickerControllerDelegate>
@property (nonatomic,strong) UIButton *btnImage;
@property (nonatomic,strong) UIButton *btnVideo;
@property (nonatomic,strong) UIButton *btnImageOrVideo;
@property (nonatomic,strong) UIButton *btnImageAndVideo;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *labelDescription;
@end

@implementation LocalMaterialsViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [[UIButton appearance] setTintColor:[UIColor darkTextColor]];
    [UIButton appearance].titleLabel.font = [UIFont systemFontOfSize:14];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 50, 200, 200)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.imageView];
    
    self.labelDescription = [[UILabel alloc] initWithFrame:CGRectMake(60, 260, 200, 20)];
    self.labelDescription.textAlignment = NSTextAlignmentCenter;
    self.labelDescription.font = [UIFont systemFontOfSize:12];
    self.labelDescription.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.labelDescription];
    
    CGRect frame = CGRectMake(60, 290, 200, 30);
    self.btnImage = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btnImage setTitle:@"Image Only" forState:UIControlStateNormal];
    [self.btnImage addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.btnImage.frame = frame;
    [self.view addSubview:self.btnImage];
    
    self.btnVideo = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btnVideo setTitle:@"Video Only" forState:UIControlStateNormal];
    [self.btnVideo addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    frame.origin.y = frame.origin.y + 40;
    self.btnVideo.frame = frame;
    [self.view addSubview:self.btnVideo];
    
    self.btnImageOrVideo = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btnImageOrVideo setTitle:@"Image or Video" forState:UIControlStateNormal];
    [self.btnImageOrVideo addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    frame.origin.y = frame.origin.y + 40;
    self.btnImageOrVideo.frame = frame;
    [self.view addSubview:self.btnImageOrVideo];
    
    self.btnImageAndVideo = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btnImageAndVideo setTitle:@"Image and Video" forState:UIControlStateNormal];
    [self.btnImageAndVideo addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    frame.origin.y = frame.origin.y + 40;
    self.btnImageAndVideo.frame = frame;
    [self.view addSubview:self.btnImageAndVideo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)btnAction:(id)sender
{
    NSLog(@"sender %@",sender);
    UzysAssetsPickerController *picker = [[UzysAssetsPickerController alloc] init];
    picker.delegate = self;
    if([sender isEqual:self.btnImage])
    {
        picker.maximumNumberOfSelectionVideo = 0;
        picker.maximumNumberOfSelectionPhoto = 3;
    }
    else if([sender isEqual:self.btnVideo])
    {
        picker.maximumNumberOfSelectionVideo = 2;
        picker.maximumNumberOfSelectionPhoto = 0;
    }
    else if([sender isEqual:self.btnImageOrVideo])
    {
        picker.maximumNumberOfSelectionVideo = 2;
        picker.maximumNumberOfSelectionPhoto = 3;
    }
    else if([sender isEqual:self.btnImageAndVideo])
    {
        picker.maximumNumberOfSelectionMedia = 2;
    }
    [self presentViewController:picker animated:YES completion:^{
        
    }];
    
}
- (void)UzysAssetsPickerController:(UzysAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    self.imageView.backgroundColor = [UIColor clearColor];
    NSLog(@"assets %@",assets);
    if(assets.count ==1)
    {
        self.labelDescription.text = [NSString stringWithFormat:@"%ld asset selected",(unsigned long)assets.count];
    }
    else
    {
        self.labelDescription.text = [NSString stringWithFormat:@"%ld assets selected",(unsigned long)assets.count];
    }
    __weak typeof(self) weakSelf = self;
    if([[assets[0] valueForProperty:@"ALAssetPropertyType"] isEqualToString:@"ALAssetTypePhoto"]) //Photo
    {
        [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset *representation = obj;
            
            UIImage *img = [UIImage imageWithCGImage:representation.defaultRepresentation.fullResolutionImage
                                               scale:representation.defaultRepresentation.scale
                                         orientation:(UIImageOrientation)representation.defaultRepresentation.orientation];
            weakSelf.imageView.image = img;
            *stop = YES;
        }];
        
        
    }
    else //Video
    {
        ALAsset *alAsset = assets[0];
        
        UIImage *img = [UIImage imageWithCGImage:alAsset.defaultRepresentation.fullResolutionImage
                                           scale:alAsset.defaultRepresentation.scale
                                     orientation:(UIImageOrientation)alAsset.defaultRepresentation.orientation];
        weakSelf.imageView.image = img;
        
        
        
        ALAssetRepresentation *representation = alAsset.defaultRepresentation;
        NSURL *movieURL = representation.url;
        NSURL *uploadURL = [NSURL fileURLWithPath:[[NSTemporaryDirectory() stringByAppendingPathComponent:@"test"] stringByAppendingString:@".mp4"]];
        AVAsset *asset      = [AVURLAsset URLAssetWithURL:movieURL options:nil];
        AVAssetExportSession *session =
        [AVAssetExportSession exportSessionWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
        
        session.outputFileType  = AVFileTypeQuickTimeMovie;
        session.outputURL       = uploadURL;
        
        [session exportAsynchronouslyWithCompletionHandler:^{
            
            if (session.status == AVAssetExportSessionStatusCompleted)
            {
                NSLog(@"output Video URL %@",uploadURL);
            }
            
        }];
        
    }
    
}
//- (IBAction)buttonAction:(id)sender {
//    
//    [_LocalRightButton setTitle:@"确定" forState:UIControlStateNormal];
//    [_LocalRightButton addTarget:self action:@selector(EnsureButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    _selectedButtonIsClicked = YES;
//    [_localMaterialCView reloadData];
//    
//}
//-(void)EnsureButtonAction{
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//   
//    _selectedButtonIsClicked = NO;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark -- UICollectionViewDataSource
//
////定义展示的Section的个数
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 2;
//}
//
//
////定义展示的UICollectionViewCell的个数
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return 11;
//    } else {
//        return 27;
//    }
//}
////每个UICollectionView展示的内容
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    static NSString * LocalMaterialsIdentifier_pictures = @"LocalMaterialsIdentifier_pictures";
//    
//    
//    static NSString * LocalMaterialsIdentifier_video = @"LocalMaterialsIdentifier_video";
//    
//    if (_selectedButtonIsClicked) {
//        
//        if (indexPath.section == 0) {
//            
//            LocalMaterialPhotoCollectionViewCell * cell_pictures = [collectionView dequeueReusableCellWithReuseIdentifier:LocalMaterialsIdentifier_pictures forIndexPath:indexPath];
//            
//            //cell_pictures.backgroundColor = [UIColor greenColor];
//            cell_pictures.unSelectButton.hidden = NO;
//            return cell_pictures;
//        } else {
//            LocalMaterialVideoCollectionViewCell *cell_video = [collectionView dequeueReusableCellWithReuseIdentifier:LocalMaterialsIdentifier_video forIndexPath:indexPath];
//            
//            //cell_video.backgroundColor = [UIColor orangeColor];
//            cell_video.unCheckedButton.hidden = NO;
//            return cell_video;
//        }
//
//    } else {
//        if (indexPath.section == 0) {
//            
//            LocalMaterialPhotoCollectionViewCell * cell_pictures = [collectionView dequeueReusableCellWithReuseIdentifier:LocalMaterialsIdentifier_pictures forIndexPath:indexPath];
//            
//            //cell_pictures.backgroundColor = [UIColor greenColor];
//            cell_pictures.unSelectButton.hidden = YES;
//            
//            
//            
//            return cell_pictures;
//        } else {
//            LocalMaterialVideoCollectionViewCell *cell_video = [collectionView dequeueReusableCellWithReuseIdentifier:LocalMaterialsIdentifier_video forIndexPath:indexPath];
//            
//            cell_video.unCheckedButton.hidden = YES;
//            //cell_video.backgroundColor = [UIColor orangeColor];
//            
//            return cell_video;
//        }
//
//        
//    }
//}
//
//#pragma mark --UICollectionViewDelegateFlowLayout
//
////定义每个UICollectionView 的大小
////- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
////{
////    return CGSizeMake((self.view.width)/4, 80);
////}
//
//
////定义每个UICollectionView 的 margin
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(0, 3, 0, 3);
//    //return UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>))
//}
//
//
//#pragma mark --UICollectionViewDelegate
//
////UICollectionView被选中时调用的方法
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    
//    cell.backgroundColor = [UIColor greenColor];
//}
//
////返回这个UICollectionView是否可以被选择
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
////    CollectViewHeaderView *view = [collectionViewdequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeaderwithReuseIdentifier:@"cccc"forIndexPath:indexPath];
//
//    UICollectionReusableView *sectionHeaderView  = [collectionView dequeueReusableSupplementaryViewOfKind: UICollectionElementKindSectionHeader withReuseIdentifier:@"SectionHeaderViewIdentifier" forIndexPath:indexPath];
//    
//    return sectionHeaderView;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
