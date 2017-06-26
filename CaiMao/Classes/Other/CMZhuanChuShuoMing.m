//
//  CMZhuanChuShuoMing.m
//  CaiMao
//
//  Created by MAC on 16/11/10.
//  Copyright © 2016年 58cm. All rights reserved.
//

#import "CMZhuanChuShuoMing.h"

@implementation CMZhuanChuShuoMing

-(instancetype)init{
    self=[super init];
    if (self) {
        self.frame=[UIScreen mainScreen].bounds;
        //模糊视图
        UIImageView  *bgView=[[UIImageView alloc]initWithFrame:self.frame];
        bgView.userInteractionEnabled=YES;
        bgView.backgroundColor=[UIColor blackColor];
        bgView.alpha=0.8f;
        [self addSubview:bgView];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissView)];
        [bgView addGestureRecognizer:tap];
        
        UILabel *label1=[[UILabel alloc]init];
        label1.textColor=[UIColor whiteColor];
        label1.font=[UIFont boldSystemFontOfSize:14.0];
        label1.text=@"如何将钱转入财富宝？";
        [bgView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@200);
            make.top.equalTo(bgView.mas_top).offset(80);
            make.left.equalTo(bgView.mas_left).offset(15);
        }];
        UILabel *label2=[[UILabel alloc]init];
        label2.textColor=[UIColor whiteColor];
        label2.font=[UIFont systemFontOfSize:12.0];
        label2.text=@"*目前共两种支付方式可以将资金转入财富宝:";
        [bgView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@300);
            make.top.equalTo(label1.mas_bottom).offset(5);
            make.left.equalTo(bgView.mas_left).offset(20);
        }];
        
        
        UILabel *label3=[[UILabel alloc]init];
        label3.textColor=[UIColor whiteColor];
        label3.font=[UIFont systemFontOfSize:12.0];
        label3.text=@"1.直接将财富账户中的余额转入财富宝;";
        [bgView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@300);
            make.top.equalTo(label2.mas_bottom).offset(5);
            make.left.equalTo(bgView.mas_left).offset(20);
        }];
        
        UILabel *label4=[[UILabel alloc]init];
        label4.textColor=[UIColor whiteColor];
        label4.font=[UIFont systemFontOfSize:12.0];
        label4.text=@"2.通过个人网上银行将资金转入财富宝;";
        [bgView addSubview:label4];
        [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@300);
            make.top.equalTo(label3.mas_bottom).offset(5);
            make.left.equalTo(bgView.mas_left).offset(20);
        }];
        
        UILabel *label5=[[UILabel alloc]init];
        label5.textColor=[UIColor whiteColor];
        label5.font=[UIFont boldSystemFontOfSize:14.0];
        label5.text=@"转出是否需要支付手续费?";
        [bgView addSubview:label5];
        [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@300);
            make.top.equalTo(label4.mas_bottom).offset(10);
            make.left.equalTo(bgView.mas_left).offset(15);
        }];
        
        UILabel *label6=[[UILabel alloc]init];
        label6.textColor=[UIColor whiteColor];
        label6.font=[UIFont systemFontOfSize:12.0];
        label6.text=@"*财富宝转出到财富账户不收取任何费用";
        [bgView addSubview:label6];
        [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.width.equalTo(@300);
            make.top.equalTo(label5.mas_bottom).offset(5);
            make.left.equalTo(bgView.mas_left).offset(20);
        }];
        
        UILabel *label7=[[UILabel alloc]init];
        label7.textColor=[UIColor whiteColor];
        label7.font=[UIFont systemFontOfSize:12.0];
        label7.numberOfLines=0;
        label7.text=@"*投资人从财富账户提现到银行卡,第三方支付平台收取提现金额的千分之三,不足3元时按3元收取,超过100元按100元收取。";
        CGRect rect=[label7.text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
        [bgView addSubview:label7];
        [label7 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rect.size.height+2);
            make.width.equalTo(@280);
            make.top.equalTo(label6.mas_bottom).offset(5);
            make.left.equalTo(bgView.mas_left).offset(20);
        }];
        
        
        UILabel *label8=[[UILabel alloc]init];
        label8.textColor=[UIColor whiteColor];
        label8.font=[UIFont boldSystemFontOfSize:14.0];
        label8.text=@"转入转出有什么限制?";
       
        [bgView addSubview:label8];
        [label8 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.width.equalTo(@300);
            make.top.equalTo(label7.mas_bottom).offset(10);
            make.left.equalTo(bgView.mas_left).offset(15);
        }];
        
        UILabel *label9=[[UILabel alloc]init];
        label9.textColor=[UIColor whiteColor];
        label9.font=[UIFont systemFontOfSize:12.0];
        label9.numberOfLines=0;
        label9.text=@"*当财富宝余额资金不足100元,进行转出操作必须全部转出。";
        CGRect rect1=[label9.text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
        [bgView addSubview:label9];
        [label9 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rect1.size.height+2);
            make.width.equalTo(@280);
            make.top.equalTo(label8.mas_bottom).offset(5);
            make.left.equalTo(bgView.mas_left).offset(20);
        }];
        
        UILabel *label10=[[UILabel alloc]init];
        label10.textColor=[UIColor whiteColor];
        label10.font=[UIFont boldSystemFontOfSize:14.0];
        label10.text=@"财富宝赎回及计息规则";
        
        [bgView addSubview:label10];
        [label10 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.width.equalTo(@300);
            make.top.equalTo(label9.mas_bottom).offset(10);
            make.left.equalTo(bgView.mas_left).offset(15);
        }];
        
        UILabel *label11=[[UILabel alloc]init];
        label11.textColor=[UIColor whiteColor];
        label11.font=[UIFont systemFontOfSize:12.0];
        label11.numberOfLines=0;
        label11.text=@"*在对财富宝进行资金转出时可以转出不大于财富宝余额中的任意额度(注:每天累计转出不超过50000元);";
        CGRect rect2=[label11.text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
        [bgView addSubview:label11];
        [label11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rect2.size.height+2);
            make.width.equalTo(@280);
            make.top.equalTo(label10.mas_bottom).offset(5);
            make.left.equalTo(bgView.mas_left).offset(20);
        }];
        UILabel *label12=[[UILabel alloc]init];
        label12.textColor=[UIColor whiteColor];
        label12.font=[UIFont systemFontOfSize:12.0];
        label12.text=@"*财富宝每日转出次数不限;";
        [bgView addSubview:label12];
        [label12 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.width.equalTo(@300);
            make.top.equalTo(label11.mas_bottom).offset(5);
            make.left.equalTo(bgView.mas_left).offset(20);
        }];
        
        UILabel *label13=[[UILabel alloc]init];
        label13.textColor=[UIColor whiteColor];
        label13.font=[UIFont systemFontOfSize:12.0];
        label13.numberOfLines=0;
        label13.text=@"*在进行转出操作时,优先转出较近转入的资金,保证用户收益最大化;";
        CGRect rect3=[label13.text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
        [bgView addSubview:label13];
        [label13 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rect3.size.height+2);
            make.width.equalTo(@280);
            make.top.equalTo(label12.mas_bottom).offset(5);
            make.left.equalTo(bgView.mas_left).offset(20);
        }];
        UILabel *label14=[[UILabel alloc]init];
        label14.textColor=[UIColor whiteColor];
        label14.font=[UIFont systemFontOfSize:12.0];
        label14.numberOfLines=0;
        label14.text=@"*当转出的金额数小于整笔转入金额数时,系统会对相应的转入资金计息金额进行冲减,剩下的资金将会继续保持其现有预期年化收益率及计息天数计算收益。";
        CGRect rect4=[label14.text boundingRectWithSize:CGSizeMake(280, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]} context:nil];
        [bgView addSubview:label14];
        [label14 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(rect4.size.height+2);
            make.width.equalTo(@280);
            make.top.equalTo(label13.mas_bottom).offset(5);
            make.left.equalTo(bgView.mas_left).offset(20);
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
@end
