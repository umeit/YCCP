//
//  YCCarService.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/19.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCarService.h"
#import "YCBaoKuanEntity.h"
#import "YCYouCheHTTPClient.h"

@implementation YCCarService

- (void)baokuanWithBlock:(BaokuanBlock)block
{
    /*
    [[YCYouCheHTTPClient httpClient] GET:@"baokuan" parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
                                 }];
    */
    block([self tempData]);
}

- (NSArray *)tempData
{
    YCBaoKuanEntity *baokuan1 = [[YCBaoKuanEntity alloc] init];
    baokuan1.imageURL = [NSURL URLWithString:@"http://file.youche.com/_380_252/0/car/24bab11bb5db2168.jpg"];
    baokuan1.carID = 9943;
    baokuan1.price = @"7.99";
    baokuan1.series = @"嘉年华两厢 11款 1.5L 自动运动型";
    baokuan1.linkURL = [NSURL URLWithString:@"http://m.youche.com/detail/9943.shtml"];
    
    return @[baokuan1, baokuan1, baokuan1, baokuan1, baokuan1, baokuan1];
}

@end
