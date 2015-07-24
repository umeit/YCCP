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
    
    // 显示电话号码（如果有）
    self.phoneNumField.text = [self userPhoneNum];
    
    // 没有填写过电话号码，弹出键盘
    if (!self.phoneNumField.text.length) {
        [self.phoneNumField becomeFirstResponder];
    }
    else {
        [self.getButton setTitle:@"重新领取" forState: UIControlStateNormal];
    }
}



#pragma mark - Action

/** 打电话 */
- (IBAction)phtonButtonPress:(id)sender {
    [self call:MainPhoneNum];
}

/** 点击领取 */
- (IBAction)getButtonPress:(id)sender {
    if (![self availablePhoneNum:self.phoneNumField.text]) {
        [self showCustomText:@"请输入正确的手机号码" delay:2];
        return;
    }
    
    [self showLodingView];
    
    [YCUserService sendCouponMessageToUserPhone:self.phoneNumField.text
                                      withBlock:^(BOOL success, NSString *msg) {
                                          [self hideLodingView];
                                          
                                          if (success) {
                                              [self saveUserPhoneNum:self.phoneNumField.text];
                                              [self showCustomTextAlert:@"亲，优惠劵已用短信发送到您的手机，请注意查收。"];
                                          }
                                          else {
                                              [self showCustomTextAlert:msg];
                                          }
                                      }];
}

- (void)call:(NSString *)tel {
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", tel];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
}


#pragma mark - Private
- (void)saveUserPhoneNum:(NSString *)phoneNum {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:phoneNum forKey:UserCouponPhoneNum];
}

- (NSString *)userPhoneNum {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults stringForKey:UserCouponPhoneNum];
}

- (BOOL)availablePhoneNum:(NSString *)phoneNum {
    if (phoneNum.length == 11) {
        return YES;
    }
    
    return NO;
}
@end
