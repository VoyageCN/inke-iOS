//
//  UIImageView+SDWebImage.m
//  inke-iOS
//
//  Created by VoyageCN on 2016/11/7.
//  Copyright © 2016年 VoyageCN. All rights reserved.
//

#import "UIImageView+SDWebImage.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (SDWebImage)

- (void)downloadImage:(NSString *)url
          placeholder:(NSString *)imageName {
    
    [self sd_setImageWithURL:[NSURL URLWithString:url]
            placeholderImage:[UIImage imageNamed:imageName]
                     options:SDWebImageRetryFailed|SDWebImageLowPriority];
    
}

- (void)downloadImage:(NSString *)url
          placeholder:(NSString *)imageName
              success:(DownloadImageSuccessBlock)success
               failed:(DownloadImageFailedBlock)failed
             progress:(DownloadImageProgressBlock)progress {
 
   [self sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:url]
                                  placeholderImage:[UIImage imageNamed:imageName]
                                           options:SDWebImageRetryFailed|SDWebImageLowPriority
                                          progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    
    progress(receivedSize * 1.0 / expectedSize);
    
} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
    if (error) {
        
        failed(error);
    } else {
        
        self.image = image;
        success(image);
    }
}];
}

@end
