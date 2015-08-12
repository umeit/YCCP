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
#import "UtilDefine.h"

@interface YCWebViewController ()
@property (strong, nonatomic) UIWebView *callWebView;
@end

@implementation YCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem
    = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dianhua"]
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(phoneButtonPress:)];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style: UIBarButtonItemStylePlain target:nil action:nil];
    
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webPageURL]]];
    
    
//    self.webView.scrollView.contentInset = UIEdgeInsetsMake(66, 0, 0, 0);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.showBottomBar) {
         self.bottomBarBackgroundView.hidden = NO;
//        self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, self.bottomBarBackgroundView.frame.size.height, 0);
    }
    else {
        self.bottomBarBackgroundView.hidden = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.callWebView removeFromSuperview];
    self.callWebView = nil;
    
    [super viewWillDisappear:animated];
}

#pragma mark - Action
- (void)phoneButtonPress:(id)sender
{
    [self call:MainPhoneNum];
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
        // 页面请求手机号，与显示用户收藏的车辆
        else if ([dicArg[@"f"] isEqualToString:@"getPhoneNum"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userPhoneNum = [userDefaults stringForKey:@"UserPhoneNum"];
            if (userPhoneNum.length) {
                [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@')", jsFunctionName, userPhoneNum?:@""]];
            }
        }
        // 弹出输入手机号码
        else if ([dicArg[@"f"] isEqualToString:@"inputPhoneNum"]) {
            NSString *carID = dicArg[@"args"][0];
            [self showTextFieldAlertWithTitle:@"收藏车辆" message:@"请输入您的手机号码" block:^(NSString *text) {
                
                if (![YCUserUtil isValidPhoneNum:text]) {
                    [self showCustomTextAlert:@"请正确输入号码"];
                    return;
                }
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:text forKey:@"UserPhoneNum"];
                
                [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@','%@')", jsFunctionName, text?:@"", carID?:@""]];
            }];
        }
        return NO;
    }
    return YES;
}

#pragma mark - Private

- (void)call:(NSString *)tel
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", tel];
    self.callWebView = [[UIWebView alloc] init];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:self.callWebView];
}

@end
