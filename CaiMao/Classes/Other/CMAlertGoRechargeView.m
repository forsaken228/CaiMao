//
//  CMAlertGoRechargeView.m
//  CaiMao
//
//  Created by MAC on 16/8/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAlertGoRechargeView.h"

@implementation CMAlertGoRechargeView

-(id)initWithReChargeWith:(int)msg{
    self=[super init];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIView  *bgView=[[UIView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
        
        tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        tap.delegate=self;
        [bgView addGestureRecognizer:tap];
        //弹框背景
        UIView *contentView=[[UIView alloc]init];
        
        
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
            make.height.mas_equalTo(120);
            make.width.mas_equalTo(270);
        }];
        
        UILabel *regeistSuccess=[[UILabel alloc]init];
        regeistSuccess.text=[NSString stringWithFormat:@"账户余额不足%d,请先充值!",msg];
        regeistSuccess.font=[UIFont systemFontOfSize:15];
        regeistSuccess.textColor=UIColorFromRGB(0x777573);
        regeistSuccess.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:regeistSuccess];
        [regeistSuccess mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@50);
            make.width.left.equalTo(contentView);
            
            make.top.equalTo(contentView.mas_top).offset(10);
        }];
        
        UIView *lineView=[UIView new];
        lineView.backgroundColor=UIColorFromRGB(0xcccccc);
        [contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.left.equalTo(contentView);
            
            make.top.equalTo(regeistSuccess.mas_bottom).offset(8);
            
        }];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitle:@"充值" forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0xfb3f19) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goRechargeViewFromAlert) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:20];
    
        [contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.height.equalTo(@30);
            make.top.equalTo(lineView.mas_bottom).offset(8);
            
            make.width.left.equalTo(contentView);
            
        }];
        
    }
    
    return self;
}
-(void)goRechargeViewFromAlert{
    
    
    if ([_delegate respondsToSelector:@selector(goRechargeView)]) {
        [_delegate  goRechargeView ];
    }
    
}
-(void)dismissView{
    
    if ([_delegate respondsToSelector:@selector(tapDismissView)]) {
        [_delegate  tapDismissView ];
    }
    
}
// //展示alertView
-(void)ShowAlert
{
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    // //展示alertView,将alertView展示在window
    [window addSubview:self];
    
}
-(void)dimissAlert{
    for (UIView *vc in self.subviews) {
        [vc removeFromSuperview];
    }
    [self removeFromSuperview];
}

@end
