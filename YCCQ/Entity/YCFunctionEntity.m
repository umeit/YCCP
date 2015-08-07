//
//  YCFunctionEntity.m
//  YCCQ
//
//  Created by Liu Feng on 15/8/7.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCFunctionEntity.h"

@implementation YCFunctionEntity

- (instancetype)initWithImageName:(NSString *)imageName labelText:(NSString *)labelText
{
    if (self = [super init]) {
        _imageName = imageName;
        _labelText = labelText;
    }
    return self;
}

@end
