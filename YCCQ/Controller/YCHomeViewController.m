//
//  YCHomeViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/15.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCHomeViewController.h"
#import "YCBannerService.h"
#import "YCBaoKuanCollectionViewCell.h"
#import "YCFunctionCollectionViewCell.h"
#import "YCCarService.h"
#import "YCBaoKuanEntity.h"
#import "YCBannerEntity.h"
#import "YCFunctionEntity.h"
#import "AppKeFuLib.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "UIViewController+GViewController.h"
#import "YCWebViewController.h"
#import "YCCarListViewController.h"
#import "YCFilterKeyUtil.h"
#import "UtilDefine.h"
#import "YCEvaluateCarFilterController.h"
#import "MobClick.h"
#import "YCBrandTableViewController.h"
#import "YCBaokuanTableViewController.h"
#import "YCCQ-Swift.h"
#import "YCFilterConditionStore.h"
#import "YCCarFilterConditionEntity.h"
#import "QCAdsView.h"

#define Banner_Row_Index    0
#define Function_Row_Index  1
#define Baokuan_Row_Index   2
#define CarType_Row_Index   3
#define CarBrand_Row_Index  4
#define CarPrice_Row_Index  5

#define PageIndex @"Home"

@interface YCHomeViewController () <UIScrollViewDelegate, UICollectionViewDataSource,
                                    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *banners;
@property (strong, nonatomic) NSArray *baokuans;
@property (strong, nonatomic) UIWebView *callWebView;

@end

@implementation YCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refreshHome:)
                  forControlEvents:UIControlEventValueChanged];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    self.carService = [[YCCarService alloc] init];
    self.bannerService = [[YCBannerService alloc] init];
    
    self.callWebView = [[UIWebView alloc] init];
    [self.view addSubview:self.callWebView];
    
    [self setBanner];
    [self setBaokuan];
    
//    self.functionCollectionView.contentSize = CGSizeMake(CGRectGetWidth(self.functionCollectionView.frame) * 3,
//                                                         CGRectGetHeight(self.functionCollectionView.frame));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:PageIndex];
//    [self.view setNeedsUpdateConstraints];
    [self.bannerView startRoll];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:PageIndex];
    [self.bannerView stopRoll];
}


#pragma mark - Action
- (IBAction)hotButtonPress:(UIButton *)button {
    [self toCarListViewWithKey:[YCFilterKeyUtil hotCarFilterKeyWithButtonTah:button.tag]];
}
- (IBAction)moreSaleCarList:(id)sender {
    [self toCarListViewWithKey:@"ershouche/t37"];
}

- (IBAction)storeButtonPress:(UIButton *)button {
    if (button.tag == 0) {
        [self toWebViewWithURL:[BaseURL stringByAppendingString:@"about/address.shtml?t=app#address03"] controllerTitle:@"店铺地址" showBottomBar:NO];
    }
    else if (button.tag == 1){
        [self toWebViewWithURL:[BaseURL stringByAppendingString:@"about/address.shtml?t=app#address02"] controllerTitle:@"店铺地址" showBottomBar:NO];
    }
    else if (button.tag == 2){
        [self toWebViewWithURL:[BaseURL stringByAppendingString:@"about/address.shtml?t=app#address04"] controllerTitle:@"店铺地址" showBottomBar:NO];
    }
}

- (IBAction)phoneButtonPress:(id)sender {
    [self call:MainPhoneNum];
}

- (void)refreshHome:(id)sender {
    [self setBanner];
    [self setBaokuan];
    
    [self.refreshControl endRefreshing];
}

/** 选择品牌 */
- (IBAction)brandButtonPress:(UIButton *)sender
{
    if (sender.tag == 38) {
        YCBrandTableViewController *vc = [self controllerWithStoryBoardID:@"YCBrandTableViewController"];
        vc.navigationItem.title = @"选择品牌";
        vc.hidesBottomBarWhenPushed = YES;
        vc.useOnlineData = YES;
        vc.conditionType = CarListSimpleFileterConditionType;
        [self.navigationController pushViewController:vc animated:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedBrandFinish) name:@"FilterConditionFinish" object:nil];
    } else {
        [self toCarListViewWithKey:[YCFilterKeyUtil brandFilterKeyWithButtonTag:sender.tag]];
    }
}

/** 选测车型 */
- (IBAction)carTypeButtonPress:(UIButton *)sender
{
    [self toCarListViewWithKey:[YCFilterKeyUtil carTypeWithButtonTag:sender.tag]];
}

/** 选择价格 */
- (IBAction)carPriceButtonPress:(UIButton *)sender
{
    [self toCarListViewWithPriceKey:[YCFilterKeyUtil carPriceFilterKeyWithButtonTag:sender.tag]];
}


#pragma mark - Private

- (YCFunctionEntity *)functionEntityWithIndexPath:(NSIndexPath *)indexPath {
    YCFunctionEntity *functionEntity = nil;
    switch (indexPath.row) {
        case 0:  // 我要买车
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"woyaomaiche" labelText:@"我要买车"];
            break;
        case 1:  // 道路救援
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"jiuyuan" labelText:@"道路救援"];
            break;
        case 2:  // 用车急问
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"yongche" labelText:@"用车急问"];
            break;
        case 3:  // 卖车咨询
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"maiche1" labelText:@"卖车咨询"];
            break;
        case 4:  // 维修咨询
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"weixiu" labelText:@"维修咨询"];
            break;
        case 5:  // 车辆评估
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"pinggu" labelText:@"车辆评估"];
            break;
        case 6:  // 事故咨询
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"shigu" labelText:@"事故咨询"];
            break;
        case 7:  // 门店地址
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"mendian" labelText:@"门店地址"];
            break;
        case 8:  // 代办车险
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"chexian" labelText:@"代办车险"];
            break;
        case 9:  // 预约咨询
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"yuyue" labelText:@"预约咨询"];
            break;
        case 10:  // 今日油价
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"youjia" labelText:@"今日油价"];
            break;
        case 11:  // 预约检测
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"jiance" labelText:@"预约检测"];
            break;
        case 12:  // 上门收车
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"shangmen" labelText:@"上门收车"];
            break;
        case 13:  // 售后咨询
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"shouhou" labelText:@"售后咨询"];
            break;
        case 14:  // 延保服务
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"yanbao" labelText:@"延保服务"];
            break;
        case 15:  // 全部工具
            functionEntity = [[YCFunctionEntity alloc] initWithImageName:@"alltools" labelText:@"全部工具"];
            break;
        default:
            break;
    }
    return functionEntity;
}


- (void)call:(NSString *)tel
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", tel];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
}

- (void)setBanner
{
    [self.bannerService bannersWithBlock:^(NSArray * banners) {
        
        NSMutableArray *bannersPath = [NSMutableArray array];
        [banners enumerateObjectsUsingBlock:^(YCBannerEntity *banner, NSUInteger idx, BOOL *stop) {
            [bannersPath addObject:banner.imageURL.absoluteString];
        }];
        
        self.bannerView.adsImages = bannersPath;
        __weak typeof(self) weakSelf = self;
        [weakSelf.bannerView setImageTouchBlock:^(QCAdsView *adsView, NSInteger index) {
            YCBannerEntity *banner = weakSelf.banners[index];
            if (banner && [banner.linkURL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length) {
                [weakSelf toWebViewWithURL:banner.linkURL controllerTitle:@"详情" showBottomBar:NO];
            }
        }];
        
        self.banners = banners;
    }];
}

- (void)setBaokuan
{
    [self.carService baokuanWithBlock:^(NSArray *baokuans) {
        self.baokuans = baokuans;
        [self.tableView reloadData];
        [self.baokuanCollectionView reloadData];
    }];
}


#pragma mark - Configrue Cell

- (void)configrueFunctionCell:(YCFunctionCollectionViewCell *)functionCell withEntity:(YCFunctionEntity *)entity {
    functionCell.functionImageView.image = [UIImage imageNamed:entity.imageName];
    functionCell.functionLabel.text = entity.labelText;
}

- (void)configrueBaoKuanCell:(YCBaoKuanCollectionViewCell *)cell entity:(YCBaoKuanEntity *)entity
{
    [cell.carImageView setImageWithURL:entity.imageURL];
    cell.carSeriesLabel.text = entity.series;
    cell.carPriceLabel.text = entity.price;
    cell.oldPriceLabel.text = [NSString stringWithFormat:@"优车原价%@万", entity.oldPrice];
    if (iPhone5 || iPhone4) {
        cell.carPriceLabel.font = [UIFont systemFontOfSize:16];
        cell.oldPriceLabel.font = [UIFont systemFontOfSize:10];
    }
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[YCBaokuanTableViewController class]]) {
        YCBaokuanTableViewController *controller = (YCBaokuanTableViewController *)segue.destinationViewController;
        controller.baokuans = self.baokuans;
    }
    else if ([segue.identifier isEqualToString:@"ToToolsList"]) {
        UIViewController *vc = segue.destinationViewController;
        vc.hidesBottomBarWhenPushed = YES;
    }
}

- (void)toConsultationViewControllerWithWorkgroup:(NSString *)key title:(NSString *)title
{
    UIFont *font = [UIFont boldSystemFontOfSize: 17];
    NSDictionary *attributes = @{NSFontAttributeName: font};
    CGSize size = [title sizeWithAttributes:attributes];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.text = title;
    label.font = font;
    label.textColor = [UIColor whiteColor];
    label.minimumScaleFactor = 1;
    label.textAlignment = NSTextAlignmentCenter;

    [[AppKeFuLib sharedInstance] pushChatViewController:self.navigationController
                                      withWorkgroupName:key
                                 hideRightBarButtonItem:YES
                             rightBarButtonItemCallback:nil
                                 showInputBarSwitchMenu:NO
                                  withLeftBarButtonItem:nil
                                          withTitleView:label
                                 withRightBarButtonItem:nil
                                        withProductInfo:nil
                             withLeftBarButtonItemColor:nil
                               hidesBottomBarWhenPushed:YES
                                     showHistoryMessage:YES
                                           defaultRobot:NO
                                    withKefuAvatarImage:nil
                                    withUserAvatarImage:nil
                             httpLinkURLClickedCallBack:nil];
}

/** 加载车辆估价视图 */
- (void)toEvaluateCar
{
    YCEvaluateCarFilterController *filterViewController = (YCEvaluateCarFilterController *)[self controllerWithStoryBoardID:@"YCEvaluateCarFilterController"];
    [self.navigationController pushViewController:filterViewController animated:YES];
}

/** 显示车辆列表，根据选择的筛选条件 */
- (void)toCarListViewWithKey:(NSString *)key
{
    [self toCarListViewWithCarListURL:[NSString stringWithFormat:@"%@%@/", BaseURL, key]];
}

/** 显示车辆列表，根据选择的价格筛选条件 */
- (void)toCarListViewWithPriceKey:(NSString *)priceKey
{
    [self toCarListViewWithCarListURL:[NSString stringWithFormat:@"%@ershouche/%@", BaseURL, priceKey]];
}

- (void)toCarListViewWithCarListURL:(NSString *)url
{
    YCCarListViewController *carListViewController = (YCCarListViewController *)[self controllerWithStoryBoardID:@"YCCarListViewController"];
    carListViewController.carListURL = url;
    carListViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carListViewController animated:YES];
}

- (void)toWebViewWithURL:(NSString *)url controllerTitle:(NSString *)title showBottomBar:(BOOL)b
{
    YCWebViewController *webViewController = (YCWebViewController *)[self controllerWithStoryBoardID:@"YCWebViewController"];
    webViewController.webPageURL = url;
    webViewController.navigationItem.title = title;
    webViewController.showBottomBar = b;
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)selectedBrandFinish
{
    YCCarFilterConditionEntity *carFilterConditionEntity = [YCFilterConditionStore sharedInstance].carListFilterCondition;
    NSString *key = carFilterConditionEntity.brandValue;
    YCCarListViewController *carListViewController = (YCCarListViewController *)[self controllerWithStoryBoardID:@"YCCarListViewController"];
    carListViewController.carListURL = [NSString stringWithFormat:@"%@%@/", BaseURL, key];
    carListViewController.hidesBottomBarWhenPushed = YES;
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [viewControllers insertObject:carListViewController atIndex:viewControllers.count-1];
    [self.navigationController setViewControllers:viewControllers];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.functionCollectionView) {
        if (IS_OS_9_OR_LATER) {
            [self.functionCollectionView reloadData];
        }
        NSInteger pageIndex = scrollView.contentOffset.x / (CGRectGetWidth(scrollView.frame) - 16);
        self.functionPageControl.currentPage = pageIndex;
    }
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.functionCollectionView) {
        return 16;
    }
    else if (collectionView == self.baokuanCollectionView) {
        return self.baokuans.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.baokuanCollectionView) {
        static NSString *collectionCellID = @"BaoKuaiCell";
        
        YCBaoKuanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
        
        if (indexPath.row == self.baokuans.count) {
            return cell;
        }
        
        YCBaoKuanEntity *baoKuanEntity = self.baokuans[indexPath.row];
        
        [self  configrueBaoKuanCell:cell entity:baoKuanEntity];
        return cell;
    }
    else if (collectionView == self.functionCollectionView) {
        static NSString *functionCellID   = @"FunctionCell";
        YCFunctionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:functionCellID forIndexPath:indexPath];
        YCFunctionEntity *functionEntity = [self functionEntityWithIndexPath:indexPath];
        
        [self configrueFunctionCell:cell withEntity:functionEntity];
        return cell;
    }
    return nil;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.baokuanCollectionView) {
        YCBaoKuanEntity *baokuan = self.baokuans[indexPath.row];
        if (baokuan) {
            NSString *carURL = [NSString stringWithFormat:@"%@?t=app", [baokuan.linkURL stringByReplacingOccurrencesOfString:@"www"
                                                                                                                  withString:@"m"]];
            [self toWebViewWithURL:carURL controllerTitle:@"车辆详情" showBottomBar:YES];
        }
    }
    else if (collectionView == self.functionCollectionView) {
        switch (indexPath.row) {
            case 0:  // 我要买车
                [self toCarListViewWithCarListURL:[BaseURL stringByAppendingString:@"ershouche/"]];
                break;
            case 1:  // 道路救援
                [self call:@"400-835-6650"];
                break;
            case 2:  // 用车急问
                [self toConsultationViewControllerWithWorkgroup:@"usecar" title:@"用车急问"];
                break;
            case 3:  // 卖车咨询
                [self toConsultationViewControllerWithWorkgroup:@"sellcar" title:@"卖车咨询"];
                break;
            case 4:  // 维修咨询
                [self toConsultationViewControllerWithWorkgroup:@"repair" title:@"维修咨询"];
                break;
            case 5:  // 车辆评估
                [self toEvaluateCar];
                break;
            case 6:  // 事故咨询
                [self toConsultationViewControllerWithWorkgroup:@"accident" title:@"事故咨询"];
                break;
            case 7:  // 门店地址
                [self toWebViewWithURL:[BaseURL stringByAppendingString:@"about/address.shtml?t=app"] controllerTitle:@"店铺地址" showBottomBar:NO];
                break;
            case 8:  // 代办车险
                [self toWebViewWithURL:[BaseURL stringByAppendingString:@"service/insurance?t=app"] controllerTitle:@"代办车险" showBottomBar:NO];
                break;
            case 9:  // 预约咨询
                [self call:@"13718233424"];
                break;
            case 10:  // 今日油价
                [self pushViewControllerWithStoryBoardID:@"YCOilPriceViewController" title:@"今日油价"];
                break;
            case 11:  // 预约检测
                [self toWebViewWithURL:[BaseURL stringByAppendingString:@"service/evaluate?t=app"] controllerTitle:@"预约检测" showBottomBar:NO];
                break;
            case 12:  // 上门收车
                [self toWebViewWithURL:[BaseURL stringByAppendingString:@"service/salecar?t=app"] controllerTitle:@"上门收车" showBottomBar:NO];
                break;
            case 13:  // 售后咨询
                [self toConsultationViewControllerWithWorkgroup:@"aftersales" title:@"售后咨询"];
                break;
            case 14:  // 延保服务
                [self toWebViewWithURL:[BaseURL stringByAppendingString:@"service/warranty.shtml?t=app"]
                       controllerTitle:@"延保服务"
                         showBottomBar:NO];
                break;
            case 15:  // 全部工具
                [self pushViewControllerWithStoryBoardID:@"YCToolListViewController" title:@"工具列表" HideBottonBar:YES];
                break;
            default:
                break;
        }
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.baokuanCollectionView) {  // 爆款
        return [HomeLayoutUtil baokuanCollectionCellSizeWithIndexPath:indexPath];
    }
    else if (collectionView == self.functionCollectionView) {  // 功能按钮
        return [HomeLayoutUtil functionCollectionCellSizeWithIndexPath:indexPath];
    }
    return CGSizeMake(0, 0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.functionCollectionView) {
        if (iPhone5 || iPhone4) {
            return UIEdgeInsetsMake(8, 0, 12, 14);
        }
        else {
            return UIEdgeInsetsMake(8, 8, 12, 8);
        }
    }
    return UIEdgeInsetsMake(8, 14, 12, 14);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (collectionView == self.functionCollectionView) {
        return 4.f;
    }
    return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 16.f;
}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [HomeLayoutUtil homeTableRowHightWithIndexPath:indexPath baokuanCount:self.baokuans.count];
}


#pragma mark - YCCarFilterConditionDelegate

- (void)selecteConditionFinish:(NSDictionary *)condition filterType:(CarFilterType)filterType
{
    YCCarListViewController *carListViewController = (YCCarListViewController *)[self controllerWithStoryBoardID:@"YCCarListViewController"];
    carListViewController.carListURL = [NSString stringWithFormat:@"%@%@/", BaseURL, condition[@"CV"]];
    carListViewController.hidesBottomBarWhenPushed = YES;
    NSMutableArray *controllers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [controllers setObject:carListViewController atIndexedSubscript:1];
    [self.navigationController setViewControllers:controllers];
}

//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    self.functionScrolViewConstraintWidth.constant = CGRectGetWidth([UIScreen mainScreen].bounds) * 2;
//}

@end
