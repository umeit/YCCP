//
//  YCBannerService.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/19.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCBannerService.h"
#import "YCBannerEntity.h"

@interface YCBannerService ()

@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation YCBannerService

- (void)bannersWithBlock:(BannerBlock)block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        YCBannerEntity *banner1 = [[YCBannerEntity alloc] init];
        banner1.imageURL = [NSURL URLWithString:@"http://file.youche.com/_380_252/0/car/cac12b7d7256b7ad.jpg"];
        banner1.linkURL = [NSURL URLWithString:@"http://www.youche.com/detail/9622.shtml"];
        
        YCBannerEntity *banner2 = [[YCBannerEntity alloc] init];
        banner2.imageURL = [NSURL URLWithString:@"http://file.youche.com/_380_252/0/car/f2a60f6a1becca01.jpg"];
        banner2.linkURL = [NSURL URLWithString:@"http://www.youche.com/detail/10197.shtml"];
        
        YCBannerEntity *banner3 = [[YCBannerEntity alloc] init];
        banner3.imageURL = [NSURL URLWithString:@"http://file.youche.com/_380_252/0/car/76b6c45fdd2a12de.jpg"];
        banner3.linkURL = [NSURL URLWithString:@"http://www.youche.com/detail/9984.shtml"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(@[banner1, banner2, banner3]);
        });
    });
}

@end
