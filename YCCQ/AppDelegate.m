//
//  AppDelegate.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/15.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "AppDelegate.h"
#import "AppKeFuLib.h"
#import "UtilDefine.h"
#import "MobClick.h"
#import "UMFeedback.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSnsService.h"

#import "YCWebViewController.h"
#import "NSString+YCSubString.h"
#import "UITabBar+badge.h"

#define FirstLaunch @"FirstLaunch"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 设置友盟统计
    [MobClick startWithAppkey:UMAPPKey];
    
    // 设置友盟反馈
    [UMFeedback setAppkey:UMAPPKey];
    
    // 登录微客服
    [[AppKeFuLib sharedInstance] loginWithAppkey:WeiKeFuAPPKey];
    
    // 向苹果注册推送服务
    [self registerAPNs];
    
    // 设置导航栏颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 显示引导页
    if ([self isFirestLaunch]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:@"FirstLaunch"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self.window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"YCUserGuideViewController"];
    }
    
    // 设置微信分享
    [UMSocialWechatHandler setWXAppId:WeiXinAppID appSecret:WeiXinAppSecret url:@"http://www.youche.com"];
    // 设置QQ 分享
    [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAppKey url:@"http://www.youche.com"];
    
    [self showOrHideMyControllerBadge:launchOptions];
    
    application.applicationIconBadgeNumber = 0;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[AppKeFuLib sharedInstance] logout];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[AppKeFuLib sharedInstance] loginWithAppkey:WeiKeFuAPPKey];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}

#pragma mark - APNs

- (void)registerAPNs
{
    if (IS_OS_8 || IS_OS_9_OR_LATER) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:
         (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound)
                                          categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[AppKeFuLib sharedInstance] uploadDeviceToken:deviceToken];
    
    NSString *deviceTokenString = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:deviceTokenString forKey:@"device"];
    [userDefaults synchronize];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"收到推送消息。这里主要起到通知的作用，用户进入应用后，服务器会再次推送即时通讯消息");
    [self showOrHideMyControllerBadge:userInfo];
}

// iOS7 以后用这个处理后台任务接收到得远程通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSLog(@"收到推送消息。这里主要起到通知的作用，用户进入应用后，服务器会再次推送即时通讯消息");
    [self showOrHideMyControllerBadge:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"注册推送失败，原因：%@",error);
}

#pragma mark - Private
- (BOOL)isFirestLaunch
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return ![userDefaults boolForKey:FirstLaunch];
}

- (void)showOrHideMyControllerBadge:(NSDictionary *)launchOptions {
    if (launchOptions[@"aps"]) {
        UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
        [tab.tabBar showBadgeOnItemIndex:MyControllerIndex];
        [[NSNotificationCenter defaultCenter] postNotificationName:ShowDepreciateCarNotification object:nil];
    }
}

#pragma mark - 今天跳转
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    if ([url.absoluteString hasPrefix:@"app://"]) {
        NSString *carID = [url.absoluteString YCSubStringFromString:@"(" toString:@")"];
        YCWebViewController *webVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"YCWebViewController"];
        webVC.webPageURL = [NSString stringWithFormat:@"http://m.youche.com/detail/%@.shtml?t=app", carID];
        webVC.navigationItem.title = @"车辆详情";
        webVC.showBottomBar = YES;
        UITabBarController *tab = (UITabBarController *)self.window.rootViewController;
        [tab.viewControllers.firstObject pushViewController:webVC animated:YES];
    }
    return YES;
}

@end
