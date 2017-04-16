//
//  MyMovieCell.m
//  M-Cut
//
//  Created by losehero on 15/12/5.
//  Copyright © 2015年 Crab movier. All rights reserved.
//

#import "MyMovieCell.h"
#import "UIImageView+WebCache.h"
#import  "MC_OrderAndMaterialCtrl.h"

@implementation MyMovieCell

-(IBAction)downButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(MyMovieCellDownButtonDelegate:)])
    {
        [self.delegate MyMovieCellDownButtonDelegate:_currentIndexPath];
    }
}



-(IBAction)deleteButtonAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(MyMovieCellDeleteButtonDelegate:)])
    {
        [self.delegate MyMovieCellDeleteButtonDelegate:_currentIndexPath];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if ([self.moveData isKindOfClass:[NewNSOrderDetail class]])
    {
        NewNSOrderDetail *order = (NewNSOrderDetail *)self.moveData;
        _movieTitleLabel.text = order.szVideoName;
    }
    else //if([self.moveData isKindOfClass:[MovierDCInterfaceSvc_VDCVideoInfoEx class]])
    {
        MovierDCInterfaceSvc_VDCVideoInfoEx *vdcINfor = (MovierDCInterfaceSvc_VDCVideoInfoEx *)self.moveData;
        _autherLabel.text = vdcINfor.szOwnerName;
        _movieTitleLabel.text = vdcINfor.szVideoName;
        _lookLabel.text = [NSString stringWithFormat:@"%d",[vdcINfor.nVisitCount intValue]];
        _favoriteLabel.text = [NSString stringWithFormat:@"%d",[vdcINfor.nPraise intValue]];
        [_videoImageView sd_setImageWithURL:[NSURL URLWithString:[vdcINfor.szThumbnail
                                                                  stringByAddingPercentEscapesUsingEncoding:
                                                                  NSUTF8StringEncoding]]];
    }
}

@end
