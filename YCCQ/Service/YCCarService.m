//
//  YCCarService.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/19.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCarService.h"
#import "YCBaoKuanEntity.h"

@implementation YCCarService

- (YCBaoKuanEntity *)baoKuanCarAtIndex:(NSInteger)index
{
    YCBaoKuanEntity *bk = [[YCBaoKuanEntity alloc] init];
    bk.imageName = @"Banner2";
    bk.series = @"奔驰 C 级";
    bk.price = @"100000";
    
    return bk;
}

@end
