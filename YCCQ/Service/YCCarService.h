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

/** 获取爆款 */
- (void)baokuanWithBlock:(BaokuanBlock)block;

/** 获取在售品牌（包含‘不限’）*/
- (void)brandsFromOnSell:(OnSellBrandBlock)block;

/** 根据品牌 ID 获取在售车系（包含‘不限’）*/
- (void)seriesesFromOnSellWithPID:(NSString *)pid block:(BaokuanBlock)block;

/** 根据品牌 ID 获取在售车型（包含‘不限’）*/
- (void)modelsFromOnSellWithPID:(NSString *)pid block:(BaokuanBlock)block;

/** 获取所有品牌（不包含‘不限’）*/
- (void)allBrands:(OnSellBrandBlock)block;

/** 获取所有车系（不包含‘不限’）*/
- (void)allSeriesesWithPID:(NSString *)pid block:(OnSellBrandBlock)block;

/** 获取所有车型（不包含‘不限’）*/
- (void)allModelsWithPID:(NSString *)pid block:(BaokuanBlock)block;
@end
