//
//  YCFilterTableViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/6/3.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCCarFilterDelegate.h"
#import "YCCarFilterEnum.h"

//typedef NS_ENUM(NSUInteger, FilterDataType) {
//    PriceType,
//    CarTypeType,
//};

@interface YCFilterTableViewController : UITableViewController

@property (weak, nonatomic) id<YCCarFilterDelegate> delegate;

@property (nonatomic) CarFilterType dataType;

@end
