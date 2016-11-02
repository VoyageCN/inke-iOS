//
//  VCMainTopView.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/1.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCMainTopView.h"

@implementation VCMainTopView

- (instancetype)initWithFrame:(CGRect)frame titleNames:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat btnW = self.width / titles.count;
        CGFloat btnH = self.height;
        
        for (NSInteger i = 0; i < titles.count; i ++) {
            
            UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            NSString *vcName = titles[i];
            
            [titleBtn setTitle:vcName forState:(UIControlStateNormal)];
            [titleBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            titleBtn.titleLabel.font = [UIFont systemFontOfSize:18.0];
            
            titleBtn.frame = CGRectMake(i * btnW, 0, btnW, btnH);
            
            [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self addSubview:titleBtn];
        }
        
    }
    return self;
}

- (void)titleClick:(UIButton *)button {
    
    
}

@end
