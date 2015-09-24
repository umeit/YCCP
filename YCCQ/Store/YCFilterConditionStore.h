//
//  YCFilterConditionStore.h
//  YCCQ
//
//  Created by Liu Feng on 15/9/22.
//  Copyright © 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCCarFilterConditionEntity;

@interface YCFilterConditionStore : NSObject

@property (nonatomic, strong) YCCarFilterConditionEntity *carListFilterCondition;

@property (nonatomic, strong) YCCarFilterConditionEntity *carEvaluateFilterCondition;

+ (instancetype)sharedInstance;

- (void)clearCarListFilterCondition;

- (void)clearCarEvaluateFilterCondition;

- (void)carListConditionBrandName:(NSString *)name value:(NSString *)value ID:(NSString *)iD;

- (void)carListConditionSeriesName:(NSString *)name value:(NSString *)value ID:(NSString *)iD;

- (void)carListConditionModelName:(NSString *)name value:(NSString *)value ID:(NSString *)iD;

@end
