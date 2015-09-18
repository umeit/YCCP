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
        _brandName = [aDecoder decodeObjectForKey:@""];
        _brandValue = [aDecoder decodeObjectForKey:@""];
        _seriesName = [aDecoder decodeObjectForKey:@""];
        _seriesValue = [aDecoder decodeObjectForKey:@""];
        _modelName = [aDecoder decodeObjectForKey:@""];
        _modelValue = [aDecoder decodeObjectForKey:@""];
        _priceName = [aDecoder decodeObjectForKey:@""];
        _priceValue = [aDecoder decodeObjectForKey:@""];
        _carTypeName = [aDecoder decodeObjectForKey:@""];
        _carTypeValue = [aDecoder decodeObjectForKey:@""];
        _mileageName = [aDecoder decodeObjectForKey:@""];
        _mileageValue = [aDecoder decodeObjectForKey:@""];
        _gearboxName = [aDecoder decodeObjectForKey:@""];
        _gearboxValue = [aDecoder decodeObjectForKey:@""];
        _colorName = [aDecoder decodeObjectForKey:@""];
        _colorValue = [aDecoder decodeObjectForKey:@""];
        _yearName = [aDecoder decodeObjectForKey:@""];
        _yearValue = [aDecoder decodeObjectForKey:@""];
        _ccName = [aDecoder decodeObjectForKey:@""];
        _ccName = [aDecoder decodeObjectForKey:@""];
        _storeName = [aDecoder decodeObjectForKey:@""];
        _storeValue = [aDecoder decodeObjectForKey:@""];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_brandName forKey:@""];
    [aCoder encodeObject:_brandValue forKey:@""];
    [aCoder encodeObject:_seriesName forKey:@""];
    [aCoder encodeObject:_seriesValue forKey:@""];
    [aCoder encodeObject:_modelName forKey:@""];
    [aCoder encodeObject:_modelValue forKey:@""];
    [aCoder encodeObject:_priceName forKey:@""];
    [aCoder encodeObject:_priceValue forKey:@""];
    [aCoder encodeObject:_carTypeName forKey:@""];
    [aCoder encodeObject:_carTypeValue forKey:@""];
    [aCoder encodeObject:_mileageName forKey:@""];
    [aCoder encodeObject:_mileageValue forKey:@""];
    [aCoder encodeObject:_gearboxName forKey:@""];
    [aCoder encodeObject:_gearboxValue forKey:@""];
    [aCoder encodeObject:_colorName forKey:@""];
    [aCoder encodeObject:_colorValue forKey:@""];
    [aCoder encodeObject:_yearName forKey:@""];
    [aCoder encodeObject:_yearValue forKey:@""];
    [aCoder encodeObject:_ccName forKey:@""];
    [aCoder encodeObject:_ccValue forKey:@""];
    [aCoder encodeObject:_storeName forKey:@""];
    [aCoder encodeObject:_storeValue forKey:@""];
}

@end
