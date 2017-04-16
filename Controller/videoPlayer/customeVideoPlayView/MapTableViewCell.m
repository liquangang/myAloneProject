//
//  MapTableViewCell.m
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "MapTableViewCell.h"
#import "CustomeClass.h"
#import "CustomAnnotation.h"
#import "locationManager.h"

@interface MapTableViewCell()<MKMapViewDelegate>
@end

@implementation MapTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mapView.showsUserLocation = YES;
    [SINGLETON(locationManager) startGetLocationInfo];
    
    //接受地理位置信息的通知
    REGISTEREDNOTI(getLocationInfo:, getLocationInfo);
}

#pragma mark - 功能模块

/**
 *  位置通知
 */
- (void)getLocationInfo:(NSNotification *)noti{
    CLLocationDegrees latitude = [noti.userInfo[locationLatitudeInfo] doubleValue];
    CLLocationDegrees longitude = [noti.userInfo[locationLongitudeInfo] doubleValue];
    CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(locationCoordinate, 5000, 5000) animated:YES];
    [SINGLETON(locationManager) getCoordinateWithAddress:@"国美" MapView:self.mapView];
}

/**
 *  获得cell
 */
+ (instancetype)MapTableViewCellWithTable:(UITableView *)tableView
                              ResuableStr:(NSString *)resuableStr
{
    MapTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:resuableStr];
    if (!cell) {
        cell = XIBCELL(@"MapTableViewCell")
    }
    return cell;
}

@end
