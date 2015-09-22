//
//  YCFilterService.m
//  YCCQ
//
//  Created by Liu Feng on 15/9/22.
//  Copyright © 2015年 Baisika. All rights reserved.
//

#import "YCFilterService.h"
#import "YCCarFilterConditionEntity.h"

@implementation YCFilterService

+ (YCCarFilterConditionEntity *)currentFilterCondition
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:@"YCCarFilterConditionEntity"];
    
    if (!data) {
        YCCarFilterConditionEntity *filterCondition = [[YCCarFilterConditionEntity alloc] init];
        filterCondition.brandName   = @"不限";
        filterCondition.seriesName  = @"不限";
        filterCondition.modelName   = @"不限";
        filterCondition.priceName   = @"不限";
        filterCondition.carTypeName = @"不限";
        filterCondition.yearName    = @"不限";
        filterCondition.ccName      = @"不限";
        filterCondition.mileageName = @"不限";
        filterCondition.gearboxName = @"不限";
        filterCondition.colorName   = @"不限";
        filterCondition.storeName   = @"不限";
        filterCondition.pID = @"";
        
        data = [NSKeyedArchiver archivedDataWithRootObject:filterCondition];
        [userDefaults setObject:data forKey:@"YCCarFilterConditionEntity"];
        return filterCondition;
    }
    else {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
}

+ (void)saveCondition:(YCCarFilterConditionEntity *)condition
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:condition];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"YCCarFilterConditionEntity"];
}

@end
