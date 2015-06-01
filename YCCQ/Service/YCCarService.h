//
//  YCCarService.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/19.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCBaoKuanEntity;

typedef void (^BaokuanBlock) (NSArray *baokuans);

typedef void (^OnSellBrandBlock) (NSArray *brands);

@interface YCCarService : NSObject

// 获取所有爆款
- (void)baokuanWithBlock:(BaokuanBlock)block;

// 获取所有在售品牌
- (void)brandsFromOnSell:(OnSellBrandBlock)block;

@end
