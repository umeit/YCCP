//
//  YCPushService.h
//  YCCQ
//
//  Created by qi chao on 15/12/16.
//  Copyright © 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^lookPushBlock) (BOOL success, NSString *msg);

@interface YCPushService : NSObject

+ (void)lookPushWithBlock:(lookPushBlock)block;

@end
