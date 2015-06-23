//
//  YCDriveService.h
//  YCCQ
//
//  Created by Liu Feng on 15/6/23.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^OilPriceBlock) (NSDictionary *oilPrice);

@interface YCDriveService : NSObject

// 获取北京油价
- (void)oilPrice:(OilPriceBlock)block;

@end
