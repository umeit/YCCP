//
//  YCLimitDriveInfoViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/6/25.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCDriveService;

@interface YCLimitDriveInfoViewController : UIViewController

@property (strong, nonatomic) YCDriveService *driveService;

@property (strong, nonatomic) NSString *licensePlateNum;

@property (weak, nonatomic) IBOutlet UILabel *licensePlateNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *limitIntroLabel;

@property (weak, nonatomic) IBOutlet UILabel *mon1numLabel;

@property (weak, nonatomic) IBOutlet UILabel *mon2numLabel;

@property (weak, nonatomic) IBOutlet UILabel *tues1NumLabel;

@property (weak, nonatomic) IBOutlet UILabel *tues2NumLabel;

@property (weak, nonatomic) IBOutlet UILabel *wed1NumLabel;

@property (weak, nonatomic) IBOutlet UILabel *wed2NumLabel;

@property (weak, nonatomic) IBOutlet UILabel *thurs1NumLabel;

@property (weak, nonatomic) IBOutlet UILabel *thurs2NumLabel;

@property (weak, nonatomic) IBOutlet UILabel *fri1NumLabel;

@property (weak, nonatomic) IBOutlet UILabel *fri2NumLabel;

@end
