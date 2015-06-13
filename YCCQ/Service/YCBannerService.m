//
//  YCBannerService.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/19.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCBannerService.h"
#import "YCBannerEntity.h"
#import "YCYouCheHTTPClient.h"
#import "YCNetUtil.h"

@interface YCBannerService ()

@property (strong, nonatomic) NSMutableArray *images;

@end

@implementation YCBannerService

- (void)bannersWithBlock:(BannerBlock)block
{
    [[YCYouCheHTTPClient httpClient] GET:@"app/banner" parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     NSNumber *ret = [responseObject objectForKey:@"ret"];
                                     if ([ret integerValue] == 1) {
                                         NSArray *baokuans = [responseObject objectForKey:@"bannerdata"];
                                         block([self bannerEntitysWithDicArrar:baokuans]);
                                     }
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     
                                 }];
}

- (NSArray *)bannerEntitysWithDicArrar:(NSArray *)bannerDicArray
{
    NSMutableArray *banners = [NSMutableArray array];
    for (NSDictionary *bannerDic in bannerDicArray) {
        YCBannerEntity *banner = [[YCBannerEntity alloc] init];
        banner.imageURL = [NSURL URLWithString:bannerDic[@"url"]];
        banner.linkURL = bannerDic[@"link"];
        [banners addObject:banner];
    }
    return banners;
}

@end
