//
//  VCMainViewController.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/10/31.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCMainViewController.h"

@interface VCMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation VCMainViewController

- (NSArray *)dataList {
    if (!_dataList) {
        _dataList = @[@"关注",@"热点",@"附近"];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    //
    [self setupNav];
    
    // 添加子视图控制器
    [self setupChildViewControllers];
}

- (void)setupChildViewControllers {
    
    NSArray *vcNames = @[@"VCFocusViewController",@"VCHotViewController",@"VCNearViewController"];
    
    for (NSInteger i = 0; i < vcNames.count; i ++) {
        NSString *vcName = vcNames[i];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        
        [self addChildViewController:vc];
    }
    // 将子控制器的View，加到MainVC的ScrollView上
    
    // 设置scrollView的ContentSize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.dataList.count, 0);
    
    // 默认先展示第二个页面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH , 0);
    
    // 进入主控制器加载第一个页面
    [self scrollViewDidEndDecelerating:self.contentScrollView];
}

- (void)setupNav {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:(UIBarButtonItemStyleDone) target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:(UIBarButtonItemStyleDone) target:self action:@selector(checkMail)];
}

- (void)search {
    NSLog(@"进入搜索页面");
}

- (void)checkMail {
    NSLog(@"检查新消息");
}

// 减速结束时调用加载子控制器View的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat width = SCREEN_WIDTH; 
    CGFloat height = SCREEN_HEIGHT;
    
    CGFloat offset = scrollView.contentOffset.x;
    
    // 获取索引值
    NSInteger idx = offset / width;
    
    // 根据索引值返回vc引用
    UIViewController *vc = self.childViewControllers[idx];
    
    // 判断当前vc是否执行过viewDidLoad
    if ([vc isViewLoaded]) return;
    
    // 设置子控制器view的大小
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
    
    // 将子控制器的view加入scrollView上
    [scrollView addSubview:vc.view];
}



@end
