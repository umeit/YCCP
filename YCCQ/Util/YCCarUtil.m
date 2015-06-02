//
//  YCCarUtil.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCarUtil.h"

@implementation YCCarUtil

static NSDictionary *carBrands;
static NSDictionary *carBrandsForFilter;
static NSDictionary *carTypes;
static NSDictionary *carPID;

+ (NSString *)brandWithTag:(NSInteger)tag
{
    if (!carBrands) {
        carBrands = @{@"31": @"mercedes-benz",
                      @"32": @"bmw",
                      @"33": @"audi",
                      @"34": @"volkswagen",
                      @"35": @"hyundai",
                      @"36": @"ford",
                      @"37": @"buick",
                      @"38": @""};
    }

    return carBrands[[@(tag) stringValue]];
}

+ (NSString *)brandWithTagForFilter:(NSInteger)tag
{
    if (!carBrandsForFilter) {
        carBrandsForFilter = @{@"31": @"mercedes-benz",
                      @"32": @"bmw",
                      @"33": @"audi",
                      @"34": @"volkswagen",
                      @"35": @"hyundai",
                      @"36": @"ford",
                      @"37": @"buick",
                      @"38": @"toyota"};
    }
    
    return carBrandsForFilter[[@(tag) stringValue]];
}

+ (NSString *)pIDWithBrand:(NSString *)brandName
{
    if (!carPID) {
        carPID = @{@"mercedes-benz": @"107",
                   @"bmw": @"108",
                   @"audi": @"100",
                   @"volkswagen": @"129",
                   @"hyundai": @"269",
                   @"ford": @"145",
                   @"buick": @"117",
                   @"toyota": @"144"};
    }
    
    return carPID[brandName];
}

+ (NSString *)carTypeWithTag:(NSInteger)tag
{
    if (!carTypes) {
        carTypes = @{@"31": @"suv",
                     @"32": @"mpv",
                     @"33": @"paoche",
                     @"34": @"weixing",
                     @"35": @"xiaoxing",
                     @"36": @"jinchou",
                     @"37": @"zhongxingche",
                     @"38": @"zhongdaxing",
                     @"39": @"haohua",
                     @"40": @"ershouche"};
    }
    
    return carTypes[[@(tag) stringValue]];
}

@end
