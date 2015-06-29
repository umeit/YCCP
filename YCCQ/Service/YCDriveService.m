//
//  YCDriveService.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/23.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCDriveService.h"
#import "TFHpple.h"

@implementation YCDriveService

- (void)oilPrice:(OilPriceBlock)block
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://m.15tianqi.cn/youjia/beijing/"]];
        
        TFHpple *htmlDoc = [[TFHpple alloc] initWithHTMLData:data encoding:@"UTF8"];
        NSArray *array = [htmlDoc searchWithXPathQuery:@"//td[@class='red']"];
        
        NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            TFHppleElement *element1 = obj1;
            TFHppleElement *element2 = obj2;
            
            NSString *price1 = [element1.content substringFromIndex:1];
            NSString *price2 = [element2.content substringFromIndex:1];
            
            if ([price1 floatValue] > [price2 floatValue]) {
                return NSOrderedAscending;
            }
            else if ([price1 floatValue] < [price2 floatValue]) {
                return NSOrderedDescending;
            }
            return NSOrderedSame;
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (sortedArray) {
                block(@{@"97":[((TFHppleElement *)sortedArray[0]).content substringFromIndex:1],
                        @"93":[((TFHppleElement *)sortedArray[1]).content substringFromIndex:1],
                        @"0":[((TFHppleElement *)sortedArray[2]).content substringFromIndex:1],
                        @"90":[((TFHppleElement *)sortedArray[3]).content substringFromIndex:1]});
            }
            else {
                block(nil);
            }
        });
    });
}

- (void)limitDriveInfo:(LimitDriveBlock)block
{
    block(@{@"LimitNum": @[@[@"1", @"6"], @[@"2", @"7"], @[@"3", @"8"], @[@"4", @"9"], @[@"5", @"0"], @[]],
            @"LimitIntro": @"2015年4月13日--2015年7月11日，限行规则："});
}

@end
