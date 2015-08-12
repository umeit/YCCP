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
#import "YCUserUtil.h"
#import "UtilDefine.h"

@interface YCCarListViewController ()

@property (nonatomic) NSMutableDictionary *orderButtonStatus;

@property (strong, nonatomic) UIWebView *callWebView;

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
    
    self.carListWebView.scrollView.contentInset = UIEdgeInsetsMake(28, 0, 0, 0);
    
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

- (void)viewWillDisappear:(BOOL)animated
{
    [self.callWebView removeFromSuperview];
    self.callWebView = nil;
    [super viewWillDisappear:animated];
}


#pragma mark - Action
- (IBAction)phoneButtonPress:(id)sender
{
    [self call:MainPhoneNum];
}

- (IBAction)defaultButtonPress:(id)sender
{
    [self arrowDefault:self.mileageArrowImageView];
    [self arrowDefault:self.priceArrowImageView];
    
    [self.carListWebView loadRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:
       [self.carListURL stringByAppendingString:@"?t=app"]]]];
}

- (IBAction)priceButtonPress:(UIButton *)button
{
    // 动画
    [self arrowDefault:self.mileageArrowImageView];
    
    // 如果当前列表为「占号用车」，则排序时按初始列表处理
    if ([self.carListURL.lastPathComponent isEqualToString:@"t32"]) {
        self.carListURL = @"http://m.youche.com/ershouche/";
    }
    
    if ([self.orderButtonStatus[@"price"] boolValue]) {
        self.orderButtonStatus[@"price"] = @NO;
        [self arrowUp:self.priceArrowImageView];
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"o1?t=app"]]]];
    } else {
        self.orderButtonStatus[@"price"] = @YES;
        [self arrowDown:self.priceArrowImageView];
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"o2?t=app"]]]];
    }
}

- (IBAction)mileageButtonPress:(id)sender
{
    // 动画
    [self arrowDefault:self.priceArrowImageView];
    
    // 如果当前列表为「占号用车」，则排序时按初始列表处理
    if ([self.carListURL.lastPathComponent isEqualToString:@"t32"]) {
        self.carListURL = @"http://m.youche.com/ershouche/";
    }
    
    if ([self.orderButtonStatus[@"mileage"] boolValue]) {
        self.orderButtonStatus[@"mileage"] = @NO;
        [self arrowUp:self.mileageArrowImageView];
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"o5?t=app"]]]];
    } else {
        self.orderButtonStatus[@"mileage"] = @YES;
        [self arrowDown:self.mileageArrowImageView];
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"o6?t=app"]]]];
    }
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    webView.hidden = YES;
    [self showLodingView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    webView.hidden = NO;
    [self hideLodingView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    webView.hidden = NO;
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
        // 前往详情页
        if ([dicArg[@"f"] isEqualToString:@"toDetail"]) {
             YCWebViewController *webVC = [self controllerWithStoryBoardID:@"YCWebViewController"];
            webVC.webPageURL = dicArg[@"args"][0];
            webVC.navigationItem.title = @"车辆详情";
            [self.navigationController pushViewController:webVC animated:YES];
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
        // 页面获取手机号
        else if ([dicArg[@"f"] isEqualToString:@"getPhoneNum"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userPhoneNum = [userDefaults stringForKey:@"UserPhoneNum"];
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@')", jsFunctionName, userPhoneNum?:@""]];
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

- (void)call:(NSString *)tel
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", tel];
    self.callWebView = [[UIWebView alloc] init];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:self.callWebView];
}

- (NSString *)defaultURL
{
    return @"http://m.youche.com/ershouche/";
}

- (void)arrowUp:(UIImageView *)arrowImage
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation((M_PI / -2));
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         arrowImage.transform = endAngle;
                     }
                     completion:^(BOOL finished) {
                         arrowImage.transform = endAngle;
                     }];
}

- (void)arrowDown:(UIImageView *)arrowImage
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation((M_PI / 2));
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         arrowImage.transform = endAngle;
                     }
                     completion:^(BOOL finished) {
                         arrowImage.transform = endAngle;
                     }];
}

- (void)arrowDefault:(UIImageView *)arrowImage
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(0);
    
    [UIView animateWithDuration:0.35
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         arrowImage.transform = endAngle;
                     }
                     completion:^(BOOL finished) {
                         arrowImage.transform = endAngle;
                     }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
    if ([vc respondsToSelector:@selector(setDelegate:)]) {
        [vc performSelector:@selector(setDelegate:) withObject:self];
    }
}


@end
