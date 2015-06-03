//
//  YCFilterTableViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/3.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCFilterTableViewController.h"

@interface YCFilterTableViewController ()

@property (strong, nonatomic) NSArray *dataList;

@end

@implementation YCFilterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.dataType) {
        case PriceType:
            self.dataList = [self priceList];
            break;
        case CarTypeType:
            self.dataList = [self carTyppList];
            break;
        default:
            break;
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataList[indexPath.row][@"name"];
 
    return cell;
}



#pragma mark - Private

- (NSArray *)priceList
{
    return @[@{@"name": @"不限",    @"value":@""},
             @{@"name": @"5万以下", @"value":@"j1"},
             @{@"name": @"5-8万",   @"value":@"j2"},
             @{@"name": @"8-10万",  @"value":@"j3"},
             @{@"name": @"10-15万", @"value":@"j4"},
             @{@"name": @"15-20万", @"value":@"j5"},
             @{@"name": @"20-30万", @"value":@"j6"},
             @{@"name": @"30-50万", @"value":@"j7"},
             @{@"name": @"50万以上", @"value":@"j8"}];
}

- (NSArray *)carTyppList
{
    return @[@{@"name": @"不限",    @"value":@""},
             @{@"name": @"微型车", @"value":@"weixing"},
             @{@"name": @"小型车",   @"value":@"xiaoxing"},
             @{@"name": @"紧凑型车",  @"value":@"jinchou"},
             @{@"name": @"中型车", @"value":@"zhongxingche"},
             @{@"name": @"中大型车", @"value":@"zhongdaxing"},
             @{@"name": @"豪华车", @"value":@"haohua"},
             @{@"name": @"SUV", @"value":@"suv"},
             @{@"name": @"MPV", @"value":@"mpv"},
             @{@"name": @"跑车", @"value":@"paoche"}];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
