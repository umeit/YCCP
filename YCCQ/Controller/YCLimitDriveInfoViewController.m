//
//  YCLimitDriveInfoViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/25.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCLimitDriveInfoViewController.h"
#import "YCDriveService.h"

@interface YCLimitDriveInfoViewController ()

@end

@implementation YCLimitDriveInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.driveService = [[YCDriveService alloc] init];
    
    self.licensePlateNumLabel.text = self.licensePlateNum ? : @"没有填写车牌号";
    
    [self.driveService limitDriveInfo:^(NSDictionary *limitDriveInfo) {
        NSArray *limitNum = limitDriveInfo[@"LimitNum"];
        NSString *limitIntro = limitDriveInfo[@"LimitIntro"];
        
        self.limitIntroLabel.text = limitIntro;
        
        self.mon1numLabel.text = limitNum[0][0];
        self.mon2numLabel.text = limitNum[0][1];
        
        self.tues1NumLabel.text = limitNum[1][0];
        self.tues2NumLabel.text = limitNum[1][1];
        
        self.wed1NumLabel.text = limitNum[2][0];
        self.wed2NumLabel.text = limitNum[2][1];
        
        self.thurs1NumLabel.text = limitNum[3][0];
        self.thurs2NumLabel.text = limitNum[3][1];
        
        self.fri1NumLabel.text = limitNum[4][0];
        self.fri2NumLabel.text = limitNum[4][1];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
