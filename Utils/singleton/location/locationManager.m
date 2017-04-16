//
//  locationManager.m
//  M-Cut
//
//  Created by apple on 16/11/17.
//  Copyright © 2016年 Crab movier. All rights reserved.
//

#import "locationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "CustomeClass.h"
#import <MapKit/MapKit.h>
#import "CustomAnnotation.h"

@interface locationManager()<CLLocationManagerDelegate>
//定位控制对象
@property (nonatomic, strong) CLLocationManager * locationManager;
//地理编码
@property (nonatomic, strong) CLGeocoder * geocoder;
@end

@implementation locationManager

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * location = [locations lastObject];
    CLLocationCoordinate2D locationCoorinate = location.coordinate;
    
    //发出通知，要处理这个信息的就接收这个通知
    POSTNOTI(getLocationInfo,
             (@{locationLongitudeInfo:@(locationCoorinate.longitude),
                locationLatitudeInfo:@(locationCoorinate.latitude)}));
}

#pragma mark - 功能模块

/**
 *  开始请求地理信息
 */
- (void)startGetLocationInfo{
    
    //判断定位功能是否可用
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized ||
         [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            [self.locationManager startUpdatingLocation];
        }else{
            [CustomeClass showMessage:@"定位功能不可用" ShowTime:3];
        }
}

/**
 *  停止请求位置信息
 */
- (void)stopGetLocationInfo{
    [self.locationManager stopUpdatingLocation];
    POSTNOTI(stopGetLocationInfo, nil);
}

/**
 *  正地理编码
 */
- (void)getCoordinateWithAddress:(NSString *)addressStr MapView:(MKMapView *)mapView
{
    [self.geocoder geocodeAddressString:addressStr
                      completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                          
                          //设置大头针
                          MAINQUEUEUPDATEUI({
                              for (CLPlacemark * placeMark in placemarks) {
                                  CLLocation * location = placeMark.location;
                                  CLLocationCoordinate2D coordinate = location.coordinate;
                                  CustomAnnotation * annotation = [CustomAnnotation new];
                                  annotation.coordinate = coordinate;
                                  annotation.title = addressStr;
                                  annotation.subtitle = @"快去做片吧！";
                                  [mapView addAnnotation:annotation];
                              }
                          })
                          
                      }];
}

#pragma mark - 创建单例

/**
 *  创建单例
 */

static locationManager *instance;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init] ;
    }) ;
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone] ;
    }) ;
    return instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return instance;
}

#pragma mark - 懒加载

/**
 *  定位控制对象
 */
- (CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [_locationManager requestAlwaysAuthorization];
    }
    return _locationManager;
}

/**
 *  懒加载地理编码控制器
 */
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [CLGeocoder new];
    }
    return _geocoder;
}
@end
