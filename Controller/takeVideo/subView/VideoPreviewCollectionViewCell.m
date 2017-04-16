
//
//  VideoPreviewCollectionViewCell.m
//  M-Cut
//
//  Created by apple on 16/10/29.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "VideoPreviewCollectionViewCell.h"

@interface VideoPreviewCollectionViewCell()
@end

@implementation VideoPreviewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (id)VideoPreviewCollectionViewCellWithTable:(UICollectionView *)collectionView
                                  ResuableStr:(NSString *)resuableStr
                                    IndexPath:(NSIndexPath *)index
                                     AssModel:(TempVideoOBj *)videoModel
{
    VideoPreviewCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:resuableStr
                                                                                      forIndexPath:index];
    if (!cell) {
        cell = XIBCELL(@"VideoPreviewCollectionViewCell")
    }
    cell.videoThumailImageView.image = videoModel.videoThumailImage;
    cell.playImage.hidden = NO;
    return cell;
}
@end
