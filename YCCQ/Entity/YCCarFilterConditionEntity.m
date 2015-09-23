//
//  YCCarFilterConditionEntity.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/29.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCarFilterConditionEntity.h"

@implementation YCCarFilterConditionEntity

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _brandName = [aDecoder decodeObjectForKey:@"_brandName"];
        _brandValue = [aDecoder decodeObjectForKey:@"_brandValue"];
        _brandID = [aDecoder decodeObjectForKey:@"_brandID"];
        _seriesName = [aDecoder decodeObjectForKey:@"_seriesName"];
        _seriesValue = [aDecoder decodeObjectForKey:@"_seriesValue"];
        _seriesID = [aDecoder decodeObjectForKey:@"_seriesID"];
        _modelName = [aDecoder decodeObjectForKey:@"_modelName"];
        _modelValue = [aDecoder decodeObjectForKey:@"_modelValue"];
        _priceName = [aDecoder decodeObjectForKey:@"_priceName"];
        _priceValue = [aDecoder decodeObjectForKey:@"_priceValue"];
        _carTypeName = [aDecoder decodeObjectForKey:@"_carTypeName"];
        _carTypeValue = [aDecoder decodeObjectForKey:@"_carTypeValue"];
        _mileageName = [aDecoder decodeObjectForKey:@"_mileageName"];
        _mileageValue = [aDecoder decodeObjectForKey:@"_mileageValue"];
        _gearboxName = [aDecoder decodeObjectForKey:@"_gearboxName"];
        _gearboxValue = [aDecoder decodeObjectForKey:@"_gearboxValue"];
        _colorName = [aDecoder decodeObjectForKey:@"_colorName"];
        _colorValue = [aDecoder decodeObjectForKey:@"_colorValue"];
        _yearName = [aDecoder decodeObjectForKey:@"_yearName"];
        _yearValue = [aDecoder decodeObjectForKey:@"_yearValue"];
        _yearNumName = [aDecoder decodeObjectForKey:@"_yearNumName"];
        _yearNumValue = [aDecoder decodeObjectForKey:@"_yearNumValue"];
        _monthName = [aDecoder decodeObjectForKey:@"_monthName"];
        _monthValue = [aDecoder decodeObjectForKey:@"_monthValue"];
        _ccName = [aDecoder decodeObjectForKey:@"_ccName"];
        _ccName = [aDecoder decodeObjectForKey:@"_ccName"];
        _storeName = [aDecoder decodeObjectForKey:@"_storeName"];
        _storeValue = [aDecoder decodeObjectForKey:@"_storeValue"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_brandName forKey:@"_brandName"];
    [aCoder encodeObject:_brandValue forKey:@"_brandValue"];
    [aCoder encodeObject:_brandID forKey:@"_brandID"];
    [aCoder encodeObject:_seriesName forKey:@"_seriesName"];
    [aCoder encodeObject:_seriesValue forKey:@"_seriesValue"];
    [aCoder encodeObject:_seriesID forKey:@"_seriesID"];
    [aCoder encodeObject:_modelName forKey:@"_modelName"];
    [aCoder encodeObject:_modelValue forKey:@"_modelValue"];
    [aCoder encodeObject:_priceName forKey:@"_priceName"];
    [aCoder encodeObject:_priceValue forKey:@"_priceValue"];
    [aCoder encodeObject:_carTypeName forKey:@"_carTypeName"];
    [aCoder encodeObject:_carTypeValue forKey:@"_carTypeValue"];
    [aCoder encodeObject:_mileageName forKey:@"_mileageName"];
    [aCoder encodeObject:_mileageValue forKey:@"_mileageValue"];
    [aCoder encodeObject:_gearboxName forKey:@"_gearboxName"];
    [aCoder encodeObject:_gearboxValue forKey:@"_gearboxValue"];
    [aCoder encodeObject:_colorName forKey:@"_colorName"];
    [aCoder encodeObject:_colorValue forKey:@"_colorValue"];
    [aCoder encodeObject:_yearName forKey:@"_yearName"];
    [aCoder encodeObject:_yearValue forKey:@"_yearValue"];
    [aCoder encodeObject:_yearNumName forKey:@"_yearNumName"];
    [aCoder encodeObject:_yearNumValue forKey:@"_yearNumValue"];
    [aCoder encodeObject:_monthName forKey:@"_monthName"];
    [aCoder encodeObject:_monthValue forKey:@"_monthValue"];
    [aCoder encodeObject:_ccName forKey:@"_ccName"];
    [aCoder encodeObject:_ccValue forKey:@"_ccValue"];
    [aCoder encodeObject:_storeName forKey:@"_storeName"];
    [aCoder encodeObject:_storeValue forKey:@"_storeValue"];
}

@end
