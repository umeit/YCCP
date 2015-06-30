//
//  YCLimitDriveViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/25.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCLimitDriveEditViewController.h"
#import "YCLimitDriveInfoViewController.h"
#import "UIViewController+GViewController.h"

@interface YCLimitDriveEditViewController ()

@end

@implementation YCLimitDriveEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setOKButton];
}

- (void)okButtonPress:(id)sender {
    [self pushViewControllerWithStoryBoardID:@"YCLimitDriveInfoViewController" title:@"限行详情"];
}


- (void)setOKButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"确 定" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height + 40);
    button.backgroundColor = [UIColor colorWithRed:0.96f green:0.29f blue:0.35f alpha:1];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tableView setTableFooterView:button];
    [button addTarget:self action:@selector(okButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}
@end
