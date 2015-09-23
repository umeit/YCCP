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
        _carListFilterCondition.brandName   = @"不限";
        _carListFilterCondition.brandID     = @"";
        _carListFilterCondition.seriesName  = @"不限";
        _carListFilterCondition.seriesID    = @"";
        _carListFilterCondition.modelName   = @"不限";
        _carListFilterCondition.priceName   = @"不限";
        _carListFilterCondition.carTypeName = @"不限";
        _carListFilterCondition.yearName    = @"不限";
        _carListFilterCondition.ccName      = @"不限";
        _carListFilterCondition.mileageName = @"不限";
        _carListFilterCondition.gearboxName = @"不限";
        _carListFilterCondition.colorName   = @"不限";
        _carListFilterCondition.storeName   = @"不限";
        
        _carEvaluateFilterCondition = [[YCCarFilterConditionEntity alloc] init];
    }
    return self;
}

@end
