//
//  VCTabBar.h
//  inke-iOS
//
//  Created by VoyageCN on 2016/10/31.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VCItemType) {
    
    VCItemTypeLaunch = 10,
    VCItemTypeLive = 100, // 展示直播
    VCItemTypeMe, // 我的直播
    
};

@class VCTabBar;

typedef void(^TabBlock)(VCTabBar *tabBar, VCItemType index);

@protocol VCTabBarDelegate <NSObject>

- (void)tabBar:(VCTabBar *)tabBar clickButton:(VCItemType) index;

@end

@interface VCTabBar : UIView

@property (nonatomic, weak) id<VCTabBarDelegate> delegate;

@property (nonatomic, copy) TabBlock block;

@end
