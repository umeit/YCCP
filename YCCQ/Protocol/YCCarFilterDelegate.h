//
//  YCCarFilterProtocol.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/29.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YCCarFilterDelegate <NSObject>

- (void)selecteConditionFinish:(NSDictionary *)condition;

@end
