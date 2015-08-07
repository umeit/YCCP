//
//  YCFunctionEntity.h
//  YCCQ
//
//  Created by Liu Feng on 15/8/7.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCFunctionEntity : NSObject

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSString *labelText;

- (instancetype)initWithImageName:(NSString *)imageName labelText:(NSString *)labelText;

@end
