//
//  YCCarListViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCarListViewController.h"

@interface YCCarListViewController ()

@property (nonatomic) NSMutableDictionary *orderButtonStatus;

@end

@implementation YCCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.carListURL) {
        self.carListURL = [NSURL URLWithString:@"http://m.youche.com/ershouche/"];
    }
    
    [self.carListWebView loadRequest:[NSURLRequest requestWithURL:self.carListURL]];
    
    self.carListWebView.scrollView.contentInset = UIEdgeInsetsMake(47, 0, 0, 0);
    
    self.orderButtonStatus = [NSMutableDictionary dictionaryWithDictionary:@{@"price": @NO, @"mileage": @NO}];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.navigationController) {
        CGRect frame = self.carListWebView.frame;
        self.carListWebView.frame = CGRectMake(0, frame.origin.y + 22, frame.size.width, frame.size.height - 22);
    }
}

#pragma mark - Action

- (IBAction)defaultButtonPress:(id)sender
{
    [self.carListWebView loadRequest:[NSURLRequest requestWithURL:self.carListURL]];
}
- (IBAction)priceButtonPress:(UIButton *)button
{
    if ([self.orderButtonStatus[@"price"] boolValue]) {
        self.orderButtonStatus[@"price"] = @NO;
        
        [self.carListWebView loadRequest:
         [NSURLRequest requestWithURL:[self.carListURL URLByAppendingPathComponent:@"o1"]]];
    } else {
        self.orderButtonStatus[@"price"] = @YES;
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[self.carListURL URLByAppendingPathComponent:@"o2"]]];
    }
}

- (IBAction)mileageButtonPress:(id)sender
{
    if ([self.orderButtonStatus[@"mileage"] boolValue]) {
        self.orderButtonStatus[@"mileage"] = @NO;
        
        [self.carListWebView loadRequest:
         [NSURLRequest requestWithURL:[self.carListURL URLByAppendingPathComponent:@"o5"]]];
    } else {
        self.orderButtonStatus[@"mileage"] = @YES;
        [self.carListWebView loadRequest:
         [NSURLRequest requestWithURL:[self.carListURL URLByAppendingPathComponent:@"o6"]]];
    }
}


#pragma mark - Privatre

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
