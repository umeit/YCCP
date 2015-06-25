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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)okButtonPress:(id)sender {
    YCLimitDriveInfoViewController *vc = [self controllerWithStoryBoardID:@"YCLimitDriveInfoViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
