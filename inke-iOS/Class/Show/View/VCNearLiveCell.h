//
//  VCNearLiveCell.h
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/7.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCLive.h"

@interface VCNearLiveCell : UICollectionViewCell

@property (nonatomic, strong) VCLive *live;

- (void)showAnimation;

@end
