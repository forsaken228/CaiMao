//
//  CMNavigationController.m
//  CaiMao
//
//  Created by Fengpj on 14-12-12.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import "CMNavigationController.h"
#import "CMTabBarController.h"
#import "UIBarButtonItem+CM.h"

@interface CMNavigationController ()

@end

@implementation CMNavigationController

/**
 *  初始化（每一个类只会调用一次）
 */
+ (void)initialize
{
    // 获得bar对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    // bg.png为自己ps出来的想要的背景颜色。可以去除导航底部黑线
    [navBar setBackgroundImage:[UIImage imageNamed:@"bg.png"]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
   [navBar setShadowImage:[UIImage new]];
 //   [navBar setBackgroundColor:RedButtonColor];
   navBar.barTintColor = RedButtonColor;
   

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // 设置文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    // 设置导航栏按钮的主题
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    // 设置按钮的文字样式
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [barItem setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    [barItem setTitleTextAttributes:itemAttrs forState:UIControlStateHighlighted];
   

    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   
 
    if (self.viewControllers.count) {
      viewController.hidesBottomBarWhenPushed = YES;
      viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"nav_back_btn" higlightedImage:nil target:self action:@selector(backClick)];
    }
    // 解决导航栏左侧按钮自定义影响系统返回手势问题
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.interactivePopGestureRecognizer.enabled = YES;
       self.interactivePopGestureRecognizer.delegate = nil;
    }
    [viewController setNeedsStatusBarAppearanceUpdate];
    [super pushViewController:viewController animated:animated];
    
    
}



- (void)backClick
{
   
    
 [self popViewControllerAnimated:YES];
   
}

@end
