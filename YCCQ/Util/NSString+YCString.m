//
//  NSString+YCSubString.m
//  YCCQ
//
//  Created by qi chao on 15/11/26.
//  Copyright © 2015年 Baisika. All rights reserved.
//

#import "NSString+YCString.h"

@implementation NSString (YCString)

- (NSString *)YCSubStringFromString:(NSString *)from toString:(NSString *)to {
    NSRange fromRange = [self rangeOfString:from];
    NSRange toRange = [self rangeOfString:to];
    return [self substringWithRange:NSMakeRange(fromRange.location + 1, toRange.location - fromRange.location - 1)];
}

- (NSString *)YCDeleteLastPathOfT {
    if (![self hasSuffix:@"ershouche/"]) {
        return [self stringByDeletingLastPathComponent];
    }
    return self;
}

@end
