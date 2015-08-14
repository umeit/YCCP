//
//  YCCarListViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCCarFilterViewController.h"

@interface YCCarListViewController : UIViewController <UIWebViewDelegate, YCCarFilterDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *carListWebView;
@property (weak, nonatomic) IBOutlet UIImageView *mileageArrowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *priceArrowImageView;
@property (weak, nonatomic) IBOutlet UIView *topBarViewBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *sortButton;
@property (strong, nonatomic)  UIView *darkBackgroundView;
@property (strong, nonatomic) NSString *carListURL;
@end
