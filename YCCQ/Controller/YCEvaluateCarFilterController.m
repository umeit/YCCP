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
#import "YCFieldTableViewCell.h"
#import "YCWebViewController.h"

@interface YCEvaluateCarFilterController ()

@property (strong, nonatomic) NSArray *dataList;

@end

@implementation YCEvaluateCarFilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setOKButton];
    
    self.dataList = @[[NSMutableDictionary dictionaryWithDictionary:@{@"title":@"品牌", @"detail": @"选择"}],
                      [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"上牌时间", @"detail": @"选择"}],
                      [NSMutableDictionary dictionaryWithDictionary:@{@"title":@"里程（万）", @"detail": @""}]];
}

#pragma mark - Action

- (void)okButtonPress:(UIButton *)button
{
    NSString *brand = self.dataList[0][@"value"];
    if (!brand.length) {
        return;
    }
    NSString *date = self.dataList[1][@"value"];
    if (!date.length) {
        return;
    }
    NSString *mileage = self.dataList[2][@"value"];
    if (!mileage.length) {
        return;
    }
    
    YCWebViewController *webVC = [self controllerWithStoryBoardID:@"YCWebViewController"];
    webVC.webPageURL = [NSString stringWithFormat:@"http://m.youche.com/service/evaluateresult/?distance=%@&regDate=%@&brandID=%@&seriesID=%@&modelID=%@&callback=evalCallback", mileage, date, [brand substringToIndex:3], [brand substringToIndex:9], brand];
    webVC.navigationItem.title = @"估价结果";
    [self.navigationController pushViewController:webVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSDictionary *dic = self.dataList[indexPath.row];
    
    if (indexPath.row == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"FieldCell" forIndexPath:indexPath];
        YCFieldTableViewCell *fieldCell = (YCFieldTableViewCell *)cell;
        fieldCell.titleLabel.text = dic[@"title"];
        fieldCell.cellField.text = dic[@"detail"];
        
        fieldCell.cellField.delegate = self;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        
        
        cell.textLabel.text = dic[@"title"];
        cell.detailTextLabel.text = dic[@"detail"];
    }
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


#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (IBAction)textFieldEditingChanged:(UITextField *)field
{
    self.dataList[2][@"value"] = field.text;
}

#pragma mark - YCCarFilterConditionDelegate

-(void)selecteConditionFinish:(NSDictionary *)condition filterType:(CarFilterType)filterType
{
    switch (filterType) {
        case ModelType:
        {
            self.dataList[0][@"detail"] = condition[@"CN"];
            self.dataList[0][@"value"] = condition[@"CV"];
        }
            break;
        case yearNumType:
        {
            self.dataList[1][@"detail"] = condition[@"CN"];
            self.dataList[1][@"value"] = condition[@"CV"];
        }
            break;
        default:
            break;
    }
    
    [self.tableView reloadData];
}


#pragma mark - Private

- (void)setOKButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"确 定" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, button.frame.size.width, button.frame.size.height + 40);
    button.backgroundColor = [UIColor colorWithRed:0.96f green:0.29f blue:0.35f alpha:1];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tableView setTableFooterView:button];
    [button addTarget:self action:@selector(okButtonPress:) forControlEvents:UIControlEventTouchUpInside];
}

@end
