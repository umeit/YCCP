//
//  YCBannerService.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/19.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YCBannerService : NSObject

+ (id)sharedInstance;

- (NSArray *)bannerImages;

@end
