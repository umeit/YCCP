//
//  YCCarListViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCarListViewController.h"
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
    
    [self.carListWebView loadRequest:[NSURLRequest requestWithURL:self.carListURL]];
    
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
    [self.carListWebView loadRequest:[NSURLRequest requestWithURL:self.carListURL]];
}

- (IBAction)priceButtonPress:(UIButton *)button
{
    NSMutableString *path = [NSMutableString stringWithString:self.carListURL.absoluteString];
    
    if ([self.orderButtonStatus[@"price"] boolValue]) {
        self.orderButtonStatus[@"price"] = @NO;
        
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[path stringByAppendingString:@"o1?t=app"]]]];
    } else {
        self.orderButtonStatus[@"price"] = @YES;
        
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[path stringByAppendingString:@"o2?t=app"]]]];
    }
}

- (IBAction)mileageButtonPress:(id)sender
{
    NSMutableString *path = [NSMutableString stringWithString:self.carListURL.absoluteString];
    
    if ([self.orderButtonStatus[@"mileage"] boolValue]) {
        self.orderButtonStatus[@"mileage"] = @NO;
        
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[path stringByAppendingString:@"o5?t=app"]]]];
    } else {
        self.orderButtonStatus[@"mileage"] = @YES;
        
        [self.carListWebView loadRequest:
        [NSURLRequest requestWithURL:[NSURL URLWithString:[path stringByAppendingString:@"o6?t=app"]]]];
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
    if ([[url scheme] isEqualToString:@"gap"]) {
        // 在这里做js调native的事情
        // ....
        // 做完之后用如下方法调回js
        [webView stringByEvaluatingJavaScriptFromString:@"alert('done')"];
        return NO;
    }
    return YES;
}


#pragma mark - Car Filter Delegate

- (void)conditionDidFinish:(NSString *)urlFuffix
{
    self.carListURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.youche.com/%@", urlFuffix]];
    [self.carListWebView loadRequest:[NSURLRequest requestWithURL:self.carListURL]];
}


#pragma mark - Privatre

- (NSURL *)defaultURL
{
    return [NSURL URLWithString:@"http://m.youche.com/ershouche/"];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
    if ([vc respondsToSelector:@selector(setDelegate:)]) {
        [vc performSelector:@selector(setDelegate:) withObject:self];
    }
}


@end
