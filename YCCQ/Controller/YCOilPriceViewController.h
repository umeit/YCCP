//
//  YCOilPriceViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/6/23.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YCDriveService;

@interface YCOilPriceViewController : UITableViewController

@property (strong, nonatomic) YCDriveService *driveService;

@property (weak, nonatomic) IBOutlet UILabel *num90PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *num93PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *num97PriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *num0PriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end
