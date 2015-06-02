//
//  YCCarUtil.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCCarUtil : NSObject

+ (NSString *)brandWithTag:(NSInteger)tag;

+ (NSString *)brandWithTagForFilter:(NSInteger)tag;

+ (NSString *)carTypeWithTag:(NSInteger)tag;

+ (NSString *)pIDWithBrand:(NSString *)brandName;

@end
