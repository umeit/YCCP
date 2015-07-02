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
#import "YCCarFilterDelegate.h"
#import "UtilDefine.h"

@interface YCBrandTableViewController ()
@property (strong, nonatomic) NSArray *brands;
@end

@implementation YCBrandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.carService = [[YCCarService alloc] init];
    
    [self showLodingView];
    
    switch (self.dataType) {
        case BrandType:   // 显示品牌
        {
            if (self.useOnlineData) {
                [self.carService brandsFromOnSell:^(NSArray *brands) {
                    [self hideLodingView];
                    self.brands = brands;
                    [self.tableView reloadData];
                }];
            }
            else {
                [self.carService allBrands:^(NSArray *brands) {
                    [self hideLodingView];
                    self.brands = brands;
                    [self.tableView reloadData];
                }];
            }
        }
        break;
            
        case SeriesType:    // 显示车系
        {
            if (self.useOnlineData) {
                [self.carService seriesesFromOnSellWithPID:self.pid block:^(NSArray *serieses) {
                    [self hideLodingView];
                    self.brands = serieses;
                    [self.tableView reloadData];
                }];
            }
            else {
                [self.carService allSeriesesWithPID:self.pid block:^(NSArray *serieses) {
                    [self hideLodingView];
                    self.brands = serieses;
                    [self.tableView reloadData];
                }];
            }
        }
        break;
            
        case ModelType:    // 显示车型
        {
            if (self.useOnlineData) {
                [self.carService modelsFromOnSellWithPID:self.pid block:^(NSArray *models) {
                    [self hideLodingView];
                    self.brands = models;
                    [self.tableView reloadData];
                }];
            }
            else {
                [self.carService allModelsWithPID:self.pid block:^(NSArray *models) {
                    [self hideLodingView];
                    self.brands = models;
                    [self.tableView reloadData];
                }];
            }
        }
        break;
             
        default:
            break;
    }
}

- (IBAction)brandButtonPress:(UIButton *)button
{
    NSString *brandVlue = [YCCarUtil brandWithTagForFilter:button.tag];
    NSString *pid = [YCCarUtil pIDWithBrand:brandVlue];
    [self.delegate selecteConditionFinish:@{@"CN": [YCCarUtil brandCnNameWithHotBrandButtonTag:button.tag],
                                            @"CV": brandVlue,
                                            @"PID": pid}
                               filterType:BrandType];
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
            return @"热门品牌";
        }
        NSString *title = self.brands[section - 1][@"key1"];
        if ([title isEqualToString:@"0"]) {
            return @"";
        }
        return title;
    }
    else {
        return self.brands[section][@"key1"];
    }
}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0 && self.dataType == BrandType) {
        if (iPhone4 || iPhone5) {
            return 104;
        }
        if (iPhone6) {
            return 124;
        }
        if (iPhone6Plus || iPhone6Plus_Simulator) {
            return 138;
        }
        if (iPad_Retina) {
            return 104;
        }
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.dataType) {
        case BrandType:
        {
            if (indexPath.section == 0 && indexPath.row == 0) {
                return;
            }
            
            NSDictionary *dic = self.brands[indexPath.section - 1][@"key2"][indexPath.row];
            
            if (self.continuousMode) {
                YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
                vc.delegate = self;
                vc.dataType = SeriesType;
                vc.useOnlineData = NO;
                vc.continuousMode = YES;
                vc.pid = [dic[@"id"] integerValue];
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            else {
                [self.delegate selecteConditionFinish:@{@"CN" : dic[@"title"],
                                                        @"CV" : dic[@"enname"],
                                                        @"PID": dic[@"id"]}
                                           filterType:BrandType];
            }
        }
            break;
        case SeriesType:
        {
            NSDictionary *dic = self.brands[indexPath.section][@"key2"][indexPath.row];
            
            if (self.continuousMode) {
                YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
                vc.delegate = self;
                vc.dataType = ModelType;
                vc.useOnlineData = NO;
                vc.continuousMode = YES;
                vc.pid = [dic[@"id"] integerValue];
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
            else {
                [self.delegate selecteConditionFinish:@{@"CN" : dic[@"title"],
                                                        @"CV" : dic[@"enname"],
                                                        @"PID": dic[@"id"]}
                                           filterType:SeriesType];
            }
        }
            break;
        case ModelType:
        {
            NSDictionary *dic = self.brands[indexPath.section][@"key2"][indexPath.row];
            
            [self.delegate selecteConditionFinish:@{@"CN" : dic[@"title"],
                                                    @"CV" : dic[@"enname"],
                                                    @"PID": dic[@"id"]}
                                       filterType:ModelType];
            
            if (self.continuousMode) {
                NSInteger controllerCount = self.navigationController.viewControllers.count;
                [self.navigationController popToViewController:self.navigationController.viewControllers[controllerCount - 4] animated:YES];
                return;
            }
        }
            break;
        default:
            break;
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - YCCarFilterConditionDelegate

- (void)selecteConditionFinish:(NSDictionary *)condition filterType:(CarFilterType)filterType
{
    [self.delegate selecteConditionFinish:condition filterType:filterType];
}

@end
