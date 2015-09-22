//
//  YCFilterService.h
//  YCCQ
//
//  Created by Liu Feng on 15/9/22.
//  Copyright © 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCCarFilterConditionEntity;

@interface YCFilterService : NSObject

+ (YCCarFilterConditionEntity *)currentFilterCondition;

+ (void)saveCondition:(YCCarFilterConditionEntity *)condition;

@end
