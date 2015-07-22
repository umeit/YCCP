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
@property (strong, nonatomic) UIWebView *callWebView;

@end

@implementation YCAftermarketTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableData];
    
    ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:[UIImage imageNamed:@"shouhoubanner"]
                                                                             forSize:CGSizeMake(self.tableView.frame.size.width, 150)];
    
    [self.tableView setTableHeaderView:headerView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0., 0., CGRectGetHeight(self.tabBarController.tabBar.frame), 0);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [(ParallaxHeaderView *)self.tableView.tableHeaderView refreshBlurViewForNewImage];
    
    [self.callWebView removeFromSuperview];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 23;
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
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",aftermarket.tel];
    self.callWebView = [[UIWebView alloc] init];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:self.callWebView];
}


#pragma mark - ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView) {
        [(ParallaxHeaderView *)self.tableView.tableHeaderView
         layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}


#pragma mark - Private

- (void)configureCell:(YCAfterMarketCell *)cell with:(YCAftermarketEntity *)entity
{
    cell.iconImageView.image = [UIImage imageNamed:entity.imageName];
    cell.iconImageView.contentMode = UIViewContentModeCenter;
    cell.nameLabel.text = entity.name;
    cell.rightIconImageVIew.image = [UIImage imageNamed:@"p"];
}

- (void)initTableData
{
    YCAftermarketEntity *aftermarket1 = [[YCAftermarketEntity alloc] initWithName:@"24小时道路救援"
                                                                              tel:@"18500581075"
                                                                            image:@"p_jiuyuan"];
    
    YCAftermarketEntity *aftermarket2 = [[YCAftermarketEntity alloc] initWithName:@"预约报修"
                                                                              tel:@"4000-689-966"
                                                                            image:@"p_baoxiu"];
    
    YCAftermarketEntity *aftermarket3 = [[YCAftermarketEntity alloc] initWithName:@"预约检测"
                                                                              tel:@"13718233424"
                                                                            image:@"p_jiance"];
    
    YCAftermarketEntity *aftermarket4 = [[YCAftermarketEntity alloc] initWithName:@"热线投诉"
                                                                              tel:@"4000-689-966"
                                                                            image:@"p_tousu"];
    
    YCAftermarketEntity *aftermarket5 = [[YCAftermarketEntity alloc] initWithName:@"中国人民财产保险"
                                                                              tel:@"95518"
                                                                            image:@"landian"];
    
    YCAftermarketEntity *aftermarket6 = [[YCAftermarketEntity alloc] initWithName:@"中国太平洋财产保险"
                                                                              tel:@"95500"
                                                                            image:@"landian"];
    
    YCAftermarketEntity *aftermarket7 = [[YCAftermarketEntity alloc] initWithName:@"中国平安财产保险"
                                                                              tel:@"95512"
                                                                            image:@"landian"];
    
    YCAftermarketEntity *aftermarket8 = [[YCAftermarketEntity alloc] initWithName:@"中华联合财产保险"
                                                                              tel:@"95585"
                                                                            image:@"landian"];
    
    YCAftermarketEntity *aftermarket9 = [[YCAftermarketEntity alloc] initWithName:@"中国大地财产保险"
                                                                              tel:@"95590"
                                                                            image:@"landian"];
    
    YCAftermarketEntity *aftermarket10 = [[YCAftermarketEntity alloc] initWithName:@"天安保险"
                                                                              tel:@"95505"
                                                                            image:@"landian"];
    YCAftermarketEntity *aftermarket11 = [[YCAftermarketEntity alloc] initWithName:@"大众保险"
                                                                              tel:@"96012345"
                                                                            image:@"landian"];
    YCAftermarketEntity *aftermarket12 = [[YCAftermarketEntity alloc] initWithName:@"华泰财产保险"
                                                                              tel:@"95509"
                                                                            image:@"landian"];
    YCAftermarketEntity *aftermarket13 = [[YCAftermarketEntity alloc] initWithName:@"永安财产保险"
                                                                              tel:@"95502"
                                                                            image:@"landian"];
    YCAftermarketEntity *aftermarket14 = [[YCAftermarketEntity alloc] initWithName:@"华安财产保险"
                                                                              tel:@"95556"
                                                                            image:@"landian"];
    YCAftermarketEntity *aftermarket15 = [[YCAftermarketEntity alloc] initWithName:@"安邦财产保险"
                                                                              tel:@"95569"
                                                                            image:@"landian"];
    YCAftermarketEntity *aftermarket16 = [[YCAftermarketEntity alloc] initWithName:@"阳光财产保险"
                                                                              tel:@"95510"
                                                                            image:@"landian"];
    YCAftermarketEntity *aftermarket17 = [[YCAftermarketEntity alloc] initWithName:@"中银保险"
                                                                              tel:@"400-6995566"
                                                                            image:@"landian"];
    YCAftermarketEntity *aftermarket18 = [[YCAftermarketEntity alloc] initWithName:@"永诚财产保险"
                                                                              tel:@"021-51105888"
                                                                            image:@"landian"];
    YCAftermarketEntity *aftermarket19 = [[YCAftermarketEntity alloc] initWithName:@"太平汽车保险"
                                                                              tel:@"4006706666"
                                                                            image:@"landian"];
    
    
    
    YCAftermarketEntity *aftermarket20 = [[YCAftermarketEntity alloc] initWithName:@"急救电话 120"
                                                                              tel:@"120"
                                                                            image:@"hongdian"];
    
    YCAftermarketEntity *aftermarket21 = [[YCAftermarketEntity alloc] initWithName:@"交警电话 122"
                                                                              tel:@"122"
                                                                            image:@"hongdian"];
    
    YCAftermarketEntity *aftermarket22 = [[YCAftermarketEntity alloc] initWithName:@"火警电话 119"
                                                                              tel:@"119"
                                                                            image:@"hongdian"];
    
    YCAftermarketEntity *aftermarket23 = [[YCAftermarketEntity alloc] initWithName:@"报警电话 110"
                                                                              tel:@"110"
                                                                            image:@"hongdian"];
    
    self.aftermarkets = @[aftermarket1, aftermarket2, aftermarket3, aftermarket4,
                          aftermarket5, aftermarket6, aftermarket7, aftermarket8,
                          aftermarket9, aftermarket10, aftermarket11, aftermarket12,
                          aftermarket13, aftermarket14, aftermarket15, aftermarket16,
                          aftermarket17, aftermarket18, aftermarket19, aftermarket20,
                          aftermarket21, aftermarket22, aftermarket23];
}

@end
