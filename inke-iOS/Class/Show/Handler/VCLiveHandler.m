//
//  VCLiveHandler.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/7.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCLiveHandler.h"
#import "HTTPTool.h"
#import "VCLive.h"
#import "VCAdvertise.h"
#import "NSObject+YYModel.h"
#import "VCLocationManager.h"

@implementation VCLiveHandler

+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    [HTTPTool getWithPath:API_HotLive params:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
        } else {
            
            NSArray *lives = [VCLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            success(lives);
        }
    } failure:^(NSError *error) {
        
        failed(error);
    }];
    
}

+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
    VCLocationManager *manager = [VCLocationManager sharedManager];
#pragma clang diagnositc pop
    static CLLocationCoordinate2D coor;
    [manager getLocation:^(NSString *lat, NSString *lon) {
        
        coor = CLLocationCoordinate2DMake([lat unsignedLongLongValue], [lon unsignedLongLongValue]);
    }];
#if TARGET_IPHONE_SIMULATOR
    NSDictionary * params = @{@"uid":@"85149891",
                              @"latitude":@"40.090562",
                              @"longitude":@"116.413353"
                              };
#elif TARGET_OS_IPHONE
    NSDictionary * params = @{@"uid":@"85149891",
                              @"latitude":@(coor.latitude),
                              @"longitude":@(coor.longitude)
                              };
#endif
    
    [HTTPTool getWithPath:API_NearLive params:params success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        } else {
            //如果返回信息正确
            //数据解析
            NSArray * lives =  [VCLive mj_objectArrayWithKeyValuesArray:json[@"lives"]];
            
            
            success(lives);
            
        }
        
    } failure:^(NSError *error) {
        
        failed(error);
        
    }];

}

+ (void)executeGetAdvertiseTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
    [HTTPTool getWithPath:API_Advertise params:nil success:^(id json) {
        
        if ([json[@"dm_error"] integerValue]) {
            
            failed(json);
            
        } else {
            
            
        }
    } failure:^(NSError *error) {
        
        
    }];
}

@end
