//
//  YCFilterCellDataEntity.h
//  YCCQ
//
//  Created by Liu Feng on 15/9/18.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YCCarFilterEnum.h"

@interface YCFilterCellDataEntity : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *detail;

@property (nonatomic) CarFilterType filteType;

@end
