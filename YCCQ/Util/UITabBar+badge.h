//
//  UITabBar+badge.h
//  YCCQ
//
//  Created by qi chao on 15/12/14.
//  Copyright © 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)

- (void)showBadgeOnItemIndex:(int)index;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end
