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
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
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
        self.tabBarController.tabBar.hidden = YES;
        self.bottomBarBackgroundView.hidden = NO;
    }
    else {
        self.bottomBarBackgroundView.hidden = YES;
    }
    
    if ([self.navigationItem.title isEqualToString:@"保存模板"]) {
        self.downloadButton.hidden = NO;
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
                                      shareText:@"优车诚品，有保障的二手车"
                                     shareImage:[UIImage imageNamed:@"share_icon"]
                                shareToSnsNames:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]
                                       delegate:self];
    NSString *shareURL = [NSString stringWithFormat:@"%@detail/%@.shtml", BaseURL, self.carID];
    
    [UMSocialData defaultData].extConfig.wechatSessionData.url = shareURL;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = shareURL;
    [UMSocialData defaultData].extConfig.wechatSessionData.title = self.carName;
    [UMSocialData defaultData].extConfig.wechatTimelineData.title = self.carName;
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    
    [UMSocialData defaultData].extConfig.qqData.url = shareURL;
    [UMSocialData defaultData].extConfig.qzoneData.url = shareURL;
    [UMSocialData defaultData].extConfig.qqData.title = self.carName;
    [UMSocialData defaultData].extConfig.qzoneData.title = self.carName;
    [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
}

- (IBAction)orderButtonPress:(id)sender {
    YCWebViewController *webVC = [self controllerWithStoryBoardID:@"YCWebViewController"];
    webVC.webPageURL = [NSString stringWithFormat:@"%@yuyue?yuyueType=1&carID=%@&t=app", BaseURL, self.carID];
    webVC.navigationItem.title = @"车辆信息";
    [self.navigationController pushViewController:webVC animated:YES];
}

- (IBAction)phone888ButtonPress:(id)sender {
    [self call:@"4000-990-888"];
}

- (IBAction)downloadButtonPress {
    UIImageWriteToSavedPhotosAlbum([self captureScrollView:self.webView.scrollView], self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
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
        // 跳转分享模板页
        else if ([dicArg[@"f"] isEqualToString:@"toTemplates"]) {
            YCWebViewController *webVC = [self controllerWithStoryBoardID:@"YCWebViewController"];
            webVC.webPageURL = dicArg[@"args"][0];
            webVC.navigationItem.title = @"选择模板";
            [self.navigationController pushViewController:webVC animated:YES];
        }
        // 跳转模板图片页
        else if ([dicArg[@"f"] isEqualToString:@"toFinalTemplate"]) {
            YCWebViewController *webVC = [self controllerWithStoryBoardID:@"YCWebViewController"];
            webVC.webPageURL = dicArg[@"args"][0];
            webVC.navigationItem.title = @"保存模板";
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
// 生成webView截图
- (UIImage *)captureScrollView:(UIScrollView *)scrollView {
    UIImage* image = nil;
    UIGraphicsBeginImageContext(scrollView.contentSize);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }
    return nil;
}
// 保存图片到相册指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [self showCustomTextAlert:msg];
}

@end
