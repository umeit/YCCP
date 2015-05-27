//
//  YCNetUtil.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/27.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCNetUtil : NSObject

+ (NSURL *)youcheImageURLWithPath:(NSString *)path w:(NSInteger)w h:(NSInteger)h;

+ (NSURL *)youcheCarURLWithCarID:(NSInteger)carID;

@end
