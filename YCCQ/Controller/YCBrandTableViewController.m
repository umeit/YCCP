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
        
        [self.carService brandsFromOnSell:^(NSArray *brands) {
            [self hideLodingView];
            
            self.brands = brands;
            [self.tableView reloadData];
        }];
    }
}

- (IBAction)brandButtonPress:(UIButton *)button
{
    NSString *brandVlue = [YCCarUtil brandWithTagForFilter:button.tag];
    [self.delegate selecteConditionFinish:@{@"CK": @"Brand",
                                            @"CN": button.titleLabel.text,
                                            @"CV": brandVlue}];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.brands.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    NSDictionary *brandInfo = self.brands[section - 1];
    NSArray *brands = [brandInfo objectForKey:@"key2"];
    return brands.count;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0 && indexPath.row == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"BrandCommonCell" forIndexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BrandCell" forIndexPath:indexPath];
    cell.textLabel.text = self.brands[indexPath.section - 1][@"key2"][indexPath.row][@"title"];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"热门车辆";
    }
    if (section == 1) {
        return @"";
    }
    return self.brands[section - 1][@"key1"];
}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 104;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
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
