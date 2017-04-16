//
//  locationManager.h
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

/**
 *  使用数据要注册通知
 */

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface locationManager : NSObject

/**
 *  创建单例
 */
+ (instancetype)shareInstance;

/**
 *  开始请求地理信息
 */
- (void)startGetLocationInfo;

/**
 *  停止请求位置信息
 */
- (void)stopGetLocationInfo;

/**
 *  正地理编码
 */
- (void)getCoordinateWithAddress:(NSString *)addressStr MapView:(MKMapView *)mapView;
@end
