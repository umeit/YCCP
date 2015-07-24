//
//  YCUserService.m
//  YCCQ
//
//  Created by Liu Feng on 15/7/24.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCUserService.h"
#import "YCYouCheHTTPClient.h"

@implementation YCUserService

+ (void)sendCouponMessageToUserPhone:(NSString *)phoneNum
                           withBlock:(sendCouponMsgBlock)block
{
    [[YCYouCheHTTPClient httpClient] POST:@"/special/apply"
                               parameters:@{@"mobile": phoneNum, @"type": @(8)}
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSString *status = [responseObject objectForKey:@"msg"];
                                      if ([status isEqualToString:@"success"]) {
                                          block(YES, @"");
                                      }
                                      else {
                                          block(NO, @"领取礼品劵失败");
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      block(NO, @"网络不给力");
                                  }];
}

@end
