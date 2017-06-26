//
//  CMCfbTopView.m
//  CaiMao
//
//  Created by MAC on 16/9/1.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMCfbTopView.h"

@implementation CMCfbTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=ViewBackColor;
        [self creatUiView];
    }
    return self;
}
-(void)creatUiView{
    
#pragma mark 财富宝余额
    UIImageView *topbgView=[[UIImageView alloc]init];
    topbgView.image=[UIImage imageNamed:@"xqybj"];
    topbgView.userInteractionEnabled=YES;
    [self addSubview:topbgView];
    [topbgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@170);
        make.width.top.left.equalTo(self);
    }];
    UILabel *cfYu=[[UILabel alloc]init];
    cfYu.text=@"财富宝余额(元)";
    cfYu.textColor=UIColorFromRGB(0xfed6c8);
    cfYu.font=[UIFont systemFontOfSize:16];
    cfYu.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:cfYu];
    [cfYu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@18);
        make.centerX.equalTo(topbgView.mas_centerX);
        make.width.equalTo(topbgView);
        make.top.equalTo(topbgView.mas_top).offset(20);
        
    }];
    UILabel *CaiYu=[[UILabel alloc]init];
    self.CFBYE=CaiYu;
    CaiYu.textColor=[UIColor whiteColor];
     CaiYu.textAlignment=NSTextAlignmentCenter;
    CaiYu.font=[UIFont systemFontOfSize:30];
    [topbgView addSubview:CaiYu];
    [CaiYu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.centerX.equalTo(topbgView.mas_centerX);
        make.width.equalTo(topbgView);
        make.top.equalTo(cfYu.mas_bottom).offset(8);
        
    }];
    
    UILabel *zuiGao=[[UILabel alloc]init];
    //zuiGao.frame=CGRectMake(13 , 39, 39, 20);
    zuiGao.font=[UIFont systemFontOfSize:14.0];
    zuiGao.text=@"最高 8.80% 年收益";
    zuiGao.textColor=[UIColor whiteColor];
    zuiGao.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:zuiGao];
    
    [zuiGao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CaiYu.mas_bottom).offset(10);
        make.centerX.equalTo(topbgView);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(15);
        
        
    }];
    UIButton *detaiBt=[UIButton buttonWithType:UIButtonTypeSystem];
    [detaiBt setBackgroundImage:[UIImage imageNamed:@"cfbht_wenhao_icon"] forState:UIControlStateNormal];
    self.detaibtn=detaiBt;
    [topbgView addSubview:detaiBt];
    [detaiBt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@15);
        make.top.equalTo(zuiGao);
        make.left.equalTo(zuiGao.mas_right);
        
    }];
    UIView *lefeLine=[[UIView alloc]init];
    lefeLine.backgroundColor=UIColorFromRGB(0xfe8565);
    
    [topbgView addSubview:lefeLine];
    [lefeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.width.equalTo(@60);
        make.right.equalTo(zuiGao.mas_left);
        make.top.equalTo(zuiGao.mas_centerY);
    }];
    UIView *rightLine=[[UIView alloc]init];
    rightLine.backgroundColor=UIColorFromRGB(0xfe8565);
    
    [topbgView addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.width.equalTo(@60);
        make.left.equalTo(detaiBt.mas_right).offset(2);
        make.top.equalTo(lefeLine);
    }];
    
    #pragma mark 财富宝说明
//UIColorFromRGB(0xfed6c8)
    UILabel *QiTou=[[UILabel alloc]init];
    QiTou.text=@"方便";
    QiTou.font=[UIFont systemFontOfSize:14.0];
    QiTou.textColor=[UIColor whiteColor];
    QiTou.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:QiTou];
    [QiTou mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@14);
        make.width.equalTo(@30);
        make.top.equalTo(zuiGao.mas_bottom).offset(25);
        make.centerX.equalTo(topbgView.mas_centerX);
    }];
    UIView *leftVLine=[[UIView alloc]init];
    leftVLine.backgroundColor=UIColorFromRGB(0xfe8565);
    
    [topbgView addSubview:leftVLine];
    [leftVLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.width.equalTo(@0.5);
        make.left.equalTo(QiTou.mas_left).offset(-40);
        make.top.equalTo(QiTou);
    }];
    
    UIView *rightVLine=[[UIView alloc]init];
    rightVLine.backgroundColor=UIColorFromRGB(0xfe8565);
    
    [topbgView addSubview:rightVLine];
    [rightVLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.width.equalTo(leftVLine);
        
        make.left.equalTo(QiTou.mas_right).offset(40);
        
    }];
    UILabel *QiXian=[[UILabel alloc]init];
    QiXian.text=@"活期";
    QiXian.font=[UIFont systemFontOfSize:14.0];
    QiXian.textColor=[UIColor whiteColor];
    QiXian.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:QiXian];
    [QiXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(QiTou);
        make.right.equalTo(leftVLine.mas_left).offset(-40);
        ;
    }];
    
    UILabel *shengYu=[[UILabel alloc]init];
    shengYu.text=@"安全";
    shengYu.font=[UIFont systemFontOfSize:14.0];
    shengYu.textColor=[UIColor whiteColor];
    shengYu.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:shengYu];
    [shengYu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(QiTou);
        make.left.equalTo(rightVLine.mas_right).offset(40);
    }];

    UILabel *SC=[[UILabel alloc]init];
    SC.text=@"随存随取";
    SC.font=[UIFont systemFontOfSize:12.0];
    SC.textColor=UIColorFromRGB(0xfed6c8);
    SC.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:SC];
    [SC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@14);
        make.width.equalTo(@100);
        make.top.equalTo(QiTou.mas_bottom).offset(5);
        make.centerX.equalTo(QiTou.mas_centerX);
    }];
    
    UILabel *DateIncrease=[[UILabel alloc]init];
    DateIncrease.text=@"收益每7日递增";
    DateIncrease.font=[UIFont systemFontOfSize:12.0];
    DateIncrease.textColor=UIColorFromRGB(0xfed6c8);
    DateIncrease.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:DateIncrease];
    [DateIncrease mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(SC);
        
        
        make.centerX.equalTo(QiXian.mas_centerX);
    }];
    
    UILabel *safe=[[UILabel alloc]init];
    safe.text=@"0风险";
    safe.font=[UIFont systemFontOfSize:12.0];
    safe.textColor=UIColorFromRGB(0xfed6c8);
    safe.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:safe];
    [safe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(SC);
        
        
        make.centerX.equalTo(shengYu.mas_centerX);
    }];
    
#pragma mark 财富宝真实收益
    UIView *bottomLine=[[UIView alloc]init];
    bottomLine.backgroundColor=UIColorFromRGB(0xd6d6d6);
    
    [self addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.width.equalTo(@0.5);
        make.centerX.equalTo(self.mas_centerX)
        ;
        make.top.equalTo(topbgView.mas_bottom).offset(10);
        
    }];
    UILabel *ZRSY=[[UILabel alloc]init];
    ZRSY.text=@"昨日收益(元)";
    ZRSY.font=[UIFont systemFontOfSize:14.0];
    ZRSY.textColor=UIColorFromRGB(0xbdbdbd);
    ZRSY.textAlignment=NSTextAlignmentCenter;
    [self addSubview:ZRSY];
    [ZRSY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.width.equalTo(@100);
        make.top.equalTo(bottomLine);
        make.centerX.equalTo(self.mas_centerX).offset(-CMScreenW/4.0);
    }];
    
    
    UILabel *DetailZRSY=[[UILabel alloc]init];
    self.yesterdayGain=DetailZRSY;
    DetailZRSY.font=[UIFont systemFontOfSize:20.0];
    DetailZRSY.textColor=UIColorFromRGB(0xfa3e19);
    DetailZRSY.textAlignment=NSTextAlignmentCenter;
    [self addSubview:DetailZRSY];
    [DetailZRSY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@20);
        make.width.equalTo(@100);
        make.top.equalTo(ZRSY.mas_bottom).offset(5);
        make.centerX.equalTo(ZRSY.mas_centerX);
    }];
    
    
    
    UILabel *LJSY=[[UILabel alloc]init];
    LJSY.text=@"累计收益(元)";
    LJSY.font=[UIFont systemFontOfSize:14.0];
    LJSY.textColor=UIColorFromRGB(0xbdbdbd);
    LJSY.textAlignment=NSTextAlignmentCenter;
    [self addSubview:LJSY];
    [LJSY mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.width.height.equalTo(ZRSY);
       make.centerX.equalTo(self.mas_centerX).offset(CMScreenW/4.0);;
    }];
    UILabel *DetailLJSY=[[UILabel alloc]init];
    self.totalGain=DetailLJSY;
    DetailLJSY.font=[UIFont systemFontOfSize:20.0];
    DetailLJSY.textColor=UIColorFromRGB(0xfa3e19);
    DetailLJSY.textAlignment=NSTextAlignmentCenter;
    [self addSubview:DetailLJSY];
    [DetailLJSY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(DetailZRSY);
        make.centerX.equalTo(LJSY.mas_centerX);
    }];
    
    UIView *bottomLine2=[[UIView alloc]init];
    bottomLine2.backgroundColor=UIColorFromRGB(0xd6d6d6);
    
    [self addSubview:bottomLine2];
    [bottomLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@0.5);
        make.width.left.equalTo(self);
     
       
        make.top.equalTo(DetailLJSY.mas_bottom).offset(10);
        
    }];
    
    
    UILabel *JieTi=[[UILabel alloc]init];
    JieTi.text=@"财富宝收益阶梯";
    JieTi.font=[UIFont systemFontOfSize:14.0];
    JieTi.textColor=UIColorFromRGB(0xbdbdbd);
    JieTi.textAlignment=NSTextAlignmentLeft;
    [self addSubview:JieTi];
    [JieTi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@15);
        make.width.equalTo(@100);
        make.top.equalTo(bottomLine2.mas_bottom).offset(8);
        make.left.equalTo(self.mas_left).offset(10);
    
    }];
    UIImage *tiIcon=[UIImage imageNamed:@"cfb_syijt"];
    UIImageView *imagev=[[UIImageView alloc]init];
    imagev.image=tiIcon;
    [self addSubview:imagev];
    [imagev mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(f_i5real(tiIcon.size.height));
        make.top.equalTo(JieTi.mas_bottom).offset(5);
        make.left.right.equalTo(self);
    }];
    
    NSArray *btnTittleArr=@[@"余额明细",@"转入记录",@"转出记录"];
    for (int i=0; i<btnTittleArr.count;i++) {
        
        UIButton *titleBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame=CGRectMake(i%3*(CMScreenW/3.0),f_i5real(tiIcon.size.height+10)+265, CMScreenW/3.0, f_i5real(30));
        [titleBtn setTitle:btnTittleArr[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [titleBtn setTitleColor:RedButtonColor forState:UIControlStateSelected];
        [titleBtn setBackgroundColor:[UIColor whiteColor]];
        titleBtn.tag=i+10;
        titleBtn.titleLabel.font=[UIFont systemFontOfSize:15.0];
        [titleBtn addTarget:self action:@selector(clickRecord:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            titleBtn.selected=YES;
           self.myBtn=titleBtn;
        }
        [self addSubview:titleBtn];
        
    }
//    UIView *Line=[[UIView alloc]init];
//    Line.backgroundColor=UIColorFromRGB(0xfe8565);
//    
//    [self addSubview:Line];
//    [Line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(f_i5real(0.5));
//        make.width.left.equalTo(self);
//        make.top.equalTo(self.mas_bottom);
//    }];
    redView=[[UIView alloc]init];
    redView.frame=CGRectMake(0, f_i5real(tiIcon.size.height+38)+265, CMScreenW/3.0, f_i5real(2));
    
    redView.backgroundColor=RedButtonColor;
    [self addSubview:redView];
    
}

-(void)clickRecord:(UIButton*)btn{
    
    
    if (self.myBtn==btn) {
        return;
    }
    
    //原来btn
    
    self.myBtn.selected=NO;
    //点击btn
    btn.selected=YES;
    self.myBtn=btn;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    //小红条
    redView.center=CGPointMake(btn.center.x, redView.center.y);
    //获得点击按钮的标题
    
    [UIView commitAnimations];
  
    self.CfbBlock(btn.tag);
}

@end
