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
#import "YCCarService.h"
#import "YCBaoKuanEntity.h"
#import "YCBannerEntity.h"
#import "AppKeFuLib.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"
#import "UIViewController+GViewController.h"
#import "YCWebViewController.h"
#import "YCCarListViewController.h"
#import "YCCarUtil.h"
#import "UtilDefine.h"
#import "YCEvaluateCarFilterController.h"
#import "MobClick.h"

#define Banner_Row_Index    0
#define Function_Row_Index  1
#define Baokuan_Row_Index   2
#define CarType_Row_Index   3
#define CarBrand_Row_Index  4

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
    
    [self setBanner];
    [self setBaokuan];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [MobClick beginLogPageView:PageIndex];
}

- (void)viewWillDisappear:(BOOL)animated {
    [MobClick endLogPageView:PageIndex];
    
    [self.callWebView removeFromSuperview];
    self.callWebView = nil;
    
    [super viewWillDisappear:animated];
}


#pragma mark - Action
- (IBAction)phoneButtonPress:(id)sender
{
    [self call:MainPhoneNum];
}

- (void)refreshHome:(id)sender
{
    [self setBanner];
    [self setBaokuan];
    
    [self.refreshControl endRefreshing];
}

- (IBAction)functionButtonPress:(UIButton *)button {
    switch (button.tag) {
        case 31:  // 用车急问
            [self toConsultationViewControllerWithWorkgroup:@"usecar" title:@"用车急问"];
            break;
        case 32:  // 维修咨询
            [self toConsultationViewControllerWithWorkgroup:@"repair" title:@"维修咨询"];
            break;
        case 33:  // 事故咨询
            [self toConsultationViewControllerWithWorkgroup:@"accident" title:@"事故咨询"];
            break;
        case 34:  // 道路救援
            [self call:@"18500581075"];
            break;
        case 35:  // 卖车咨询
            [self toConsultationViewControllerWithWorkgroup:@"sellcar" title:@"卖车咨询"];
            break;
        case 36:  // 车辆评估
            [self toEvaluateCar];
            break;
        case 37:  // 代办车险
            [self toWebViewWithURL:@"http://m.youche.com/service/insurance?t=app"
                   controllerTitle:@"代办车险"];
            break;
        case 38:  // 今日油价
            [self pushViewControllerWithStoryBoardID:@"YCOilPriceViewController" title:@"今日油价"];
            break;
        case 39:  // 上门收车
            [self toWebViewWithURL:@"http://m.youche.com/service/salecar?t=app"
                   controllerTitle:@"上门收车"];
            break;
        case 40:  // 预约检测
            [self toWebViewWithURL:@"http://m.youche.com/service/evaluate?t=app"
                   controllerTitle:@"预约检测"];
            break;
        case 41:  // 延保服务
            [self toWebViewWithURL:@"http://m.youche.com/service/warranty.shtml?t=app"
                   controllerTitle:@"延保服务"];
            break;
        case 42:  // 全部工具
            break;
        default:
            [self showCustomText:@"功能暂未开通" delay:1.3];
            break;
    }
    
}

// 进入 banner 所指链接
- (void)bannerDidTouch:(UIButton *)bannerButton {
    YCBannerEntity *bannner = self.banners[bannerButton.tag];
    if (bannner) {
        [self toWebViewWithURL:bannner.linkURL controllerTitle:@"详情"];
    }
}

- (IBAction)brandButtonPress:(UIButton *)sender
{
    [self toCarListViewWithKey:[YCCarUtil brandWithTag:sender.tag]];
}

- (IBAction)carTypeButtonPress:(UIButton *)sender
{
    [self toCarListViewWithKey:[YCCarUtil carTypeWithTag:sender.tag]];
}


#pragma mark - Private

- (void)call:(NSString *)tel
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", tel];
    self.callWebView = [[UIWebView alloc] init];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:self.callWebView];
}

- (void)setBanner
{
    [self.bannerService bannersWithBlock:^(NSArray * banners) {
        // 往 ScrollView 中添加图片
        [banners enumerateObjectsUsingBlock:^(YCBannerEntity *banner, NSUInteger idx, BOOL *stop) {
            UIButton *button = [[UIButton alloc] initWithFrame:
                                CGRectMake(CGRectGetWidth(self.bannerScrollView.frame) * idx,
                                           0,
                                           CGRectGetWidth(self.bannerScrollView.frame),
                                           CGRectGetHeight(self.bannerScrollView.frame))];
            button.contentMode = UIViewContentModeScaleAspectFill;
            [button setBackgroundImageForState:UIControlStateNormal withURL:banner.imageURL];
            [button addTarget:self
                       action:@selector(bannerDidTouch:)
             forControlEvents:UIControlEventTouchUpInside];
            button.tag = idx;
            [self.bannerScrollView addSubview:button];
            
            // 图片的数量
            NSInteger imagesCount = [banners count];
            self.bannerPageControl.numberOfPages = imagesCount;
            // ScrollView 的大小
            self.bannerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bannerScrollView.frame) * imagesCount,
                                                           CGRectGetHeight(self.bannerScrollView.frame));
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


#pragma mark - Navigation

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

// 加载车辆估价视图
- (void)toEvaluateCar
{
    YCEvaluateCarFilterController *filterViewController = (YCEvaluateCarFilterController *)[self controllerWithStoryBoardID:@"YCEvaluateCarFilterController"];
    [self.navigationController pushViewController:filterViewController animated:YES];
}

- (void)toCarListViewWithKey:(NSString *)key
{
    YCCarListViewController *carListViewController = (YCCarListViewController *)[self controllerWithStoryBoardID:@"YCCarListViewController"];
    carListViewController.carListURL = [NSString stringWithFormat:@"http://m.youche.com/%@/", key];
    carListViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carListViewController animated:YES];
}

- (void)toWebViewWithURL:(NSString *)url controllerTitle:(NSString *)title
{
    YCWebViewController *webViewController = (YCWebViewController *)[self controllerWithStoryBoardID:@"YCWebViewController"];
    webViewController.webPageURL = url;
    webViewController.navigationItem.title = title;
    [self.navigationController pushViewController:webViewController animated:YES];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.bannerPageControl.currentPage = pageIndex;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.baokuans.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionCellID = @"BaoKuaiCell";
    YCBaoKuanCollectionViewCell *cell = (YCBaoKuanCollectionViewCell *)
    [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    if (indexPath.row == self.baokuans.count) {
        return cell;
    }
    
    YCBaoKuanEntity *baoKuanEntity = self.baokuans[indexPath.row];
    
    [self  configrueBaoKuanCell:cell entity:baoKuanEntity];
    return cell;
}

- (void)configrueBaoKuanCell:(YCBaoKuanCollectionViewCell *)cell entity:(YCBaoKuanEntity *)entity
{
    [cell.carImageView setImageWithURL:entity.imageURL];
    cell.carSeriesLabel.text = entity.series;
    cell.carPriceLabel.text = entity.price;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YCBaoKuanEntity *baokuan = self.baokuans[indexPath.row];
    if (baokuan) {
        NSString *carURL = [NSString stringWithFormat:@"%@?t=app", [baokuan.linkURL stringByReplacingOccurrencesOfString:@"www" withString:@"m"]];
        [self toWebViewWithURL:carURL controllerTitle:@"爆款车辆"];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPhone4 || iPhone5 || iPad_Retina) {
        return CGSizeMake(150, 150);
    }
    else if (iPhone6) {
        return CGSizeMake(170, 170);
    }
    else if (iPhone6Plus_Simulator) {
        return CGSizeMake(190, 180);
    }
    else if (iPhone6Plus) {
        return CGSizeMake(174, 180);
    }
    
    return CGSizeMake(150, 160);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.f;
}


#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPhone4 || iPhone5) {
        if (indexPath.row == Banner_Row_Index) {
            return 150.f;
        }
        if (indexPath.row == Function_Row_Index) {
            return 210.f;
        }
        if (indexPath.row == Baokuan_Row_Index) {
            return 366.f;
        }
        if (indexPath.row == CarType_Row_Index) {
            return 116.f;
        }
        if (indexPath.row == CarBrand_Row_Index) {
            return 154.f;
        }
    }
    else if (iPhone6) {
        if (indexPath.row == Banner_Row_Index) {
            return 170.f;
        }
        if (indexPath.row == Function_Row_Index) {
            return 250.f;
        }
        if (indexPath.row == Baokuan_Row_Index) {
            return self.baokuans.count <= 2 ? 223.f : 406.f;
        }
        if (indexPath.row == CarType_Row_Index) {
            return 116.f;
        }
        if (indexPath.row == CarBrand_Row_Index) {
            return 186.f;
        }
    }
    else if (iPhone6Plus_Simulator) {
        if (indexPath.row == Banner_Row_Index) {
            return 170.f;
        }
        if (indexPath.row == Function_Row_Index) {
            return 280.f;
        }
        if (indexPath.row == Baokuan_Row_Index) {
            return 424.f;
        }
        if (indexPath.row == CarType_Row_Index) {
            return 110.f;
        }
        if (indexPath.row == CarBrand_Row_Index) {
            return 196.f;
        }
    }
    else if (iPad_Retina) {
        if (indexPath.row == Banner_Row_Index) {
            return 150.f;
        }
        if (indexPath.row == Function_Row_Index) {
            return 210.f;
        }
        if (indexPath.row == Baokuan_Row_Index) {
            return 382.f;
        }
        if (indexPath.row == CarType_Row_Index) {
            return 116.f;
        }
        if (indexPath.row == CarBrand_Row_Index) {
            return 154.f;
        }
    }
    else if (iPhone6Plus) {
        if (indexPath.row == Banner_Row_Index) {
            return 170.f;
        }
        if (indexPath.row == Function_Row_Index) {
            return 250.f;
        }
        if (indexPath.row == Baokuan_Row_Index) {
            return 424.f;
        }
        if (indexPath.row == CarType_Row_Index) {
            return 110.f;
        }
        if (indexPath.row == CarBrand_Row_Index) {
            return 196.f;
        }
    }
    
    return 44.f;
}

@end
