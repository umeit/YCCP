//
//  YCWebViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/25.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCWebViewController.h"
#import "UIViewController+GViewController.h"
#import "YCUserUtil.h"

@interface YCWebViewController ()

@end

@implementation YCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webPageURL]]];
}

#pragma mark - Web view delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showLodingView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideLodingView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideLodingView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL * url = [request URL];
    if ([[url scheme] isEqualToString:@"youcheapp"]) {
        
        NSString *command = [[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *jsonArg = [command substringFromIndex:@"youcheapp:///".length];
        
        NSError *error;
        NSDictionary *dicArg = [NSJSONSerialization JSONObjectWithData:[jsonArg dataUsingEncoding:NSUTF8StringEncoding]
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
        NSString *jsFunctionName = dicArg[@"calls"];
        
        if ([dicArg[@"f"] isEqualToString:@"toCheckInfo"]) {
            YCWebViewController *webVC = [self controllerWithStoryBoardID:@"YCWebViewController"];
            webVC.webPageURL = dicArg[@"args"][0];
            webVC.navigationItem.title = @"车辆信息";
            [self.navigationController pushViewController:webVC animated:YES];
        }
        else if ([dicArg[@"f"] isEqualToString:@"getPhoneNum"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userPhoneNum = [userDefaults stringForKey:@"UserPhoneNum"];
            if (userPhoneNum.length) {
                [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@')", jsFunctionName, userPhoneNum?:@""]];
            }
            else {
                [self showTextFieldAlertWithTitle:@"收藏车辆" message:@"请输入您的手机号码" block:^(NSString *text) {
                    
                    if (![YCUserUtil isValidPhoneNum:text]) {
                        [self showCustomTextAlert:@"请正确输入号码"];
                        return;
                    }
                    
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:text forKey:@"UserPhoneNum"];
                    
                    [self.webView reload];
                    
//                    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@')", jsFunctionName, userPhoneNum?:@""]];
                }];
            }
        }
        return NO;
    }
    return YES;
}

@end
