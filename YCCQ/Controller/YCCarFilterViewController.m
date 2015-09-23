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
#import "YCCarFilterConditionEntity.h"
#import "YCFilterConditionStore.h"

@interface YCCarFilterViewController ()
@property (strong, nonatomic) NSMutableArray *cellContentList;
@property (nonatomic) NSInteger brandID;
@property (nonatomic) NSInteger seriesID;
@end

@implementation YCCarFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setOKButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCellViews) name:@"FilterConditionUpdate" object:nil];
    
    [self updateCellViews];
}

#pragma mark - Action

- (void)okButtonPress:(UIButton *)button {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FilterConditionFinish" object:nil];
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
            vc.dataType = BrandType;
            vc.useOnlineData = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case SeriesType:
        {
            YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
            vc.dataType = SeriesType;
            vc.useOnlineData = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ModelType:
        {
            YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
            vc.dataType = ModelType;
            vc.useOnlineData = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case PriceType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.dataType = PriceType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case CarTypeType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.dataType = CarTypeType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ccType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.dataType = ccType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case gearboxType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.dataType = gearboxType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case mileageType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.dataType = mileageType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case yearType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.dataType = yearType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case colorType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.dataType = colorType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case storeType:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.dataType = storeType;
            [self.navigationController pushViewController:vc animated:YES];
        }
        default:
            break;
    }
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

/** 更新列表数据源 */
- (void)updateCellViews
{
    YCCarFilterConditionEntity *currentFilterCondition = [YCFilterConditionStore sharedInstance].carListFilterCondition;
    
    self.cellContentList = [NSMutableArray array];
    
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"品牌" detail:currentFilterCondition.brandName filteType:BrandType]];
    if (currentFilterCondition.brandValue.length) {
        [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"车系" detail:currentFilterCondition.seriesName filteType:SeriesType]];
        if (currentFilterCondition.seriesValue.length) {
            [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"车型" detail:currentFilterCondition.modelName filteType:ModelType]];
        }
    }
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"价格" detail:currentFilterCondition.priceName filteType:PriceType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"类型" detail:currentFilterCondition.carTypeName filteType:CarTypeType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"门店" detail:currentFilterCondition.storeName filteType:storeType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"车龄" detail:currentFilterCondition.yearName filteType:yearType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"里程" detail:currentFilterCondition.mileageName filteType:mileageType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"变速箱" detail:currentFilterCondition.gearboxName filteType:gearboxType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"排量" detail:currentFilterCondition.ccName filteType:ccType]];
    [self.cellContentList addObject:[[YCFilterCellDataEntity alloc] initWithTitile:@"颜色" detail:currentFilterCondition.colorName filteType:colorType]];
    
    [self.tableView reloadData];
}

@end
