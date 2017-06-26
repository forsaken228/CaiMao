//
//  FFScrollView.h
//  CaiMao
//
//  Created by Fengpj on 14-12-15.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    FFScrollViewSelecttionTypeTap = 100,  //默认的为可点击模式
    FFScrollViewSelecttionTypeNone   //不可点击的
}FFScrollViewSelecttionType;

@protocol FFScrollViewDelegate <NSObject>

@optional
//- (void)scrollViewDidClickedAtPage:(NSInteger)pageNumber;

@end

@interface FFScrollView : UIView <UIScrollViewDelegate>
{
    NSTimer *timer;
    //NSArray *sourceArr;
}
@property(strong,nonatomic) UIScrollView *scrollView;
@property(strong,nonatomic) UIPageControl *pageControl;
@property(strong,nonatomic) NSArray *sourceArr;
@property(assign,nonatomic) FFScrollViewSelecttionType selectionType;
//@property(assign,nonatomic) id <FFScrollViewDelegate> pageViewDelegate;
@property(nonatomic,copy)void (^scrollViewDidClickedBlock)(NSInteger pageNumber);

- (id)initPageViewWithFrame:(CGRect)frame views:(NSArray *)views;
@end
