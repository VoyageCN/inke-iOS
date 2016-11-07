//
//  VCNearLiveCell.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/7.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCNearLiveCell.h"
#import "UIImageView+SDWebImage.h"

@interface VCNearLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation VCNearLiveCell

- (void)showAnimation {
    
    if (self.live.isShow) {
        return ;
    }
    
    self.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        
        self.live.show = YES;
    }];
}

- (void)setLive:(VCLive *)live {
    
    _live = live;
    
    [self.headImage downloadImage:[NSString stringWithFormat:@"%@%@", IMAGE_HOST, live.creator.portrait] placeholder:@"default_room"];
    
    self.distanceLabel.text = live.distance;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
