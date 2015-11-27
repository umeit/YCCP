//
//  QCAdsView.h
//  quanquan
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 QC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QCAdsView;
@protocol QCAdsViewDelegate <NSObject>

- (void)adsView:(QCAdsView *)adsView TouchImageAtIndex:(NSInteger)index;

@end


@interface QCAdsView : UIView

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *adsImages;

/**
 *  页码背景颜色（默认lightGrayColor）
 */
@property (nonatomic, strong) UIColor *pageColor;

/**
 *  当前选中页码背景颜色（默认whiteColor）
 */
@property (nonatomic, strong) UIColor *currentPageColor;

/**
 *  图片自动滚动时间
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 *  点击广告图片代理
 */
@property (nonatomic, weak) id<QCAdsViewDelegate> delegate;

/**
 *  点击广告图片Block
 */
@property (nonatomic, copy) void(^imageTouchBlock)(QCAdsView *adsView, NSInteger index);



/**
 *  初始化方法，需要自己设置图片数组
 */
+ (instancetype)adsView;


- (instancetype)initWithImages:(NSArray *)adsImages;
+ (instancetype)adsViewWithImages:(NSArray *)adsImages;


/**
 *  图片为网络图片时使用该方法
 *
 *  @param webImages 网络图片地址 数组
 */
- (instancetype)initWithWebImages:(NSArray *)webImages;
+ (instancetype)adsViewWithWebImages:(NSArray *)webImages;


@end
