//
//  YCBaoKuanEntity.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/19.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YCBaoKuanEntity : NSObject

@property (strong, nonatomic) NSURL *imageURL;

@property (nonatomic) NSInteger carID;

@property (strong, nonatomic) NSString *series;

@property (strong, nonatomic) NSString *price;

@property (strong, nonatomic) NSURL *linkURL;

@end
