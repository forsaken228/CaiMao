//
//  CMSendMsgAlert.m
//  CaiMao
//
//  Created by MAC on 16/10/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMSendMsgAlert.h"

@implementation CMSendMsgAlert

-(id)initWithAlert
{  self=[super init];
    if (self) {
        
        
        self.frame=CGRectMake(0, 0, CMScreenW, CMScreenH);
        //模糊视图
        UIView  *bgView=[[UIView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
        UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        
        [bgView addGestureRecognizer:tap];
        //弹框背景
        UIView *contentView=[[UIView alloc]init];
        //contentView.bounds=CGRectMake(0, 0, 452/2.0,187/2.0);
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(93.5);
            make.width.mas_equalTo(250);
            make.center.equalTo(self);
        }];
        
        
        
    

         UIButton *CancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //CancleBtn.frame=CGRectMake(20, 160, 260, 40);
        CancleBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        CancleBtn.titleLabel.font=[UIFont systemFontOfSize:12];
        [CancleBtn setTitleColor:RedButtonColor forState:UIControlStateNormal];
        CancleBtn.backgroundColor=[UIColor whiteColor];
//        CancleBtn.layer.cornerRadius=5.0;
//        CancleBtn.clipsToBounds=YES;
        [CancleBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [CancleBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [contentView addSubview:CancleBtn];
        [CancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(contentView.mas_bottom).offset(-27/2.0);
            make.width.left.equalTo(contentView);
            make.height.equalTo(@12);
        }];
        
        UILabel *line=[[UILabel alloc]init];
        line.backgroundColor=separateLineColor;
        [contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@0.5);
            make.left.equalTo(contentView.mas_left).offset(20);
            make.right.equalTo(contentView.mas_right).offset(-20);
            make.bottom.equalTo(CancleBtn.mas_top).offset(-10);
        }];
        
        //弹框顶部说明
        UILabel *label=[[UILabel alloc]init];
        label.text=@"已发送邀请给所有人,请耐心等待好友的加入";
//        CGSize rect=[label.text boundingRectWithSize:CGSizeMake(contentView.bounds.size.width-40, 50) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil].size;
        label.numberOfLines=0;
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:12.0];
        label.textColor=UIColorFromRGB(0x8e8d95);
        [contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.right.left.equalTo(line);
            make.top.equalTo(contentView.mas_top).offset(31/2.0);
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
    [self removeFromSuperview];
    
}
-(void)btnClick
{
    
    [self removeFromSuperview];
    
}

@end
