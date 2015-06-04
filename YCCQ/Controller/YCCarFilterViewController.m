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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height + 40);
    button.backgroundColor = [UIColor redColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tableView setTableFooterView:button];
    
    [button addTarget:self action:@selector(okButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.filterCondition = [[YCCarFilterConditionEntity alloc] init];
    self.filterCondition.brandName   = @"不限";
    self.filterCondition.seriesName  = @"不限";
    self.filterCondition.modelName   = @"不限";
    self.filterCondition.priceName   = @"不限";
    self.filterCondition.carTypeName = @"不限";
    self.filterCondition.yearName    = @"不限";
    self.filterCondition.ccName      = @"不限";
    self.filterCondition.mileageName = @"不限";
    self.filterCondition.gearboxName = @"不限";
    self.filterCondition.colorName   = @"不限";
    
    [self updateCellViews];
}


#pragma mark - Action

- (void)okButtonPress:(UIButton *)button {
    [self.delegate conditionDidFinish:[self urlFuffix]];
    [self.navigationController popViewControllerAnimated:YES];
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
            break;
        case PriceType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.delegate = self;
            vc.dataType = PriceType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case CarTypeType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.delegate = self;
            vc.dataType = CarTypeType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ccType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.delegate = self;
            vc.dataType = ccType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case gearboxType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.delegate = self;
            vc.dataType = gearboxType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case mileageType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.delegate = self;
            vc.dataType = mileageType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case yearType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.delegate = self;
            vc.dataType = yearType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case colorType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.delegate = self;
            vc.dataType = colorType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Car Filter Delegate

- (void)selecteConditionFinish:(NSDictionary *)condition filterType:(CarFilterType)filterType
{
    switch (filterType) {
        case BrandType:
        {
            self.filterCondition.brandName = condition[@"CN"];
            self.filterCondition.brandValue = condition[@"CV"];
            self.brandID = [condition[@"PID"] integerValue];
            
            self.filterCondition.seriesName = @"不限";
            self.filterCondition.seriesValue = nil;
            self.filterCondition.modelName = @"不限";
            self.filterCondition.modelValue = nil;
        }
            break;
        case SeriesType:
        {
            self.filterCondition.seriesName = condition[@"CN"];
            self.filterCondition.seriesValue = condition[@"CV"];
            self.seriesID = [condition[@"PID"] integerValue];
            
            self.filterCondition.modelName = @"不限";
            self.filterCondition.modelValue = nil;
        }
            break;
        case ModelType:
        {
            self.filterCondition.modelName = condition[@"CN"];
            self.filterCondition.modelValue = condition[@"CV"];
        }
            break;
            
        case PriceType:
        {
            self.filterCondition.priceName = condition[@"CN"];
            self.filterCondition.priceValue = condition[@"CV"];
        }
            break;
        case CarTypeType:
        {
            self.filterCondition.carTypeName = condition[@"CN"];
            self.filterCondition.carTypeValue = condition[@"CV"];
        }
            break;
        case yearType:
        {
            self.filterCondition.yearName = condition[@"CN"];
            self.filterCondition.yearValue = condition[@"CV"];
        }
            break;
        case colorType:
        {
            self.filterCondition.colorName = condition[@"CN"];
            self.filterCondition.colorValue = condition[@"CV"];
        }
            break;
        case ccType:
        {
            self.filterCondition.ccName = condition[@"CN"];
            self.filterCondition.ccValue = condition[@"CV"];
        }
            break;
        case gearboxType:
        {
            self.filterCondition.gearboxName = condition[@"CN"];
            self.filterCondition.gearboxValue = condition[@"CV"];
        }
            break;
        case mileageType:
        {
            self.filterCondition.mileageName = condition[@"CN"];
            self.filterCondition.mileageValue = condition[@"CV"];
        }
            break;
        default:
            break;
    }
    
    [self updateCellViews];
}


#pragma mark - Private

// 通过 FilterCondition 实体，生成查询 URL 后缀
- (NSString *)urlFuffix
{
    NSMutableString *url = [NSMutableString string];
    
    // 选择类型
    if (self.filterCondition.carTypeValue.length) {
        [url appendString:self.filterCondition.carTypeValue];
        // 品牌
        if (self.filterCondition.brandValue.length) {
            [url appendString:[self.filterCondition.brandValue isEqualToString:@"all"] ? @"" :self.filterCondition.brandValue];
        }
        // 价格
        if (self.filterCondition.priceValue) {
            [url appendFormat:@"/%@", self.filterCondition.priceValue];
        }
        
        return url;
    }

    // 选择品牌
    if (self.filterCondition.brandValue.length) {
        [url appendString:[self.filterCondition.brandValue isEqualToString:@"all"] ? @"" :self.filterCondition.brandValue];
        // 车系
        if (self.filterCondition.seriesValue.length) {
            [url appendString:[self.filterCondition.seriesValue isEqualToString:@"all"] ? @"" :self.filterCondition.seriesValue];
            // 车型
            if (self.filterCondition.modelValue.length) {
                [url appendString:[self.filterCondition.modelValue isEqualToString:@"all"] ? @"" :self.filterCondition.modelValue];
            }
        }
        // 价格
        if (self.filterCondition.priceValue) {
            [url appendFormat:@"/%@", self.filterCondition.priceValue];
        }
        
        return url;
    }

    // 没选类型，没选品牌，价格前加 ershouche
    if (self.filterCondition.priceValue) {
        [url appendFormat:@"ershouche/%@", self.filterCondition.priceValue];
    }
    return url;
}

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
    [array addObject:@{@"name": @"价格",  @"value": self.filterCondition.priceName, @"type": @(PriceType)}];
    [array addObject:@{@"name": @"类型",  @"value": self.filterCondition.carTypeName, @"type": @(CarTypeType)}];
    [array addObject:@{@"name": @"车龄",  @"value": self.filterCondition.yearName, @"type": @(yearType)}];
    [array addObject:@{@"name": @"里程",  @"value": self.filterCondition.mileageName, @"type": @(mileageType)}];
    [array addObject:@{@"name": @"变速箱", @"value": self.filterCondition.gearboxName, @"type": @(gearboxType)}];
    [array addObject:@{@"name": @"排量",  @"value": self.filterCondition.ccName, @"type": @(ccType)}];
    [array addObject:@{@"name": @"颜色",  @"value": self.filterCondition.colorName, @"type": @(colorType)}];
    
    self.cellContentList = array;
    [self.tableView reloadData];
}

@end
