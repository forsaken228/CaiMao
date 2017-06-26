//
//  CMTabBar.m
//  CaiMao
//
//  Created by Fengpj on 14-12-13.
//  Copyright (c) 2014年 58cm. All rights reserved.
//

#import "CMTabBar.h"

@interface CMTabBar ()
{
    int _tabBarButtonCount;
    CMTabBarButton *_selectedBtn;
   
}

@end

@implementation CMTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置背景色
      // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background_os7"]];
        
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
  
    // 创建底部按钮
    CMTabBarButton *btn = [[CMTabBarButton alloc] init];
    
    // 设置frame
    CGFloat btnH = self.frame.size.height;
    CGFloat btnW = self.frame.size.width / 4;
    CGFloat btnX = btnW * _tabBarButtonCount;
    btn.frame = CGRectMake(btnX, 0, btnW, btnH);
    
    // 设置图片和标题
    btn.item = item;
    
    // 监听点击
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    // 默认选中第0个按钮
    btn.tag = _tabBarButtonCount;
    if (_tabBarButtonCount == 0) {
        [self btnClick:btn];
    }
    
    [self addSubview:btn];
    
    _tabBarButtonCount++;
    
}

/**
 *  监听CMTabBarButton点击
 */
- (void)btnClick:(CMTabBarButton *)btn
{

    if (btn.selected==YES) {
        return ;
    }
    // 通知代理
    if ([_delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [_delegate tabBar:self didSelectedButtonFrom:_selectedBtn.tag to:btn.tag];
    }
    
    if (btn.tag == 3) {
        if (![CMRequestManager islogin]) {
            return;
        }else{
        _selectedBtn.selected = NO;
        btn.selected = YES;
        _selectedBtn = btn;
        }
    }else {
        // 控制器选中按钮
        _selectedBtn.selected = NO;
        btn.selected = YES;
        _selectedBtn = btn;
    }
    
    
    if (btn.tag==3) {
    
        // 取出账号、密码
        NSUserDefaults *userDefault = CMUserDefaults;
        NSString *name = [userDefault objectForKey:@"name"];
        NSString *password = [PassWordTool readPassWord];
        
        if (name&&password) {
            
            //NSLog(@"123456");
            NSString *urlStr = [NSString stringWithFormat:@"%@/handler/AppInterface.ashx?action=login&mobile=%@&pwd=%@&type=%@&id=%@",OnLineCode,name,password,@"1",[JPUSHService registrationID]];
            [CMHttpTool getWithURL:urlStr params:nil success:^(id responseObj) {
                
                
                NSString *strStatus = [responseObj valueForKey:@"status"];
              
                if ([strStatus isEqualToString:@"200"]) {
                
                    
                }
                
            } failure:^(NSError *error) {
                DLog(@"自动陆失败------%@",error);
            }];
            
        }  
    }
    
    
}
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if (self.selectedIndex<0||self.selectedIndex>=self.subviews.count) {
        return;
    }
    CMTabBarButton *item=self.subviews[self.selectedIndex];
    [self btnClick:item];
}

@end
