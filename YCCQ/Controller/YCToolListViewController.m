//
//  YCToolListViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/16.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCToolListViewController.h"
#import "YCWebViewController.h"
#import "UIViewController+GViewController.h"
#import "AppKeFuLib.h"
#import "YCEvaluateCarFilterController.h"

@interface YCToolListViewController ()

@end

@implementation YCToolListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                [self toConsultationViewControllerWithWorkgroup:@"usecar"];
                break;
            case 1:
                [self toConsultationViewControllerWithWorkgroup:@"usecar"];
                break;
            case 2:
                [self toConsultationViewControllerWithWorkgroup:@"usecar"];
                break;
            case 3:
                [self toConsultationViewControllerWithWorkgroup:@"usecar"];
                break;
            case 4:
                [self toConsultationViewControllerWithWorkgroup:@"usecar"];
                break;
            case 5:
                [self toConsultationViewControllerWithWorkgroup:@"usecar"];
                break;
            case 6:
                [self toConsultationViewControllerWithWorkgroup:@"usecar"];
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self showCustomText:@"功能暂未开通" delay:1.3];
                break;
            case 1:
                [self toEvaluateCar];
                break;
            case 2:
                [self toWebViewWithURL:@"http://m.youche.com/service/insurance?t=app"
                       controllerTitle:@"代办车险"];
                break;
            case 3:
                [self showCustomText:@"功能暂未开通" delay:1.3];
                break;
        }
    }
    else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                [self toWebViewWithURL:@"http://m.youche.com/service/salecar?t=app"
                       controllerTitle:@"上门收车"];
                break;
            case 1:
                [self toWebViewWithURL:@"http://m.youche.com/service/evaluate?t=app"
                       controllerTitle:@"预约检测"];
                break;
            case 2:
                [self toWebViewWithURL:@"http://m.youche.com/service/warranty.shtml?t=app"
                       controllerTitle:@"延保服务"];
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 0:
                [self showCustomText:@"功能暂未开通" delay:1.3];
                break;
                
            default:
                break;
        }
    }
}

#pragma mark - Navigation
- (void)toWebViewWithURL:(NSString *)url controllerTitle:(NSString *)title
{
    YCWebViewController *webViewController = (YCWebViewController *)[self controllerWithStoryBoardID:@"YCWebViewController"];
    webViewController.webPageURL = url;
    webViewController.navigationItem.title = title;
    [self.navigationController pushViewController:webViewController animated:YES];
}

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

// 前往车辆估价视图
- (void)toEvaluateCar
{
    YCEvaluateCarFilterController *filterViewController = (YCEvaluateCarFilterController *)[self controllerWithStoryBoardID:@"YCEvaluateCarFilterController"];
    [self.navigationController pushViewController:filterViewController animated:YES];
}
@end
