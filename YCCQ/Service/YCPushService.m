//
//  YCPushService.m
//  YCCQ
//
//  Created by qi chao on 15/12/16.
//  Copyright © 2015年 Baisika. All rights reserved.
//

#import "YCPushService.h"
#import "AFHTTPRequestOperationManager.h"

#ifdef DEBUG
#define LookPushURL @"http://172.16.0.10:7223/m/pusher/lookPush?device=%@"
#else
#define LookPushURL @"http://appapi.youche.com/m/pusher/lookPush?device=%@"
#endif

@implementation YCPushService

+ (void)lookPushWithBlock:(lookPushBlock)block
{
    [[AFHTTPRequestOperationManager manager] GET:[NSString stringWithFormat:LookPushURL, [[NSUserDefaults standardUserDefaults] objectForKey:@"device"]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            NSString *status = responseObject[@"v"][@"status"];
            if ([status isEqualToString:@"success"]) {
                block(YES, @"");
            } else {
                block(NO, @"读取失败");
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(NO, @"网络不给力啊");
        }
    }];
     
}

@end
