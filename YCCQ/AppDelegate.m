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

#define WeiKeFuAPPKey @"002285068eb76753921a60addd37bc34"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 登录微客服
    [[AppKeFuLib sharedInstance] loginWithAppkey:WeiKeFuAPPKey];
    
    // 向苹果注册推送服务
    [self registerAPNs];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
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

@end
