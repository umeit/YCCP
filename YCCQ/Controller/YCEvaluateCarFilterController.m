//
//  YCEvaluateCarFilterController.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/10.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCEvaluateCarFilterController.h"
#import "YCBrandTableViewController.h"
#import "YCFilterTableViewController.h"
#import "UIViewController+GViewController.h"

@interface YCEvaluateCarFilterController ()

@property (strong, nonatomic) NSArray *dataList;

@end

@implementation YCEvaluateCarFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = @[[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"品牌", @"detail": @"选择"}],
                      @{@"title":@"上牌时间", @"detail": @"选择"},
                      @{@"title":@"里程（万）", @"detail": @"选择"}];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *dic = self.dataList[indexPath.row];
    cell.textLabel.text = dic[@"title"];
    cell.detailTextLabel.text = dic[@"detail"];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            YCBrandTableViewController *vc = (YCBrandTableViewController *)[self controllerWithStoryBoardID:@"YCBrandTableViewController"];
            vc.delegate = self;
            vc.dataType = BrandType;
            vc.useOnlineData = NO;
            vc.continuousMode = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1:
        {
            YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
            vc.delegate = self;
            vc.dataType = yearNumType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}


#pragma mark - YCCarFilterConditionDelegate

-(void)selecteConditionFinish:(NSDictionary *)condition filterType:(CarFilterType)filterType
{
    self.dataList[0][@"detail"] = condition[@"CN"];
    [self.tableView reloadData];
}
@end
