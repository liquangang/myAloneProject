
//
//  ImageCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/12/6.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "ImageCollectionViewCell.h"
#import "PhotoModel.h"

@interface ImageCollectionViewCell()
@property (nonatomic, strong) PhotoModel *photoModel;
@end

@implementation ImageCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.selectButton setImage:[UIImage imageNamed:@"灰色对号"]
                           forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"对号1"] forState:UIControlStateSelected];
}

- (IBAction)selectButtonAction:(id)sender {
    self.selectButton.selected = !self.selectButton.selected;
    self.photoModel.isSelect = self.selectButton.selected;
    self.selectBlock((UIButton *)sender);
}

- (IBAction)previewButtonAction:(id)sender {
    self.previewBlock();
}

+ (instancetype)ImageCollectionViewCellWithResuableStr:(NSString *)resuableStr
                                             IndexPath:(NSIndexPath *)indexPath
                                        CollectionView:(UICollectionView *)collectionView
                                              CellInfo:(PhotoModel *)photoModel{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:resuableStr forIndexPath:indexPath];
    cell.photoModel = photoModel;
    cell.selectButton.selected = photoModel.isSelect;
    
    [SINGLETON(PhotoManager) getAssetThumbnailWithAsset:photoModel.asset TargetSize:photoModel.itemSize complete:^(UIImage *image) {
       
        [CustomeClass mainQueue:^{
            cell.backImage.image = image;
        }];
    }];
    return cell;
}
@end
