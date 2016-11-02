//
//  VCLaunchViewController.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/1.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCLaunchViewController.h"

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

- (IBAction)closeLaunch:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
