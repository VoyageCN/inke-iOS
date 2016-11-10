//
//  VCLive.h
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/7.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VCCreator.h"

@interface VCLive : NSObject
@property (nonatomic, strong) NSString * city;
@property (nonatomic, strong) VCCreator * creator;
@property (nonatomic, assign) NSInteger group;
@property (nonatomic, strong) NSString * ID;
@property (nonatomic, strong) NSString * image;
@property (nonatomic, assign) NSInteger link;
@property (nonatomic, assign) NSInteger multi;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger online_users;
@property (nonatomic, assign) NSInteger optimal;
@property (nonatomic, assign) NSInteger pub_stat;
@property (nonatomic, assign) NSInteger roomId;
@property (nonatomic, assign) NSInteger rotate;
@property (nonatomic, strong) NSString * share_addr;
@property (nonatomic, assign) NSInteger slot;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * streamAddr;
@property (nonatomic, assign) NSInteger version;

@property (nonatomic, copy) NSString * distance;

@property (nonatomic, getter=isShow) BOOL show;

@end
