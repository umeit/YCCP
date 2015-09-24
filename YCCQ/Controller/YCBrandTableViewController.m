//
//  YCBrandTableViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/29.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCBrandTableViewController.h"
#import "YCFilterKeyUtil.h"
#import "YCCarService.h"
#import "UIViewController+GViewController.h"
#import "UtilDefine.h"
#import "YCCarFilterConditionEntity.h"
#import "YCFilterConditionStore.h"
#import "YCFilterConditionTypeEnum.h"

@interface YCBrandTableViewController ()
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation YCBrandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.carService = [[YCCarService alloc] init];
    
    [self showLodingView];
    
    YCCarFilterConditionEntity *condition = (self.conditionType == CarListFilterConditionType) ?
    [YCFilterConditionStore sharedInstance].carListFilterCondition
    : [YCFilterConditionStore sharedInstance].carEvaluateFilterCondition;
    
    switch (self.dataType) {
        case BrandType:   // 显示品牌
        {
            if (self.useOnlineData) {
                [self.carService brandsFromOnSell:^(NSArray *brands) {
                    [self hideLodingView];
                    self.dataList = brands;
                    [self.tableView reloadData];
                }];
            }
            else {
                [self.carService allBrands:^(NSArray *brands) {
                    [self hideLodingView];
                    self.dataList = brands;
                    [self.tableView reloadData];
                }];
            }
        }
        break;
            
        case SeriesType:   // 显示车系
        {
            if (self.useOnlineData) {
                [self.carService seriesesFromOnSellWithPID:condition.brandID block:^(NSArray *serieses) {
                    [self hideLodingView];
                    self.dataList = serieses;
                    [self.tableView reloadData];
                }];
            }
            else {
                [self.carService allSeriesesWithPID:condition.brandID block:^(NSArray *serieses) {
                    [self hideLodingView];
                    self.dataList = serieses;
                    [self.tableView reloadData];
                }];
            }
        }
        break;
            
        case ModelType:   // 显示车型
        {
            if (self.useOnlineData) {
                [self.carService modelsFromOnSellWithPID:condition.seriesID block:^(NSArray *models) {
                    [self hideLodingView];
                    self.dataList = models;
                    [self.tableView reloadData];
                }];
            }
            else {
                [self.carService allModelsWithPID:condition.seriesID block:^(NSArray *models) {
                    [self hideLodingView];
                    self.dataList = models;
                    [self.tableView reloadData];
                }];
            }
        }
        break;
             
        default:
            break;
    }
}

#pragma mark - Action

/** 点击品牌快捷入口 */
- (IBAction)brandButtonPress:(UIButton *)button
{
    NSString *brandVlue = [YCFilterKeyUtil brandFilterKeyWithButtonTag:button.tag];
    NSString *pid = [YCFilterKeyUtil pIDWithBrand:brandVlue];
    
    YCCarFilterConditionEntity *conditionEntity = (self.conditionType == CarListFilterConditionType) ?
    [YCFilterConditionStore sharedInstance].carListFilterCondition
    : [YCFilterConditionStore sharedInstance].carEvaluateFilterCondition;
    
    conditionEntity.brandName = [YCFilterKeyUtil brandCnNameWithHotBrandButtonTag:button.tag];
    conditionEntity.brandValue = brandVlue;
    conditionEntity.brandID = pid;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterConditionUpdate" object:nil];
    
    if (self.continuousMode) {
        YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
        vc.dataType = SeriesType;
        vc.useOnlineData = NO;
        vc.continuousMode = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataType == BrandType) {
        return self.dataList.count + 1;
    }
    else {
        return self.dataList.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataType == BrandType) {
        if (section == 0) {
            return 1;
        }
        NSDictionary *brandInfo = self.dataList[section - 1];
        NSArray *brands = [brandInfo objectForKey:@"key2"];
        return brands.count;
    }
    else {
        NSDictionary *brandInfo = self.dataList[section];
        NSArray *brands = [brandInfo objectForKey:@"key2"];
        return brands.count;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.dataType == BrandType) {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@"热"];
        for (NSDictionary *brandInfo in self.dataList) {
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
        cell.textLabel.text = self.dataList[indexPath.section - 1][@"key2"][indexPath.row][@"title"];
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandCell" forIndexPath:indexPath];
        cell.textLabel.text = self.dataList[indexPath.section][@"key2"][indexPath.row][@"title"];
        return cell;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.dataType == BrandType) {
        if (section == 0) {
            return @"热门品牌";
        }
        NSString *title = self.dataList[section - 1][@"key1"];
        if ([title isEqualToString:@"0"]) {
            return @"";
        }
        return title;
    }
    else {
        return self.dataList[section][@"key1"];
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
    YCCarFilterConditionEntity *conditionEntity = (self.conditionType == CarListFilterConditionType) ?
    [YCFilterConditionStore sharedInstance].carListFilterCondition
    : [YCFilterConditionStore sharedInstance].carEvaluateFilterCondition;
    
    switch (self.dataType) {
        case BrandType: {
            // 品牌列表的第一行是热门品牌的容器，点击无效
            if (indexPath.section == 0 && indexPath.row == 0) {
                return;
            }
            
            NSDictionary *dic = self.dataList[indexPath.section - 1][@"key2"][indexPath.row];
            
            switch (self.conditionType) {
                case CarListFilterConditionType:
                    [[YCFilterConditionStore sharedInstance] carListConditionBrandName:dic[@"title"] value:dic[@"enname"] ID:dic[@"id"]];
                    break;
                case CarListSimpleFileterConditionType:
                    [[YCFilterConditionStore sharedInstance] clearCarListFilterCondition];
                    [[YCFilterConditionStore sharedInstance] carListConditionBrandName:dic[@"title"] value:dic[@"enname"] ID:dic[@"id"]];
                    break;
                case CarEvaluateFilterConditionType:
                    
                    break;
                default:
                    break;
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterConditionUpdate" object:nil];
            
            // 一直选到车款
            if (self.continuousMode) {
                YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
                vc.dataType = SeriesType;
                vc.conditionType = self.conditionType;
                vc.useOnlineData = NO;
                vc.continuousMode = YES;
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
        }
            break;
        case SeriesType:
        {
            NSDictionary *dic = self.dataList[indexPath.section][@"key2"][indexPath.row];
            
            conditionEntity.seriesName = dic[@"title"];
            conditionEntity.seriesValue = dic[@"enname"];
            conditionEntity.seriesID = dic[@"id"];
            conditionEntity.modelName = @"";
            conditionEntity.modelValue = @"";
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterConditionUpdate" object:nil];
            
            if (self.continuousMode) {
                YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
                vc.dataType = ModelType;
                vc.conditionType = self.conditionType;
                vc.useOnlineData = NO;
                vc.continuousMode = YES;
                [self.navigationController pushViewController:vc animated:YES];
                return;
            }
        }
            break;
        case ModelType:
        {
            NSDictionary *dic = self.dataList[indexPath.section][@"key2"][indexPath.row];
            
            conditionEntity.modelName = dic[@"title"];
            conditionEntity.modelValue = dic[@"enname"];
            conditionEntity.modelID = dic[@"id"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterConditionUpdate" object:nil];
            
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

@end
