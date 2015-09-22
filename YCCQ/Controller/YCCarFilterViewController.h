//
//  YCCarFilterViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/29.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCCarFilterConditionEntity.h"

@protocol YCCarFilterDelegate <NSObject>
- (void)conditionDidFinish:(NSString *)urlFuffix;
@end

@interface YCCarFilterViewController : UITableViewController
//@property (strong, nonatomic) YCCarFilterConditionEntity *filterCondition;

@property (weak, nonatomic) id<YCCarFilterDelegate> delegate;

@end

