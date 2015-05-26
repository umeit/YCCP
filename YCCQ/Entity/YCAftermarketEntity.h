//
//  YCAftermarketEntity.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/26.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCAftermarketEntity : NSObject

@property (strong, nonatomic) NSString *name;

@property (strong, nonatomic) NSString *tel;

@property (strong, nonatomic) NSString *imageName;

- (instancetype)initWithName:(NSString *)name tel:(NSString *)tel image:(NSString *)imageName;

@end
