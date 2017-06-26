//
//  CMTabBarController.m
//  CaiMao
//
//  Created by Fengpj on 14-12-12.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import "CMTabBarController.h"
#import "CMHomeViewController.h"
#import "CMLiCaiViewController.h"
#import "CMTehuiViewController.h"
#import "CMAccountViewController.h"
#import "CMNavigationController.h"
#import "CMTabBar.h"

@interface CMTabBarController ()<CMTabBarDelegate>
{
    CMTabBar *_customTabbar;
    NSInteger _indexSelctTabBarTag;
}

@end

@implementation CMTabBarController


- (void)viewDidLoad
{
   [super viewDidLoad];

    // 添加tabbar
    [self addTabbar];
    // 添加所有子控制器
    [self addAllChildViewControllers];
 
    [self removeTabBarBlackLine];
 
}


-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) { //UITabBarButton
            [child removeFromSuperview];
        }
    }
    

}
-(void)removeTabBarBlackLine{
    
    CGRect rect = CGRectMake(0, 0, CMScreenW, CMScreenH);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self.tabBar setBackgroundImage:img];
    
    [self.tabBar setShadowImage:img];
    [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    
}

/**
 *  添加自定义Tabbar
 */
- (void)addTabbar
{
    CMTabBar *customTabbar = [[CMTabBar alloc] init];
    customTabbar.delegate = self;
    
    customTabbar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabbar];
    _customTabbar = customTabbar;
}


/**
 *  代理方法
 */
- (void)tabBar:(CMTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to
{
    
    if (to==3) {
        BOOL is=[CMRequestManager islogin];
        if (is==NO) {
            if (_indexSelctTabBarTag == 0) {
                [CMNSNotice postNotificationName:@"homeLoginVc" object:nil];
            } else if (_indexSelctTabBarTag == 1) {
                [CMNSNotice postNotificationName:@"mattersLoginVc" object:nil];
            } else if (_indexSelctTabBarTag == 2) {
                [CMNSNotice postNotificationName:@"preferenceLoginVc" object:nil];
            }else{
                 [CMNSNotice postNotificationName:@"AccountLoginVc" object:nil];
                
            }
            return;
        }
        
            
        else{
            self.selectedIndex = to;
        }
        
    }
//    else if(to==0){
//        
//        self.selectedIndex = to;
//    }
    else{
        self.selectedIndex = to;
    }

    _indexSelctTabBarTag = to;

}

-(void)selectTap:(NSInteger)index{
    
    _customTabbar.selectedIndex=index;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    _imageView.hidden=YES;
    // 移除之前的4个UITabBarButton

    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) { //UITabBarButton
            [child removeFromSuperview];
        }
    }
    
}


- (void)addAllChildViewControllers
{
    
    
    // 1,首页
    CMHomeViewController *home = [[CMHomeViewController alloc] init];
    [self addChildViewController:home title:@"首页" image:@"home_submenu_shouye_hui" selectedImage:@"home_submenu_shouye_red"];
    
    // 2,理财
    CMLiCaiViewController *licai = [[CMLiCaiViewController alloc] init];
    [self addChildViewController:licai title:@"理财" image:@"home_submenu_licai_hui" selectedImage:@"home_submenu_licai_red"];
    
    // 3,特惠
    CMTehuiViewController *tehui = [[CMTehuiViewController alloc] init];
    [self addChildViewController:tehui title:@"特惠" image:@"home_submenu_tehui_hui" selectedImage:@"home_submenu_tehui_red"];
    
    // 4,账户

        CMAccountViewController *account = [[CMAccountViewController alloc] init];
        [self addChildViewController:account title:@"账户" image:@"home_submenu_zhanghu_hui" selectedImage:@"home_submenu_zhanghu_red"];

}

#pragma mark - 添加一个子控制器
- (void)addChildViewController:(UIViewController *)child title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置标题和图片
    child.tabBarItem.title = title;
    child.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *selected = [UIImage imageNamed:selectedImage];
    
    // 不渲染选中的图片
    child.tabBarItem.selectedImage = [selected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 包装一个导航控制器
    child.title = title;

    CMNavigationController *nav = [[CMNavigationController alloc] initWithRootViewController:child];
  
    // 成为tabbarController的子控制器
    [self addChildViewController:nav];
    
    // 添加一个按钮
    [_customTabbar addTabBarButtonWithItem:child.tabBarItem];
    
}

//checkNet
@end
