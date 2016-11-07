//
//  VCMainTopView.h
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/1.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MainTopBlock)(NSInteger tag);

@interface VCMainTopView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles;

@property (nonatomic, copy) MainTopBlock block;

- (void)scrolling:(NSInteger)tag;
@end
