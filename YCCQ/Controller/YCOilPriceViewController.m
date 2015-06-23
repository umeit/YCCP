//
//  YCOilPriceViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/23.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCOilPriceViewController.h"
#import "YCDriveService.h"

@interface YCOilPriceViewController ()

@end

@implementation YCOilPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.driveService = [[YCDriveService alloc] init];
    
    [self.driveService oilPrice:^(NSDictionary *oilPrice) {
        self.num0PriceLabel.text = [NSString stringWithFormat:@"%@（元/升）", oilPrice[@"0"]];
        self.num90PriceLabel.text = [NSString stringWithFormat:@"%@（元/升）", oilPrice[@"90"]];
        self.num93PriceLabel.text = [NSString stringWithFormat:@"%@（元/升）", oilPrice[@"93"]];
        self.num97PriceLabel.text = [NSString stringWithFormat:@"%@（元/升）", oilPrice[@"97"]];
    }];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    self.dateLabel.text = [NSString stringWithFormat:@"更新时间:%@", [formatter stringFromDate:[NSDate date]]];
    
}

@end
