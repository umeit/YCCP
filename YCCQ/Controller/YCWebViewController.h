//
//  YCWebViewController.h
//  YCCQ
//
//  Created by Liu Feng on 15/5/25.
//  Copyright (c) 2015年 Baisika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSURL *url;

@end
