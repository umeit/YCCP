//
//  YCAftermarketTableViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/26.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCAftermarketTableViewController.h"
#import "YCAftermarketEntity.h"
#import "YCAfterMarketCell.h"
#import "ParallaxHeaderView.h"

@interface YCAftermarketTableViewController ()

@property (strong, nonatomic) NSArray *aftermarkets;

@end

@implementation YCAftermarketTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableData];
    
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:@"售后头图"]
                                                                             forSize:CGSizeMake(self.tableView.frame.size.width, 150)];
    
    [self.tableView setTableHeaderView:headerView];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.contentInset = UIEdgeInsetsMake(0., 0., CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [(ParallaxHeaderView *)self.tableView.tableHeaderView refreshBlurViewForNewImage];
//    CGRect oldBounds = self.tableView.bounds;
//    self.tableView.bounds = CGRectMake(oldBounds.origin.x,
//                                       0,
//                                       oldBounds.size.width,
//                                       oldBounds.size.height - 64);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"AftermarketCell";
    YCAfterMarketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    [self configureCell:cell with:self.aftermarkets[indexPath.row]];
    
    return cell;
}

#pragma mark - TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YCAftermarketEntity *aftermarket = self.aftermarkets[indexPath.row];
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",aftermarket.tel];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        [(ParallaxHeaderView *)self.tableView.tableHeaderView
         layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
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

#pragma mark - Private

- (void)configureCell:(YCAfterMarketCell *)cell with:(YCAftermarketEntity *)entity
{
    cell.iconImageView.image = [UIImage imageNamed:entity.imageName];
    cell.nameLabel.text = entity.name;
    cell.rightIconImageVIew.image = [UIImage imageNamed:entity.imageName];
}

- (void)initTableData
{
    YCAftermarketEntity *aftermarket1 = [[YCAftermarketEntity alloc] initWithName:@"优车400"
                                                                              tel:@"400-400-400"
                                                                            image:@"用车急问"];
    
    self.aftermarkets = @[aftermarket1, aftermarket1, aftermarket1, aftermarket1,
                          aftermarket1, aftermarket1, aftermarket1, aftermarket1,
                          aftermarket1, aftermarket1];
}

@end
