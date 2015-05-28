//
//  YCCarListViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCCarListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *carListWebView;

@property (strong, nonatomic) NSURL *carListURL;

@end
