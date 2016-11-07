//
//  VCLocationManager.h
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/7.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^VCLocationBlock)(NSString *lat, NSString *lon);

@interface VCLocationManager : NSObject

+ (instancetype)sharedManager;

- (void)getLocation:(VCLocationBlock)block;

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *lon;

@end
