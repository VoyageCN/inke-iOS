//
//  VCHotLiveCell.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/10.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "VCHotLiveCell.h"
#import "UIImageView+SDWebImage.h"

@interface VCHotLiveCell ()

@property (weak, nonatomic) IBOutlet UIImageView *liveImageView;
@property (weak, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineUserCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *areaButton;

@end

@implementation VCHotLiveCell

- (void)setLive:(VCLive *)live {
    
    _live = live;
    
    [self.liveImageView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
    [self.portraitImageView downloadImage:[NSString stringWithFormat:@"%@%@",IMAGE_HOST,live.creator.portrait] placeholder:@"default_room"];
    
    self.nameLabel.text = live.creator.nick;
    self.onlineUserCountLabel.text = [NSString stringWithFormat:@"%li",live.online_users];
    [self.areaButton setTitle:[NSString stringWithFormat:@"%@",live.city] forState:UIControlStateNormal];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
