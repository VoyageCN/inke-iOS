//
//  VCNearViewController.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/7.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCNearViewController.h"
#import "VCNearLiveCell.h"
#import "VCLiveHandler.h"
#import "VCPlayerViewController.h"

static NSString *identifier = @"VCNearLiveCell";

#define kMargin 5
#define kItemWidth 100
@interface VCNearViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *dataList;

@end

@implementation VCNearViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegate
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VCNearLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.live = self.dataList[indexPath.row];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataList.count;
}

// cell将要显示时调用
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    VCNearLiveCell *c = (VCNearLiveCell *)cell;
    
    [c showAnimation];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = self.collectionView.width / kItemWidth;
    
    CGFloat etraWidth = (self.collectionView.width - kMargin * (count + 1)) / count;
    
    return CGSizeMake(etraWidth, etraWidth + 20);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    VCLive *live = self.dataList[indexPath.row];
    
    VCPlayerViewController *playVC = [[VCPlayerViewController alloc] init];
    playVC.live = live;
    [self.navigationController pushViewController:playVC animated:YES];
    
}

- (void)initUI {
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"VCNearLiveCell" bundle:nil] forCellWithReuseIdentifier:identifier];
}

- (void)loadData {
    
    [VCLiveHandler executeGetNearLiveTaskWithSuccess:^(id obj) {
        
        self.dataList = obj;
        [self.collectionView reloadData];
        
    } failed:^(id obj) {
        
        NSLog(@"%@",obj);
    }];
}


@end
