//
//  YCCarListViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCarListViewController.h"

@interface YCCarListViewController ()

@end

@implementation YCCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.carListWebView loadRequest:
    [NSURLRequest requestWithURL:self.carListURL]];
    
    self.carListWebView.scrollView.contentInset = UIEdgeInsetsMake(47, 0, 0, 0);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
