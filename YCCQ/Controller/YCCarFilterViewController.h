//
//  YCCarFilterViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/29.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YCCarFilterViewController <NSObject>

- (void)conditionDidFinish;

@end

@interface YCCarFilterViewController : UITableViewController

@property (weak, nonatomic) id<YCCarFilterViewController> delegate;

@end

