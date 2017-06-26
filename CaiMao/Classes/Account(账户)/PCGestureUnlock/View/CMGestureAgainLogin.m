//
//  CMGestureAgainLogin.m
//  CaiMao
//
//  Created by MAC on 16/8/25.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMGestureAgainLogin.h"

@implementation CMGestureAgainLogin

-(id)initWithRegist{
    self=[super init];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIView  *bgView=[[UIView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
        //弹框背景
        UIView *contentView=[[UIView alloc]init];
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView);
            make.height.mas_equalTo(150);
            make.width.mas_equalTo(260);
        }];
        
        
        UILabel *detail=[[UILabel alloc]init];
        detail.numberOfLines=0;
        detail.text=@"你已连续5次输错手势，手势解锁已关闭,请重新登录。";
        detail.font=[UIFont systemFontOfSize:14];
        detail.textColor=UIColorFromRGB(0x666666);
        detail.textAlignment=NSTextAlignmentCenter;
        
        [contentView addSubview:detail];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@40);
            make.left.equalTo(contentView.mas_left).offset(20);
            make.right.equalTo(contentView.mas_right).offset(-20);
            make.top.equalTo(contentView.mas_top).offset(20);
            
        }];
        
        UIView *lineView=[UIView new];
        lineView.backgroundColor=separateLineColor;
        [contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.left.right.equalTo(contentView);
            make.bottom.equalTo(detail.mas_bottom).offset(20);
            
        }];

        UIButton *SureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [SureBtn setTitle:@"确定" forState:UIControlStateNormal];
        SureBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [SureBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [contentView addSubview:SureBtn];
        [SureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(buttonHeight);
            make.width.equalTo(contentView);
            make.top.equalTo(lineView.mas_bottom).offset(20);
            make.centerX.equalTo(contentView.mas_centerX);
        }];
        
 [SureBtn addTarget:self action:@selector(didClickBtn) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
        return self;
    }

//-(void)dismissView{
//    
//    [self dimissAlert];
//    
//}
-(void)didClickBtn{
    
    if ([_delegate respondsToSelector:@selector(exitView)]) {
        [_delegate exitView];
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
