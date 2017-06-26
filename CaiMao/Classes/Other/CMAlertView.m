//
//  CMAlertView.m
//  CaiMao
//
//  Created by MAC on 16/6/15.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAlertView.h"

@implementation CMAlertView



-(id)initWithCancleButtonTitle:(NSString *)CancleTitle WithTitle:(NSString*)aTitle WithDetailUp:(NSString*)aDetailUp WithDetaildown:(NSString*)aDetaildown
{  self=[super init];
    if (self) {
        
        
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
      UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.52f;
        [self addSubview:bgView];
        UITapGestureRecognizer  *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        
        [bgView addGestureRecognizer:tap];
        //弹框背景
UIImageView *contentView=[[UIImageView alloc]init];
        contentView.center=bgView.center;
        contentView.bounds=CGRectMake(0, 0, 300,210);
        contentView.backgroundColor=[UIColor whiteColor];
        contentView.userInteractionEnabled=YES;
        contentView.layer.cornerRadius=5.0;
        contentView.clipsToBounds=YES;
        [self addSubview:contentView];
        
        
        
        
         //弹框标题
        UILabel *topTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, contentView.bounds.size.width, 30)];
//        topTitle.layer.cornerRadius=5.0;
//        topTitle.clipsToBounds=YES;
        topTitle.font=[UIFont systemFontOfSize:14];
        topTitle.text=aTitle;
        topTitle.textColor=[UIColor whiteColor];
        topTitle.textAlignment=NSTextAlignmentCenter;
        topTitle.backgroundColor=RedButtonColor;
        [contentView addSubview:topTitle];
        //弹框顶部说明
                   UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10,40, contentView.bounds.size.width-20, 60)];
                    label1.text=aDetailUp;
                    label1.numberOfLines=0;
                    label1.font=[UIFont systemFontOfSize:14];
                    label1.textColor=CMColor(77, 77, 77);
                    [contentView addSubview:label1];
        
        //
        //            //弹框底部说明
                    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 90, contentView.bounds.size.width-20, 70)];
                    label2.text=aDetaildown;
                    label2.numberOfLines=0;
                    label2.textColor=CMColor(77, 77, 77);
                    label2.font=[UIFont systemFontOfSize:14];
                    [contentView addSubview:label2];
            //
                    UIButton *CancleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
                    CancleBtn.frame=CGRectMake(20, 160, 260, 40);
                    CancleBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
                    CancleBtn.titleLabel.font=[UIFont systemFontOfSize:14];
                    CancleBtn.titleLabel.textColor=[UIColor whiteColor];
                    CancleBtn.backgroundColor=RedButtonColor;
                    CancleBtn.layer.cornerRadius=5.0;
                    CancleBtn.clipsToBounds=YES;
                    [CancleBtn setTitle:CancleTitle forState:UIControlStateNormal];
                    [CancleBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
                    
                    [contentView addSubview:CancleBtn];
            
            


    }
    
    return self;
    
}

// //展示alertView
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
