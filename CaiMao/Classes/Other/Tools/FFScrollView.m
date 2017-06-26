//
//  FFScrollView.m
//  CaiMao
//
//  Created by Fengpj on 14-12-15.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import "FFScrollView.h"
#import "UIImageView+WebCache.h"

@implementation FFScrollView
@synthesize scrollView;
@synthesize pageControl;
@synthesize selectionType;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        selectionType = FFScrollViewSelecttionTypeTap;
        
        self.userInteractionEnabled = YES;
        [self iniSubviewsWithFrame:frame];
    }
    return self;
}

#pragma mark-- init methods
- (id)initPageViewWithFrame:(CGRect)frame views:(NSArray *)views
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if(views.count<=0){
            return nil;
        }
        selectionType = FFScrollViewSelecttionTypeTap;
        self.sourceArr = views;
        
        self.userInteractionEnabled = YES;
        [self iniSubviewsWithFrame:frame];
    }
    return self;
}

- (void)iniSubviewsWithFrame:(CGRect)frame
{
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    CGRect fitRect = CGRectMake(0, 0, width, height);
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:fitRect];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.scrollsToTop = NO;
    if (self.sourceArr.count == 1) {
        self.scrollView.contentSize = CGSizeMake(width , height);
    } else {
        self.scrollView.contentSize = CGSizeMake(width * (self.sourceArr.count + 2), height);
    }
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    
    UIImageView *firstImageView = [[UIImageView alloc]initWithFrame:fitRect];
    
//    firstImageView.image = [UIImage imageNamed:[sourceArr lastObject]];
    [firstImageView sd_setImageWithURL:[NSURL URLWithString:[self.sourceArr lastObject]] placeholderImage:[UIImage imageNamed:@"NoDataImage"] options:SDWebImageAllowInvalidSSLCertificates];
    
    [self.scrollView addSubview:firstImageView];
    
    for (int i = 0; i < self.sourceArr.count; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(width*(i+1), 0, width, height)];
//        imageview.image = [UIImage imageNamed:[sourceArr objectAtIndex:i]];
        [imageview sd_setImageWithURL:[NSURL URLWithString:[self.sourceArr objectAtIndex:i]] placeholderImage:[UIImage imageNamed:@"NoDataImage"] options:SDWebImageAllowInvalidSSLCertificates];
        
        [self.scrollView addSubview:imageview];
    }
    
    UIImageView *lastImageView = [[UIImageView alloc]initWithFrame:CGRectMake(width*(self.sourceArr.count+1), 0, width, height)];
    
//    lastImageView.image = [UIImage imageNamed:[sourceArr objectAtIndex:0]];
    [lastImageView sd_setImageWithURL:[NSURL URLWithString:[self.sourceArr objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"NoDataImage"] options:SDWebImageAllowInvalidSSLCertificates];
    
    [self.scrollView addSubview:lastImageView];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(width-80, height-20, 50, 20)];
    self.pageControl.numberOfPages = self.sourceArr.count;
    self.pageControl.currentPage = 0;
    self.pageControl.enabled = YES;
    
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [self addSubview:self.pageControl];
    
  
    [self.scrollView scrollRectToVisible:CGRectMake(width, 0, width, height) animated:NO];
    
    if (self.sourceArr.count == 1) {
       
    } else {
        timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    }
//
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
}

#pragma mark --- custom methods
// 自动滚动到下一页
- (void)nextPage:(id)sender
{
    
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int currentPage = self.scrollView.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        self.pageControl.currentPage = self.sourceArr.count-1;
    }
    else if (currentPage == self.sourceArr.count+1) {
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    NSInteger currPageNumber = self.pageControl.currentPage;
    CGSize viewSize = self.scrollView.frame.size;
    CGRect rect = CGRectMake((currPageNumber+2)*pageWidth, 0, viewSize.width, viewSize.height);
    [self.scrollView scrollRectToVisible:rect animated:YES];
    currPageNumber++;
    if (currPageNumber == self.sourceArr.count) {
        CGRect newRect=CGRectMake(viewSize.width, 0, viewSize.width, viewSize.height);
        [self.scrollView scrollRectToVisible:newRect animated:NO];
        currPageNumber = 0;
    }
    self.pageControl.currentPage = currPageNumber;
}

// 点击图片的时候 触发
- (void)singleTap:(UITapGestureRecognizer *)tapGesture
{
    if (selectionType != FFScrollViewSelecttionTypeTap) {
        return;
    }
//    if (pageViewDelegate && [pageViewDelegate respondsToSelector:@selector(scrollViewDidClickedAtPage:)]) {
//        [pageViewDelegate scrollViewDidClickedAtPage:self.pageControl.currentPage];
//    }
//    
    if (self.scrollViewDidClickedBlock) {
        self.scrollViewDidClickedBlock(self.pageControl.currentPage);
    }
}

#pragma mark---- UIScrollView delegate methods
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 开始拖动scrollview的时候 停止计时器控制的跳转
    
//    [timer invalidate];
//    timer = nil;
    
    if (self.sourceArr.count == 1) {
        
    } else {
        [timer invalidate];
        timer = nil;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat width = self.scrollView.frame.size.width;
    CGFloat heigth = self.scrollView.frame.size.height;
    // 当手指滑动scrollview，而scrollview减速停止的时候 开始计算当前的图片的位置
    int currentPage = self.scrollView.contentOffset.x/width;
    if (currentPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(width*self.sourceArr.count, 0, width, heigth) animated:NO];
        self.pageControl.currentPage = self.sourceArr.count-1;
    }
    else if (currentPage == self.sourceArr.count+1) {
        [self.scrollView scrollRectToVisible:CGRectMake(width, 0, width, heigth) animated:NO];
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    // 拖动完毕的时候 重新开始计时器控制跳转
    
//    timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    if (self.sourceArr.count == 1) {
        
    } else {
        timer = [NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(nextPage:) userInfo:nil repeats:YES];
    }
}

@end
