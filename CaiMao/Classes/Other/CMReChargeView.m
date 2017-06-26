//
//  CMReChargeView.m
//  CaiMao
//
//  Created by MAC on 16/7/16.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMReChargeView.h"

@implementation CMReChargeView

-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.frame=[UIScreen mainScreen].bounds;
        //银行卡标志
        UIImageView *bg=[[UIImageView alloc]init];
        //bg.frame=CGRectMake(13,15, 105, 36);
        self.bankIcon=bg;
        [self addSubview:bg];
        [bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(self.mas_top).offset(15);
            make.height.mas_equalTo(36);
            make.width.mas_equalTo(105);
            
            
        }];
        
        
        
        //分割线
        UIView *line=[[UIView alloc]init];
        // line.frame=CGRectMake(130, 20, 1, 30);
        line.backgroundColor=separateLineColor;
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bg.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(20);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(0.5);
            
            
        }];
        
        //银行卡名
        UILabel *tBankName=[[UILabel alloc]init];
        // tBankName.frame=CGRectMake(140 , 20 ,150,30 );
        tBankName.font=[UIFont systemFontOfSize:14];
        tBankName.textColor=CMColor(77, 77, 77);
        self.bankNum=tBankName;
        [self addSubview:tBankName];
        [tBankName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(line.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(20);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(150);
            
            
        }];
        
        UILabel *bgLabel=[[UILabel alloc]init];
        // tLimit.frame=CGRectMake(0 , 67 ,self.view.bounds.size.width,30);
        
        bgLabel.userInteractionEnabled=YES;
        bgLabel.backgroundColor=ViewBackColor;
        [self addSubview:bgLabel];
        [bgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(30);
            make.width.left.equalTo(self);
            make.top.equalTo(bg.mas_bottom).offset(15);
            
        }];
        
        
        
        //限额说明
        UIButton *tLimitContent=[UIButton buttonWithType:UIButtonTypeCustom];
        // tLimitContent.frame=CGRectMake(248, 67, 64, 30);
        [tLimitContent setImage:[UIImage imageNamed:@"detail_pressed"] forState:UIControlStateNormal];
        tLimitContent.imageEdgeInsets=UIEdgeInsetsMake(0, -3, 0, 14);
        tLimitContent.titleLabel.font=[UIFont systemFontOfSize:13];
        [tLimitContent setTitle:@"限额说明" forState:UIControlStateNormal];
        [tLimitContent setTitleColor:UIColorFromRGB(0x1b84ef) forState:UIControlStateNormal];
        self.limitContent=tLimitContent;
        [self addSubview:tLimitContent];
        [tLimitContent mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(30);
            make.right.equalTo(self.mas_right).offset(-20);
            make.top.equalTo(bg.mas_bottom).offset(15);
            make.width.mas_equalTo(70);
        }];
//        //详情图标
//        UIImageView *detail=[[UIImageView alloc]init];
//        //detail.frame=CGRectMake(233, 74, 16, 16);
//        detail.image=[UIImage imageNamed:@"detail_pressed"];
//        detail.layer.cornerRadius=7;
//        detail.clipsToBounds=YES;
//        [self addSubview:detail];
//        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.height.width.mas_equalTo(14);
//            make.right.equalTo(tLimitContent.mas_left).offset(-2);
//            make.centerY.equalTo(tLimitContent.mas_centerY);
//            
//        }];
        
        //限额说明
        UILabel *tLimit=[[UILabel alloc]init];
        // tLimit.frame=CGRectMake(0 , 67 ,self.view.bounds.size.width,30);
        tLimit.font=[UIFont systemFontOfSize:12];
        tLimit.userInteractionEnabled=YES;
        // tLimit.backgroundColor=CMColor(242,242,242);
        self.limitMoney=tLimit;
        [self addSubview:tLimit];
        [tLimit mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.mas_equalTo(30);
            make.right.equalTo(tLimitContent.mas_left);
            make.left.equalTo(self.mas_left).offset(8);
            make.top.equalTo(bg.mas_bottom).offset(15);
            
        }];

        //账户余额
        
        UILabel *balance=[[UILabel alloc]init];
        //balance.frame=CGRectMake(13 , 107 ,64,40 );
        balance.font=[UIFont systemFontOfSize:14];
        balance.textColor=CMColor(77, 77, 77);
        balance.text=@"账户余额";
        [self addSubview:balance];
        [balance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.width.mas_equalTo(64);
            make.left.equalTo(self.mas_left).offset(15);
            make.top.equalTo(tLimit.mas_bottom).offset(15);
            
        }];
        
        
        UILabel *tbalance=[[UILabel alloc]init];
        //tbalance.frame=CGRectMake(239 , 112 ,64,29 );
        tbalance.textAlignment=NSTextAlignmentRight;
        tbalance.font=[UIFont systemFontOfSize:14];
        tbalance.textColor=RedButtonColor;
        self.BalanceLabel=tbalance;
        [self addSubview:tbalance];
        [tbalance mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(balance);
            make.width.equalTo(@100);
            
            make.right.equalTo(self.mas_right).offset(-15);
            make.top.equalTo(balance);
            
        }];
        //分割线
        
        UIView *line1=[[UIView alloc]init];
        //line1.frame=CGRectMake(0, 150, self.view.bounds.size.width, 1);
        line1.backgroundColor=separateLineColor;
        [self addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5);
            make.top.equalTo(tbalance.mas_bottom).offset(5);
            make.right.left.equalTo(self);
            
            
        }];
        //充值余额
        
        UILabel *recharge=[[UILabel alloc]init];
        //recharge.frame=CGRectMake(13 , 155 ,64,40 );
        recharge.font=[UIFont systemFontOfSize:14];
        recharge.textColor=CMColor(77, 77, 77);
        recharge.text=@"充值余额";
        [self addSubview:recharge];
        [recharge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.left.equalTo(balance);
            make.top.equalTo(line1.mas_bottom).offset(5);
            
        }];
        UITextField *tRecharge=[[UITextField alloc]init];
        //tRecharge.frame=CGRectMake(188, 165, 132, 30);
        tRecharge.borderStyle=UITextBorderStyleNone;
        tRecharge.font=[UIFont systemFontOfSize:14];
        tRecharge.textAlignment=NSTextAlignmentRight;
       // tRecharge.keyboardType=UIKeyboardTypeNumberPad;
        self.RechargeNum=tRecharge;
        tRecharge.placeholder=@"请输入充值金额";
        [self addSubview:tRecharge];
        [tRecharge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.equalTo(tbalance);
            make.top.equalTo(recharge);
            make.width.mas_equalTo(130);
        }];
        //分割线
        
        UIView *line2=[[UIView alloc]init];
        // line2.frame=CGRectMake(0, 200, self.view.bounds.size.width, 1);
        line2.backgroundColor=separateLineColor;
        [self addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.right.left.equalTo(line1);
            make.top.equalTo(recharge.mas_bottom).offset(5);
            
        }];
        //充值账户余额
        
        UILabel *balanceBefore=[[UILabel alloc]init];
        //balanceBefore.frame=CGRectMake(8 , 209 ,290,27 );
        balanceBefore.font=[UIFont systemFontOfSize:14];
        balanceBefore.textColor=[UIColor lightGrayColor];
        self.RechargeLimit=balanceBefore;
        [self addSubview:balanceBefore];
        [balanceBefore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(recharge);
            make.height.mas_equalTo(27);
            make.width.mas_equalTo(290);
            make.top.equalTo(line2.mas_bottom).offset(5);
            
        }];
        
        
        
        
        UIButton *rechargeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        //rechargeBtn.frame=CGRectMake(13, 249, 285, 36);
        rechargeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rechargeBtn.layer.cornerRadius=5.0;
        rechargeBtn.clipsToBounds=YES;
        rechargeBtn.backgroundColor=RedButtonColor;
        self.Rechargebtn=rechargeBtn;
        [self addSubview:rechargeBtn];
        
        [rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.height.mas_equalTo(buttonHeight);
            make.width.mas_equalTo(290);
            make.top.equalTo(balanceBefore.mas_bottom).offset(5);
            
        }];
        
        
        
        //Other
        UILabel *content=[[UILabel alloc]init];
        // content.frame=CGRectMake(68 , 293 ,185,21 );
        content.font=[UIFont systemFontOfSize:13];
        content.textAlignment=NSTextAlignmentCenter;
        content.textColor=CMColor(127, 127, 127);
        content.text=@"快捷支付服务由第三方支付提供";
        [self addSubview:content];
        
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(CMScreenW);
            make.top.equalTo(rechargeBtn.mas_bottom).offset(5);
            
        }];
        
    /*
        UILabel *content1=[[UILabel alloc]init];
        //content1.frame=CGRectMake(24 , 336,69,21 );
        content1.font=[UIFont systemFontOfSize:12];
        content1.textColor=RedButtonColor;
        content1.text=@"*充值提醒:";
        [self addSubview:content1];
        [content1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(balanceBefore);
            make.height.mas_equalTo(21);
            make.width.mas_equalTo(70);
            make.top.equalTo(content.mas_bottom).offset(20);
            
        }];
        
        
        UILabel *content2=[[UILabel alloc]init];
        //content2.frame=CGRectMake(24 ,358,279,42 );
        content2.font=[UIFont systemFontOfSize:12];
        content2.textColor=CMColor(128, 128, 128);
        content2.numberOfLines=0;
        content2.text=@"如果充值未及时到财猫账户,如您确认已扣款,请到财富账户-充值-充值记录中点击核对,系统会自动补单。";
        [self addSubview:content2];
        
        [content2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(balanceBefore);
            make.height.mas_equalTo(30);
            make.top.equalTo(content1.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-10);
            
        }];
        
        UILabel *content3=[[UILabel alloc]init];
        // content3.frame=CGRectMake(24 ,400,274,21 );
        content3.font=[UIFont systemFontOfSize:12];
        content3.textColor=CMColor(128, 128, 128);
        
        content3.text=@"PC端请用电脑核对,手机端请用手机核对。";
        [self addSubview:content3];
        [content3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(balanceBefore);
            make.height.mas_equalTo(21);
            make.top.equalTo(content2.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(-10);
            
        }];
        

       */
        
        
    }
    return self;
}

@end
