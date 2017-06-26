//
//  CMTabBar.h
//  CaiMao
//
//  Created by Fengpj on 14-12-13.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMTabBar;
@class CMTabBarButton;

/**
 *  代理协议方法
 */
@protocol CMTabBarDelegate <NSObject>

@optional
- (void)tabBar:(CMTabBar *)tabBar didSelectedButtonFrom:(NSInteger)from to:(NSInteger)to ;

@end

@interface CMTabBar : UIView

/**
 *  通过一个item对象来添加一个按钮TabBarButton
 */
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

/**
 *  代理
 */
@property (nonatomic, weak) id<CMTabBarDelegate> delegate;
@property(nonatomic,assign)NSInteger selectedIndex;
- (void)btnClick:(CMTabBarButton *)btn;

@end
