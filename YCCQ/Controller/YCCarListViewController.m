//
//  YCCarListViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCarListViewController.h"
#import "YCWebViewController.h"
#import "UIViewController+GViewController.h"

@interface YCCarListViewController ()

@property (nonatomic) NSMutableDictionary *orderButtonStatus;

@end

@implementation YCCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.carListWebView.delegate = self;
    
    if (!self.carListURL) {
        self.carListURL = [self defaultURL];
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.carListWebView loadRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:
       [self.carListURL stringByAppendingString:@"?t=app"]]]];
    
    self.carListWebView.scrollView.contentInset = UIEdgeInsetsMake(47, 0, 0, 0);
    
    self.orderButtonStatus = [NSMutableDictionary dictionaryWithDictionary:@{@"price": @NO, @"mileage": @NO}];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.navigationController) {
        CGRect frame = self.carListWebView.frame;
        self.carListWebView.frame = CGRectMake(0,
                                               frame.origin.y + 22,
                                               frame.size.width,
                                               frame.size.height - 22);
    }
}


#pragma mark - Action

- (IBAction)defaultButtonPress:(id)sender
{
    [self.carListWebView loadRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:
       [self.carListURL stringByAppendingString:@"?t=app"]]]];
}

- (IBAction)priceButtonPress:(UIButton *)button
{
    if ([self.orderButtonStatus[@"price"] boolValue]) {
        self.orderButtonStatus[@"price"] = @NO;
        
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"/o1?t=app"]]]];
    } else {
        self.orderButtonStatus[@"price"] = @YES;
        
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"/o2?t=app"]]]];
    }
}

- (IBAction)mileageButtonPress:(id)sender
{
    if ([self.orderButtonStatus[@"mileage"] boolValue]) {
        self.orderButtonStatus[@"mileage"] = @NO;
        
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"/o5?t=app"]]]];
    } else {
        self.orderButtonStatus[@"mileage"] = @YES;
        
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"/o6?t=app"]]]];
    }
}


#pragma mark - UIWebViewDelegate

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
        // 前往详情页
        if ([dicArg[@"f"] isEqualToString:@"toDetail"]) {
             YCWebViewController *webVC = [self controllerWithStoryBoardID:@"YCWebViewController"];
            webVC.webPageURL = dicArg[@"args"][0];
            webVC.navigationItem.title = @"车辆详情";
            [self.navigationController pushViewController:webVC animated:YES];
        }
        // 弹出输入手机号码
        else if ([dicArg[@"f"] isEqualToString:@"inputPhoneNum"]) {
             [self showTextFieldAlertWithTitle:@"收藏车辆" message:@"请输入您的手机号码" block:^(NSString *text) {
                 
                 if (![self isValidPhoneNum:text]) {
                     [self showCustomTextAlert:@"请正确输入号码"];
                     return;
                 }
                 
                 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                 [userDefaults setObject:text forKey:@"UserPhoneNum"];
                 
                 [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"callbackUserMobile('%@')", text?:@""]];
             }];
        }
        // 页面获取手机号
        else if ([dicArg[@"f"] isEqualToString:@"getPhoneNum"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userPhoneNum = [userDefaults stringForKey:@"UserPhoneNum"];
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"callbackUserMobile('%@')", userPhoneNum?:@""]];
        }
        
        return NO;
    }
    return YES;
}


#pragma mark - Car Filter Delegate

- (void)conditionDidFinish:(NSString *)urlFuffix
{
    self.carListURL = [NSString stringWithFormat:@"http://m.youche.com/%@", urlFuffix];
    [self.carListWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"?t=app"]]]];
}


#pragma mark - Privatre

- (BOOL)isValidPhoneNum:(NSString *)phoneNum
{
    return phoneNum.length == 11;
}

- (NSString *)defaultURL
{
    return @"http://m.youche.com/ershouche";
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
    if ([vc respondsToSelector:@selector(setDelegate:)]) {
        [vc performSelector:@selector(setDelegate:) withObject:self];
    }
}


@end
