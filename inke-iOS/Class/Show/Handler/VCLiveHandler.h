//
//  VCLiveHandler.h
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/7.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCBaseHandler.h"

@interface VCLiveHandler : VCBaseHandler

/**
 *  Get hot live information
 *
 *  @param success 成功回调
 *  @param failed 失败回调
 */
+ (void)executeGetHotLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 *  获取附近的直播信息
 *
 *  @param success 成功回调
 *  @param failed 失败回调
 */
+ (void)executeGetNearLiveTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 *  获取广告页
 *
 *  @param success 成功回调
 *  @param failed 失败回调
 */

+ (void)executeGetAdvertiseTaskWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

@end
