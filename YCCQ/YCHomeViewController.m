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

@interface YCHomeViewController () <UIScrollViewDelegate, UICollectionViewDataSource>

@end

@implementation YCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.carService = [[YCCarService alloc] init];
    self.bannerService = [[YCBannerService alloc] init];
    
    [self setBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma -mark Action

- (IBAction)talkButtonPress:(id)sender {
    [[AppKeFuLib sharedInstance] pushChatViewController:self.navigationController
                                      withWorkgroupName:@"usecar"
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

#pragma -mark Private

- (void)setBanner
{
    [self.bannerService bannersWithBlock:^(NSArray * banners) {
        // 往 ScrollView 中添加图片
        [banners enumerateObjectsUsingBlock:^(YCBannerEntity *banner, NSUInteger idx, BOOL *stop) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:
                                      CGRectMake(CGRectGetWidth(self.bannerScrollView.frame) * idx,
                                                 0,
                                                 CGRectGetWidth(self.bannerScrollView.frame),
                                                 CGRectGetHeight(self.bannerScrollView.frame))];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [imageView setImageWithURL:banner.imageURL];
#warning 以后要改成 Button
            [self.bannerScrollView addSubview:imageView];
        }];
        
        NSInteger imagesCount = [banners count];
        // 图片的数量
        self.bannerPageControl.numberOfPages = imagesCount;
        // ScrollView 的大小
        self.bannerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bannerScrollView.frame) * imagesCount, CGRectGetHeight(self.bannerScrollView.frame));
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
    
    
    YCBaoKuanEntity *baoKuanEntity = [self.carService baoKuanCarAtIndex:indexPath.row];
    [self  configrueBaoKuanCell:cell entity:baoKuanEntity];
    return cell;
}

- (void)configrueBaoKuanCell:(YCBaoKuanCollectionViewCell *)cell entity:(YCBaoKuanEntity *)entity
{
    cell.carImageView.image = [UIImage imageNamed:entity.imageName];
    cell.carSeriesLabel.text = entity.series;
    cell.carPriceLabel.text = entity.price;
}

#pragma mark - Table view data source

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
