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
#import "YCUserUtil.h"
#import "YCLimitDriveEditViewController.h"
#import "UtilDefine.h"

@interface YCToolListViewController ()

@property (strong, nonatomic) UIWebView *callWebView;

@end

@implementation YCToolListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.callWebView = [[UIWebView alloc] init];
    [self.view addSubview:self.callWebView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - Action

- (IBAction)phoneButtonPress:(id)sender
{
    [self call:MainPhoneNum];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:  // 用车急问
                [self toConsultationViewControllerWithWorkgroup:@"usecar" title:@"用车急问"];
                break;
            case 1:  // 维修咨询
                [self toConsultationViewControllerWithWorkgroup:@"repair" title:@"维修咨询"];
                break;
            case 2:  // 事故咨询
                [self toConsultationViewControllerWithWorkgroup:@"accident" title:@"事故咨询"];
                break;
            case 3:  // 道路救援
                [self call:@"18500581075"];
                break;
            case 4:  // 售后咨询
                [self toConsultationViewControllerWithWorkgroup:@"aftersales" title:@"售后咨询"];
                break;
            case 5:  // 买车咨询
                [self toConsultationViewControllerWithWorkgroup:@"buycar" title:@"买车咨询"];
                break;
            case 6:  // 卖车咨询
                [self toConsultationViewControllerWithWorkgroup:@"sellcar" title:@"卖车咨询"];
                break;
            case 7:  // 预约咨询
                [self call:@"13718233424"];
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
//            case 0:  // 违章查询
//                [self showCustomText:@"功能暂未开通" delay:1.3];
//                break;
            case 0:  // 估价
                [self toEvaluateCar];
                break;
            case 1:
                [self toWebViewWithURL:@"http://m.youche.com/service/insurance?t=app"
                       controllerTitle:@"代办车险"];
                break;
            case 2:
//                [self toLimitDrive];
                [self pushViewControllerWithStoryBoardID:@"YCOilPriceViewController" title:@"今日油价"];
                break;
//            case 3:  // 今日油价
//                [self pushViewControllerWithStoryBoardID:@"YCOilPriceViewController" title:@"今日油价"];
//                break;
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
//    else if (indexPath.section == 3) {
//        switch (indexPath.row) {
//            case 0:  // 限号提醒
//                [self showCustomText:@"功能暂未开通" delay:1.3];
//                break;
//                
//            default:
//                break;
//        }
//    }
}


#pragma mark - Navigation

- (void)toLimitDrive
{
    if ([YCUserUtil userLicensePlateNumber]) {
        [self controllerWithStoryBoardID:@"YCLimitDriveInfoViewController"];
    }
    else {
        [self pushViewControllerWithStoryBoardID:@"YCLimitDriveEditViewController" title:@"限行查询"];
    }
}

- (void)toWebViewWithURL:(NSString *)url controllerTitle:(NSString *)title
{
    YCWebViewController *webViewController = (YCWebViewController *)[self controllerWithStoryBoardID:@"YCWebViewController"];
    webViewController.webPageURL = url;
    webViewController.navigationItem.title = title;
    [self.navigationController pushViewController:webViewController animated:YES];
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

// 前往车辆估价视图
- (void)toEvaluateCar
{
    YCEvaluateCarFilterController *filterViewController = (YCEvaluateCarFilterController *)[self controllerWithStoryBoardID:@"YCEvaluateCarFilterController"];
    [self.navigationController pushViewController:filterViewController animated:YES];
}


#pragma mark - Private

- (void)call:(NSString *)tel
{
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", tel];
    
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
}
@end
