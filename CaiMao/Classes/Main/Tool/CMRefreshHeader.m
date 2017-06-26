//
//  CMRefreshHeader.m
//  CaiMao
//
//  Created by Fengpj on 16/2/27.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMRefreshHeader.h"

@implementation CMRefreshHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];
    
    // 设置普通状态的动画图片 dropdown_01
    NSMutableArray *idleImages = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_0%d", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_0%ld", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
  
    
     self.lastUpdatedTimeLabel.hidden = YES;
//    // 设置字体
  self.stateLabel.font = [UIFont systemFontOfSize:11.0];

//    
    // 设置颜色
 self.stateLabel.textColor = UIColorFromRGB(0xa9a9aa);
    
}
- (void)placeSubviews{
    [super placeSubviews];
    
    //如果需要自己重新布局子控件，请在这里设置
    
    self.gifView.mj_x = self.mj_w/2.0+12;
    self.gifView.mj_y = 5;
    self.gifView.mj_w = 10;
    self.gifView.mj_h = 10;
    
    self.stateLabel.mj_x = 0;
    self.stateLabel.mj_y = 35;
    self.stateLabel.mj_w = self.mj_w;
    self.stateLabel.mj_h = 15;
    
}
@end
