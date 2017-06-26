//
//  CMEndAlertView.m
//  CaiMao
//
//  Created by MAC on 16/11/11.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMEndAlertView.h"

@implementation CMEndAlertView

-(id)initCMSmsCodeAlertWithTitle:(NSString *)msg{
    self=[super init];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        [bgView addGestureRecognizer:tap];
        //弹框背景
        UIImageView *contentView=[[UIImageView alloc]init];
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.layer.masksToBounds=YES;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(bgView.mas_centerX);
            make.centerY.equalTo(bgView.mas_centerY);
            make.width.mas_equalTo(210);
            make.height.mas_equalTo(100);
            
        }];
        
        //弹框顶部说明
        UILabel *label=[[UILabel alloc]init];
        label.textAlignment=NSTextAlignmentCenter;
        label.numberOfLines=0;
        // label.text=@"验证码已发送到您手机,3分钟之后失效";
        label.text=msg;
        label.font=[UIFont systemFontOfSize:12.0];
        label.textColor=UIColorFromRGB(0x333333);
        [contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(contentView.mas_top).offset(5);
            make.left.equalTo(contentView.mas_left).offset(5);
            make.right.equalTo(contentView.mas_right).offset(-5);
            make.height.mas_equalTo(50);
            
        }];
        UILabel *line=[UILabel new];
        line.backgroundColor=separateLineColor;
        [contentView addSubview:line];
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.width.left.equalTo(contentView);
            make.top.equalTo(label.mas_bottom).offset(10);
        }];
        UIButton *CancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        CancleBtn.titleLabel.font=[UIFont boldSystemFontOfSize:14];
        [CancleBtn setTitleColor:RedButtonColor forState:UIControlStateNormal];
        [CancleBtn setTitle:@"确定" forState:UIControlStateNormal];
        [CancleBtn addTarget:self action:@selector(dismissView) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:CancleBtn];
        [CancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(line.mas_bottom).offset(5);
            make.left.width.equalTo(contentView);
            make.height.mas_equalTo(20);
            
        }];
        
        
        
        
    }
    return self;
}
-(void)ShowAlert
{
    UIWindow *window=[[[UIApplication sharedApplication]delegate]window];
    // //展示alertView,将alertView展示在window
    [window addSubview:self];
    
}
-(void)dismissView{
    
  [self DissAlert];
   self.block();
    
}
-(void)DissAlert{
     [self removeFromSuperview];
    
}
@end
