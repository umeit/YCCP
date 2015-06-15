//
//  YCNetUtil.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/27.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCNetUtil.h"

static NSString *fileYouChePath = @"http://file.youche.com/_%d_%d%@";

@implementation YCNetUtil

+ (NSURL *)youcheImageURLWithPath:(NSString *)path w:(NSInteger)w h:(NSInteger)h
{
    NSString *url = [NSString stringWithFormat:fileYouChePath, w, h, path];
    return [NSURL URLWithString:url];
}

+ (NSString *)youcheCarURLWithCarID:(NSInteger)carID
{
    NSString *url = [NSString stringWithFormat:@"http://www.youche.com/detail/%ld.shtml", (long)carID];
    return url;
}

@end
