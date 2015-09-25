//
//  YCFilterConditionStore.m
//  YCCQ
//
//  Created by Liu Feng on 15/9/22.
//  Copyright © 2015年 Baisika. All rights reserved.
//

#import "YCFilterConditionStore.h"
#import "YCCarFilterConditionEntity.h"

@implementation YCFilterConditionStore

static YCFilterConditionStore *_filterConditionStore;

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _filterConditionStore = [[YCFilterConditionStore alloc] init];
    });
    return _filterConditionStore;
}

- (instancetype)init
{
    if (self = [super init]) {
        _carListFilterCondition = [[YCCarFilterConditionEntity alloc] init];
        _carEvaluateFilterCondition = [[YCCarFilterConditionEntity alloc] init];
    }
    return self;
}

- (void)clearCarEvaluateFilterCondition
{
    self.carEvaluateFilterCondition = [[YCCarFilterConditionEntity alloc] init];
}

- (void)clearCarListFilterCondition
{
    self.carListFilterCondition.brandName = nil;
    self.carListFilterCondition.brandValue = nil;
    self.carListFilterCondition.brandID = nil;
    
    self.carListFilterCondition.seriesName = nil;
    self.carListFilterCondition.seriesValue = nil;
    self.carListFilterCondition.seriesID = nil;
    
    self.carListFilterCondition.modelName = nil;
    self.carListFilterCondition.modelValue = nil;
    self.carListFilterCondition.modelID = nil;
    
    self.carListFilterCondition.priceName = nil;
    self.carListFilterCondition.priceValue = nil;
    
    self.carListFilterCondition.carTypeName = nil;
    self.carListFilterCondition.carTypeValue = nil;
    
    self.carListFilterCondition.mileageName = nil;
    self.carListFilterCondition.mileageValue = nil;
    
    self.carListFilterCondition.gearboxName = nil;
    self.carListFilterCondition.gearboxValue = nil;
    
    self.carListFilterCondition.colorName = nil;
    self.carListFilterCondition.colorValue = nil;
    
    self.carListFilterCondition.yearName = nil;
    self.carListFilterCondition.yearValue = nil;
    
    self.carListFilterCondition.ccName = nil;
    self.carListFilterCondition.ccValue = nil;
    
    self.carListFilterCondition.storeName = nil;
    self.carListFilterCondition.storeValue = nil;
}

- (void)carListConditionBrandName:(NSString *)name value:(NSString *)value ID:(NSString *)iD
{
    self.carListFilterCondition.brandName = name;
    self.carListFilterCondition.brandValue = value;
    self.carListFilterCondition.brandID = iD;
    self.carListFilterCondition.seriesName = nil;
    self.carListFilterCondition.seriesValue = nil;
    self.carListFilterCondition.seriesID = nil;
    self.carListFilterCondition.modelName = nil;
    self.carListFilterCondition.modelValue = nil;
    self.carListFilterCondition.modelID = nil;
}

- (void)carListConditionSeriesName:(NSString *)name value:(NSString *)value ID:(NSString *)iD
{
    self.carListFilterCondition.seriesName = name;
    self.carListFilterCondition.seriesValue = value;
    self.carListFilterCondition.seriesID = iD;
    self.carListFilterCondition.modelName = nil;
    self.carListFilterCondition.modelValue = nil;
    self.carListFilterCondition.modelID = nil;
}

- (void)carListConditionModelName:(NSString *)name value:(NSString *)value ID:(NSString *)iD
{
    self.carListFilterCondition.modelName = name;
    self.carListFilterCondition.modelValue = value;
    self.carListFilterCondition.modelID = iD;
}

- (void)carEvaConditionBranName:(NSString *)name value:(NSString *)value ID:(NSString *)iD
{
    self.carEvaluateFilterCondition.brandName = name;
    self.carEvaluateFilterCondition.brandValue = value;
    self.carEvaluateFilterCondition.brandID = iD;
    self.carEvaluateFilterCondition.seriesName = nil;
    self.carEvaluateFilterCondition.seriesValue = nil;
    self.carEvaluateFilterCondition.seriesID = nil;
    self.carEvaluateFilterCondition.modelName = nil;
    self.carEvaluateFilterCondition.modelValue = nil;
    self.carEvaluateFilterCondition.modelID = nil;
}

- (void)carEvaConditionSeriesName:(NSString *)name value:(NSString *)value ID:(NSString *)iD
{
    self.carEvaluateFilterCondition.seriesName = name;
    self.carEvaluateFilterCondition.seriesValue = value;
    self.carEvaluateFilterCondition.seriesID = iD;
    self.carEvaluateFilterCondition.modelName = nil;
    self.carEvaluateFilterCondition.modelValue = nil;
    self.carEvaluateFilterCondition.modelID = nil;
}

- (void)carEvaConditionModelName:(NSString *)name value:(NSString *)value ID:(NSString *)iD
{
    self.carEvaluateFilterCondition.modelName = name;
    self.carEvaluateFilterCondition.modelValue = value;
    self.carEvaluateFilterCondition.modelID = iD;
}

@end
