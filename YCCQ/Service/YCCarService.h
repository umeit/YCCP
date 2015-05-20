//
//  YCCarService.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/19.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YCBaoKuanEntity;

@interface YCCarService : NSObject

- (YCBaoKuanEntity *) baoKuanCarAtIndex:(NSInteger)index;

@end
