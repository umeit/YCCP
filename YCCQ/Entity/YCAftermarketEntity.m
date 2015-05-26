//
//  YCAftermarketEntity.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/26.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCAftermarketEntity.h"

@implementation YCAftermarketEntity

- (instancetype)initWithName:(NSString *)name tel:(NSString *)tel image:(NSString *)imageName
{
    self = [super init];
    if (self) {
        _name = name;
        _tel = tel;
        _imageName = imageName;
    }
    return self;
}

@end
