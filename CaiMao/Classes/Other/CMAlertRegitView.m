//
//  CMAlertRegitView.m
//  CaiMao
//
//  Created by MAC on 16/8/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAlertRegitView.h"

@implementation CMAlertRegitView

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
        regeistSuccess.text=@"注册成功!";
        regeistSuccess.font=[UIFont systemFontOfSize:20];
        regeistSuccess.textColor=UIColorFromRGB(0xfb3f19);
        regeistSuccess.textAlignment=NSTextAlignmentCenter;
        [contentView addSubview:regeistSuccess];
        [regeistSuccess mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@30);
            make.width.left.equalTo(contentView);
            
            make.top.equalTo(contentView.mas_top).offset(8);
        }];
        
        UIView *lineView=[UIView new];
        lineView.backgroundColor=UIColorFromRGB(0xcccccc);
        [contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.left.equalTo(contentView);
            
            make.top.equalTo(regeistSuccess.mas_bottom).offset(8);
            
        }];
        UILabel *detail=[UILabel new];
        detail.textAlignment=NSTextAlignmentCenter;
        detail.numberOfLines=0;
        detail.textColor=UIColorFromRGB(0x777475);
        detail.font=[UIFont systemFontOfSize:14];
        detail.text=@"手机用户注册成功,密码为手机号后6位，请及时修改密码。正在转到在线支付!";
        [contentView addSubview:detail];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@60);
            make.left.equalTo(contentView.mas_left).offset(10);
            make.right.equalTo(contentView.mas_right).offset(-10);
            make.top.equalTo(lineView.mas_bottom);
            
        }];
        
        
        
    }
    
    return self;
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
