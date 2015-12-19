//
//  YCPushService.m
//  YCCQ
//
//  Created by qi chao on 15/12/16.
//  Copyright © 2015年 Baisika. All rights reserved.
//

#import "YCPushService.h"
#import "AFHTTPRequestOperationManager.h"

//#ifdef DEBUG
//#define LookPushURL @"http://172.17.149.194:8888/m/push/markread?device=%@"
//#else
#define LookPushURL @"http://appapi.youche.com/m/push/markread?device=%@"
//#endif

@implementation YCPushService

+ (void)lookPushWithBlock:(lookPushBlock)block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//#ifdef DEBUG
//    [manager.requestSerializer setValue:@"appapi.youche.com" forHTTPHeaderField:@"Host"];
//#endif
    [manager GET:[NSString stringWithFormat:LookPushURL, [[NSUserDefaults standardUserDefaults] objectForKey:@"device"]] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (block) {
            NSLog(@"%@", responseObject);
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
        NSLog(@"%@", error);
    }];
}

@end
