//
//  YCYouCheHTTPClient.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/26.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCYouCheHTTPClient.h"

@implementation YCYouCheHTTPClient

+ (instancetype)httpClient
{
    static NSString *url = @"http://www.youche.com/json/app/";
    return [[self alloc] initWithBaseURL:[NSURL URLWithString:url]];
}

@end
