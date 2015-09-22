//
//  YCFilterCellDataEntity.m
//  YCCQ
//
//  Created by Liu Feng on 15/9/18.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCFilterCellDataEntity.h"

@implementation YCFilterCellDataEntity

- (instancetype)initWithTitile:(NSString *)title detail:(NSString *)detail filteType:(CarFilterType)filteType
{
    if (self = [super init]) {
        _title = title;
        _detail = detail;
        _filteType = filteType;
    }
    return self;
}

@end
