//
//  YCFilterConditionStore.h
//  YCCQ
//
//  Created by Liu Feng on 15/9/22.
//  Copyright © 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YCCarFilterConditionEntity;

@interface YCFilterConditionStore : NSObject

@property (nonatomic, strong) YCCarFilterConditionEntity *filterCondition;

+ (instancetype)sharedInstance;

@end
