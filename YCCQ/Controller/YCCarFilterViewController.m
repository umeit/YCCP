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
#import "YCFilterCellDataEntity.h"
#import "YCFilterService.h"

@interface YCCarFilterViewController ()
@property (strong, nonatomic) NSMutableArray *cellContentList;
@property (nonatomic) NSInteger brandID;
@property (nonatomic) NSInteger seriesID;
@end

@implementation YCCarFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setOKButton];
    
    self.filterCondition = [YCFilterService currentFilterCondition];
    
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
    
    YCFilterCellDataEntity *cellDataEntity = self.cellContentList[indexPath.row];
    cell.textLabel.text = cellDataEntity.title;
    cell.detailTextLabel.text = cellDataEntity.detail;
    return cell;
}

#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CarFilterType type = ((YCFilterCellDataEntity *)self.cellContentList[indexPath.row]).filteType;
    
    switch (type) {
        case BrandType:
        {
            YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
//            vc.delegate = self;
            vc.dataType = BrandType;
            vc.useOnlineData = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SeriesType:
        {
            YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
//            vc.delegate = self;
            vc.dataType = SeriesType;
            vc.useOnlineData = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ModelType:
        {
            YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
//            vc.delegate = self;
            vc.dataType = ModelType;
            vc.useOnlineData = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case PriceType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
//            vc.delegate = self;
            vc.dataType = PriceType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case CarTypeType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
//            vc.delegate = self;
            vc.dataType = CarTypeType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ccType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
//            vc.delegate = self;
            vc.dataType = ccType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case gearboxType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
//            vc.delegate = self;
            vc.dataType = gearboxType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case mileageType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
//            vc.delegate = self;
            vc.dataType = mileageType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case yearType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
//            vc.delegate = self;
            vc.dataType = yearType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case colorType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
//            vc.delegate = self;
            vc.dataType = colorType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case storeType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
//            vc.delegate = self;
            vc.dataType = storeType;
            [self.navigationController pushViewController:vc animated:YES];
        }
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
        case storeType:
        {
            self.filterCondition.storeName = condition[@"CN"];
            self.filterCondition.storeValue = condition[@"CV"];
        }
            break;
        default:
            break;
    }
    
    [self updateCellViews];
}


#pragma mark - Private

- (void)setOKButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"确 定" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height + 40);
    button.backgroundColor = [UIColor redColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tableView setTableFooterView:button];
    [button addTarget:self action:@selector(okButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}

// 通过 FilterCondition 实体，生成查询 URL 后缀
// TODO: 移动到 YCCarListViewController 中
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
    }
    // 没选类型
    // 品牌
    else if (self.filterCondition.brandValue.length) {
        [url appendString:[self.filterCondition.brandValue isEqualToString:@"all"] ? @"" :self.filterCondition.brandValue];
        // 车系
        if (self.filterCondition.seriesValue.length) {
            [url appendString:[self.filterCondition.seriesValue isEqualToString:@"all"] ? @"" :self.filterCondition.seriesValue];
            // 车型
            if (self.filterCondition.modelValue.length) {
                [url appendString:[self.filterCondition.modelValue isEqualToString:@"all"] ? @"" :self.filterCondition.modelValue];
            }
        }
    }
    // 没选类型，没选品牌
    else {
        [url appendString:@"ershouche"];
    }
    
    [url appendString:@"/"];
    
    // 价格
    if (self.filterCondition.priceValue.length) {
        [url appendString:self.filterCondition.priceValue];
//        [url appendString:@"/"];
    }
    // 颜色
    if (self.filterCondition.colorValue.length) {
        [url appendString:self.filterCondition.colorValue];
    }
    // 公里
    if (self.filterCondition.mileageValue.length) {
        [url appendString:self.filterCondition.mileageValue];
    }
    // 排量
    if (self.filterCondition.ccValue.length) {
        [url appendString:self.filterCondition.ccValue];
    }
    // 变速箱
    if (self.filterCondition.gearboxValue.length) {
        [url appendString:self.filterCondition.gearboxValue];
//        [url appendString:@"/"];
    }
    // 车龄
    if (self.filterCondition.yearValue.length) {
        [url appendString:self.filterCondition.yearValue];
    }
    // 门店
    if (self.filterCondition.storeValue.length) {
        [url appendString:self.filterCondition.storeValue];
    }
    return url;
}

/** 更新列表数据源 */
- (void)updateCellViews
{
    self.cellContentList = [NSMutableArray array];
    
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"品牌" detail:self.filterCondition.brandName filteType:BrandType]];
    if (self.filterCondition.brandValue.length) {
        [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"车系" detail:self.filterCondition.seriesName filteType:SeriesType]];
        if (self.filterCondition.seriesValue.length) {
            [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"车型" detail:self.filterCondition.modelName filteType:ModelType]];
        }
    }
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"价格" detail:self.filterCondition.priceName filteType:PriceType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"类型" detail:self.filterCondition.carTypeName filteType:CarTypeType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"门店" detail:self.filterCondition.storeName filteType:storeType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"车龄" detail:self.filterCondition.yearName filteType:yearType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"里程" detail:self.filterCondition.mileageName filteType:mileageType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"变速箱" detail:self.filterCondition.gearboxName filteType:gearboxType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"排量" detail:self.filterCondition.ccName filteType:ccType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"颜色" detail:self.filterCondition.colorName filteType:colorType]];
    
    [self.tableView reloadData];
}

@end
