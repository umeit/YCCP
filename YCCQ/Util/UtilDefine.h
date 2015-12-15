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

#define IS_OS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)

#define IS_OS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)

#define IS_OS_9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#define iPhone6_Standard CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)

#define iPhone6_Zoom CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)

#define iPhone6Plus_Standard CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)

#define iPhone6Plus_Zoom CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size)

#define iPhone5 CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)

#define iPhone4 CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size)

#define iPad_Retina CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size)

#define MainPhoneNum       @"400-068-9966"

#define UserCouponPhoneNum @"UserCouponPhoneNum"

#define WeiKeFuAPPKey      @"002285068eb76753921a60addd37bc34"

#define UMAPPKey           @"5581085367e58e8d64003ea0"

#define WeiXinAppID        @"wx472e59e0e19accd0"

#define WeiXinAppSecret    @"fd6553fe092c7881c4b063cb02a2d0ea"

#define QQAppID            @"1104704187"

#define QQAppKey           @"hGFosnqSbCrmFDi4"

#define ShowDepreciateCarNotification @"ShowDepreciateCarNotification"

#define MyControllerIndex  4

#endif
