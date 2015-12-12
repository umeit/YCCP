//
//  QCAdsView.m
//  quanquan
//
//  Created by qianfeng on 15/9/19.
//  Copyright (c) 2015年 QC. All rights reserved.
//

#import "QCAdsView.h"
#import "UIImageView+WebCache.h"

@interface QCAdsView ()<UIScrollViewDelegate>

// 广告滚动栏
@property (nonatomic, weak) UIScrollView *adsScroll;
// 广告页码
@property (nonatomic, weak) UIPageControl *adsPage;
// 自动滚动计时器
@property (nonatomic, strong) NSTimer *timer;
// 是否为网络图片
@property (nonatomic, assign) BOOL isWeb;

@end

@implementation QCAdsView

#pragma mark - 初始化方法
- (void)awakeFromNib {
    self.isWeb = YES;
}

#pragma mark - 重写 setter 方法

#pragma mark 图片数组 setter 方法
- (void)setAdsImages:(NSArray *)adsImages {
    if (_adsImages == adsImages) return;
    
    _adsImages = adsImages;
    
    // 添加到scrollView中
    self.adsScroll.showsHorizontalScrollIndicator = NO;
    self.adsScroll.pagingEnabled = YES;
    self.adsScroll.delegate =self;
    
    // imageView宽高
    CGFloat imageViewW = CGRectGetWidth(self.adsScroll.frame);
    CGFloat imageViewH = CGRectGetHeight(self.adsScroll.frame);
    for (int i = 0; i < adsImages.count + 2; i++) {
        // 获得图片名
        NSString *imageName;
        if (i == 0) {
            imageName = [adsImages lastObject];
        }else if (i == adsImages.count + 1) {
            imageName = [adsImages firstObject];
        }else {
            imageName = adsImages[i -1];
        }
        
        // 创建imageView
        UIImageView *imageView = [[UIImageView alloc] init];
        if (self.isWeb) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
        }
        else {
            imageView.image = [UIImage imageNamed:imageName];
        }
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)]];
        [self.adsScroll addSubview:imageView];
        
        imageView.frame = CGRectMake(imageViewW * i, 0, imageViewW, imageViewH);
        self.adsScroll.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame), 0);
        
    }
    self.adsScroll.contentOffset = CGPointMake(CGRectGetWidth(self.adsScroll.frame), 0);
    
    
    // 设置UIPageControl属性
    self.adsPage.numberOfPages = adsImages.count;
    self.adsPage.pageIndicatorTintColor = self.pageColor ? self.pageColor : [UIColor lightGrayColor];
    self.adsPage.currentPageIndicatorTintColor = self.currentPageColor ? self.currentPageColor : [UIColor whiteColor];
    self.adsPage.enabled = NO;
    
    // 创建计时器
    [self createTimer:2];
}
#pragma mark 页码背景颜色 setter 方法
- (void)setPageColor:(UIColor *)pageColor {
    _pageColor = pageColor;
    
    self.adsPage.pageIndicatorTintColor = pageColor;
}
#pragma mark 当前选中页背景颜色 setter 方法
- (void)setCurrentPageColor:(UIColor *)currentPageColor {
    _currentPageColor = currentPageColor;
    
    self.adsPage.currentPageIndicatorTintColor = currentPageColor;
}
#pragma mark 图片自动滚动时间 setter 方法
- (void)setDuration:(NSTimeInterval)duration {
    _duration = duration;
    
    [self.timer invalidate];
    self.timer = nil;
    [self createTimer:duration];
}

#pragma mark - 懒加载创建控件
- (UIScrollView *)adsScroll {
    if (!_adsScroll) {
        UIScrollView *adsScroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:adsScroll];
        _adsScroll = adsScroll;
    }
    return _adsScroll;
}
- (UIPageControl *)adsPage {
    if (!_adsPage) {
        CGFloat adsPageX = 0;
        CGFloat adsPageY = CGRectGetHeight(self.bounds) - 20;
        CGFloat adsPageW = CGRectGetWidth(self.bounds);
        CGFloat adsPageH = 20;
        UIPageControl *adsPage = [[UIPageControl alloc] initWithFrame:CGRectMake(adsPageX, adsPageY, adsPageW, adsPageH)];
        [self addSubview:adsPage];
        _adsPage = adsPage;
    }
    return _adsPage;
}

#pragma mark - 滚动广告
/** 广告栏滚动协议方法 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self turnPage:scrollView];
}
/** 滑动动画结束 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self turnPage:scrollView];
}
/** 创建计时器 */
- (void)createTimer:(NSTimeInterval)duration {
    [self.timer invalidate];
    self.timer = nil;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(rollAdvertise) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/** 每*秒滚动广告栏 */
- (void)rollAdvertise {
    [self.adsScroll setContentOffset:CGPointMake(self.adsScroll.contentOffset.x + CGRectGetWidth(self.adsScroll.frame), 0) animated:YES];
}
/** 翻页方法 */
- (void)turnPage:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    if (page == 0) {
        self.adsScroll.contentOffset = CGPointMake(CGRectGetWidth(scrollView.bounds) * self.adsImages.count, 0);
        self.adsPage.currentPage = self.adsImages.count - 1;
    }
    else if (page == self.adsImages.count + 1) {
        self.adsScroll.contentOffset = CGPointMake(CGRectGetWidth(scrollView.bounds), 0);
        self.adsPage.currentPage = 0;
    }
    else {
        self.adsPage.currentPage = page - 1;
    }
}
// 手动拖动时暂停计时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
}

- (void)startRoll {
    if (self.adsImages.count) {
        [self createTimer:2];
    }
}
- (void)stopRoll {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 点击图片回调
- (void)imageViewTap:(UITapGestureRecognizer *)tap {
    if ([self.delegate respondsToSelector:@selector(adsView:TouchImageAtIndex:)]) {
        [self.delegate adsView:self TouchImageAtIndex:self.adsPage.currentPage];
    }
    if (self.imageTouchBlock) {
        self.imageTouchBlock(self, self.adsPage.currentPage);
    }
}

@end
