//
//  CMMyIntegral.m
//  CaiMao
//
//  Created by MAC on 16/9/6.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMMyIntegral.h"

@implementation CMMyIntegral

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        UIImageView *bgImage=[[UIImageView alloc]init];
        bgImage.userInteractionEnabled=YES;
        bgImage.image=[UIImage imageNamed:@"wdjf_background"];
        [self addSubview:bgImage];
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(f_i5real(100));
            make.width.top.left.equalTo(self);
            
        }];
        UILabel *Yqing=[[UILabel alloc]init];
        Yqing.text=@"我的积分";
        Yqing.font=[UIFont systemFontOfSize:15.0];
        Yqing.textColor=[UIColor whiteColor];
        Yqing.textAlignment=NSTextAlignmentCenter;
        [bgImage addSubview:Yqing];
        [Yqing mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@20);
            make.width.equalTo(@200);
            make.top.equalTo(bgImage.mas_top).offset(15);
            make.centerX.equalTo(bgImage.mas_centerX);
            
        }];
        UILabel *JF=[[UILabel alloc]init];
        self.MyIntegral=JF;
        JF.textAlignment=NSTextAlignmentCenter;
        JF.font=[UIFont systemFontOfSize:30.0];
        JF.textColor=[UIColor whiteColor];
        [bgImage addSubview:JF];
        [JF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.width.equalTo(@150);
            make.top.equalTo(Yqing.mas_bottom).offset(5);
            make.centerX.equalTo(bgImage.mas_centerX);
            
        }];
     
       
            CMDuiHuanButton *duihuan=[[CMDuiHuanButton alloc]initWithImageView:@"wdjf_dhjl" andButton:@"兑换记录"];
            duihuan.frame=CGRectMake(0, f_i5real(100), CMScreenW/2.0,f_i5real(45) );
            duihuan.tag=10;
            self.myDuiHuanRecord=duihuan;
        [duihuan.MyIntegralBtn addTarget:self action:@selector(duiHuanOrJIFen:)];
        
            [self addSubview:duihuan];
     
        CMDuiHuanButton *duihuan1=[[CMDuiHuanButton alloc]initWithImageView:@"wdjf_jfmx" andButton:@"积分明细"];
        duihuan1.frame=CGRectMake(CMScreenW/2.0, f_i5real(100), CMScreenW/2.0,f_i5real(45) );
        duihuan1.tag=11;
        self.myJFMx=duihuan1;
        
        [duihuan1.MyIntegralBtn addTarget:self action:@selector(duiHuanOrJIFen:)];
        [self addSubview:duihuan1];
        
        UIView *moveView=[[UIView alloc]init];
        moveView.frame=CGRectMake(0,f_i5real(143), CMScreenW/2.0, 2);
        moveView.backgroundColor=RedButtonColor;
        self.IntegralRedView=moveView;
        [self addSubview:moveView];
        
        
        UILabel *detail=[[UILabel alloc]init];
        detail.text=@"以下是本期18节(19日-次月18日24:00)积分的变化记录";
        detail.textAlignment=NSTextAlignmentCenter;
        detail.font=[UIFont systemFontOfSize:12.0];
        detail.textColor=UIColorFromRGB(0x818181);
        detail.backgroundColor=ViewBackColor;
        [self addSubview:detail];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@30);
            make.width.left.equalTo(self);
            make.top.equalTo(moveView.mas_bottom);
        }];
        [self LoadMyTotalImtegral];
        
    }
    return self;
}

-(void)duiHuanOrJIFen:(UITapGestureRecognizer*)tap{

    [UIView animateWithDuration:0.3 animations:^{
       self.IntegralRedView.center=CGPointMake(tap.view.center.x, self.IntegralRedView.center.y);
    }];
    

    if([self.delegate respondsToSelector:@selector(tapClickEventWithIndex:)]){
        [self.delegate tapClickEventWithIndex:tap.view.tag];
    }
    
}
#define mark 我的积分
-(void)LoadMyTotalImtegral{
    
    [CMRequestHandle myTotalJiFenWithUserID:[CMUserDefaults objectForKey:@"userID"] andSuccess:^(id responseObj) {
  
        if([[responseObj objectForKey:@"Status"]intValue]==200){
            self.MyIntegral.text=[responseObj objectForKey:@"Result"];
        }
        
    }];
    
    
    
    
}
@end
