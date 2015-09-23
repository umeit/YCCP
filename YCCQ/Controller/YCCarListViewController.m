//
//  YCCarListViewController.m
//  YCCQ
//
//  Created by Liu Feng on 15/5/28.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import "YCCarListViewController.h"
#import "YCWebViewController.h"
#import "UIViewController+GViewController.h"
#import "YCUserUtil.h"
#import "UtilDefine.h"
#import "YCBrandTableViewController.h"
#import "YCFilterTableViewController.h"
#import "YCFilterConditionStore.h"
#import "YCCarFilterConditionEntity.h"

@interface YCCarListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableDictionary *orderButtonStatus;
@property (strong, nonatomic) UIWebView *callWebView;
@property (strong, nonatomic) UITableView *optionTableView;
@property (strong, nonatomic) NSArray *sortItemList;
@property (nonatomic) BOOL optionTableViewDidShow;
@property (nonatomic) NSInteger currentIndex;
@end

@implementation YCCarListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conditionDidFinish) name:@"FilterConditionFinish" object:nil];
    
    self.carListWebView.delegate = self;
    
    if (!self.carListURL) {
        self.carListURL = [self defaultURL];
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self.carListWebView loadRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:
       [self.carListURL stringByAppendingString:@"?t=app"]]]];
    
    self.carListWebView.scrollView.contentInset = UIEdgeInsetsMake(28, 0, 0, 0);
    
    self.orderButtonStatus = [NSMutableDictionary dictionaryWithDictionary:@{@"price": @NO, @"mileage": @NO}];
    
    self.sortItemList = @[@"默认排序", @"按价格", @"按车龄", @"按里程"];
    
    [self createDarkBackgroundView];
    [self createOptionTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.sortButton setTitle:self.sortItemList[self.currentIndex] forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.navigationController) {
        CGRect frame = self.carListWebView.frame;
        self.carListWebView.frame = CGRectMake(0,
                                               frame.origin.y + 22,
                                               frame.size.width,
                                               frame.size.height - 22);
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.callWebView removeFromSuperview];
    self.callWebView = nil;
    [super viewWillDisappear:animated];
}


#pragma mark - Action

- (void)tapBackground:(id)sender {
    [self hideOptionTable];
    self.optionTableViewDidShow = NO;
}

- (IBAction)phoneButtonPress:(id)sender
{
    [self call:MainPhoneNum];
}

- (IBAction)defaultButtonPress:(id)sender
{
    [self arrowDefault:self.mileageArrowImageView];
    [self arrowDefault:self.priceArrowImageView];
    
    if (self.optionTableViewDidShow) {
        [self hideOptionTable];
        self.optionTableViewDidShow = NO;
    }
    else {
        [self showOptionTable];
        self.optionTableViewDidShow = YES;
    }
    
}

- (IBAction)brandButtonPress:(id)sender {
    YCBrandTableViewController *vc = [self controllerWithStoryBoardID:@"YCBrandTableViewController"];
    vc.navigationItem.title = @"选择品牌";
    vc.hidesBottomBarWhenPushed = YES;
    vc.useOnlineData = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)priceButtonPress:(id)sender {
    YCFilterTableViewController *vc = (YCFilterTableViewController *)[self controllerWithStoryBoardID:@"YCFilterTableViewController"];
    vc.dataType = PriceType;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    webView.hidden = YES;
    [self showLodingView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    webView.hidden = NO;
    [self hideLodingView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    webView.hidden = NO;
    [self hideLodingView];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL * url = [request URL];
    if ([[url scheme] isEqualToString:@"youcheapp"]) {
        
        NSString *command = [[url absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *jsonArg = [command substringFromIndex:@"youcheapp:///".length];

        NSError *error;
        NSDictionary *dicArg = [NSJSONSerialization JSONObjectWithData:[jsonArg dataUsingEncoding:NSUTF8StringEncoding]
                                                               options:NSJSONReadingAllowFragments
                                                                 error:&error];
        NSString *jsFunctionName = dicArg[@"calls"];
        // 前往详情页
        if ([dicArg[@"f"] isEqualToString:@"toDetail"]) {
             YCWebViewController *webVC = [self controllerWithStoryBoardID:@"YCWebViewController"];
            webVC.webPageURL = dicArg[@"args"][0];
            webVC.navigationItem.title = @"车辆详情";
            webVC.showBottomBar = YES;
            [self.navigationController pushViewController:webVC animated:YES];
        }
        // 弹出输入手机号码
        else if ([dicArg[@"f"] isEqualToString:@"inputPhoneNum"]) {
            NSString *carID = dicArg[@"args"][0];
             [self showTextFieldAlertWithTitle:@"收藏车辆" message:@"请输入您的手机号码" block:^(NSString *text) {
                 
                 if (![YCUserUtil isValidPhoneNum:text]) {
                     [self showCustomTextAlert:@"请正确输入号码"];
                     return;
                 }
                 
                 NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                 [userDefaults setObject:text forKey:@"UserPhoneNum"];
                 
                 [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@','%@')", jsFunctionName, text?:@"", carID?:@""]];
             }];
        }
        // 页面获取手机号
        else if ([dicArg[@"f"] isEqualToString:@"getPhoneNum"]) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userPhoneNum = [userDefaults stringForKey:@"UserPhoneNum"];
            [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"%@('%@')", jsFunctionName, userPhoneNum?:@""]];
        }
        return NO;
    }
    return YES;
}

- (void)conditionDidFinish
{
    NSString *url = [self urlWithCondition:[YCFilterConditionStore sharedInstance].filterCondition];
    [self.carListWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:@"?t=app"]]]];
}


#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sortItemList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
    }
    
    [cell.textLabel setTextColor:[UIColor grayColor]];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    cell.textLabel.text = self.sortItemList[indexPath.row];
    return cell;
}


#pragma mark - Table View Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
    [self.sortButton setTitle:self.sortItemList[self.currentIndex] forState:UIControlStateNormal];
    
    switch (indexPath.row) {
        case 0:
            [self.carListWebView loadRequest:
             [NSURLRequest requestWithURL:
              [NSURL URLWithString:
               [self.carListURL stringByAppendingString:@"?t=app"]]]];
            break;
        case 1:
            if ([self.orderButtonStatus[@"price"] boolValue]) {
                self.orderButtonStatus[@"price"] = @NO;
//                [self arrowUp:self.priceArrowImageView];
                [self.carListWebView loadRequest:
                 [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"o2?t=app"]]]];
            } else {
                self.orderButtonStatus[@"price"] = @YES;
//                [self arrowDown:self.priceArrowImageView];
                [self.carListWebView loadRequest:
                 [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"o1?t=app"]]]];
            }
            break;
            
        case 2:
            if ([self.orderButtonStatus[@"age"] boolValue]) {
                self.orderButtonStatus[@"age"] = @NO;
                //                [self arrowUp:self.mileageArrowImageView];
                [self.carListWebView loadRequest:
                 [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"o4?t=app"]]]];
            } else {
                self.orderButtonStatus[@"age"] = @YES;
                //                [self arrowDown:self.mileageArrowImageView];
                [self.carListWebView loadRequest:
                 [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"o3?t=app"]]]];
            }

            break;
            
        case 3:
            if ([self.orderButtonStatus[@"mileage"] boolValue]) {
                self.orderButtonStatus[@"mileage"] = @NO;
//                [self arrowUp:self.mileageArrowImageView];
                [self.carListWebView loadRequest:
                 [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"o6?t=app"]]]];
            } else {
                self.orderButtonStatus[@"mileage"] = @YES;
//                [self arrowDown:self.mileageArrowImageView];
                [self.carListWebView loadRequest:
                 [NSURLRequest requestWithURL:[NSURL URLWithString:[self.carListURL stringByAppendingString:@"o5?t=app"]]]];
            }
            break;
        default:
            break;
    }
    
    [self hideOptionTable];
    self.optionTableViewDidShow = NO;
}


#pragma mark - YCCarFilterConditionDelegate

- (void)selecteConditionFinish:(NSDictionary *)condition filterType:(CarFilterType)filterType {
    if (filterType == PriceType) {
        self.carListURL = [NSString stringWithFormat:@"http://m.youche.com/ershouche/%@", condition[@"CV"] ];
    }
    else {
        self.carListURL = [NSString stringWithFormat:@"http://m.youche.com/%@/", condition[@"CV"] ];
    }
    NSString *url = [self.carListURL stringByAppendingString:@"?t=app"];
    [self.carListWebView loadRequest:
     [NSURLRequest requestWithURL:
      [NSURL URLWithString:url]]];
}


#pragma mark - Privatre

- (NSString *)urlWithCondition:(YCCarFilterConditionEntity *)condition
{
    NSMutableString *url = [NSMutableString string];
    YCCarFilterConditionEntity *currentFilterCondition = [YCFilterConditionStore sharedInstance].filterCondition;
    
    // 选择类型
    if (currentFilterCondition.carTypeValue.length) {
        [url appendString:currentFilterCondition.carTypeValue];
        // 品牌
        if (currentFilterCondition.brandValue.length) {
            [url appendString:[currentFilterCondition.brandValue isEqualToString:@"all"] ? @"" :currentFilterCondition.brandValue];
        }
    }
    // 没选类型
    // 品牌
    else if (currentFilterCondition.brandValue.length) {
        [url appendString:[currentFilterCondition.brandValue isEqualToString:@"all"] ? @"" :currentFilterCondition.brandValue];
        // 车系
        if (currentFilterCondition.seriesValue.length) {
            [url appendString:[currentFilterCondition.seriesValue isEqualToString:@"all"] ? @"" :currentFilterCondition.seriesValue];
            // 车型
            if (currentFilterCondition.modelValue.length) {
                [url appendString:[currentFilterCondition.modelValue isEqualToString:@"all"] ? @"" :currentFilterCondition.modelValue];
            }
        }
    }
    // 没选类型，没选品牌
    else {
        [url appendString:@"ershouche"];
    }
    
    [url appendString:@"/"];
    
    // 价格
    if (currentFilterCondition.priceValue.length) {
        [url appendString:currentFilterCondition.priceValue];
    }
    // 颜色
    if (currentFilterCondition.colorValue.length) {
        [url appendString:currentFilterCondition.colorValue];
    }
    // 公里
    if (currentFilterCondition.mileageValue.length) {
        [url appendString:currentFilterCondition.mileageValue];
    }
    // 排量
    if (currentFilterCondition.ccValue.length) {
        [url appendString:currentFilterCondition.ccValue];
    }
    // 变速箱
    if (currentFilterCondition.gearboxValue.length) {
        [url appendString:currentFilterCondition.gearboxValue];
    }
    // 车龄
    if (currentFilterCondition.yearValue.length) {
        [url appendString:currentFilterCondition.yearValue];
    }
    // 门店
    if (currentFilterCondition.storeValue.length) {
        [url appendString:currentFilterCondition.storeValue];
    }
    return url;
}

- (void)createDarkBackgroundView {
    self.darkBackgroundView = [[UIView alloc] init];
//    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackground:)];
//    [self.darkBackgroundView addGestureRecognizer:gesture];
    self.darkBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.darkBackgroundView.opaque = NO;
}

- (void)createOptionTableView {
    UITableView *optionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,
                                                                                 0,
                                                                                 self.view.frame.size.width,
                                                                                 0)];
    optionTableView.rowHeight  = 36;
    optionTableView.dataSource = self;
    optionTableView.delegate   = self;
    optionTableView.backgroundColor = [UIColor whiteColor];
    self.optionTableView = optionTableView;
}

- (void)configrueDarkBackgroundViewLayout {
    CGRect topBarFrame = self.topBarViewBackgroundView.frame;
    CGRect scrollViewFrame = self.carListWebView.scrollView.frame;
    
    self.darkBackgroundView.frame = CGRectMake(topBarFrame.origin.x,
                                               topBarFrame.origin.y + topBarFrame.size.height,
                                               scrollViewFrame.size.width,
                                               scrollViewFrame.size.height);
}

- (void)showOptionTable {
    // 显示暗色背景
    [self configrueDarkBackgroundViewLayout];
    [self.view addSubview:self.darkBackgroundView];
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.darkBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
                     }
                     completion:^(BOOL finished) {
                         self.darkBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
                     }];
    
    // 显示选项列表
    [self.darkBackgroundView addSubview:self.optionTableView];
    CGFloat tableViewHeight = self.sortItemList.count * 36;
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.optionTableView.frame = CGRectMake(0,
                                                                 0,
                                                                 self.view.frame.size.width,
                                                                 tableViewHeight);
                     } completion:^(BOOL finished) {
                         self.optionTableView.frame = CGRectMake(0,
                                                                 0,
                                                                 self.view.frame.size.width,
                                                                 tableViewHeight);
                     }];
}

- (void)hideOptionTable {
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.optionTableView.frame;
        self.optionTableView.frame = CGRectMake(0, frame.origin.y, frame.size.width, 0);
        self.darkBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        
    } completion:^(BOOL finished) {
        [self.optionTableView removeFromSuperview];
        [self.darkBackgroundView removeFromSuperview];
    }];
}

- (BOOL)isSubjectCarList {
    return [self.carListURL.lastPathComponent isEqualToString:@"t32"] || [self.carListURL.lastPathComponent isEqualToString:@"t37"];
}

- (void)call:(NSString *)tel {
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", tel];
    self.callWebView = [[UIWebView alloc] init];
    [self.callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:self.callWebView];
}

- (NSString *)defaultURL {
    return @"http://m.youche.com/ershouche/";
}

- (void)arrowUp:(UIImageView *)arrowImage {
    CGAffineTransform endAngle = CGAffineTransformMakeRotation((M_PI / -2));
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         arrowImage.transform = endAngle;
                     }
                     completion:^(BOOL finished) {
                         arrowImage.transform = endAngle;
                     }];
}

- (void)arrowDown:(UIImageView *)arrowImage
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation((M_PI / 2));
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         arrowImage.transform = endAngle;
                     }
                     completion:^(BOOL finished) {
                         arrowImage.transform = endAngle;
                     }];
}

- (void)arrowDefault:(UIImageView *)arrowImage
{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(0);
    
    [UIView animateWithDuration:0.35
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         arrowImage.transform = endAngle;
                     }
                     completion:^(BOOL finished) {
                         arrowImage.transform = endAngle;
                     }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
    if ([vc respondsToSelector:@selector(setDelegate:)]) {
        [vc performSelector:@selector(setDelegate:) withObject:self];
    }
}

@end
