//
//  YCBrandTableViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/29.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCBrandTableViewController.h"
#import "YCCarUtil.h"
#import "YCCarService.h"
#import "UIViewController+GViewController.h"

@interface YCBrandTableViewController ()
@property (strong, nonatomic) NSArray *brands;
@end

@implementation YCBrandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.carService = [[YCCarService alloc] init];
    
    if ([self useOnlineData]) {
        [self showLodingView];
        
        switch (self.dataType) {
            case BrandType:
            {
                [self.carService brandsFromOnSell:^(NSArray *brands) {
                    [self hideLodingView];
                    self.brands = brands;
                    [self.tableView reloadData];
                }];
            }
            break;
                
            case SeriesType:
            {
                [self.carService seriesesFromOnSellWithPID:self.pid block:^(NSArray *serieses) {
                    [self hideLodingView];
                    self.brands = serieses;
                    [self.tableView reloadData];
                }];
            }
            break;
                
            case ModelType:
            {
                [self.carService modelsFromOnSellWithPID:self.pid block:^(NSArray *models) {
                    [self hideLodingView];
                    self.brands = models;
                    [self.tableView reloadData];
                }];
            }
            break;
                 
            default:
                break;
        }
    }
}

- (IBAction)brandButtonPress:(UIButton *)button
{
    NSString *brandVlue = [YCCarUtil brandWithTagForFilter:button.tag];
    NSString *pid = [YCCarUtil pIDWithBrand:brandVlue];
    [self.delegate selecteConditionFinish:@{@"CK": @"Brand",
                                            @"CN": button.titleLabel.text,
                                            @"CV": brandVlue,
                                            @"PID": pid}];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataType == BrandType) {
        return self.brands.count + 1;
    }
    else {
        return self.brands.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataType == BrandType) {
        if (section == 0) {
            return 1;
        }
        NSDictionary *brandInfo = self.brands[section - 1];
        NSArray *brands = [brandInfo objectForKey:@"key2"];
        return brands.count;
    }
    else {
        NSDictionary *brandInfo = self.brands[section];
        NSArray *brands = [brandInfo objectForKey:@"key2"];
        return brands.count;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.dataType == BrandType) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@"热"];
        for (NSDictionary *brandInfo in self.brands) {
            NSString *indexString = [brandInfo objectForKey:@"key1"];
            if ([indexString isEqualToString:@"0"]) {
                indexString = @"";
            }
            [array addObject:indexString];
        }
        return array;
    }
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.dataType == BrandType) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            return [tableView dequeueReusableCellWithIdentifier:@"BrandCommonCell" forIndexPath:indexPath];
        }
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandCell" forIndexPath:indexPath];
        cell.textLabel.text = self.brands[indexPath.section - 1][@"key2"][indexPath.row][@"title"];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandCell" forIndexPath:indexPath];
        cell.textLabel.text = self.brands[indexPath.section][@"key2"][indexPath.row][@"title"];
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.dataType == BrandType) {
        if (section == 0) {
            return @"热门车辆";
        }
        if (section == 1) {
            return @"";
        }
        return self.brands[section - 1][@"key1"];
    }
    else {
        return self.brands[section][@"key1"];
    }
}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataType == BrandType) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            return 104;
        }
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataType == BrandType) {
        if (indexPath.section == 0 && indexPath.row == 0) {
            return;
        }
        
        NSDictionary *dic = self.brands[indexPath.section - 1][@"key2"][indexPath.row];
        
        [self.delegate selecteConditionFinish:@{@"CK" : @"Brand",
                                                @"CN" : dic[@"title"],
                                                @"CV" : dic[@"enname"],
                                                @"PID": dic[@"id"]}];
    }
    else if (self.dataType == SeriesType) {
        NSDictionary *dic = self.brands[indexPath.section][@"key2"][indexPath.row];
        
        [self.delegate selecteConditionFinish:@{@"CK" : @"Series",
                                                @"CN" : dic[@"title"],
                                                @"CV" : dic[@"enname"],
                                                @"PID": dic[@"id"]}];
    }
    else {
        NSDictionary *dic = self.brands[indexPath.section][@"key2"][indexPath.row];
        
        [self.delegate selecteConditionFinish:@{@"CK" : @"Model",
                                                @"CN" : dic[@"title"],
                                                @"CV" : dic[@"enname"],
                                                @"PID": dic[@"id"]}];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
