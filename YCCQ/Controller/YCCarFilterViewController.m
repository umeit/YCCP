//
//  YCCarFilterViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/29.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCarFilterViewController.h"
#import "YCBrandTableViewController.h"
#import "UIViewController+GViewController.h"
#import "YCFilterTableViewController.h"
#import "YCCarFilterEnum.h"

@interface YCCarFilterViewController ()
@property (strong, nonatomic) NSMutableArray *cellContentList;
@property (nonatomic) NSInteger brandID;
@property (nonatomic) NSInteger seriesID;
@end

@implementation YCCarFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filterCondition = [[YCCarFilterConditionEntity alloc] init];
    self.filterCondition.brandName  = @"不限";
    self.filterCondition.seriesName = @"不限";
    self.filterCondition.modelName  = @"不限";
    self.filterCondition.priceName  = @"不限";
    
    [self updateCellViews];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellContentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterCell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSDictionary *dic = self.cellContentList[indexPath.row];
    cell.textLabel.text = dic[@"name"];
    cell.detailTextLabel.text = dic[@"value"];
    return cell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger type = [self.cellContentList[indexPath.row][@"type"] integerValue];
    
    switch (type) {
        case BrandType:
        {
            YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
            vc.delegate = self;
            vc.dataType = BrandType;
            vc.useOnlineData = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SeriesType:
        {
            YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
            vc.delegate = self;
            vc.dataType = SeriesType;
            vc.useOnlineData = YES;
            vc.pid = self.brandID;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ModelType:
        {
            YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
            vc.delegate = self;
            vc.dataType = ModelType;
            vc.useOnlineData = YES;
            vc.pid = self.seriesID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        case PriceType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.delegate = self;
            vc.dataType = PriceType;
            [self.navigationController pushViewController:vc animated:YES];
        }
        case CarTypeType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.delegate = self;
            vc.dataType = CarTypeType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Car Filter Delegate

- (void)selecteConditionFinish:(NSDictionary *)condition
{
    if ([condition[@"CK"] isEqualToString:@"Brand"]) {
        self.filterCondition.brandName = condition[@"CN"];
        self.filterCondition.brandValue = condition[@"CV"];
        self.brandID = [condition[@"PID"] integerValue];
        
        self.filterCondition.seriesName = @"不限";
        self.filterCondition.seriesValue = nil;
        self.filterCondition.modelName = @"不限";
        self.filterCondition.modelValue = nil;
    }
    else if ([condition[@"CK"] isEqualToString:@"Series"]) {
        self.filterCondition.seriesName = condition[@"CN"];
        self.filterCondition.seriesValue = condition[@"CV"];
        self.seriesID = [condition[@"PID"] integerValue];
        
        self.filterCondition.modelName = @"不限";
        self.filterCondition.modelValue = nil;
    }
    else if ([condition[@"CK"] isEqualToString:@"Model"]) {
        self.filterCondition.modelName = condition[@"CN"];
        self.filterCondition.modelValue = condition[@"CV"];
    }
    
    [self updateCellViews];
}


#pragma mark - Private

// 通过 FilterCondition 实体，更新列表数据源
- (void)updateCellViews
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *brand  = self.filterCondition.brandValue;
    NSString *series = self.filterCondition.seriesValue;
    
    [array addObject:@{@"name": @"品牌", @"value": self.filterCondition.brandName, @"type": @(BrandType)}];
    if (brand.length) {
        [array addObject:@{@"name": @"车系", @"value": self.filterCondition.seriesName, @"type": @(SeriesType)}];
        if (series.length) {
            [array addObject:@{@"name": @"车型", @"value": self.filterCondition.modelName, @"type": @(ModelType)}];
        }
    }
    [array addObject:@{@"name": @"价格", @"value": self.filterCondition.priceName, @"type": @(PriceType)}];
    [array addObject:@{@"name": @"类型", @"value": self.filterCondition.priceName, @"type": @(CarTypeType)}];
    
    self.cellContentList = array;
    [self.tableView reloadData];
}

@end
