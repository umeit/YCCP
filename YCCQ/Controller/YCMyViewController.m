//
//  YCMyViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/6/18.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCMyViewController.h"
#import "UMFeedback.h"
#import "YCWebViewController.h"
#import "UIViewController+GViewController.h"

@interface YCMyViewController ()

@end

@implementation YCMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                
                break;
            case 1:
            {
                UIViewController *feedbackVC = [UMFeedback feedbackViewController];
                feedbackVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:feedbackVC animated:YES];
            }
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [self toWebViewWithURL:@"" controllerTitle:@"关于优车"];
                break;
                
            default:
                break;
        }
    }
}


#pragma mark - Private 
- (void)toWebViewWithURL:(NSString *)url controllerTitle:(NSString *)title
{
    YCWebViewController *webViewController = (YCWebViewController *)[self controllerWithStoryBoardID:@"YCWebViewController"];
    webViewController.webPageURL = url;
    webViewController.navigationItem.title = title;
    [self.navigationController pushViewController:webViewController animated:YES];
}
@end
