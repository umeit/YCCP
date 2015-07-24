//
//  YCCouponViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/7/24.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCouponViewController.h"
#import "UtilDefine.h"
#import "YCUserService.h"
#import "UIViewController+GViewController.h"

@interface YCCouponViewController ()

@property (strong, nonatomic) UIWebView *callWebView;

@end

@implementation YCCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.callWebView = [[UIWebView alloc] init];
    [self.view addSubview:self.callWebView];
}



#pragma mark - Action

/** 打电话 */
- (IBAction)phtonButtonPress:(id)sender {
    [self call:MainPhoneNum];
}

/** 点击领取 */
- (IBAction)getButtonPress:(id)sender {
    [self showLodingView];
    
    [YCUserService sendCouponMessageToUserPhone:self.phoneNumField.text
                                      withBlock:^(BOOL success, NSString *msg) {
                                          [self hideLodingView];
                                          
                                          if (success) {
                                              [self showCustomTextAlert:@"优惠劵已用短信发送到您的手机，请注意查收。"];
                                          }
                                          else {
                                              [self showCustomTextAlert:msg];
                                          }
                                      }];
}

- (void)call:(NSString *)tel
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", tel];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
}

@end
