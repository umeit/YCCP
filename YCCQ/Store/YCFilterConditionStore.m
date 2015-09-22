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
        _filterCondition = [[YCCarFilterConditionEntity alloc] init];
        _filterCondition.brandName   = @"不限";
        _filterCondition.seriesName  = @"不限";
        _filterCondition.modelName   = @"不限";
        _filterCondition.priceName   = @"不限";
        _filterCondition.carTypeName = @"不限";
        _filterCondition.yearName    = @"不限";
        _filterCondition.ccName      = @"不限";
        _filterCondition.mileageName = @"不限";
        _filterCondition.gearboxName = @"不限";
        _filterCondition.colorName   = @"不限";
        _filterCondition.storeName   = @"不限";
        _filterCondition.pID = @"";
    }
    return self;
}

@end
