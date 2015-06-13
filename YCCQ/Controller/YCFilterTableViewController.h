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

@interface YCFilterTableViewController : UITableViewController <YCCarFilterConditionDelegate>

@property (weak, nonatomic) id<YCCarFilterConditionDelegate> delegate;

@property (nonatomic) CarFilterType dataType;

@end
