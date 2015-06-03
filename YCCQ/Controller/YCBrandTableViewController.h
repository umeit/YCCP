//
//  YCBrandTableViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/29.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCCarFilterDelegate.h"
#import "YCCarFilterEnum.h"

//typedef NS_ENUM(NSUInteger, BrandDataType) {
//    BrandType,
//    SeriesType,
//    ModelType,
//};

@class YCCarService;

@interface YCBrandTableViewController : UITableViewController

@property (weak, nonatomic) id<YCCarFilterDelegate> delegate;

@property (nonatomic) BOOL useOnlineData;

@property (nonatomic) CarFilterType dataType;

@property (nonatomic) NSInteger pid;

@property (strong, nonatomic) YCCarService *carService;

@end
