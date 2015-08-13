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
#import "UMSocial.h"

#define UMAPPKey @"5581085367e58e8d64003ea0"

@interface YCWebViewController () <UMSocialUIDelegate>
@property (strong, nonatomic) UIWebView *callWebView;
@end

@implementation YCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationItems];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webPageURL]]];
    
    self.callWebView = [[UIWebView alloc] init];
    [self.view addSubview:self.callWebView];
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.showBottomBar) {
         self.bottomBarBackgroundView.hidden = NO;
    }
    else {
        self.bottomBarBackgroundView.hidden = YES;
    }
}


#pragma mark - Action

- (void)phoneButtonPress:(id)sender {
    [self call:MainPhoneNum];
}

/** 分享 */
- (IBAction)shareButtonPress:(id)sender {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMAPPKey
                                      shareText:@"test"
                                     shareImage:[UIImage imageNamed:@""]
                                shareToSnsNames:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]
                                       delegate:self];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://m.youche.com/detail/%@.shtml", self.carID];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"http://m.youche.com/detail/%@.shtml", self.carID];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.title = self.carName;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.carName;
    
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
}

- (IBAction)orderButtonPress:(id)sender {
    YCWebViewController *webVC = [self controllerWithStoryBoardID:@"YCWebViewController"];
    webVC.webPageURL = [NSString stringWithFormat:@"http://m.youche.com/yuyue?yuyueType=1&carID=%@&t=app", self.carID];
    webVC.navigationItem.title = @"车辆信息";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)phone888ButtonPress:(id)sender {
    [self call:@"4000-990-888"];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
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
                
                [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@','%@')",
                                                                 jsFunctionName,
                                                                 text?:@"",
                                                                 carID?:@""]];
            }];
        }
        else if ([dicArg[@"f"] isEqualToString:@"getCarName"]) {
            NSString *argStr = dicArg[@"args"][0];
            NSArray *argList = [argStr componentsSeparatedByString:@","];
            self.carName = argList[0];
            self.carID   = argList[1];
        }
        return NO;
    }
    return YES;
}

#pragma mark - Private

- (void)setNavigationItems {
    self.navigationItem.rightBarButtonItem
    = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"dianhua"]
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(phoneButtonPress:)];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style: UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)call:(NSString *)tel {
    NSString *str = [NSString stringWithFormat:@"tel:%@", tel];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
}

@end
