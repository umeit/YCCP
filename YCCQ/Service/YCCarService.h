//
//  YCCarService.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/19.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YCBaoKuanEntity;

typedef void (^BaokuanBlock) (NSArray *baokuans);

@interface YCCarService : NSObject

- (void)baokuanWithBlock:(BaokuanBlock)block;

@end
