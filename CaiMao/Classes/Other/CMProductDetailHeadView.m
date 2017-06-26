//
//  CMProductDetailHeadView.m
//  CaiMao
//
//  Created by MAC on 16/8/9.
//  Copyright © 2016年 58cm. All rights reserved.
//
#define LineHeight 0.5
#import "CMProductDetailHeadView.h"

@implementation CMProductDetailHeadView

-(instancetype)init{
    self =[super init];
    if (self) {
       self.backgroundColor=ViewBackColor;
        [self creatHeadView];
    }
    return self;
}
#pragma mark 创建view
-(void)creatHeadView{
#pragma mark 顶部背景
    UIImageView *topbgView=[[UIImageView alloc]init];
    self.topBg=topbgView;
    topbgView.image=[UIImage imageNamed:@"xqybj"];
     [self addSubview:topbgView];
    [topbgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@260);
        make.width.top.left.equalTo(self);
    }];
   
    
    UIImageView *HubgView=[[UIImageView alloc]init];
     HubgView.image=[UIImage imageNamed:@"cpxq_bj"];
    self.hubImage=HubgView;
    [topbgView addSubview:HubgView];
    [HubgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@110);
        make.width.equalTo(@250);
        make.centerX.equalTo(topbgView.mas_centerX);
        make.top.equalTo(topbgView).offset(10);
    }];
    
    
    
    UILabel *zhengShu=[[UILabel alloc]init];
    self.ShouYiZheng=zhengShu;
    zhengShu.textColor=[UIColor whiteColor];
    zhengShu.font=[UIFont systemFontOfSize:40];
    zhengShu.textAlignment=NSTextAlignmentRight;
    [topbgView addSubview:zhengShu];
    [zhengShu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@45);
        make.width.equalTo(@50);
        make.top.equalTo(HubgView).offset(35);
        make.right.equalTo(topbgView.mas_centerX).offset(-10);
    }];
    
   
    UILabel *shouYi=[[UILabel alloc]init];
    shouYi.text=YuQiShouYi;
    shouYi.textColor=[UIColor whiteColor];
    shouYi.font=[UIFont systemFontOfSize:12.0];
    [topbgView addSubview:shouYi];
    [shouYi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@13);
        make.width.equalTo(@90);
        make.top.equalTo(zhengShu.mas_centerY).offset(2);
        make.left.equalTo(zhengShu.mas_right).offset(5);
    }];
    UILabel *xiaoShu=[[UILabel alloc]init];
    self.ShouYiXiao=xiaoShu;
    xiaoShu.textColor=[UIColor whiteColor];
    xiaoShu.font=[UIFont systemFontOfSize:15];
    [topbgView addSubview:xiaoShu];
    [xiaoShu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.left.equalTo(shouYi);
        make.width.equalTo(@50);
        make.bottom.equalTo(zhengShu.mas_centerY).offset(-2);
        
    }];
    
    
    
    UILabel *percent=[[UILabel alloc]init];
    //percent.frame=CGRectMake(117 , 77, 52, 20);
    percent.textColor=[UIColor whiteColor];
    percent.textAlignment=NSTextAlignmentCenter;
    percent.font=[UIFont systemFontOfSize:11.0];
    self.juQiShilv=percent;
    [self addSubview:percent];
    [percent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@12);
        make.bottom.equalTo(shouYi);
        make.width.equalTo(@45);
        make.left.equalTo(shouYi.mas_right);
    }];
    
    UIImageView *sanjiao=[[UIImageView alloc]init];
    self.smallSj=sanjiao;
    sanjiao.image=[UIImage imageNamed:@"cpxq_jt"];
    [topbgView addSubview:sanjiao];
    [sanjiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@8);
        make.left.equalTo(percent.mas_right);
        make.bottom.equalTo(percent.mas_bottom).offset(-3);
    }];
    
    UIImageView *bord=[[UIImageView alloc]init];
    bord.image=[UIImage imageNamed:@"xqybj_bk"];
    [topbgView addSubview:bord];
    [bord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@25);
        make.width.equalTo(@220);
        make.centerX.equalTo(topbgView.mas_centerX);
        make.top.equalTo(zhengShu.mas_bottom).offset(10);
    }];
    
 
    UIImageView *blackSign=[[UIImageView alloc]init];

    blackSign.image=[UIImage imageNamed:@"cpxq_sj_ic"];
    [topbgView addSubview:blackSign];
    [blackSign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@15);
        make.left.equalTo(bord).offset(5);
        make.centerY.equalTo(bord);
    }];
    UILabel *endTimeLabel=[[UILabel alloc]init];
    self.endTime=endTimeLabel;
    endTimeLabel.textAlignment=NSTextAlignmentRight;
    endTimeLabel.font=[UIFont systemFontOfSize:12.0];
    endTimeLabel.textColor=UIColorFromRGB(0xfef0ea);
    [self addSubview:endTimeLabel];
    [endTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@13);
        make.width.equalTo(@95);
        make.left.equalTo(blackSign.mas_right);
        make.top.equalTo(bord.mas_top).offset(6);
        
    }];
  
    
    UILabel *jPeopleNum=[[UILabel alloc]init];
    self.JinPaiPeopleNum=jPeopleNum;
    jPeopleNum.textAlignment=NSTextAlignmentLeft;
    jPeopleNum.font=[UIFont systemFontOfSize:12.0];
    jPeopleNum.textColor=UIColorFromRGB(0xfef0ea);
    [topbgView addSubview:jPeopleNum];
    [jPeopleNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.equalTo(endTimeLabel);
        make.width.equalTo(@60);
        make.right.equalTo(bord.mas_right).offset(-2);
        
    }];
    UIImageView *blackSign2=[[UIImageView alloc]init];
    blackSign2.image=[UIImage imageNamed:@"cpxq_ren_ic"];
    
    [topbgView addSubview:blackSign2];
    [blackSign2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(jPeopleNum.mas_left).offset(-3);
        make.top.width.equalTo(blackSign);
        make.height.equalTo(@12);
    }];
 #pragma mark 底部
    UIView *Tline=[[UIView alloc]init];
    Tline.backgroundColor=UIColorFromRGB(0xfe8565);
    self.horneLine=Tline;
    [topbgView addSubview:Tline];
    [Tline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@1.3);
        make.left.equalTo(topbgView.mas_left).offset(8);
        make.right.equalTo(topbgView.mas_right).offset(-8);
        make.centerY.equalTo(topbgView.mas_centerY).offset(25);
    }];
    UILabel *QiTouJin=[[UILabel alloc]init];
    self.QITouJinEr=QiTouJin;
    QiTouJin.font=[UIFont systemFontOfSize:14.0];
    
    QiTouJin.textColor=[UIColor whiteColor];
    QiTouJin.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:QiTouJin];
    [QiTouJin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@14);
        make.width.equalTo(@80);
        make.bottom.equalTo(topbgView.mas_bottom).offset(-8);
        make.centerX.equalTo(topbgView.mas_centerX).offset(-30);
        
    }];
    UILabel *QiTou=[[UILabel alloc]init];
    QiTou.text=@"起投金额";
    QiTou.font=[UIFont systemFontOfSize:14.0];
    QiTou.textColor=UIColorFromRGB(0xfed6c8);
    QiTou.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:QiTou];
    [QiTou mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.width.centerX.equalTo(QiTouJin);
       
        make.bottom.equalTo(QiTouJin.mas_top).offset(-8);
       
    }];


    UILabel *QiXian=[[UILabel alloc]init];
    QiXian.text=@"投资期限";
    QiXian.font=[UIFont systemFontOfSize:14.0];
    QiXian.textColor=UIColorFromRGB(0xfed6c8);
    QiXian.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:QiXian];
    [QiXian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(QiTou);
        make.left.equalTo(topbgView.mas_left).offset(8);
    }];
   
    UILabel *QiXianTime=[[UILabel alloc]init];
    self.QIXian=QiXianTime;
    QiXianTime.font=[UIFont systemFontOfSize:14.0];
   QiXianTime.textColor=[UIColor whiteColor];
    QiXianTime.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:QiXianTime];
    [QiXianTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.left.equalTo(QiXian);
        make.top.equalTo(QiTouJin);
    }];
    
    
   
    
    UILabel *shengYuNum=[[UILabel alloc]init];
    self.SFenShu=shengYuNum;
    shengYuNum.font=[UIFont systemFontOfSize:14.0];
     shengYuNum.textColor=[UIColor whiteColor];
    shengYuNum.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:shengYuNum];
    [shengYuNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(QiTouJin);
        make.right.equalTo(topbgView.mas_right);
        make.width.equalTo(@150);
        make.top.equalTo(QiTouJin);
    }];
    
    UILabel *shengYu=[[UILabel alloc]init];
    shengYu.text=@"剩余份数";
    shengYu.font=[UIFont systemFontOfSize:14.0];
    shengYu.textColor=UIColorFromRGB(0xfed6c8);
    shengYu.textAlignment=NSTextAlignmentCenter;
    [topbgView addSubview:shengYu];
    [shengYu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.equalTo(QiTou);
        make.centerX.equalTo(shengYuNum);
    }];
  #pragma mark 活动
//    UILabel *active=[[UILabel alloc]init];
//    self.ActiveDetail=active;
//    active.font=[UIFont systemFontOfSize:13.0];
//    active.textColor=[UIColor redColor];
//    active.textAlignment=NSTextAlignmentCenter;
//    [self addSubview:active];
//  [active mas_makeConstraints:^(MASConstraintMaker *make) {
//     
//      make.height.equalTo(@13);
//      make.top.equalTo(topbgView.mas_bottom).offset(8);
//      make.left.right.equalTo(self);
//      
//  }];
    
    
    float inteval=((CMScreenW-60)-55*4)/3;
    for (int i=0; i<4; i++) {
        CMJuHaiPercentView  *percentView=[[CMJuHaiPercentView alloc]init];
        percentView.personer.textColor=[UIColor whiteColor];
        percentView.perecent.textColor=[UIColor whiteColor];
        percentView.frame=CGRectMake(i%4*(55+inteval)+30,127.5, 55, 55);
        [topbgView addSubview:percentView];
        switch (i) {
            case 0:
                self.juImage1=percentView;
                self.juRen1=percentView.personer;
                self.juShou1=percentView.perecent;
                break;
            case 1:
                self.juImage2=percentView;
                self.juRen2=percentView.personer;
                self.juShou2=percentView.perecent;
                break;
            case 2:
                self.juImage3=percentView;
                self.juRen3=percentView.personer;
                self.juShou3=percentView.perecent;
                break;
            case 3:
                self.juImage4=percentView;
                self.juRen4=percentView.personer;
                self.juShou4=percentView.perecent;
                break;
                
            default:
                break;
        }
        
        
    }
    

    UILabel *hai=[[UILabel alloc]init];
    self.HaiPeopleNum=hai;
    hai.hidden=YES;
    hai.font=[UIFont systemFontOfSize:13.0];
    hai.textAlignment=NSTextAlignmentCenter;
    hai.textColor=UIColorFromRGB(0xfed6c8);
    [topbgView addSubview:hai];
    [hai mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.juImage1.mas_bottom).offset(5);
        make.height.equalTo(@15);
        make.centerX.equalTo(topbgView.mas_centerX);
        make.width.equalTo(topbgView);

    }];
    
    UILabel *QXHL=[[UILabel alloc]init];
    QXHL.backgroundColor=UIColorFromRGB(0xfe8565);
    [topbgView addSubview:QXHL];
    [QXHL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.top.equalTo(QiXian);
        make.width.equalTo(@0.5);
        make.right.equalTo(QiTou.mas_left).offset(-5);
    }];
    UILabel *QXHL2=[[UILabel alloc]init];
    QXHL2.backgroundColor=UIColorFromRGB(0xfe8565);
    [topbgView addSubview:QXHL2];
    [QXHL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.top.equalTo(QiXian);
        make.width.equalTo(@0.5);
        make.left.equalTo(QiTou.mas_right).offset(5);
    }];
    
}

#pragma mark set
-(void)setProductDict:(NSDictionary *)productDict{
    _productDict=productDict;
#pragma mark  收益率
    float shouyi = [[productDict objectForKey:@"nlv_max"]floatValue];
    int x = (int)shouyi;
    self.ShouYiZheng.text = [NSString stringWithFormat:@"%.0f",floorf(shouyi)];
    if ((shouyi-(float)x)*100 == 0) {
        self.ShouYiXiao.text = [[NSString stringWithFormat:@".00"] stringByAppendingString:@"%"];
    } else {
        self.ShouYiXiao.text = [[NSString stringWithFormat:@".%.f",(shouyi-(float)x)*100] stringByAppendingString:@"%"];
    }
    
#pragma mark投资期限
    
    int QiXian=[[productDict objectForKey:@"jkqx_dw"]intValue];
    if (QiXian == 1) {    // 期限->天
        self.QIXian.text = [NSString stringWithFormat:@"%@天",[productDict objectForKey:@"jkqx"]];
        [NSString LoneAttributedFontStringEndString:@"天" FromLabel:self.QIXian];
        
    } else if (QiXian == 2) { // 期限->月
        self.QIXian.text = [NSString stringWithFormat:@"%@个月",[productDict objectForKey:@"jkqx"]];
        [NSString LoneAttributedFontStringEndString:@"个" FromLabel: self.QIXian];
        
    } else {                            // 期限->年
        self.QIXian.text = [NSString stringWithFormat:@"%@年",[productDict objectForKey:@"jkqx"]];
        [NSString LoneAttributedFontStringEndString:@"年" FromLabel: self.QIXian];
    }
#pragma mark 起投金额
    self.QITouJinEr.text=[NSString stringWithFormat:@"%@元",[productDict objectForKey:@"cpfe"]];
    [NSString LoneAttributedFontStringEndString:@"元" FromLabel:self.QITouJinEr];
    
#pragma mark  已拍人数
    NSString *renshu=[productDict objectForKey:@"jpRenShu"];
    if ([renshu isEqualToString:@""]||[renshu intValue]==0) {
        self.JinPaiPeopleNum.text= [NSString stringWithFormat:@"%@人已拍",[productDict objectForKey:@"jbcnt"]];
       
    }else{
        self.JinPaiPeopleNum.text= [NSString stringWithFormat:@"%@人已拍",[productDict objectForKey:@"jpRenShu"]];
    
    }
    
  
    
    
}
-(void)setLiCaiDeati:(CMLiCaiDetailController *)LiCaiDeati{
    
      [LiCaiDeati statisticalPage:[NSString stringWithFormat:@"%@+%@",[_productDict objectForKey:@"title"],self.QIXian.text]];
}

@end
