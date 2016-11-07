//
//  VCLocationManager.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/7.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface VCLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locManager;

@property (nonatomic, copy) VCLocationBlock block;

@end

@implementation VCLocationManager

+ (instancetype)sharedManager {
    
    static VCLocationManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[VCLocationManager alloc] init];
    });
    
    return _manager;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _locManager = [[CLLocationManager alloc] init];
        [_locManager setDesiredAccuracy:(kCLLocationAccuracyBest)];
        _locManager.distanceFilter = 100;
        _locManager.delegate = self;
        
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"开启定位服务");
        } else {
            
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locManager requestWhenInUseAuthorization];
            }
        }
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    CLLocationCoordinate2D coor = newLocation.coordinate;
    
    NSString *lat = [NSString stringWithFormat:@"%@",@(coor.latitude)];
    NSString *lon = [NSString stringWithFormat:@"%@",@(coor.longitude)];
    
    [VCLocationManager sharedManager].lat = lat;
    [VCLocationManager sharedManager].lon = lon;
    
    self.block(lat, lon);
    
    [self.locManager stopUpdatingLocation];
}

#pragma mark - public
- (void)getLocation:(VCLocationBlock)block {
    
    self.block = block;
    [self.locManager startUpdatingLocation];
}

@end
