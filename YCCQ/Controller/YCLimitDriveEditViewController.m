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
    YCLimitDriveInfoViewController *vc = [self controllerWithStoryBoardID:@"YCLimitDriveInfoViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)setOKButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height + 40);
    button.backgroundColor = [UIColor redColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tableView setTableFooterView:button];
    [button addTarget:self action:@selector(okButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}
@end
