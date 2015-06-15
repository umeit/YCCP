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

#define Banner_Row_Index    0
#define Function_Row_Index  1
#define Baokuan_Row_Index   2
#define CarType_Row_Index   3
#define CarBrand_Row_Index  4

@interface YCHomeViewController () <UIScrollViewDelegate, UICollectionViewDataSource,
                                    UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *banners;
@property (strong, nonatomic) NSArray *baokuans;

@end

@implementation YCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.carService = [[YCCarService alloc] init];
    self.bannerService = [[YCBannerService alloc] init];
    
    [self setBanner];
    [self setBaokuan];
}

#pragma mark - Action
- (IBAction)functionButtonPress:(UIButton *)button {
    switch (button.tag) {
        case 31:
        {
            [self toConsultationViewControllerWithWorkgroup:@"usecar"];
        }
            break;
        case 36:
        {
            [self toEvaluateCar];
        }
            break;
        default:
            break;
    }
    
}

// 进入 banner 所指链接
- (void)bannerDidTouch:(UIButton *)bannerButton {
    YCBannerEntity *bannner = self.banners[bannerButton.tag];
    if (bannner) {
        [self toWebViewWithURL:bannner.linkURL];
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

- (void)toConsultationViewControllerWithWorkgroup:(NSString *)key
{
    [[AppKeFuLib sharedInstance] pushChatViewController:self.navigationController
                                      withWorkgroupName:key
                                 hideRightBarButtonItem:YES
                             rightBarButtonItemCallback:nil
                                 showInputBarSwitchMenu:NO
                                  withLeftBarButtonItem:nil
                                          withTitleView:nil
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

- (void)toWebViewWithURL:(NSString *)url
{
    YCWebViewController *webViewController = (YCWebViewController *)[self controllerWithStoryBoardID:@"YCWebViewController"];
    webViewController.webPageURL = url;
    [self.navigationController pushViewController:webViewController animated:YES];
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
        [self.baokuanCollectionView reloadData];
    }];
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
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionCellID = @"BaoKuaiCell";
    YCBaoKuanCollectionViewCell *cell = (YCBaoKuanCollectionViewCell *)
    [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    
    YCBaoKuanEntity *baoKuanEntity = self.baokuans[indexPath.row];
    
    CGPoint origin = cell.frame.origin;
    CGSize  size   = cell.frame.size;
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        cell.frame = CGRectMake(origin.x, origin.y, 160, size.height);
    }
    else if (indexPath.row == 2 || indexPath.row == 3) {
        cell.frame = CGRectMake(160, origin.y, 160, size.height);
    }
    
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
        [self toWebViewWithURL:baokuan.linkURL];
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPhone4) {
        return CGSizeMake(190, 160);
    }
    else if (iPhone6) {
        return CGSizeMake(380, 160);
    }
    else if (iPhone6Plus) {
        
    }
    
    return CGSizeMake(190, 160);
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPhone4) {
        if (indexPath.row == Banner_Row_Index) {
            return 150.f;
        }
        if (indexPath.row == Function_Row_Index) {
            return 241.f;
        }
        if (indexPath.row == Baokuan_Row_Index) {
            return 340.f;
        }
        if (indexPath.row == CarType_Row_Index) {
            return 100.f;
        }
        if (indexPath.row == CarBrand_Row_Index) {
            return 100.f;
        }
    }
    else if (iPhone6) {
        if (indexPath.row == Banner_Row_Index) {
            return 170.f;
        }
        if (indexPath.row == Function_Row_Index) {
            return 241.f;
        }
        if (indexPath.row == Baokuan_Row_Index) {
            return 380.f;
        }
        if (indexPath.row == CarType_Row_Index) {
            return 100.f;
        }
        if (indexPath.row == CarBrand_Row_Index) {
            return 120.f;
        }
    }
    return 44.f;
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    UITableViewCell *cell;
//    
//    if (indexPath.row == 0) {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"BannerCell"];
//    }
//    else if (indexPath.row == 1) {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"FunctionCell"];
//    }
//    else {
//        cell = [tableView dequeueReusableCellWithIdentifier:@"BaoKuanCell"];
//    }
//    
//    return cell;
//}


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
