//
//  YCCarUtil.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCFilterKeyUtil.h"

@implementation YCFilterKeyUtil

//static NSDictionary *carBrands;
static NSDictionary *carBrandsForFilter;
static NSDictionary *carBrandsCnNameForHotBrand;
static NSDictionary *carTypes;
static NSDictionary *carPrice;
static NSDictionary *carPID;

// /** 根据在首页选择的品牌获取筛选参数 */
//+ (NSString *)brandWithTag:(NSInteger)tag
//{
//    if (!carBrands) {
//        carBrands = @{@"31": @"mercedes-benz",
//                      @"32": @"bmw",
//                      @"33": @"audi",
//                      @"34": @"volkswagen",
//                      @"35": @"hyundai",
//                      @"36": @"ford",
//                      @"37": @"buick",
//                      @"38": @""};
//    }
//    return carBrands[[@(tag) stringValue]];
//}

/** 根据快速选择品牌的按钮的 tag 获取品牌筛选筛选参数 */
+ (NSString *)brandFilterKeyWithButtonTag:(NSInteger)tag
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

+ (NSString *)brandCnNameWithHotBrandButtonTag:(NSInteger)tag
{
    if (!carBrandsCnNameForHotBrand) {
        carBrandsCnNameForHotBrand = @{@"31": @"奔驰",
                                       @"32": @"宝马",
                                       @"33": @"奥迪",
                                       @"34": @"大众",
                                       @"35": @"现代",
                                       @"36": @"福特",
                                       @"37": @"别克",
                                       @"38": @"丰田"};
    }
    return carBrandsCnNameForHotBrand[[@(tag) stringValue]];
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

+ (NSString *)carTypeWithButtonTag:(NSInteger)tag
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

+ (NSString *)carPriceFilterKeyWithButtonTag:(NSInteger)tag
{
    if (!carPrice) {
        carPrice = @{@"31": @"j1",
                     @"32": @"j2",
                     @"33": @"j3",
                     @"34": @"j4",
                     @"35": @"j5",
                     @"36": @"j6",
                     @"37": @"j7",
                     @"38": @"j8"};
    }
    return carPrice[[@(tag) stringValue]];
}

@end
