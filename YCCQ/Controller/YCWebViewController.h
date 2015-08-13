//
//  YCWebViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/25.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCWebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *bottomBarBackgroundView;
@property (strong, nonatomic) NSString *webPageURL;

@property (nonatomic) BOOL showBottomBar;

@property (strong, nonatomic) NSString *carName;
@property (strong, nonatomic) NSString *carID;

@end
