//
//  VCMainViewController.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/10/31.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCMainViewController.h"
#import "VCMainTopView.h"

@interface VCMainViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic, strong) NSArray *dataList;

@property (nonatomic, strong) VCMainTopView *topView;

@end

@implementation VCMainViewController

- (VCMainTopView *)topView {
    
    if (!_topView) {
        _topView = [[VCMainTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 50) titleNames:self.dataList];
        
        @weakify(self);
        _topView.block = ^(NSInteger tag) {
            @strongify(self);
            CGPoint point = CGPointMake(tag * SCREEN_WIDTH, self.contentScrollView.contentOffset.y);
            [self.contentScrollView setContentOffset:point animated:YES];
            
        };
    }
    return _topView;
}

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
    
    [self.view addSubview:self.contentScrollView];
    // 添加左右按钮
    [self setupNav];
    
    // 添加子视图控制器
    [self setupChildViewControllers];
}

- (void)setupChildViewControllers {
    
    NSArray *vcNames = @[@"VCFocusViewController",@"VCHotViewController",@"VCNearViewController"];
    
    for (NSInteger i = 0; i < vcNames.count; i ++) {
        NSString *vcName = vcNames[i];
        
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = self.dataList[i];
        //当执行这句话addChildViewController时，不会执行该vc的viewdidload
        [self addChildViewController:vc];
    }
    // 将子控制器的View，加到MainVC的ScrollView上
    
    // 设置scrollView的ContentSize
    self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.dataList.count, 0);
    
    // 默认先展示第二个页面
    self.contentScrollView.contentOffset = CGPointMake(SCREEN_WIDTH , 0);
    
    // 进入主控制器加载第一个页面
    [self scrollViewDidEndScrollingAnimation:self.contentScrollView];
}

- (void)setupNav {
    
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"global_search"] style:(UIBarButtonItemStyleDone) target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"title_button_more"] style:(UIBarButtonItemStyleDone) target:self action:@selector(checkMail)];
}

#pragma mark - UIScrollViewDelegate
// 动画结束时调用代理
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    CGFloat width = SCREEN_WIDTH;//scrollView.frame.size.width;
    
    CGFloat height = SCREEN_HEIGHT - 64 - 49;
    
    CGFloat offset = scrollView.contentOffset.x;
    //获取索引值
    NSInteger idx = offset / width;
    
    //索引值联动topView
    [self.topView scrolling:idx];
    
    //根据索引值返回vc引用
    UIViewController * vc = self.childViewControllers[idx];
    
    //判断当前vc是否执行过viewdidLoad
    if ([vc isViewLoaded]) return;
    
    //设置子控制器view的大小
    vc.view.frame = CGRectMake(offset, 0, scrollView.frame.size.width, height);
    //将子控制器的view加入scrollview上
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - private
- (void)search {
    NSLog(@"进入搜索页面");
}

- (void)checkMail {
    NSLog(@"检查新消息");
}


@end
