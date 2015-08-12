//
//  YCCarUtil.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCFilterKeyUtil : NSObject

+ (NSString *)brandFilterKeyWithButtonTag:(NSInteger)tag;

+ (NSString *)brandCnNameWithHotBrandButtonTag:(NSInteger)tag;

+ (NSString *)carTypeWithButtonTag:(NSInteger)tag;

+ (NSString *)pIDWithBrand:(NSString *)brandName;

+ (NSString *)carPriceFilterKeyWithButtonTag:(NSInteger)tag;

+ (NSString *)hotCarFilterKeyWithButtonTah:(NSInteger)tag;

@end
