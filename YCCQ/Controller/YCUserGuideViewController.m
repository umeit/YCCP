//
//  YCUserGuideViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/7/21.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCUserGuideViewController.h"
#import "UtilDefine.h"

@interface YCUserGuideViewController () <UIScrollViewDelegate>

@end

@implementation YCUserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageControl.numberOfPages = 5;
}

- (void)viewDidAppear:(BOOL)animated
{
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * 5,
                                             CGRectGetHeight(self.scrollView.frame));

    NSString *imageNmae1;
    NSString *imageNmae2;
    NSString *imageNmae3;
    NSString *imageNmae4;
    NSString *imageNmae5;
    
    if (iPhone4) {
        imageNmae1 = @"ug_640-960-1";
        imageNmae2 = @"ug_640-960-2";
        imageNmae3 = @"ug_640-960-3";
        imageNmae4 = @"ug_640-960-4";
        imageNmae5 = @"ug_640-960-5";
    } else if (iPhone5) {
        imageNmae1 = @"ug_640-1136-1";
        imageNmae2 = @"ug_640-1136-2";
        imageNmae3 = @"ug_640-1136-3";
        imageNmae4 = @"ug_640-1136-4";
        imageNmae5 = @"ug_640-1136-5";
    } else if (iPhone6) {
        imageNmae1 = @"ug_750-1334-1";
        imageNmae2 = @"ug_750-1334-2";
        imageNmae3 = @"ug_750-1334-3";
        imageNmae4 = @"ug_750-1334-4";
        imageNmae5 = @"ug_750-1334-5";
    } else if (iPhone6Plus || iPhone6Plus_Simulator) {
        imageNmae1 = @"ug_1242-2208-1";
        imageNmae2 = @"ug_1242-2208-2";
        imageNmae3 = @"ug_1242-2208-3";
        imageNmae4 = @"ug_1242-2208-4";
        imageNmae5 = @"ug_1242-2208-5";
    }
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNmae1]];
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNmae2]];
    UIImageView *imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNmae3]];
    UIImageView *imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNmae4]];
    UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNmae5]];
    
    
    imageView1.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame) * 0, 0,
                                  CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    imageView2.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame) * 1, 0,
                                  CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    imageView3.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame) * 2, 0,
                                  CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    imageView4.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame) * 3, 0,
                                  CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    imageView5.frame = CGRectMake(CGRectGetWidth(self.scrollView.frame) * 4, 0,
                                  CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    [self.scrollView addSubview:imageView1];
    [self.scrollView addSubview:imageView2];
    [self.scrollView addSubview:imageView3];
    [self.scrollView addSubview:imageView4];
    [self.scrollView addSubview:imageView5];
}


#pragma mark - Action

- (IBAction)buttonPress:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.view.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainTabBarController"];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.pageControl.currentPage = pageIndex;
    
    if (pageIndex == 4) {
        self.button.hidden = NO;
    } else {
        self.button.hidden = YES;
    }
    
}

@end
