//
//  YCBrandTableViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/29.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCCarFilterDelegate.h"

@interface YCBrandTableViewController : UITableViewController

@property (weak, nonatomic) id<YCCarFilterDelegate> delegate;

@end
