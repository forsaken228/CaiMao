//
//  CMGuideView.h
//  CaiMao
//
//  Created by MAC on 16/11/18.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMGuideView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *imageArray;

@property (nonatomic, strong) UIPageControl *PageControl;
@property (nonatomic, strong) UIButton *PassButton;
@property (nonatomic, strong) UIButton *loginButton;
//创建引导页
- (instancetype)init:(NSArray *)imageArray;
@property(nonatomic,weak)id  delegate;
@end
@protocol CMGuideViewDelegate <NSObject>

-(void)enterAppMainControllerWithIndex:(NSInteger)Index;

@end
