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
#import "YCNetUtil.h"

@implementation YCCarService

- (void)baokuanWithBlock:(BaokuanBlock)block
{
    [[YCYouCheHTTPClient httpClient] GET:@"app/baokuan" parameters:nil
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     NSNumber *ret = [responseObject objectForKey:@"ret"];
                                     if ([ret integerValue] == 1) {
                                         NSArray *baokuans = [responseObject objectForKey:@"baokuandata"];
                                         block([self bokuanEntitysWithDicArrar:baokuans]);
                                     }
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"Error! %@", error);
                                 }];
}

- (void)brandsFromOnSell:(OnSellBrandBlock)block
{
    [[YCYouCheHTTPClient httpClient] GET:@"select/showcarmodel"
                              parameters:@{@"depth": @1}
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     block(responseObject);
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"Error! %@", error);
                                 }];
}

- (void)allBrands:(OnSellBrandBlock)block
{
    NSString *allbrandPath = [[NSBundle mainBundle] pathForResource:@"allbrand" ofType:@"json"];
    NSString *content = [NSString stringWithContentsOfFile:allbrandPath encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:allbrandPath];
    NSData *data = [NSData dataWithContentsOfFile:allbrandPath];
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
}

- (void)seriesesFromOnSellWithPID:(NSInteger)pid block:(BaokuanBlock)block
{
    [[YCYouCheHTTPClient httpClient] GET:@"select/showcarmodel"
                              parameters:@{@"depth": @2, @"pid": @(pid)}
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     block(responseObject);
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"Error! %@", error);
                                 }];
}

- (void)modelsFromOnSellWithPID:(NSInteger)pid block:(BaokuanBlock)block
{
    [[YCYouCheHTTPClient httpClient] GET:@"select/showcarmodel"
                              parameters:@{@"depth": @3, @"pid": @(pid)}
                                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                     block(responseObject);
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     NSLog(@"Error! %@", error);
                                 }];
}

- (NSArray *)bokuanEntitysWithDicArrar:(NSArray *)baokuanDicArray
{
    NSMutableArray *baokuans = [NSMutableArray array];
    for (NSDictionary *baokuanDic in baokuanDicArray) {
        YCBaoKuanEntity *baokuan = [[YCBaoKuanEntity alloc] init];
        baokuan.imageURL = [YCNetUtil youcheImageURLWithPath:baokuanDic[@"firstPic"] w:300 h:200];
        baokuan.carID = [baokuanDic[@"id"] integerValue];
        baokuan.price = [baokuanDic[@"salePrice"] stringValue];
        baokuan.series = baokuanDic[@"carName"];
        baokuan.linkURL = [YCNetUtil youcheCarURLWithCarID:baokuan.carID];
        [baokuans addObject:baokuan];
    }
    return baokuans;
}

@end
