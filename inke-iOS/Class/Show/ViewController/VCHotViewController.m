//
//  VCHotViewController.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/1.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCHotViewController.h"
#import "VCHotLiveCell.h"
#import "VCLiveHandler.h"
#import "VCPlayerViewController.h"

static NSString *identifier = @"VCHotLiveCell";

@interface VCHotViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation VCHotViewController

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataList {
    
    if (!_dataList) {
        _dataList = [NSArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VCHotLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.live = self.dataList[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70 + SCREEN_WIDTH;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    VCLive *live = self.dataList[indexPath.row];
    
    VCPlayerViewController *playVC = [[VCPlayerViewController alloc] init];
    playVC.live = live;
    
    [self.navigationController pushViewController:playVC animated:YES];
}

- (void)initUI {
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VCHotLiveCell" bundle:nil] forCellReuseIdentifier:identifier];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 64 + 49 + 50, 0);
}

- (void)loadData {
    
    [VCLiveHandler executeGetHotLiveTaskWithSuccess:^(id obj) {
        
        
        self.dataList = obj;
        [self.tableView reloadData];
        
    } failed:^(id obj) {
        
        NSLog(@"%@", obj);
    }];
}

@end
