//
//  YCUserUtil.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/24.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCUserUtil.h"

#define kUserLicensePlateNumber @"UserLicensePlateNumber"

#define UserDefaulte [NSUserDefaults standardUserDefaults]

@implementation YCUserUtil

+ (BOOL)isValidPhoneNum:(NSString *)num
{
    return num.length == 11;
}

+ (NSString *)userLicensePlateNumber
{
    return [UserDefaulte stringForKey:kUserLicensePlateNumber];
}

@end
