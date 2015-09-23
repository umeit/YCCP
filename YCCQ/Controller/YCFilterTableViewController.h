//
//  YCFilterTableViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/6/3.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCCarFilterEnum.h"
#import "YCFilterConditionTypeEnum.h"

@interface YCFilterTableViewController : UITableViewController

@property (nonatomic) CarFilterType dataType;

@property (nonatomic) FilterConditionTypeEnum conditionType;

@end
