//
//  YCMyViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/18.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCMyViewController.h"
#import "UMFeedback.h"
#import "YCWebViewController.h"
#import "UIViewController+GViewController.h"
#import "UtilDefine.h"
#import "UITabBar+badge.h"
#import "YCPushService.h"

@interface YCMyViewController ()

@property (strong, nonatomic) UIWebView *callWebView;
@property (weak, nonatomic) IBOutlet UILabel *depreciateCarL;

@end

@implementation YCMyViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowDepreciateCar) name:ShowDepreciateCarNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self.callWebView removeFromSuperview];
    self.callWebView = nil;
    
    [super viewWillDisappear:animated];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Action

- (IBAction)phoneButtonPress:(id)sender
{
    [self call:MainPhoneNum];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self toWebViewWithURL:@"http://m.youche.com/collect/show?t=app"
                       controllerTitle:@"我的收藏"];
                [self hideBadge];
                break;
            case 1:
            {
                UIViewController *feedbackVC = [UMFeedback feedbackViewController];
                feedbackVC.hidesBottomBarWhenPushed = YES;
                feedbackVC.navigationItem.title = @"意见反馈";
                [self.navigationController pushViewController:feedbackVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self toWebViewWithURL:@"http://m.youche.com/about/aboutme.shtml?t=app"
                       controllerTitle:@"关于优车"];
                break;
                
            default:
                break;
        }
    }
}


#pragma mark - Private

- (void)call:(NSString *)tel
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", tel];
    self.callWebView = [[UIWebView alloc] init];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:self.callWebView];
}

- (void)toWebViewWithURL:(NSString *)url controllerTitle:(NSString *)title
{
    YCWebViewController *webViewController = (YCWebViewController *)[self controllerWithStoryBoardID:@"YCWebViewController"];
    webViewController.webPageURL = url;
    webViewController.navigationItem.title = title;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)hideBadge {
    if (!self.depreciateCarL.hidden) {
        self.depreciateCarL.hidden = YES;
        UIApplication *application = [UIApplication sharedApplication];
        application.applicationIconBadgeNumber = 0;
        UITabBarController *tab = (UITabBarController *)application.keyWindow.rootViewController;
        [tab.tabBar hideBadgeOnItemIndex:MyControllerIndex];
        [YCPushService lookPushWithBlock:^(BOOL success, NSString *msg) {
            if (success) {
                NSLog(@"成功");
            }
        }];
    }
}

- (void)ShowDepreciateCar {
    [self view];
    self.depreciateCarL.hidden = NO;
}
@end
