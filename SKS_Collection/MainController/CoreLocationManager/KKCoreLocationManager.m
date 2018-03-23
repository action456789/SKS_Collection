//
//  CoreLocationManager.m
//  RICISmartSwift
//
//  Created by sen.ke on 2017/9/25.
//  Copyright © 2017年 ke sen. All rights reserved.
//  iOS7+

#import "KKCoreLocationManager.h"

@interface KKCoreLocationManager()<CLLocationManagerDelegate>

@property (nonatomic ,strong) CLLocationManager *mgr;

@property (nonatomic, copy) RequestPermissionBlock responseBlock;
@property (nonatomic, copy) GeocodedBlock geocodedBlock;

@end

@implementation KKCoreLocationManager

singleton_implementation(KKCoreLocationManager)

- (CLLocationManager *)mgr
{
    if (!_mgr) {
        _mgr = [[CLLocationManager alloc] init];
        _mgr.delegate = self;
    }
    return _mgr;
}

- (void)stopService {
    [self.mgr stopUpdatingLocation];
    self.mgr = nil;
    self.responseBlock = nil;
    self.geocodedBlock = nil;
}

- (void)updateWithMaximumDesiredAccuracy:(KKLocationAccuracy)maximumDesiredAccuracy {
    switch (maximumDesiredAccuracy) {
        case KKLocationAccuracyNone:
            break;
        case KKLocationAccuracyCity:
            if (self.mgr.desiredAccuracy != kCLLocationAccuracyThreeKilometers) {
                self.mgr.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
                NSLog(@"Changing location services accuracy level to: low (minimum).");
            }
            break;
        case KKLocationAccuracyNeighborhood:
            if (self.mgr.desiredAccuracy != kCLLocationAccuracyKilometer) {
                self.mgr.desiredAccuracy = kCLLocationAccuracyKilometer;
                NSLog(@"Changing location services accuracy level to: medium low.");
            }
            break;
        case KKLocationAccuracyBlock:
            if (self.mgr.desiredAccuracy != kCLLocationAccuracyHundredMeters) {
                self.mgr.desiredAccuracy = kCLLocationAccuracyHundredMeters;
                NSLog(@"Changing location services accuracy level to: medium.");
            }
            break;
        case KKLocationAccuracyHouse:
            if (self.mgr.desiredAccuracy != kCLLocationAccuracyNearestTenMeters) {
                self.mgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
                NSLog(@"Changing location services accuracy level to: medium high.");
            }
            break;
        case KKLocationAccuracyRoom:
            if (self.mgr.desiredAccuracy != kCLLocationAccuracyBest) {
                self.mgr.desiredAccuracy = kCLLocationAccuracyBest;
                NSLog(@"Changing location services accuracy level to: high (maximum).");
            }
            break;
        default:
            NSAssert(nil, @"Invalid maximum desired accuracy!");
            break;
    }
}

// 请求获取位置权限
- (void)requestLocationPermissionWithAccuracy:(KKLocationAccuracy)accuracy
                                     response:(RequestPermissionBlock)response {
    // 服务不可用
    if (![CLLocationManager locationServicesEnabled]) {
        if (response) {response(NO);}
        return;
    }
    
    // 已经授权
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        if (response) {response(YES);}
        return;
    }
    
    // 用户明确拒绝授权
    if (status == kCLAuthorizationStatusDenied) {
        if (response) {response(NO);}
        return;
    }
    
    // 请求授权
    self.responseBlock = [response copy];
    [self updateWithMaximumDesiredAccuracy:accuracy];
    
    if ([self.mgr respondsToSelector:@selector(requestWhenInUseAuthorization)]) { // iOS8 or latter
        [self.mgr requestWhenInUseAuthorization];
    } else { // iOS7
        [self.mgr startUpdatingLocation];
    }
}

- (void)startUpdateLocationWithAccuracy:(KKLocationAccuracy)accuracy
                          geocodedBlock:(GeocodedBlock)geocodedBlock {
    [self requestLocationPermissionWithAccuracy:accuracy response:^(BOOL isGranted) {
        if (isGranted) {
            self.geocodedBlock = [geocodedBlock copy];
            [self.mgr startUpdatingLocation];
        } else {
            if (geocodedBlock) {
                NSError *error = [NSError errorWithDomain:@"KKCoreLocationManager"
                                                     code:-1
                                                 userInfo:@{@"errorMesssage" : @"用户未授权"}];
                geocodedBlock(nil, error);
            }
        }
    }];
}

- (void)_testPlacemark:(CLPlacemark *)placemark {
    NSLog(@"name: %@", placemark.name);
    NSLog(@"thoroughfare: %@", placemark.thoroughfare);
    NSLog(@"subThoroughfare: %@", placemark.subThoroughfare);
    NSLog(@"locality: %@", placemark.locality);
    NSLog(@"subLocality: %@", placemark.subLocality);
    NSLog(@"administrativeArea: %@", placemark.administrativeArea);
    NSLog(@"subAdministrativeArea: %@", placemark.subAdministrativeArea);
    NSLog(@"postalCode: %@", placemark.postalCode);
    NSLog(@"ISOcountryCode: %@", placemark.ISOcountryCode);
    NSLog(@"country: %@", placemark.country);
    NSLog(@"inlandWater: %@", placemark.inlandWater);
    NSLog(@"ocean: %@", placemark.ocean);
    NSLog(@"areasOfInterest: %@", placemark.areasOfInterest);
}

- (void)startUpdateLocationToGetCity:(GeocodedCityNameBlock)geocodedBlock {
    [self startUpdateLocationWithAccuracy:KKLocationAccuracyCity
                            geocodedBlock:^(CLPlacemark * _Nullable placemark, NSError * _Nullable error) {
        if (!geocodedBlock) {return;}
        geocodedBlock(placemark.locality, placemark.administrativeArea, error);
    }];
}

# pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"等待用户授权");
        if (self.responseBlock) {self.responseBlock(NO);}
        
    } else if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        NSLog(@"授权成功");
        if (self.responseBlock) {self.responseBlock(YES);}
    } else {
        if (self.responseBlock) {self.responseBlock(NO);}
        NSLog(@"授权失败");
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.mgr stopUpdatingLocation];
    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userDefaultLanguages = [standardUserDefaults objectForKey:@"AppleLanguages"];
    [standardUserDefaults setObject:[NSArray arrayWithObjects:@"zh-hans",nil] forKey:@"AppleLanguages"];

    CLLocation *location = locations.lastObject;
    CLGeocoder *geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location
                   completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
           // 还原Device 的语言
           [standardUserDefaults setObject:userDefaultLanguages forKey:@"AppleLanguages"];
           if (error) {
               NSLog(@"%@", error.localizedDescription);
               if (self.geocodedBlock) {self.geocodedBlock(nil, error);}
           } else {
               if (self.geocodedBlock) {self.geocodedBlock(placemarks.firstObject, nil);}
           }
    }];
}

@end
