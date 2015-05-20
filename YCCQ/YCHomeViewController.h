//
//  YCHomeViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/15.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCCarService;

@interface YCHomeViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIScrollView *bannerScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *bannerPageControl;

@property (strong, nonatomic) YCCarService *carService;
@end
