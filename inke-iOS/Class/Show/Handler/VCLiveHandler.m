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
#import "NSObject+YYModel.h"

@implementation VCLiveHandler

+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
}

+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    
   // SXTLocationManager * manager = [SXTLocationManager sharedManager];
    
    NSDictionary * params = @{@"uid":@"85149891",
                              @"latitude":@"40.090562",
                              @"longitude":@"116.413353"
                              };
    
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
    
}

@end
