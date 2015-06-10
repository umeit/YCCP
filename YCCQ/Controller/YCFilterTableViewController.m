//
//  YCFilterTableViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/3.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCFilterTableViewController.h"

@interface YCFilterTableViewController ()

@property (strong, nonatomic) NSArray *dataList;

@end

@implementation YCFilterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.dataType) {
        case PriceType:
            self.dataList = [self priceList];
            break;
        case CarTypeType:
            self.dataList = [self carTyppList];
            break;
        case gearboxType:
            self.dataList = [self gearboxTyppList];
            break;
        case ccType:
            self.dataList = [self ccTyppList];
            break;
        case colorType:
            self.dataList = [self colorTyppList];
            break;
        case yearType:
            self.dataList = [self yearTyppList];
            break;
        case yearNumType:
            self.dataList = [self yearNumTypeList];
            break;
        case mileageType:
            self.dataList = [self mileageTyppList];
            break;
        default:
            break;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataList[indexPath.row][@"name"];
 
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataList[indexPath.row];
    [self.delegate selecteConditionFinish:@{@"CN" : dic[@"name"],
                                            @"CV" : dic[@"value"]}
                               filterType:self.dataType];

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Private

- (NSArray *)priceList
{
    return @[@{@"name": @"不限",    @"value":@""},
             @{@"name": @"5万以下", @"value":@"j1"},
             @{@"name": @"5-8万",   @"value":@"j2"},
             @{@"name": @"8-10万",  @"value":@"j3"},
             @{@"name": @"10-15万", @"value":@"j4"},
             @{@"name": @"15-20万", @"value":@"j5"},
             @{@"name": @"20-30万", @"value":@"j6"},
             @{@"name": @"30-50万", @"value":@"j7"},
             @{@"name": @"50万以上", @"value":@"j8"}];
}

- (NSArray *)carTyppList
{
    return @[@{@"name": @"不限",    @"value":@""},
             @{@"name": @"微型车", @"value":@"weixing"},
             @{@"name": @"小型车",   @"value":@"xiaoxing"},
             @{@"name": @"紧凑型车",  @"value":@"jinchou"},
             @{@"name": @"中型车", @"value":@"zhongxingche"},
             @{@"name": @"中大型车", @"value":@"zhongdaxing"},
             @{@"name": @"豪华车", @"value":@"haohua"},
             @{@"name": @"SUV", @"value":@"suv"},
             @{@"name": @"MPV", @"value":@"mpv"},
             @{@"name": @"跑车", @"value":@"paoche"}];
}

- (NSArray *)ccTyppList
{
    return @[@{@"name": @"不限",    @"value":@""},
             @{@"name": @"1.0L以下", @"value":@"l1"},
             @{@"name": @"1.1L-1.5L",   @"value":@"l2"},
             @{@"name": @"1.6L-2.0L",  @"value":@"l3"},
             @{@"name": @"2.1L-2.5L", @"value":@"l4"},
             @{@"name": @"2.6L-3.0L", @"value":@"l5"},
             @{@"name": @"3.1L-4.0L", @"value":@"l6"},
             @{@"name": @"4.0L以上", @"value":@"l7"}];
}

- (NSArray *)mileageTyppList
{
    return @[@{@"name": @"不限",    @"value":@""},
             @{@"name": @"1万以内", @"value":@"d1"},
             @{@"name": @"1-3万",   @"value":@"d2"},
             @{@"name": @"3-6万",  @"value":@"d3"},
             @{@"name": @"6-10万", @"value":@"d4"},
             @{@"name": @"10万以上", @"value":@"d5"}];
}

- (NSArray *)gearboxTyppList
{
    return @[@{@"name": @"不限",    @"value":@""},
             @{@"name": @"手动", @"value":@"g1"},
             @{@"name": @"自动",   @"value":@"g2"}];
}

- (NSArray *)colorTyppList
{
    return @[@{@"name": @"不限",    @"value":@""},
             @{@"name": @"黑色", @"value":@"c1"},
             @{@"name": @"白色",   @"value":@"c2"},
             @{@"name": @"银色",  @"value":@"c3"},
             @{@"name": @"灰色", @"value":@"c4"},
             @{@"name": @"栗色", @"value":@"c5"},
             @{@"name": @"红色", @"value":@"c6"},
             @{@"name": @"蓝色", @"value":@"c7"},
             @{@"name": @"绿色", @"value":@"c8"},
             @{@"name": @"黄色", @"value":@"c9"},
             @{@"name": @"橙色", @"value":@"c10"},
             @{@"name": @"棕色", @"value":@"c11"},
             @{@"name": @"紫色", @"value":@"c12"},
             @{@"name": @"金色", @"value":@"c13"}];
}

- (NSArray *)yearTyppList
{
    return @[@{@"name": @"不限",    @"value":@""},
             @{@"name": @"1年以内", @"value":@"a1"},
             @{@"name": @"2年以内",   @"value":@"a2"},
             @{@"name": @"3年以内",  @"value":@"a3"},
             @{@"name": @"5年以内", @"value":@"a7"},
             @{@"name": @"5年以上", @"value":@"a8"},
             @{@"name": @"准新车", @"value":@"a9"}];
}

- (NSArray *)yearNumTypeList
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:[NSDate date]];
    NSInteger year = comps.year;
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 20; i ++) {
        [arr addObject:@(year-i)];
    }
    
    return arr;
}

@end
