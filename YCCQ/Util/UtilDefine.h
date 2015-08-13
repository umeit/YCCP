//
//  UtilDefine.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/21.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <sys/utsname.h>

#ifndef YCCQ_UtilDefine_h
#define YCCQ_UtilDefine_h

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Plus_Simulator ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPad_Retina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)

#define MainPhoneNum       @"400-068-9966"

#define UserCouponPhoneNum @"UserCouponPhoneNum"

#define WeiKeFuAPPKey @"002285068eb76753921a60addd37bc34"

#define UMAPPKey      @"5581085367e58e8d64003ea0"

#define WeiXinAppID     @"wx472e59e0e19accd0"

#define WeiXinAppSecret @"fd6553fe092c7881c4b063cb02a2d0ea"

#define QQAppID   @""

#define QQAppKey  @""

#endif
