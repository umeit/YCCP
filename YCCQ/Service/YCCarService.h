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

// 获取爆款
- (void)baokuanWithBlock:(BaokuanBlock)block;

// 获取在售品牌
- (void)brandsFromOnSell:(OnSellBrandBlock)block;

// 根据品牌 ID 获取在售车系
- (void)seriesesFromOnSellWithPID:(NSInteger)pid block:(BaokuanBlock)block;

// 根据品牌 ID 获取在售车型
- (void)modelsFromOnSellWithPID:(NSInteger)pid block:(BaokuanBlock)block;


// 获取所有品牌
- (void)allBrands:(OnSellBrandBlock)block;

// 获取所有车系
- (void)allSeriesesWithPID:(NSInteger)pid block:(OnSellBrandBlock)block;

// 获取所有车型
- (void)allModelsWithPID:(NSInteger)pid block:(BaokuanBlock)block;
@end
