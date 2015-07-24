//
//  YCUserService.h
//  YCCQ
//
//  Created by Liu Feng on 15/7/24.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^sendCouponMsgBlock) (BOOL success, NSString *msg);

@interface YCUserService : NSObject

+ (void)sendCouponMessageToUserPhone:(NSString *)phoneNum
                           withBlock:(sendCouponMsgBlock)block;

@end
