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

@class YCCarService;

@interface YCBrandTableViewController : UITableViewController<YCCarFilterConditionDelegate>

@property (weak, nonatomic) id<YCCarFilterConditionDelegate> delegate;

@property (nonatomic) BOOL useOnlineData;

@property (nonatomic) BOOL continuousMode;

@property (nonatomic) CarFilterType dataType;

@property (nonatomic) NSInteger pid;

@property (strong, nonatomic) YCCarService *carService;

@end
