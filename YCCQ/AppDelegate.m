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
    [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAppKey url:@"http://www.youche.com"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[AppKeFuLib sharedInstance] logout];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[AppKeFuLib sharedInstance] loginWithAppkey:WeiKeFuAPPKey];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - APNs

- (void)registerAPNs
{
    if (IS_OS_8_OR_LATER) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)
                                          categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[AppKeFuLib sharedInstance] uploadDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"收到推送消息。这里主要起到通知的作用，用户进入应用后，服务器会再次推送即时通讯消息");
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

@end
