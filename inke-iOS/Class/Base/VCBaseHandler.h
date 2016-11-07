//
//  VCBaseHandler.h
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/7.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  处理完成事件
 */
typedef void(^CompleteBlock)();

/**
 *  处理事件成功
 *
 *  @param obj 返回数据
 */
typedef void(^SuccessBlock)(id obj);

/**
 *  处理事件失败
 *
 *  @param obj 错误信息
 */
typedef void(^FailedBlock)(id obj);

@interface VCBaseHandler : NSObject

@end
