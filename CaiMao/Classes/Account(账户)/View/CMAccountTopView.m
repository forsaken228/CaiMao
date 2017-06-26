//
//  CMAccountTopView.m
//  CaiMao
//
//  Created by MAC on 16/7/14.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMAccountTopView.h"

@implementation CMAccountTopView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(0, 0, CMScreenW, 224);
        int labelHeight=21;
        int labelWidth=100;
        self.userInteractionEnabled=YES;
        UIView *zhanghuBg=[[UIView alloc]init];
        zhanghuBg.frame=CGRectMake(0, 0, CMScreenW, 180);
        zhanghuBg.userInteractionEnabled=YES;
        self.zhangBgView=zhanghuBg;
        [self addSubview:zhanghuBg];
        
        //增加渐变色
        //初始化渐变层
        CAGradientLayer *gradientLayer = [CAGradientLayer new];
        gradientLayer.frame = zhanghuBg.bounds;
        
        //设置渐变颜色方向
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        //设定颜色组
        gradientLayer.colors = @[(__bridge id)CMColor(255, 95, 41).CGColor, (__bridge id)CMColor(254,68,47).CGColor];
        //设定颜色分割点
        gradientLayer.locations = @[@(0.5f) ,@(1.0f)];
        [zhanghuBg.layer insertSublayer:gradientLayer atIndex:0];
        
        UILabel *user=[[UILabel alloc]init];
        //user.frame=CGRectMake(22, 14, 139, 21);
        self.userLabl=user;
        user.font=[UIFont systemFontOfSize:13.0];
        user.textColor=[UIColor whiteColor];
        [zhanghuBg addSubview:user];
        [user mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(zhanghuBg.mas_left).offset(22);
            make.top.equalTo(zhanghuBg.mas_top).offset(14);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(139);
            
        }];
    
        UIButton *vip=[UIButton buttonWithType:UIButtonTypeSystem];
        //vip.frame=CGRectMake(261, 18, 59, 16);
        [vip setBackgroundImage:[UIImage imageNamed:@"vip_putong"] forState:UIControlStateNormal];
        self.vipBtn=vip;
        [zhanghuBg addSubview:vip];
        
        [vip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top).offset(18);
            make.height.mas_equalTo(17);
            make.width.mas_equalTo(59);
            
        }];
        
        UILabel *todayGain=[[UILabel alloc]init];
        //todayGain.frame=CGRectMake(98, 45, 124, 21);
        //todayGain.text=@"今日收益 (元)";
        todayGain.text=@"总资产 (元)";
        todayGain.alpha=0.8;
        todayGain.textAlignment=NSTextAlignmentCenter;
        todayGain.font=[UIFont systemFontOfSize:15.0];
        todayGain.textColor=[UIColor whiteColor];
        [zhanghuBg addSubview:todayGain];
        [todayGain mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(self.mas_top).offset(45);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(124);
            
        }];
        
        UILabel *todayGainMoney=[[UILabel alloc]init];
        //todayGainMoney.frame=CGRectMake(69, 73, 182, 39);
        self.zongZiLab=todayGainMoney;
       todayGainMoney.text=@"0.00";
     todayGainMoney.textAlignment=NSTextAlignmentCenter;
        todayGainMoney.font=[UIFont systemFontOfSize:30.0];
        todayGainMoney.textColor=[UIColor whiteColor];
        [zhanghuBg addSubview:todayGainMoney];
        
        [todayGainMoney mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(todayGain.mas_bottom).offset(10);
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(180);
            
            
        }];
        UIButton *BZongZi=[UIButton buttonWithType:UIButtonTypeSystem];
        [BZongZi setTitle:@" >>" forState:UIControlStateNormal];
        [BZongZi setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        BZongZi.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        BZongZi.titleLabel.font=[UIFont systemFontOfSize:20.0];
        self.ZongZiBtn=BZongZi;
        //[BZongZi setBackgroundColor:[UIColor clearColor]];
        [zhanghuBg addSubview:BZongZi];
        [BZongZi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(labelHeight);
            make.width.equalTo(@80);
            make.centerY.equalTo(todayGainMoney.mas_centerY);
            make.left.equalTo(todayGainMoney.mas_right).offset(5);
            
        }];
        
        UILabel *yuEOut=[[UILabel alloc]init];
        //yuEOut.frame=CGRectMake(111, 148, 98, 21);
        yuEOut.text=@"可用金额 (元)";
        yuEOut.alpha=0.8;
        yuEOut.textAlignment=NSTextAlignmentCenter;
        yuEOut.font=[UIFont systemFontOfSize:13.0];
        yuEOut.textColor=[UIColor whiteColor];
        [zhanghuBg addSubview:yuEOut];
        
        [yuEOut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(zhanghuBg.mas_bottom).offset(-10);
            //make.left.equalTo(zhanghuBg.mas_left).offset(3);
            make.centerX.equalTo(zhanghuBg.mas_centerX);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(labelWidth);
            
            
        }];
        
        UILabel *yuE=[[UILabel alloc]init];
        //yuE.frame=CGRectMake(111, 130, 98, 21);
        self.zhangYuLab=yuE;
        yuE.text=@"0.00";
        yuE.textAlignment=NSTextAlignmentCenter;
        yuE.font=[UIFont systemFontOfSize:15.0];
        yuE.textColor=[UIColor whiteColor];
        [zhanghuBg addSubview:yuE];
        
        [yuE mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(yuEOut.mas_top).offset(-1);;
            make.centerX.equalTo(zhanghuBg.mas_centerX);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(labelWidth);
            
            
        }];
        
        
        
        
        
        UIView *line=[UIView new];
        // line.frame=CGRectMake(106, 134, 1, 35);
        line.backgroundColor=[UIColor whiteColor];
        line.alpha=0.4;
        [zhanghuBg addSubview:line];
        
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(yuE.mas_centerY).offset(-5);
            
            make.right.equalTo(yuEOut.mas_left).offset(-10);
            make.height.mas_equalTo(35);
            make.width.mas_equalTo(0.5);
            
            
        }];
        
        
        UILabel *leijiOut=[[UILabel alloc]init];
        //leijiOut.frame=CGRectMake(3, 148, 98, 21);
        leijiOut.text=@"累计收益 (元)";
        leijiOut.textAlignment=NSTextAlignmentCenter;
        leijiOut.font=[UIFont systemFontOfSize:13.0];
        leijiOut.textColor=[UIColor whiteColor];
        leijiOut.alpha=0.8;
        [zhanghuBg addSubview:leijiOut];
        
        [leijiOut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(yuEOut);
            make.right.equalTo(line.mas_left).offset(-8);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(labelWidth);
            
            
        }];
        
        UILabel *leiji=[[UILabel alloc]init];
        //leiji.frame=CGRectMake(3, 130, 98, 21);
        self.leijiShouyiLab=leiji;
        leiji.text=@"0.00";
        leiji.textAlignment=NSTextAlignmentCenter;
        leiji.font=[UIFont systemFontOfSize:15.0];
        leiji.textColor=[UIColor whiteColor];
        [zhanghuBg addSubview:leiji];
        [leiji mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(yuE);
            //make.left.equalTo(zhanghuBg.mas_left).offset(3);
            make.left.equalTo(leijiOut.mas_left);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(labelWidth);
            
            
        }];
        
        UIView *line1=[UIView new];
        // line1.frame=CGRectMake(214, 134, 1, 35);
        line1.backgroundColor=[UIColor whiteColor];
        line1.alpha=0.4;
        [zhanghuBg addSubview:line1];
        
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            // make.bottom.equalTo(zhanghuBg.mas_bottom).offset(-5);
            
            make.left.equalTo(yuEOut.mas_right).offset(10);
            //        make.height.mas_equalTo(35);
            //        make.width.mas_equalTo(1);
            make.height.width.bottom.equalTo(line);
            
        }];
        
        
        UILabel *totalLabel=[[UILabel alloc]init];
        //totalLabel.frame=CGRectMake(219, 148, 98, 21);
       //totalLabel.text=@"总资产 (元)";
        totalLabel.text=@"今日收益 (元)";
        totalLabel.alpha=0.8;
        totalLabel.textAlignment=NSTextAlignmentCenter;
        totalLabel.font=[UIFont systemFontOfSize:13.0];
        totalLabel.textColor=[UIColor whiteColor];
        [zhanghuBg addSubview:totalLabel];
        
        [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(yuEOut);
            //make.left.equalTo(zhanghuBg.mas_left).offset(3);
            make.left.equalTo(line1.mas_right).offset(8);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(labelWidth);
            
            
        }];
        
        
        UILabel *total=[[UILabel alloc]init];
        //  total.frame=CGRectMake(217, 130, 98, 21);
        self.jinShouYiLab=total;
        total.text=@"0.00";
        total.textAlignment=NSTextAlignmentCenter;
        total.font=[UIFont systemFontOfSize:15.0];
        total.textColor=[UIColor whiteColor];
        [zhanghuBg addSubview:total];
        
        [total mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(yuE);
            //make.left.equalTo(zhanghuBg.mas_left).offset(3);
            make.right.equalTo(totalLabel);
            make.height.mas_equalTo(labelHeight);
            make.width.mas_equalTo(labelWidth);
            
            
        }];
        
        
        
        UIButton *chongzhi=[UIButton buttonWithType:UIButtonTypeCustom];
        chongzhi.frame=CGRectMake(0, 180, [UIScreen mainScreen].bounds.size.width/2.0, 224-180);
        [chongzhi setImage:[UIImage imageNamed:@"充值"] forState:UIControlStateNormal];
        chongzhi.imageEdgeInsets=UIEdgeInsetsMake(0, -15, 0, 0);
        [chongzhi setTitle:@"充值" forState:UIControlStateNormal];
        self.chongzhiBtn=chongzhi;
        [chongzhi setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        chongzhi.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [chongzhi setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:chongzhi];
        
        
        UIButton *tiXian=[UIButton buttonWithType:UIButtonTypeCustom];
        tiXian.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2.0, 180, [UIScreen mainScreen].bounds.size.width/2.0, 224-180);
        self.tiXianBtn=tiXian;
         tiXian.imageEdgeInsets=UIEdgeInsetsMake(0, -15, 0, 0);
        [tiXian setImage:[UIImage imageNamed:@"提现"] forState:UIControlStateNormal];
        [tiXian setTitle:@"提现" forState:UIControlStateNormal];
    tiXian.titleLabel.font=[UIFont systemFontOfSize:16.0];
        [tiXian setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
        [tiXian setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:tiXian];
        UIView *line3=[UIView new];
        line3.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2.0, 180, 0.5, 224-180);
        line3.backgroundColor=separateLineColor;
        [self addSubview:line3];

    }
    
    
    return self;
}

@end
