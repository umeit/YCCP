//
//  YCBannerService.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/19.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCBannerService.h"

@interface YCBannerService ()

@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation YCBannerService

static YCBannerService *_sharedObject = nil;

+ (id)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *image1 = [UIImage imageNamed:@"Banner1"];
        UIImage *image2 = [UIImage imageNamed:@"Banner2"];
        UIImage *image3 = [UIImage imageNamed:@"Banner3"];
        
        _images = [[NSMutableArray alloc] init];
        [_images addObject:image1];
        [_images addObject:image2];
        [_images addObject:image3];
    }
    return self;
}

- (NSArray *)bannerImages
{
    return self.images;
}

@end
