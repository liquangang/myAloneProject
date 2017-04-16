//
//  HomePageBelowCollectionViewCell.m
//  M-Cut
//
//  Created by liquangang on 16/9/8.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "HomePageBelowCollectionViewCell.h"
#import "CustomeClass.h"
#import <UIImageView+WebCache.h>

@interface HomePageBelowCollectionViewCell()
@property (nonatomic, copy) NSString *imageFilePath;
@end

@implementation HomePageBelowCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backImage = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.backImage];
    }
    return self;
}

/** 封装复用代码，方便调用*/
+ (id)getHomePageBelowCollectionViewCellWithCollectionView:(UICollectionView *)cellSuperCollectionView
                                                  CellInfo:(HomePageLabelModel *)cellInfo
                                                 CellIndex:(NSIndexPath *)cellIndex
                                               ResuableStr:(NSString *)resuableStr{
    HomePageBelowCollectionViewCell * cell = [cellSuperCollectionView dequeueReusableCellWithReuseIdentifier:resuableStr
                                                                                                forIndexPath:cellIndex];
    
    [cell getLaunchImageWithLabelInfo:cellInfo completeBlock:^(UIImage *image) {
        MAINQUEUEUPDATEUI({
            cell.backImage.image = image;
        })
    }];
    
    return cell;
}

- (void)getLaunchImageWithLabelInfo:(HomePageLabelModel *)labelModel completeBlock:(void(^)(UIImage *image))completeBlock{
    WEAKSELF2
    
    [CustomeClass backgroundQueue:^{
        
        if (!labelModel.backImage) {
            completeBlock(DEFAULTVIDEOTHUMAIL);
            MovierDCInterfaceSvc_VDCVideoLabelEx2 *videoLabelInfo = labelModel.labelInfo;
            
            //获取文件路径
            NSString *imagePath = [NSString stringWithFormat:@"%@/%@.png", weakSelf.imageFilePath, videoLabelInfo.nLabelID];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
                
                //存在就使用
                completeBlock(labelModel.backImage = [CustomeClass getImageWithImageFile:imagePath]);
            }else{
                
                //下载设置图片
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:videoLabelInfo.szThumbnail]];
                UIImage *image = [UIImage imageWithData:imageData];
                completeBlock(labelModel.backImage = image);
                
                //保存图片
                [CustomeClass saveImageWithPath:imagePath ImageData:image];
            }
        }else{
            completeBlock(labelModel.backImage);
        }
    }];
}

#pragma mark - 懒加载

- (NSString *)imageFilePath{
    if (!_imageFilePath) {
        _imageFilePath = [CustomeClass createFileAtSandboxWithName:homeImageFileName];
    }
    return _imageFilePath;
}
@end
