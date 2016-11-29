//
//  VCLaunchViewController.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/1.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCLaunchViewController.h"
#import "LFLivePreview.h"

@interface VCLaunchViewController ()

@end

@implementation VCLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startLive:(id)sender {
    
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backView];
    
    LFLivePreview *preView = [[LFLivePreview alloc] initWithFrame:self.view.bounds];
    preView.vc = self;
    [self.view addSubview:preView];
    
    [preView startLive];
}

- (IBAction)closeLaunch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
