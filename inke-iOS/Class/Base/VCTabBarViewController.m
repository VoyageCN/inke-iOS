//
//  VCTabBarViewController.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/10/31.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCTabBarViewController.h"
#import "VCTabBar.h"
#import "VCBaseNavViewController.h"

@interface VCTabBarViewController ()<VCTabBarDelegate>

@property (nonatomic, strong) VCTabBar *vcTabBar;

@end

@implementation VCTabBarViewController

- (VCTabBar *)vcTabBar {
    if (!_vcTabBar) {
        _vcTabBar = [[VCTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
        _vcTabBar.delegate = self;
    }
    return _vcTabBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configViewControllers];
    
    [self.tabBar addSubview:self.vcTabBar];
}

- (void)configViewControllers {
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"VCMainViewController",@"VCMeViewController"]];
    
    for (NSInteger i = 0; i < array.count; i++) {
        
        NSString *vcName = array[i];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        
        VCBaseNavViewController *nav = [[VCBaseNavViewController alloc] initWithRootViewController:vc];
        
        [array replaceObjectAtIndex:i withObject:nav];
        
    }
    
    self.viewControllers = array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - VCTabBarDelegate
- (void)tabBar:(VCTabBar *)tabBar clickButton:(VCItemType)index {
    
}

@end
