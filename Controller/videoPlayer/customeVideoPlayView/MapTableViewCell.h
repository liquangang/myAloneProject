//
//  MapTableViewCell.h
//  M-Cut
//
//  Created by apple on 16/10/24.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


/**
 *  获得cell
 */
+ (instancetype)MapTableViewCellWithTable:(UITableView *)tableView
                              ResuableStr:(NSString *)resuableStr;
@end
