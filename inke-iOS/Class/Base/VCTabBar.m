//
//  VCTabBar.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/10/31.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCTabBar.h"

@interface VCTabBar ()

@property (nonatomic, strong) UIImageView *tabBgView;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) UIButton *lastItem;

@property (nonatomic, strong) UIButton *cameraButton;

@end

@implementation VCTabBar

- (UIButton *)cameraButton {
    
    if (!_cameraButton) {
        _cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraButton.tag = VCItemTypeLaunch;
        [_cameraButton setImage:[UIImage imageNamed:@"tab_launch"] forState:UIControlStateNormal];
        [_cameraButton addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraButton;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = @[@"tab_live",@"tab_me"];
    }
    return _dataList;
}

- (UIImageView *)tabBgView {
    
    if (!_tabBgView) {
        _tabBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"global_tab_bg"]];
    }
    return _tabBgView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 装载背景
        [self addSubview:self.tabBgView];
        
        // 装载item
        for (NSInteger i = 0; i < self.dataList.count; i++) {
            
            UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
            
            item.adjustsImageWhenHighlighted = NO;
            
            [item setImage:[UIImage imageNamed:self.dataList[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:[self.dataList[i] stringByAppendingString:@"_p"]] forState:UIControlStateSelected];
            
            [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
            
            item.tag = VCItemTypeLive + i;
            
            if (i == 0) {
                item.selected = YES;
                self.lastItem = item;
            }
            
            [self addSubview:item];
        }
        [self addSubview:self.cameraButton];
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.tabBgView.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width / self.dataList.count;
    
    for (NSInteger i = 0; i < [self subviews].count; i ++) {
        
        UIView *btn = [self subviews][i];
        if ([btn isKindOfClass:[UIButton class]]) {
            
            btn.frame = CGRectMake((btn.tag - VCItemTypeLive) * width, 0, width, self.frame.size.height);
        }
    }
    [self.cameraButton sizeToFit];
    self.cameraButton.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height - 50);
}

- (void)clickItem:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(tabBar:clickButton:)]) {
        [self.delegate tabBar:self clickButton:button.tag];
    }
    
    !self.block? : self.block(self,button.tag);
    
    if (button.tag == VCItemTypeLaunch) {
        return ;
    }
    
    self.lastItem.selected = NO;
    button.selected = YES;
    self.lastItem = button;
    
    [UIView animateWithDuration:0.2 animations:^{
        button.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            button.transform = CGAffineTransformIdentity;
        }];
    }];
}

@end
