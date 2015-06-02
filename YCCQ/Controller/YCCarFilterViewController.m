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

@interface YCCarFilterViewController ()
@property (strong, nonatomic) NSMutableArray *cellContentList;
@property (nonatomic) NSInteger pid;
@end

@implementation YCCarFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.filterCondition = [[YCCarFilterConditionEntity alloc] init];
    self.filterCondition.brandName = @"不限";
    self.filterCondition.seriesName = @"不限";
    self.filterCondition.modelName = @"不限";
    self.filterCondition.priceName = @"不限";
    
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
    
    switch (indexPath.row) {
        case 0:
        {
            YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
            vc.delegate = self;
            vc.brandType = BrandType;
            vc.useOnlineData = YES;
            vc.pid = self.pid;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            if (self.filterCondition.brandValue) {
                YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
                vc.delegate = self;
                vc.brandType = SeriesType;
                vc.useOnlineData = YES;
                vc.pid = self.pid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else {
                
            }
        }
            break;
        case 2:
        {
            if (self.filterCondition.brandValue) {
                YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
                vc.delegate = self;
                vc.brandType = ModelType;
                vc.useOnlineData = YES;
                vc.pid = self.pid;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else {
                
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark - YCCarFilterDelegate

- (void)selecteConditionFinish:(NSDictionary *)condition
{
    if ([condition[@"CK"] isEqualToString:@"Brand"]) {
        self.filterCondition.brandName = condition[@"CN"];
        self.filterCondition.brandValue = condition[@"CV"];
    }
    self.pid = [condition[@"PID"] integerValue];
    [self updateCellViews];
}


#pragma mark - Private

// 通过 FilterCondition 实体，更新列表数据源
- (void)updateCellViews
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *brand  = self.filterCondition.brandValue;
    NSString *series = self.filterCondition.seriesValue;
    
    [array addObject:@{@"name": @"品牌", @"value": self.filterCondition.brandName}];
    if (brand.length) {
        [array addObject:@{@"name": @"车系", @"value": self.filterCondition.seriesName}];
        if (series.length) {
            [array addObject:@{@"name": @"车型", @"value": self.filterCondition.modelName}];
        }
    }
    [array addObject:@{@"name": @"价格", @"value": self.filterCondition.priceName}];
    
    self.cellContentList = array;
    [self.tableView reloadData];
}

@end
